FROM node:22-alpine

RUN apk add --no-cache python3 g++ make

WORKDIR /app

# Copy project
COPY . .

# Install backend dependencies
WORKDIR /app/TODO/todo_backend
RUN npm install

# Install frontend dependencies
WORKDIR /app/TODO/todo_frontend
RUN npm install

# Build frontend
RUN npm run build

# Move frontend build to backend static folder
RUN mkdir -p /app/TODO/todo_backend/static && \
    mv build /app/TODO/todo_backend/static/

# Set working directory back to backend
WORKDIR /app/TODO/todo_backend

EXPOSE 5000

CMD ["npm", "start"]