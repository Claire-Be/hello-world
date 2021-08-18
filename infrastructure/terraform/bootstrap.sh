#!/usr/bin/env bash

for i in $(seq 1 20); do 
  which ansible-playbook &>/dev/null
  if  [ $? == 0 ]; then
    echo "Ansible present"
    break
  else
    echo "Ansible not installed yet"
    sleep 10
    continue
  fi
done

if [ $? == 0 ]; then
  for i in $(seq 1 20); do 
    ls /app/python/hello-world/infrastructure/ansible/ &>/dev/null
    if [ $? == 0 ]; then
      echo "Playbook present"
      break
    else
      echo "Playbook not present yet"
      sleep 10
      continue
    fi
  done
else
  exit 1
fi

if [ $? == 0 ]; then
  ansible-playbook /app/python/hello-world/infrastructure/ansible/self-config.yml
  ansible-playbook /app/python/hello-world/infrastructure/ansible/web-config.yml
else
  exit 1
fi