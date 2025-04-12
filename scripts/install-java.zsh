JAVA_VERSION="21.0.6-tem"

curl -s "https://get.sdkman.io" | bash
sdk selfupdate force

sdk install java $JAVA_VERSION
