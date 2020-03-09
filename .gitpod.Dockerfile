FROM gitpod/workspace-full:build-branch-master

USER gitpod

# Install packages
RUN brew install git-flow
