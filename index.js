const core = require('@actions/core');
const exec = require("@actions/exec");

async function run() {
    try {
        const src = __dirname;
        await exec.exec(`${src}/deploy_server.sh`) ;
    } catch (error) {
        core.setFailed(error.message);
    }
}

run();