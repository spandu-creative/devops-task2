# Use official Node.js 18 image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all files
COPY . .

# Build (if applicable)
RUN npm run build || echo "No build step, skipping"

# Run the app
EXPOSE 5000
CMD ["npm", "start"]
