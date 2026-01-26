FROM node:20-slim

# Install OpenSSL 1.1 for Prisma
RUN apt-get update -y && apt-get install -y openssl libssl-dev && rm -rf /var/lib/apt/lists/*

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
