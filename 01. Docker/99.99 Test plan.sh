# Attaches terminal directly to the container's stdin/stdout/stderr
docker attach <container_id_or_name>

# Run container with mount volume
docker run -v /path/on/host:/path/in/container my-hello-world:1.0



# Create volume
docker volume create app-data

# Run container with volume
docker run -v app-data:/app/data my-app:1.0

# Data persists even after container stops
docker run -v app-data:/app/data my-app:1.0  # Same data!

docker run -it ubuntu bash








