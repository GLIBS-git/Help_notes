# Copy files from volume to host. Both running or stopped containers.
docker cp <container-id-or-name>:</path/in/container> </path/on/host>
# Example: copy files from folder /app/data/ in container u4 to folder ~/Test/ on host
docker cp u4:/app/data/. ~/Test/.
# Example: copy the whole "data" folder from /app/data/ in container u4 to folder ~/Test/ (~/Test/data) on host
docker cp u4:/app/data/ ~/Test/
























