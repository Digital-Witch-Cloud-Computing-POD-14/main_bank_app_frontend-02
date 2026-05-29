FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object
RUN npm install --save react react-dom @types/react @types/react-dom
RUN npm install react-scripts@3.0.1 --save
RUN npm install

COPY . .

# React build arg
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Attempt to fix vulnerabilities, but continue if it fails
RUN npm audit fix --force || echo "Continuing despite npm audit fix failures"

EXPOSE 3000

CMD ["npm", "start"]