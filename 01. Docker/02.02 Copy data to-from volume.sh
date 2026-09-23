# Copy files from volume to host 
docker cp <container-id-or-name>:</path/in/container> </path/on/host>
# Example: copy files from folder /app/data/ in container u4 to folder ~/Test/ on host
docker cp u4:/app/data/. ~/Test/.
# Example: copy the whole folder /app/data/ in container u4 to folder ~/Test/ on host
docker cp u4:/app/data/ ~/Test/
























