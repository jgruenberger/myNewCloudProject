#!/usr/bin/env bash

set -x


echo "start now"


if [ $CI_WORKFLOW = "deploy" ]; then
  echo "DEPLOY WORKFLOW "

  brew install fastlane


  # Navigate to the fastlane directory
  cd ../fastlane


    # Remove the temporary private key file
    rm $PRIVATE_KEY_PATH

  echo "****************** Contents of the fastlane directory:"
  ls -l

  # Verify the private key format
  PRIVATE_KEY_PATH="key.p8"
  printf "%s" "$KEY_CONTENT" > $PRIVATE_KEY_PATH

  echo "Private key path: $PRIVATE_KEY_PATH"
  echo "Content of the private key file:"
  cat $PRIVATE_KEY_PATH
  echo "End content of the private key file:"

  openssl pkey -in "$PRIVATE_KEY_PATH" -noout -text || {
    echo "Failed to read private key. Please ensure the key is in PEM format and correctly specified."
  }

  echo "********************* Contents of the fastlane directory after key generation:"
  ls -l

  # Set environment variables
  export RELEASE_NOTES
  export VERSION_NUMBER
  export BUILD_NUMBER
  #export FASTLANE_PASSWORD
  export FASTLANE_USER
  export FASTLANE_SESSION

  echo "The fastlane session: $FASTLANE_SESSION"

  # Enable Fastlane debug mode
  export FASTLANE_DEBUG=1


  fastlane ios promote_to_app_store



  # Remove the temporary private key file
  rm $PRIVATE_KEY_PATH
  echo "Private key file removed: $PRIVATE_KEY_PATH"
  echo "Deployment done"


else
  echo "NOT DEPLOY WORKFLOW " $CI_WORKFLOW
fi

exit 0
