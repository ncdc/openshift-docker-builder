FROM ironcladlou/fedora-dind
CMD ["with_docker_service", "docker build --rm -t $DOCKER_REGISTRY/$BUILD_TAG $DOCKER_CONTEXT_URL && docker push $DOCKER_REGISTRY/$BUILD_TAG"]
