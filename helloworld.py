from fastapi import FastAPI
from socket import gethostname
from os import environ as env

try:
    soft_version = env['HELLOWORLD_RELEASE_VERSION']
except KeyError:
    soft_version = "unknown"

try:
    stats_path = env['API_STATS_PATH']
except KeyError:
    stats_path = "/207y6e98ahw9s8hd0a2y9e8haiousndswkd2oeyew08a1/stats"

hostname = gethostname()

api = FastAPI()
@api.get('/')
def response():
    return {"moo": True}

@api.get('/helloworld/{name}')
def response(name):
    return {"response": f"Hello, {name}"}

@api.get(f'{stats_path}')
def response():
    return {"hostname": hostname,
            "version": soft_version}

@api.get('/healtcheck')
def response():
    return {"moo": True}