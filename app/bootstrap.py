from flask import Flask
import requests
import logging

app = intialize_app()

@app.route('/', methods=['GET', 'POST', 'PUT', 'DELETE'])
def hello():
    return "Hello harold!"

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=8070)
