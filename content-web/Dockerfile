FROM node:dubnium-alpine AS base
RUN apk -U add curl
WORKDIR /usr/src/app
EXPOSE 3000

FROM node:dubnium AS build
RUN npm install -g @angular/cli@~8.3.4

WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app sourcikkkkk
COPY . /usr/src/app
RUN ng build 

FROM base as final
ENV CONTENT_API_URL=http://localhost:3001
RUN npm install applicationinsights --save
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
CMD [ "node", "app.js" ]
