# Create test container: (Puts output to console; stops right after running) 
docker run hello-world

# Create container
# -p -- publishes container port to the host: 
#       - 8080 -- Docker host's port
#       - 80 -- container's port
# -d -- runs detached (opposite to hello-world with output)
docker run -d -p 8080:80 nginx

# Delete container
docker rm <container_id>

# Stop running container and delete
docker rm -f <container_id>














