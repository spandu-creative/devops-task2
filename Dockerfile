# Stage 1: Build Stage (using a base image)
FROM node:18-alpine AS builder

WORKDIR /app

# Copy application files
COPY app/package*.json ./
# Install dependencies
RUN npm install
COPY app/ ./

# Stage 2: Final Run Stage (using a smaller runtime image)
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app .

EXPOSE 3000
CMD [ "npm", "start" ]