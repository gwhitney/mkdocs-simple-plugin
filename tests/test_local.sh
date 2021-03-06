#!/bin/bash

set -e

# End-to-end testing via Bats (Bash automated tests)
function docker_run_integration_tests() {
docker build -t mkdocs-simple-test-runner:$1 -f- . <<EOF
  FROM python:$1
  COPY ./requirements.txt /workspace/requirements.txt
  RUN apt-get -y update && apt-get -yyy install bats gcc
  RUN pip install -r /workspace/requirements.txt
  COPY . /workspace
  ENTRYPOINT ["bats"]
  CMD ["/workspace/tests/test.bats"]
EOF

echo "Running E2E tests via Bats in Docker (python:$1) -------->"
docker run --rm -it -w /workspace mkdocs-simple-test-runner:$1
}

if [[ ! -z "$PYTHON_37_ONLY" ]]; then
  docker_run_integration_tests "3.7"
else
  docker_run_integration_tests "3"
  docker_run_integration_tests "3.6"
  docker_run_integration_tests "3.7"
  docker_run_integration_tests "3.8"
  docker_run_integration_tests "3.9"
fi
