FROM node:20-alpine

WORKDIR /app

# Install deps first (better cache)
COPY package*.json ./
RUN npm install

# Copy source
COPY . .

# 🔴 THIS IS THE MISSING PIECE
RUN npx prisma generate

# Expose API port
EXPOSE 8086

CMD ["npm", "run", "dev"]
