#! /bin/sh

openssl dgst -sha256 -binary L1 > H00
openssl dgst -sha256 -binary L2 > H01
openssl dgst -sha256 -binary L3 > H10
openssl dgst -sha256 -binary L4 > H11

cat H00 H01 | openssl dgst -sha256 -binary > H0
cat H10 H11 | openssl dgst -sha256 -binary > H1

cat H0 H1 | openssl dgst -sha256 -binary > TOP

hexdump -C TOP
