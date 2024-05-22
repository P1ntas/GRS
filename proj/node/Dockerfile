FROM node:alpine

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

# USER root

# RUN /sbin/ip route replace default via 10.0.2.254

CMD ["npm", "run", "start"]