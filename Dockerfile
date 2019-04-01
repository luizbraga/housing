FROM python:3.6

ENV PYTHONUNBUFFERED 1
ENV PROJ_SRC src
ENV PROJ_HOME /app
ENV PROJ_SRCHOME /app/src

WORKDIR $PROJ_HOME
COPY $PROJ_SRC $PROJ_SRCHOME

RUN pip install -r $PROJ_SRCHOME/requirements.dev.txt

WORKDIR $PROJ_SRCHOME

COPY ./entrypoint.sh /

RUN sed -i 's/\r//' /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]
