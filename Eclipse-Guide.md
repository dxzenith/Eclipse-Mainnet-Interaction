<h1 align=center>Guide of Bridging ETH to Eclipse Mainnet</h1>

- Install NVM and Node.js using the below command
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && export NVM_DIR="/usr/local/share/nvm"; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"; source ~/.bashrc; nvm install --lts; nvm use --lts
```
- Install `yarn` using below command
```bash
npm install -g yarn
```
- Clone the git repository using below mentioned command
```bash
git clone https://github.com/Eclipse-Laboratories-Inc/eclipse-deposit.git && cd eclipse-deposit.git
```
- Install this project's dependencies using below command
```bash
npm install
```
- Now create a file `(pvt-key.txt)` using below command and Enter your Ethereum wallet Private Key
```bash
nano pvt-key.txt
```
- To save this file, Press `Ctrl + X` and then press `Y` and then press `Enter` button
- Now modify the below command with required data and use it to initiate the bridging process
```bash
node bin/cli.js -k pvt-key.txt -d <solana_destination_address> -a <amount_in_ether> --mainnet
```
- `<solana_destination_address>` : Your Solana Address (It is also your Eclipse Mainnet Wallet address), After bridging $ETH from Ethereum Mainnet, you will recieve Bridged $ETH in this solana address
- `<amount_in_ether>` : Here u need to mention the amount of Ethereum you want to bridge from Ethereum Mainnet to Eclipse Mainnet. For bridging to Eclipse Mainnet, the minimum amount is 0.002 $ETH
- After modification, your command will look like this `node bin/cli.js -k pvt-key.txt -d pvt-key.txt -d 8qPPLXguubuXH6X3NMoYFhb8xAN1ppdyqs2o4XeL15z7 -a 0.002 --mainnet`
- Done ✅, Your bridge tx will be processed within 3-4 mins, You can check tx in `Eclipse Explorer` via [this link](https://explorer.eclipse.xyz/)
