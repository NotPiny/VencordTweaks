#!/bin/bash
if ! [ $USER == "root" ]; then
    echo "This only works as root lmao"
    exit 1
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

npm install -g pnpm@10.4.1
# Get rid of old files
echo "Removing old files..."
rm -rf ./remote/

# Scripts
echo "Downloading userplugins..."
cd scripts
node downloadPlugins.js
cd ..

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/Vendicated/Vencord.git remote
cd remote

# Install the dependencies
echo "Installing dependencies..."
pnpm install --frozen-lockfile

# Pre build setup
# Replace files in ./ with any found in ../overrides
echo "Replacing files with overrides..."
cp -r ../overrides/* ./

# Build the project
echo "Building the project..."
pnpm build

echo "Building the project for web..."
pnpm buildWeb

# Inject into the client
echo "Injecting into the client..."
pnpm inject

# Change file ownership of remote to the user who ran the script
chown -hR $SUDO_USER .

echo "Moving web files to main directory"
mv dist/extension-chrome.zip ../output/
mv dist/extension-firefox.zip ../output/

# Finished
echo "Finished installing. Feel free to close this terminal or run 'exit' to return to your normal shell"
