https://docs.arbitrum.io/launch-orbit-chain/orbit-gentle-introduction

Deploy Locally
Once you've downloaded both config files, please follow the steps below to complete local deployment of your Orbit chain. For more details on the steps involved and additional context, please visit the documentation.

Clone the https://github.com/OffchainLabs/orbit-setup-script repository, and run:


`yarn install`

Then, move both the nodeConfig.json and orbitSetupScriptConfig.json files into the config directory within the cloned repo.

Launch Docker, and in the base directory, run:


`docker compose up -d`

This will launch the node with a Public RPC reachable at http://localhost:8449 and a corresponding BlockScout explorer instance, viewable at http://localhost.

Then, add the private key for the wallet you used to deploy the rollup contracts earlier in the following command, and run it:


`PRIVATE_KEY="0xYourPrivateKey" L2_RPC_URL="https://sepolia-rollup.arbitrum.io/rpc" L3_RPC_URL="http://127.0.0.1:8449" yarn run setup`

The Orbit chain is now set up. You can find all the information about the newly deployed chain in the outputInfo.json file, which is in the main directory of the script folder.

Optionally, to track logs, run the following command within the base directory:


`docker compose logs -f nitro`
