# Run terminal session in container (container must be running)
docker exec -it <container_id_or_name> /bin/bash
docker exec -it <container_id_or_name> /bin/sh
# Stop terminal session in container, container not stopped
exit
# ^P^Q also exits from terminal, container not stopped
# Also works:
docker exec -it <container_id_or_name> bash

# Read past logs (works for stopped container)
docker logs <container_id_or_name>

# Follows the container's output in real-time (container must be running)
docker logs -f <container_id_or_name>
# ^C to exit

# Attaches terminal directly to the container's stdin/stdout/stderr
docker attach <container_id_or_name>
# ^P^Q to detach terminal without stopping container
# ^C stops container











