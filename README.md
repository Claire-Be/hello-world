## What is this?

A simple web service that replys with your name, along with associated infrastructure to deploy it on to AWS.

## Usage

Assumptions:

1. That this repository is stored in a version control system that the associated instances will be able to access.
Currently this is GitHub, but GitLab would also work. Usage with CodeCommit would require the HTTPS credential helper
and/or an associated EC2 role.

2. Have your `ssh-agent` configured. Terraform will remote-exec into the SSH host to run the Ansible playbook and requires
an SSH key.

To deploy accomplish the following:

1. Update the `remote_user`, `ssh_pub_key` and `app_repo` variables with the user name you wish created on the instances,
   your SSH public key and the URL of the repository.

2. In the `infrastructure/terraform` directory, run `terraform init`.

3. Build the infrastructure with `terraform apply`

When Terraform finishes, it will output an SSH host to connect to, if you wish to re-run your Ansible playbook. You can use this
to update the application. It will also output the DNS record for the loadbalancer. Test the application with the following:

`curl http://LOADBALNCER_DNS_HERE/helloworld/NAME`

Where LOAD_BALANCER_DNS is the output from Terraform and NAME is the name you wish echoed back.


When finished, make sure you destroy the environment with: `terraform destroy`


## Architecture

The service is written in Python, using FastAPI for the web framework and uvicorn as the web server. 

Uvicorn runs as a `systemd` service, by default exposing TCP port 8080.

The service runs on two (2) t2.micro instances, each in a separate AZ in AWS in `us-west-2`, with an application
load balancer sitting in front of the two instances.

```
 _________________         ___      ________________  |--->private subnet (us-west-1a)---> web-1.dev.private (uvicorn service)
|ALB HTTP Listener|:80<-->|ALB|<-->|ALB Target Group|:8080
 -----------------         ---      ----------------  |--->private subnet (us-west-2a)---> web-2.dev.private (uvicorn service)

```

The application provides several endpoints. The `/` and `/healthcheck` are for health and connection testing.

There is a stats endpoint that reveals some system information. By default this endpoint is a long string, for obsfucation. It can be manually configured with the
`API_STATS_PATH` environment variable.

## Deployment Methodology

The base infrastructure creation in AWS is accomplished with Terraform. The underlying instances are configured with [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html)
and Ansible.

First the VPCs, subnets, internet gateway, NAT gateway, route tables and security groups are created.

Next the web instances are deployed into two private subnets. `cloud-init` configures the aforementioned remote user with an SSH public key. It also ensures that Python3 is installed,
allowing Ansible access for remote execution. This is purely minimal configuration to allow Ansible a toehold.

Once the web instances have finished deployment and their DNS records have been added to the private DNS zone, Terraform deploys the orchestration host.
The orchestration instance has a public IP. Terraform will use the `remote-exec` provisioner to SSH in and run two Ansible playbooks. The first Ansible playbook is a minimal
self configuration playbook, which accomplishes two things. First, it updates `/etc/ansible/hosts` with the hosts `web-1.dev.private` and `web-2.dev.private`. Second,
it edits `/etc/ansible/ansible.cfg` to disable host key checking. In a production environment, new hosts would have their SSH key fingerprints registered with Ansible,
but this is beyond the scope of this project.

The second playbook configures the web hosts. First it syncs the `helloworld.py` to the web hosts in the `/app/python/hello-world` directory. Next it installs pip and uses
pip to install FastAPI and uvicorn. It then creates a `systemd` unit for uvicorn, starts uvicorn, and/or restarts uvicorn if there have been changes to either the `systemd`
unit or `helloworld.py`.

## Local Testing

A Dockerfile is provided for local testing. Simply build the Docker image as follows:

`docker build -t helloworld:1 .`

And run as follows:

`docker run -d --publish 8080:8080 helloworld:1`

If you wish to run the service on a different port, set the `API_PORT` environment variable when running docker.
The address to bind to can also be configured with `API_HOST`. By default the application listens on `0.0.0.0`.

## TODO

Several features are currently awaiting.

1. Application tracing. Rollbar is a prime candidate.

2. As this application is fully containerizable, K8s support is forthcoming.

3. Uptime monitoring. Consider DeadmansSnitch, Pingdom, Heartbeat (Elastic Co)

4. Full CI/CD. At a minimum, infrastructure deployment should be automatic with a GitOps approach.
   Application and infrastructure code should be separated. Consider GitHub Actions, GitLab CI etc.

5. Unit tests. All endpoints need to be fully validated and checked as part of a build and deployment process

6. Load testing. Looking into (hey)[https://github.com/rakyll/hey], to validate speed/performance and for regression testing with new features. 