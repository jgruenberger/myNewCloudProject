#!/usr/bin/env bash

set -x


echo "start now"


if [ $CI_WORKFLOW = "deploy" ]; then
  echo "DEPLOY WORKFLOW "
  brew install fastlane

  # Verify the private key format
  PRIVATE_KEY_PATH="key.p8"
  printf "%s" "$KEY_CONTENT" > $PRIVATE_KEY_PATH

  echo "Private key path: $PRIVATE_KEY_PATH"

  openssl pkey -in "$PRIVATE_KEY_PATH" -noout -text || {
    echo "Failed to read private key. Please ensure the key is in PEM format and correctly specified."
  }


  # Set environment variables
  export RELEASE_NOTES
  export VERSION_NUMBER
  export BUILD_NUMBER


  fastlane ios promote_to_app_store

  # Remove the temporary private key file
  rm $PRIVATE_KEY_PATH
  echo "Private key file removed: $PRIVATE_KEY_PATH"
  echo "Deployment done"
  exit 0

else
  echo "NOT DEPLOY WORKFLOW " $CI_WORKFLOW
  exit 0
fi


exit 0
