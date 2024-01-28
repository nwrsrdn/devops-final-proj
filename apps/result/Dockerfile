FROM node:20.5-alpine3.17

# setup app directory
WORKDIR /usr/src/app

# copy package list
COPY package*.json ./

# install packages/dependencies
RUN npm ci --only=production

# copy source code
COPY . .

# expose port
EXPOSE 5001

# set user
USER node

# Instantiate/run the app
CMD ["npm", "run", "app"]
