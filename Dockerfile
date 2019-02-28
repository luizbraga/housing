FROM python:3.6

ENV PYTHONUNBUFFERED 1

WORKDIR /app
COPY . .

RUN pip install -r requirements.dev.txt

COPY ./entrypoint.sh /

RUN sed -i 's/\r//' /entrypoint.sh \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
