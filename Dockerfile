FROM maven:3.8.1-openjdk-11
LABEL "author"="Blagoja Mojsoski" "company"="TestDevLab SIA"

RUN mkdir docker
COPY . ./docker/
 
WORKDIR /docker/
 
RUN mvn dependency:resolve
RUN mvn clean install -DskipTests

# docker build --no-cache -t blazk0/mvn_tests:latest .
# docker network create test-automation-setup
# docker run --name cont1 blazk0/mvn_tests mvn clean test -Dbrowser=chrome
# docker run -it --network=test-automation-setup blazk0/mvn_tests mvn clean test -Dbrowser=chrome -DgridURL=selenium-hub:4444
# mvn clean test -Dbrowser=chrome -DgridURL=selenium-hub:4444
# docker push blazk0/mvn_tests:latest