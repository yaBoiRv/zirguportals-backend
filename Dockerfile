FROM node:20-alpine

# Install OpenSSL 1.1 for Prisma compatibility
RUN apk add --no-cache openssl1.1-compat

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
