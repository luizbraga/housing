FROM python:3.6-slim-buster

RUN apt-get -yq update

ENV PYTHONUNBUFFERED 1
ENV PROJ_SRC src
ENV PROJ_HOME /app
ENV PROJ_SRCHOME /app/src

COPY requirements.txt requirements.txt
COPY requirements.dev.txt requirements.dev.txt
RUN pip install -r requirements.dev.txt

WORKDIR $PROJ_HOME
COPY $PROJ_SRC $PROJ_SRCHOME

WORKDIR $PROJ_SRCHOME

COPY ./entrypoint.sh /

RUN sed -i 's/\r//' /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]
