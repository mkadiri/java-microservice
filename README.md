## Running the application

- You'll need to build the docker images by running `bash build.sh`. Two following two images will be created:
    - `Java maven builder image`: this takes a pom.xml and source code and builds a jar file, it also caches files in to your local .m2 folder
    - `Java microservice app`: contains the jar file which is executed on startup
- If all is successful you should be able to `docker-compose up`


## Usage

### Endpoints

- Get all users - GET [`https://localhost:8181/users`](https://localhost.datix:8181/users)
- Add user - POST [`https://localhost:8181/users/user`](https://localhost.datix:8181/users/user)
    - body `{"login": "mkadiri", "first_name": "Mohammed", "last_name": "Kadiri", "enabled": false}`
    - headers: `Content-Type: application/json`
    - if a user exists in the database the record will be updated otherwise updated.
- Healthcheck - GET [`https://localhost:8181/actuator/health`](https://localhost.datix:8181/actuator/health)


### Performance tweaking

By default the java service will use almost 700MB of memory and on startup around 1.2GB, this makes Java not so ideal for microservices.
I've also noticed CPU usage spikes of 400% =[

In docker/java-8/startup.sh I've added a few java options to tweak with the JVM memory consumption. These changes will get the image down to around 300MB


### Help

#### IntelliJ 

`Cannot resolve symbol`

    - right click pom.xml -> Add as Maven project
    - File -> project structure -> modules -> select 'src' -> mark as 'Source'
    - IntelliJ -> File -> Invalidate Caches / Restart
    - IntelliJ -> FIle -> Synchronize
    
`package name does not correspond to the file path`
