FROM ubuntu:latest
RUN apt-get update
RUN apt-get install pip -y
COPY requirements.txt requirements.txt
COPY app .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
ENV FLASK_APP=start
ENV FLASK_ENV=development
# CMD ["ls"]


CMD ["flask", "run"]

EXPOSE 5000/udp
EXPOSE 5000/tcp