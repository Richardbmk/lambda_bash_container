#First we pull the base image from DockerHub
FROM amazon/aws-lambda-provided:al2

RUN yum install zip unzip jq -y

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Install kubectl 
# AWS kubectl commands
RUN curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mkdir -p ~/.local/bin
RUN mv ./kubectl /usr/local/bin/kubectl

# Copy our bootstrap and make it executable
WORKDIR /var/runtime/
COPY bootstrap bootstrap
RUN chmod 755 bootstrap

# Copy our function code and make it executable
WORKDIR /var/task/
COPY function.sh function.sh
RUN chmod 755 function.sh

# Set the handler
# by convention <fileName>.<handlerName>
CMD [ "function.sh.handler" ]
