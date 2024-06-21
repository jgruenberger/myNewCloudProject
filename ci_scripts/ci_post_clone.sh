#!/usr/bin/env bash

set -x

          API_KEY_ID="Q9Q9ZY5LCB"
          API_ISSUER_ID="69a6de76-b502-47e3-e053-5b8c7c11a4d1"
          KEY_CONTENT="MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg2yfjm6Qlrt4O3zsA
TEE9aBYPkgTXbeu5QRSptcIgwHagCgYIKoZIzj0DAQehRANCAARaPMyqTrYfxfRG
Q3lGoQm2wiPEpvPWgi0vWZ17jcku4beMtiMGA/Qut4R0an7xwruZEtMYvZZcMoga
coO2BCxl"
          APP_ID="2Z97DX66EX.com.threedeers.myCloudApp.myNewCloudProject"
          BUILD_NUMBER="1"
          VERSION_NUMBER="1.0"
          RELEASE_NOTES="these are my release notes...."

    echo "start now"

# Fetch JWT
JWT=$(ruby -r 'base64' -r 'openssl' -r 'json' -e "
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
      "id": "'$BUILD_ID'",
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
