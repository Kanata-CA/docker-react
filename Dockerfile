FROM node:alpine as builder

WORKDIR '/app'
RUN chown -R node:node /app

COPY package.json .
RUN chown -R node:node .

USER node
RUN npm install

COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html