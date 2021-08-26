FROM node:alpine AS builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# EXPOSE is for elasticbeanstalk to know which port it should map to
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# default nginx command is start