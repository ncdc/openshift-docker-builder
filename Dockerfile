FROM ironcladlou/fedora-dind

CMD ["with_docker_service", "docker build --rm -t $BUILD_TAG $DOCKER_CONTEXT_URL"]
