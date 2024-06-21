#!/usr/bin/env bash

set -x


echo "start now"


if [ $CI_WORKFLOW = 'deploy' ]
then
    echo "DEPLOY WORKFLOW"
else
    echo "NOT DEPLOY WORKFLOW"
fi


# Fetch JWT
export JWT=$(ruby -r 'base64' -r 'openssl' -r 'json' -e "
  header = { 'alg' => 'ES256', 'kid' => $API_KEY_ID }
  payload = { 'iss' => $API_ISSUER_ID, 'iat' => Time.now.to_i, 'exp' => Time.now.to_i + 20 * 60, 'aud' => 'appstoreconnect-v1' }
  key = OpenSSL::PKey::EC.new $KEY_CONTENT
  token = Base64.urlsafe_encode64(header.to_json) + '.' + Base64.urlsafe_encode64(payload.to_json)
  signature = key.dsa_sign_asn1(Digest::SHA256.digest(token))
  puts token + '.' + Base64.urlsafe_encode64(signature)
")

# Promote build to App Store
curl -X PATCH \
  https://api.appstoreconnect.apple.com/v1/builds/{BUILD_ID} \
  -H "Authorization: Bearer $JWT" \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "type": "builds",
      "id": "'$CI_BUILD_NUMBER'",
      "attributes": {
        "usesNonExemptEncryption": false,
        "individualTesters": [],
        "reviewDetails": {
          "items": [
            {
              "item": {
                "testers": []
              }
            }
          ]
        }
      },
      "relationships": {
        "preReleaseVersion": {
          "data": {
            "type": "preReleaseVersions",
            "id": "'$VERSION_ID'"
          }
        }
      },
      "attributes": {
        "releaseNotes": "'$RELEASE_NOTES'"
      }
    }
  }'

  echo "done"





