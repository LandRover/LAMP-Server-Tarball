source ./helpers/build_pre/.pre-global-vars.sh;
source ./helpers/build_pre/.alias.sh;                      # Handle alias creation
source ./helpers/build_pre/.pre-dependency-install.sh;     # Checks all @DEPENDENCIES in tact
source ./helpers/build_pre/.pre-build-unpack.sh;           # Unpack tar and enters the app dir

echo "Configuring ${APP_NAME}-${VERSION}...";
