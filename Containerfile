# get node-modules and build
FROM node:alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# serve
FROM node:alpine
WORKDIR /app
COPY --from=build /app/dist/runTracker/browser ./dist
EXPOSE 4200

# start commando
CMD ["npx", "serve", "dist", "-p", "4200"]
