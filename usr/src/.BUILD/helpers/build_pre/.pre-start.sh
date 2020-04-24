source ./helpers/build_pre/.pre-global-vars.sh;
source ./helpers/build_pre/.pre-dependency-install.sh; ##checks all @DEPENDENCIES in tact
source ./helpers/build_pre/.pre-build-unpack.sh; ##unpack tar and enters the app dir

echo "Configuring ${APP_NAME}-${VERSION}...";
