#!/usr/bin/env sh
echo 'yarn install' >&2;
yarn || { exit 1; }

echo 'build file' >&2;
npm run dist || { exit 1; }

echo 'publish 10.1.2.111' >&2;
npm adduser --registry http://10.1.2.111:4873;
npm publish --registry http://10.1.2.111:4873;