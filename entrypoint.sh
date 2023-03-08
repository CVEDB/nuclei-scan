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
           --github_secret "${INPUT_GITHUB_SECRET}" \
           "${GITHUB_WORKSPACE}"
