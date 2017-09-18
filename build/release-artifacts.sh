#!/bin/bash

# Copyright 2014 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create release artifacts from '_output/dockerized' directory.
# This will create the tar files and the docker images based on the
# 'make cross' output.

set -o errexit
set -o nounset
set -o pipefail

# Check and error if not "in-a-container"
if [[ ! -f /.dockerenv ]]; then
  echo
  echo "'make cloud-release' can only be used from a docker container."
  echo
  exit 1
fi

KUBE_ROOT=$(dirname "${BASH_SOURCE}")/..
source "${KUBE_ROOT}/build/common.sh"
source "${KUBE_ROOT}/build/lib/release.sh"

TAR=$(which tar)
kube::version::get_version_vars
kube::release::package_tarballs
