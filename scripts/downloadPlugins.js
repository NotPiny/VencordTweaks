const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const plugins = fs.readFileSync(path.resolve(__dirname, '../plugins.map'), 'utf8').split('\n');
fs.rmSync(path.resolve(__dirname, '../overrides/src/userplugins'), { recursive: true, force: true });
if (!fs.existsSync('./tmp')) fs.mkdirSync(`./tmp`)
plugins.forEach(plugin => {
    if (plugin == '') return; // Skip empty lines
    // Plugin looks like: "src/userplugins/Quoter;https://github.com/cheesesamwich/Tobleronecord.git;/src/tobleroneplugins/Quoter"
    // So we split it by the semicolon
    // 0: src/userplugins/Quoter - The path to the destination in the overrides folder
    // 1: [url] - The URL to clone the plugin from
    // 2: /src/tobleroneplugins/Quoter - The path to the plugin in the repo
    const [dest, url, src] = plugin.split(';');

    // Clone it into ./tmp/currentPlugin
    if (url.startsWith('LOCAL_')) {
        // The folder is already downloaded at ../local/userplugins
        execSync(`cp -r ../local/userplugins/${url.substring(6)} ./tmp/currentPlugin`);
    } else {
        execSync(`git clone ${url} ./tmp/currentPlugin`);
    }

    // Copy the directory from ./tmp/currentPlugin/src/tobleroneplugins/Quoter to ./overrides/src/userplugins/Quoter
    fs.mkdirSync(path.resolve(__dirname, `../overrides/${dest}`), { recursive: true });
    execSync(`cp -r ./tmp/currentPlugin${src}/* ../overrides/${dest}`);

    // Remove the cloned plugin
    fs.rmSync(path.resolve(__dirname, './tmp/currentPlugin'), { recursive: true, force: true });

    console.log(`Downloaded ${dest}`);
})
fs.rmSync(path.resolve(__dirname, './tmp'), { recursive: true, force: true });

