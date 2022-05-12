FROM node:16-alpine AS builder
RUN apk update && apk add \
    git

WORKDIR /app
ADD package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:16-alpine
## From 'builder' copy published folder
COPY --from=builder /app /app

FROM nginx:1.15.2-alpine
RUN apk update && apk add \
    bash
COPY --from=builder /app/dist/demo /usr/share/nginx/html
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

# Expose the port the app runs in
EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]