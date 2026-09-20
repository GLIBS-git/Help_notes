# Example of creating the "Hello world" container: (Puts output to console; stops right after running)
docker run hello-world

# --name -- set a name to the container
docker run --name <set-container-name> -d <image>
# Example of setting name
docker run --name hw-test-name hello-world

# Example of creating Ubuntu container
# -i -- keeps STDIN open even if not attached
# -t -- opens terminal
docker run -it --name u1 ubuntu bash
# ^C to exit terminal. Stops container. Can be started by "start" command.
# -d -- runs container detached
docker run -id --name u2 ubuntu bash

# -p -- publishes container port to the host: 
docker run -d -p <port-at-host>:<port-in-container> <image>
# Example: 8080 -- Docker host's port; 80 -- container's port
docker run -d -p 8080:80 nginx

# -v -- run container with mount
docker run -v </path/on/host>:</path/in/container> <image>
# Example
docker run -id -v ~/Docker/mount:/app/data --name u3 ubuntu bash

# -v -- run container with volume 
docker run -v <volume-name>:</path/in/container> <image>
# Example: run container with volume "volume-1" (volume must be already created)
docker run -id -v volume-1:/app/data --name u4 ubuntu bash

# Rename container
docker rename <old-name> <new-name>

# Delete container
docker rm <container_id_or_name>

# Stop running container and delete
docker rm -f <container_id_or_name>














