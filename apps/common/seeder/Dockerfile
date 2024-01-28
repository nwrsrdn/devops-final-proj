FROM python:3.12.0b4-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /seed

COPY . .

RUN python make-data.py
RUN chmod +x /seed/generate-votes.sh

CMD ["/seed/generate-votes.sh"]