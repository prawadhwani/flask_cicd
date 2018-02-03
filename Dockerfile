FROM tiangolo/uwsgi-nginx-flask:python3.6

# copy over our requirements.txt file
COPY requirements.txt /tmp/

# upgrade pip and install required python packages
RUN pip install -U pip && \
    pip install -r /tmp/requirements.txt

ENV LISTEN_PORT 8080

COPY ./app /app

EXPOSE 8080
