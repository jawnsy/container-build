FROM docker.io/library/ubuntu

RUN apt-get update --quiet && \
    apt-get install --yes --quiet \
      curl \
      gzip \
      tar

# Install tools with published releases, where that is the
# preferred/recommended installation method.
ARG DIVE_VERSION=0.10.0 \
    DOCKER_GCR_VERSION=2.1.0 \
    GOLANGCI_LINT_VERSION=1.43.0 \
    GRYPE_VERSION=0.24.0 \
    TRIVY_VERSION=0.21.2
# dive for scanning image layer utilization metrics in CI
RUN curl --silent --show-error --location "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.tar.gz" | \
      tar --extract --gzip --directory=/usr/local/bin --file=- dive && \
    # docker-credential-gcr is a Docker credential helper for pushing/pulling
    # images from Google Container Registry and Artifact Registry
    curl --silent --show-error --location "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${DOCKER_GCR_VERSION}/docker-credential-gcr_linux_amd64-${DOCKER_GCR_VERSION}.tar.gz" | \
      tar --extract --gzip --directory=/usr/local/bin --file=- docker-credential-gcr && \
    # golangci-lint performs static code analysis for our Go code
    curl --silent --show-error --location "https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz" | \
      tar --extract --gzip --directory=/usr/local/bin --file=- --strip-components=1 "golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint" && \
    # Anchore Grype for scanning container images for security issues
    curl --silent --show-error --location "https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz" | \
      tar --extract --gzip --directory=/usr/local/bin --file=- grype && \
    # AquaSec Trivy for scanning container images for security issues
    curl --silent --show-error --location "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" | \
      tar --extract --gzip --directory=/usr/local/bin --file=- trivy
