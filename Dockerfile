# Stage 1
FROM alpine:3.20 AS build

# Install dependencies required for Hugo
RUN apk add --no-cache wget tar

# Download and install Hugo v0.148.1
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.148.1/hugo_0.148.1_Linux-64bit.tar.gz && \
    tar -xzf hugo_0.148.1_Linux-64bit.tar.gz && \
    mv hugo /usr/local/bin/ && \
    chmod +x /usr/local/bin/hugo && \
    rm hugo_0.148.1_Linux-64bit.tar.gz

WORKDIR /opt/HugoApp

# Copy Hugo config into the container Workdir.
COPY . .

# Build argument for baseURL
ARG HUGO_BASEURL=/

# Run Hugo in the Workdir to generate HTML.
RUN hugo --cleanDestinationDir --baseURL="${HUGO_BASEURL}" 

# Stage 2
FROM python:3.12-alpine

# Set workdir for the Python server.
WORKDIR /app

# Copy HTML from previous build into the Workdir.
COPY --from=build /opt/HugoApp/public .

# Expose port 3000
EXPOSE 3000/tcp

# Run the Python HTTP server on port 3000
CMD ["python", "-m", "http.server", "3000"]