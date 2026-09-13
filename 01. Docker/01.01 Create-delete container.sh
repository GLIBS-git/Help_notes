# Test container
docker run hello-world

# Create container: 8080 - Docker host's port, 80 - container's port
docker run -d -p 8080:80 nginx

# Delete container
docker rm 050037515ee2

# Stop running container and delete
docker rm -f 050037515ee2

# Container configuration
docker inspect 057b96ea64eb














