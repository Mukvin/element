#!/usr/bin/env sh
echo 'publish 10.1.2.111' >&2;
npm adduser --registry http://10.1.2.111:4873;
npm publish;

echo 'publish https://devopsnexus.kyligence.io/.' >&2;
npm adduser --registry https://devopsnexus.kyligence.io;
npm publish; 

echo 'end' >&2;
