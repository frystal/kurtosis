FROM ubuntu:20.04
WORKDIR /root

RUN apt update -y && apt install hwloc -y 

COPY ./lotus /usr/local/bin/

ENTRYPOINT ["/bin/bash"]
