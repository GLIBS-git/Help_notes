# Create a test container: (Puts output to console; stops right after running) 
docker run <image>
# Example of creating the "Hello world" container 
docker run hello-world

# -d -- runs container detached (opposite to hello-world with output)
docker run -d <image>
# Example of creating a detached container
docker run -d ubuntu

# -p -- publishes container port to the host: 
docker run -d -p <port-at-host>:<port-in-container> <image>
# Example: 8080 -- Docker host's port; 80 -- container's port
docker run -d -p 8080:80 nginx

# --name -- set a name to the container
docker run --name <set-container-name> -d <image>
# Example of setting name
docker run --name hw-test-name hello-world

# -v -- run container with mount volume
docker run -v </path/on/host>:</path/in/container> <image>
# Example
docker run -v ~/Docker/U1:/app/data --name U1 ubuntu


# Rename container
docker rename <old-name> <new-name>

# Delete container
docker rm <container_id_or_name>

# Stop running container and delete
docker rm -f <container_id_or_name>














