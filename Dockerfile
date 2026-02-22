FROM node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Create non-root user
RUN addgroup -g 1001 nodejs && adduser -u 1001 -G nodejs -s /bin/sh -D nodeapp

# Copy application code
COPY . .

# Set ownership and create directories
RUN chown -R nodeapp:nodejs /app

USER nodeapp

EXPOSE 3000

CMD ["npm", "start"]
