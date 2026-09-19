# Run terminal session in container (container must be running)
docker exec -it <container_id_or_name> /bin/bash
docker exec -it <container_id_or_name> /bin/sh

# Stop terminal session in container
exit

# Read past logs (works for stopped container)
docker logs <container_id_or_name>












