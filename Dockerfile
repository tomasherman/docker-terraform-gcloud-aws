FROM hashicorp/terraform:0.11.11

# Install dependencies.
RUN apk add --no-cache \
  bash \
  openssl \
  python

# Install Google Cloud SDK (latest version).
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts

# Install AWS CLI (latest version).
RUN curl -o /tmp/awscli-bundle.zip -SSL https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
  unzip /tmp/awscli-bundle.zip -d /tmp && \
  /tmp/awscli-bundle/install -i /usr/aws -b /bin/aws

# Install kubectl (1.13.2). Latest stable version can be found at https://storage.googleapis.com/kubernetes-release/release/stable.txt.
RUN curl -o /bin/kubectl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl && \
  chmod +x /bin/kubectl

# Install Helm (2.12.2).
RUN curl -sSL https://raw.githubusercontent.com/helm/helm/v2.12.2/scripts/get | bash

# Update $PATH.
ENV PATH="~/google-cloud-sdk/bin:${PATH}"

ENTRYPOINT []
