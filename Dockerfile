FROM ironcladlou/fedora-dind
ADD ./build.sh /tmp/build.sh
CMD ["/tmp/build.sh"]
