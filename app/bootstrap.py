from flask import Flask
import requests
import logging

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST', 'PUT', 'DELETE'])
def hello():
    return "boogyman was here a new test using ingress for the load balancer testing docker swarm"

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=8090)
