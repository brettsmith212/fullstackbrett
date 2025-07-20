# Stage 1
FROM alpine:latest AS build

# Install the Hugo go app.
RUN apk add --update hugo

WORKDIR /opt/HugoApp

# Copy Hugo config into the container Workdir.
COPY . .

# Build argument for baseURL (DEVELOPMENT)
# ARG HUGO_BASEURL=/

# Build argument for baseURL (PRODUCTION)
ARG HUGO_BASEURL=https://fullstackbrett.com/

# Run Hugo in the Workdir to generate HTML.
RUN hugo --cleanDestinationDir --baseURL="${HUGO_BASEURL}" 

# Stage 2
FROM nginx:1.25-alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set workdir to the NGINX default dir.
WORKDIR /usr/share/nginx/html

# Copy HTML from previous build into the Workdir.
COPY --from=build /opt/HugoApp/public .

# Expose port 3000
EXPOSE 3000/tcp