#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

read -p "Your deposited ethereum will be locked for an uncertain period of time. Do you want to proceed? (y/n): " LOCK_CONFIRM
case "${LOCK_CONFIRM,,}" in
    y|yes)
        ;;
    *)
        echo -e "${YELLOW}Operation cancelled by the user.${NC}"
        exit 0
        ;;
esac

read -p "You need to deposit a minimum of 0.002 ETH. Do you want to proceed? (y/n): " MIN_AMOUNT_CONFIRM
case "${MIN_AMOUNT_CONFIRM,,}" in
    y|yes)
        ;;
    *)
        echo -e "${YELLOW}Operation cancelled by the user.${NC}"
        exit 0
        ;;
esac

read -p "This interaction does not guarantee any airdrop. Would you still like to proceed? (y/n): " AIRDROP_CONFIRM
case "${AIRDROP_CONFIRM,,}" in
    y|yes)
        ;;
    *)
        echo -e "${YELLOW}Operation cancelled by the user.${NC}"
        exit 0
        ;;
esac

command_exists() {
    command -v "$1" &> /dev/null
}

if command_exists nvm; then
    echo -e "${GREEN}NVM is already installed.${NC}"
else
    echo -e "${YELLOW}Installing NVM...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    source ~/.bashrc
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if command_exists node; then
    echo -e "${GREEN}Node.js is already installed: $(node -v)${NC}"
else
    echo -e "${YELLOW}Installing Node.js LTS...${NC}"
    nvm install --lts
    nvm use --lts
    echo -e "${GREEN}Node.js installed: $(node -v)${NC}"
fi

echo -e "${YELLOW}Installing Yarn...${NC}"
npm install -g yarn
echo
echo -e "${YELLOW}Cloning the repository...${NC}"
echo
git clone https://github.com/Eclipse-Laboratories-Inc/eclipse-deposit.git
cd eclipse-deposit
echo
echo -e "${YELLOW}Installing project dependencies...${NC}"
npm install
echo
echo -e "${BLUE}Enter your Ethereum Wallet private key:${NC} "
read PVT_KEY
echo
echo "$PVT_KEY" > pvt-key.txt
echo

echo -e "${BLUE}Enter ether amount you want to deposit in Eclipse Mainnet (Min: 0.002 ETH):${NC} "
read ETH_AMOUNT
echo

echo -e "${BLUE}Enter Your Solana Address (Your deposited ${ETH_AMOUNT} will be bridged to this address):${NC} "
read SOLANA_ADDRESS
echo

echo -e "${YELLOW}Executing the node command...${NC}"
echo
node bin/cli.js -k pvt-key.txt -d "$SOLANA_ADDRESS" -a "$ETH_AMOUNT" --mainnet
echo
echo -e "${GREEN}Deposits will finalize and be processed in about 2-3 minutes.${NC}"
echo
echo -e "${GREEN}You can check Eclipse Deposit Tx here:${NC} https://explorer.eclipse.xyz/address/$SOLANA_ADDRESS"
echo
echo -e "${GREEN}Follow @ZunXBT on X for guides like this${NC}"
echo
