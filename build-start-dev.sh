# !/bin/bash
rm -rf ./dist
tsc
cp -r ./src/view/views ./dist/src/view/
cp -r ./src/view/public/css ./dist/src/view/public/
cp -r ./src/view/public/imgs ./dist/src/view/public/
cp -r ./src/view/public/bs ./dist/src/view/public/
node ./dist/src/start.js