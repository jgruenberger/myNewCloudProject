#!/usr/bin/env bash

set -x


echo "start now"


if [ $CI_WORKFLOW = "deploy" ]; then
  echo "DEPLOY WORKFLOW "

  brew install fastlane

  # Set environment variables
  export RELEASE_NOTES
  export VERSION_NUMBER
  export BUILD_NUMBER
  export KEY_CONTENT

  # Enable Fastlane debug mode
  #export FASTLANE_DEBUG=1
  cd ../fastlane
  
  fastlane ios promote_to_app_store

  echo "Deployment done"


else
  echo "NOT DEPLOY WORKFLOW " $CI_WORKFLOW
fi

exit 0
