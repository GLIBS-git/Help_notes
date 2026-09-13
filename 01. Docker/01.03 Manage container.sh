# Run terminal session in container (container must be running)
docker exec -it <container_id> /bin/bash
docker exec -it <container_id> /bin/sh

# Stop terminal session in container
exit

# Read past logs (works for stopped container)
docker logs <container_id>












