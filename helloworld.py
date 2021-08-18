from fastapi import FastAPI
from socket import gethostname
from os import environ as env

try:
    soft_version = env['HELLOWORLD_RELEASE_VERSION']
except KeyError:
    soft_version = "unknown"

hostname = gethostname()

api = FastAPI()
@api.get('/')
def response():
    return {"moo": True}

@api.get('/helloworld/{name}')
def response(name):
    return {"response": f"Hello, {name}"}

@api.get('/2109yuo82hyqaouiahskljdkhnao29yeas/data')
def response():
    return {"hostname": hostname,
            "version": soft_version}

@api.get('/healtcheck')
def response():
    return {"moo": True}