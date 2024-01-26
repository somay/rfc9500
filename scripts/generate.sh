#!/usr/bin/env bash

########
# PEMs #
########

# Generate public keys
for n in {1024,2048,4096}; do openssl dsa -in "./pem/testDLP${n}.pem" -pubout -out "./pem/testDLP${n}.pub.pem";  done
for n in {256,384,521}; do openssl ec -in "./pem/testECCP${n}.pem" -pubout -out "./pem/testECCP${n}.pub.pem";  done
for n in {1024,2048,4096}; do openssl rsa -in "./pem/testRSA${n}.pem" -pubout -out "./pem/testRSA${n}.pub.pem";  done


########
# HEXs #
########

mkdir -p hex

# Private keys in hex
openssl dsa -in ./pem/testDLP1024.pem -text -noout 2>/dev/null | grep "priv:" -A 2 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP1024.hex
openssl dsa -in ./pem/testDLP2048.pem -text -noout 2>/dev/null | grep "priv:" -A 2 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP2048.hex
openssl dsa -in ./pem/testDLP4096.pem -text -noout 2>/dev/null | grep "priv:" -A 3 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP4096.hex
openssl ec -in ./pem/testECCP256.pem -text -noout 2>/dev/null | grep "priv:" -A 3 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP256.hex
openssl ec -in ./pem/testECCP384.pem -text -noout 2>/dev/null | grep "priv:" -A 4 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP384.hex
openssl ec -in ./pem/testECCP521.pem -text -noout 2>/dev/null | grep "priv:" -A 5 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP521.hex

# Public keys in hex
openssl dsa -in ./pem/testDLP1024.pem -text -noout 2>/dev/null | grep "pub:" -A 9 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP1024.pub.hex
openssl dsa -in ./pem/testDLP2048.pem -text -noout 2>/dev/null | grep "pub:" -A 18 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP2048.pub.hex
openssl dsa -in ./pem/testDLP4096.pem -text -noout 2>/dev/null | grep "pub:" -A 35 | tail -n +2 | tr -d ' \n:' > ./hex/testDLP4096.pub.hex
openssl ec -in ./pem/testECCP256.pem -text -noout 2>/dev/null | grep "pub:" -A 5 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP256.pub.hex
openssl ec -in ./pem/testECCP384.pem -text -noout 2>/dev/null | grep "pub:" -A 7 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP384.pub.hex
openssl ec -in ./pem/testECCP521.pem -text -noout 2>/dev/null | grep "pub:" -A 9 | tail -n +2 | tr -d ' \n:' > ./hex/testECCP521.pub.hex
