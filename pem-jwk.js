const fs = require('fs');
const { createPublicKey, createPrivateKey } = require('crypto');
const jose = require('jose');

async function pemToJwkWithThumbprint(pemFilePath) {
  try {
    // Read the PEM file
    const pemContent = fs.readFileSync(pemFilePath, 'utf8');

    let key;
    if (pemFilePath.endsWith("pub.pem")) {
        key = createPublicKey(pemContent);
    } else {
      key = createPrivateKey(pemContent);
    }

    // Convert the public key to JWK
    const jwk = await jose.exportJWK(key);

    // Calculate the JWK thumbprint
    const thumbprint = await jose.calculateJwkThumbprint(jwk);

    // Add the thumbprint as the 'kid'
    jwk.kid = thumbprint;

    return jwk;
  } catch (error) {
    console.error('Error converting PEM to JWK:', error);
    throw error;
  }
}

// Get the PEM file path from command line arguments
const args = process.argv.slice(2);
if (args.length !== 1) {
  console.error('Usage: node script.js <path_to_pem_file>');
  process.exit(1);
}

const pemFilePath = args[0];

// Check if the file exists
if (!fs.existsSync(pemFilePath)) {
  console.error(`File not found: ${pemFilePath}`);
  process.exit(1);
}

pemToJwkWithThumbprint(pemFilePath)
  .then(jwk => {
    console.log(JSON.stringify(jwk, null, 2));
  })
  .catch(error => {
    console.error('Conversion failed:', error);
    process.exit(1);
  });
