FROM hashicorp/terraform:0.15.3

# Install dependencies.
RUN apk add --no-cache \
  bash \
  curl \
  openssl \
  python2

# Install Terragrunt (0.29.3). Ref: https://github.com/gruntwork-io/terragrunt/releases
RUN curl -o /bin/terragrunt -sSL https://github.com/gruntwork-io/terragrunt/releases/download/v0.29.3/terragrunt_linux_amd64 && \
  chmod u+x /bin/terragrunt

# Install Google Cloud SDK (latest version). Ref: https://cloud.google.com/sdk/docs/release-notes
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts
RUN ~/google-cloud-sdk/bin/gcloud components update
ENV PATH "~/google-cloud-sdk/bin:$PATH"

# Install AWS CLI (latest version). Ref https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
RUN curl -o /tmp/awscli-bundle.zip -SSL https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
  unzip /tmp/awscli-bundle.zip -d /tmp && \
  /tmp/awscli-bundle/install -i /usr/aws -b /bin/aws

# Install AWS IAM authenticator. Ref https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
RUN curl -o /bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator && \
  chmod u+x /bin/aws-iam-authenticator && \
  cp /bin/aws-iam-authenticator /bin/aws-iam-authenticator.exe

# Install kubectl (v1.21.1). Ref https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN curl -o /bin/kubectl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.21.1/bin/linux/amd64/kubectl && \
  chmod u+x /bin/kubectl

# Install Helm (3.4.0). Version histroy can be found at https://github.com/helm/helm/tags
ENV DESIRED_VERSION=v3.5.4
RUN curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
RUN helm repo add stable https://charts.helm.sh/stable

ENTRYPOINT []
