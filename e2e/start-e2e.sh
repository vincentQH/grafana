#!/bin/bash

echo -e "Starting Grafana Server E2E Scenario"

rm -rf e2e/tmp

mkdir e2e/tmp

echo -e "Copying grafana backend files to temp dir..."

ls dist/grafana-latest-linux*

if ls dist/grafana-latest-linux* 1> /dev/null 2>&1; then
  echo "Found built tar file"
  tar zxvf dist/grafana-latest-linux*
else
  echo "Copying local dev files"

  cp -r ./bin e2e/tmp
  cp -r ./public e2e/tmp

  mkdir e2e/tmp/conf
fi

cp ./conf/defaults.ini e2e/tmp/conf/defaults.ini
cp ./e2e/conf/scenario1.ini e2e/tmp/conf/custom.ini

cd e2e/tmp

./bin/grafana-server --pidfile=pid 2>&1 > output.log &

cd ../../