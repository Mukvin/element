#!/usr/bin/env sh
echo 'remove old node modules' >&2;
rm -rf node_modules || { exit 1; }

echo 'remove old yarn.lock' >&2;
rm -rf yarn.lock  || { exit 1; }

echo 'chear cache' >&2;
npm cache verify;

echo 'yarn install' >&2;
yarn || { exit 1; }

echo 'build file' >&2;
npm run dist || { exit 1; }

echo 'publish 10.1.2.111' >&2;
npm adduser --registry http://10.1.2.111:4873;
npm publish --registry http://10.1.2.111:4873;
