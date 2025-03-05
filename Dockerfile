### Build
#FROM beevelop/ionic:latest AS ionic
FROM beevelop/ionic:v2021.02.1 AS ionic

ARG POSTGRES_USERNAME_ARG
ARG POSTGRES_PASSWORD_ARG
ARG POSTGRES_HOST_ARG
ARG POSTGRES_DB_ARG
ARG AWS_BUCKET_ARG
ARG AWS_REGION_ARG
ARG AWS_PROFILE_ARG
ARG JWT_SECRET_ARG
ARG URL_ARG

ENV POSTGRES_USERNAME=$POSTGRES_USERNAME_ARG
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD_ARG
ENV POSTGRES_HOST=$POSTGRES_HOST_ARG
ENV POSTGRES_DB=$POSTGRES_DB_ARG
ENV AWS_BUCKET=$AWS_BUCKET_ARG
ENV AWS_REGION=$AWS_REGION_ARG
ENV AWS_PROFILE=$AWS_PROFILE_ARG
ENV JWT_SECRET=$JWT_SECRET_ARG
ENV URL=$URL_ARG

## Create app directory
WORKDIR /usr/src/app
## Install app dependencies test
## A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./
# Install dependencies
####RUN npm install
RUN npm ci
## Bundle app source
COPY . .
RUN ionic build
### Run 
FROM nginx:alpine
#COPY www /usr/share/nginx/html
COPY --from=ionic  /usr/src/app/www /usr/share/nginx/html
