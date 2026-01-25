FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

# copy prisma schema BEFORE generate
COPY prisma ./prisma

# generate prisma client into node_modules/.prisma
RUN npx prisma generate

# now copy the rest of the app
COPY . .

CMD ["npm", "run", "dev"]
