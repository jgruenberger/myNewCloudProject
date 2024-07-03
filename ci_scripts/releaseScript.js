const fs = require('fs');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const minimist = require('minimist');


// Parse command line arguments
const args = minimist(process.argv.slice(2));

// Extract required parameters
const ISSUER_ID = args.ISSUER_ID || args.issuer_id || args.i;
const KEY_ID = args.KEY_ID || args.key_id || args.k;
const PRIVATE_KEY_PATH = args.PRIVATE_KEY_PATH || args.private_key_path || args.p;
let jsonWebToken;

if (!ISSUER_ID || !KEY_ID || !PRIVATE_KEY_PATH) {
    console.error('Missing required parameters: ISSUER_ID, KEY_ID, PRIVATE_KEY_PATH');
    process.exit(1);
}

console.log('issuer_id: '+ISSUER_ID);
console.log('Key_id: '+KEY_ID);


generateKeyFile()
    .then(() => callFastlane())
    .then(() => deleteKey())
    .then(() => done())
    .catch((err) => {
        console.error(err);
        process.exit(1);
    });
function generateKeyFile() {

}

function callFastlane() {

}


function deleteKeyFile() {

}


// function generateToken() {
// // Read the private key
//     let privateKey;
//     try {
//         privateKey = fs.readFileSync(PRIVATE_KEY_PATH, 'utf8');
//         console.log("Private Key:\n", privateKey);
//     } catch (err) {
//         console.error('Failed to read private key:', err);
//         process.exit(1);
//     }
//
//     console.log("Private Key:\n", privateKey);
//
// // Generate the JWT
//     jsonWebToken = jwt.sign(
//         {
//             iss: ISSUER_ID,
//             exp: Math.floor(Date.now() / 1000) + (20 * 60), // 20 minutes from now
//             aud: 'appstoreconnect-v1'
//         },
//         privateKey,
//         {
//             algorithm: 'ES256',
//             header: {
//                 kid: KEY_ID
//             }
//         }
//     );
//     return Promise.resolve();
// }
//
//
// async function makeAppleCalls(){
//
// const config = {
//     headers: {
//         'Authorization': `Bearer ${jsonWebToken}`
//     }
// }
//
// // Make the API request using axios
// const bundleIdString = 'com.threedeers.myCloudApp.myNewCloudProject';
//
// console.log("Generated JWT:\n", jsonWebToken);
//  const response_appid = await axios.get(`https://api.appstoreconnect.apple.com/v1/apps?filter[bundleId]=${bundleIdString}`, config);
// if (!response_appid.data || !response_appid.data.data || !response_appid.data.data.length > 0) {
//     console.error('No app data found in the response.');
// }
//
//
//     // get app id
//     const appId = response_appid.data.data[0].id;
//     console.log('API Response get appid:', response_appid.data);
//
//     // get buildId
//     const response_buildid = await axios.get(`https://api.appstoreconnect.apple.com/v1/builds?filter[app]=${appId}&sort=-uploadedDate&limit=1`, config);
//
//     if (!response_buildid.data || !response_buildid.data.data || !response_buildid.data.data.length > 0) {
//         console.error('No app data found in the response.');
//     }
//
//     console.log('API Response:', response_buildid.data);
//     const bundleId = response_appid.data.data[0].id;
//     const response_get_version = await axios.get(`https://api.appstoreconnect.apple.com/v1/builds/${bundleId}/preReleaseVersion`, config )
//     if (!response_get_version.data || !response_get_version.data.data || !response_get_version.data.data.length > 0) {
//         console.error('No get_version data found in the response.');
//     }
//     console.log('API Response get version:', response_get_version.data);
//
//     const version = response_get_version.data.data
//
// //     // create new version app store
// //     $ curl --location 'https://api.appstoreconnect.apple.com/v1/appStoreVersions' \
// // --header 'Content-Type: application/json' \
// // --header 'Authorization: Bearer lONG_GENERATED_TOKEN' \
// // --data '{
// //     "data": {
// //         "type": "appStoreVersions",
// //             "attributes": {
// //             "platform":"IOS",
// //                 "versionString":"lastAppVersion"
// //         },
// //         "relationships": {
// //             "app": {
// //                 "data": {
// //                     "type":"apps",
// //                         "id":"appId"
// //                 }
// //             }
// //         }
// //     }
// // }
//
//
//
//
//     // .then(response => {
//     //     console.log('API Response:', response.data);
//     //     if (response.data && response.data.data && response.data.data.length > 0) {
//     //             const appId = response.data.data[0].id;
//     //             console.log('Extracted App ID:', appId);
//     //            axios.get(`https://api.appstoreconnect.apple.com/v1/builds?filter[app]=${appId}&sort=-uploadedDate&limit=1`, {
//     //                 headers: {
//     //                     'Authorization': `Bearer ${token}`
//     //                 }
//     //            })
//     //     } else {
//     //         console.log('No app data found in the response.');
//     //     }
//     // })
//     // .catch(error => {
//     //     console.error('API Request Failed:', error.response ? error.response.data : error.message);
//     // });
//     return Promise.resolve();
// }
function done() {

    console.log('Release - Success!');
}
