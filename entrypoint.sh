#!/bin/bash

set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

BUILD=${INPUT_BUILD:-GitHubAction}

export NUCLEI_RUN_AS=nuclei
nuclei iac --tags "system:github" \
           --tags "build:${BUILD}" \
           --tags "repository:${GITHUB_REPOSITORY}" \
           --tags "branch:${GITHUB_REF_NAME}" \
           --tags "git_user:${GITHUB_ACTOR}" \
           --nuclei-key "${INPUT_NUCLEI_KEY}" \
           --nuclei-secret "${INPUT_NUCLEI_SECRET}" \
           "${GITHUB_WORKSPACE}"
