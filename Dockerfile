FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    build-essential \
    iputils-ping \
    python3 \
    python3-dev \
    python3-pip \ 
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get -y install curl
RUN pip3 install --upgrade pip
RUN pip3 install poetry tzdata
RUN poetry config virtualenvs.create false
ENV NODE_VERSION=6.0.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
WORKDIR /app 
COPY . /app
RUN cp ./casepro/settings.py.dev ./casepro/settings.py
RUN chmod u+x start-app.sh
RUN poetry install
RUN npm install && npm build
RUN npm install -g coffee-script less
ENTRYPOINT ["python3"] 
EXPOSE 8000 
CMD ["manage.py", "runserver", "0.0.0.0:8000"]


