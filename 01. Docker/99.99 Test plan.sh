docker run --rm --name hw-test hello-world

docker search java
docker search openjdk

docker build -t my-java-app .
docker run -it --rm --name my-running-app my-java-app

FROM openjdk:11
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java
CMD ["java", "Main"]





































