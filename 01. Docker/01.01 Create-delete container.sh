# Create test container: (Puts output to cinsole; stops right after running) 
docker run hello-world

# Create container: (-p: 8080 - Docker host's port, 80 - container's port); (-d - runs detached)
docker run -d -p 8080:80 nginx

# Delete container
docker rm <container_id>

# Stop running container and delete
docker rm -f <container_id>














