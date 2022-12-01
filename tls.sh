#!/bin/bash
openssl genrsa -aes256 -passout pass:P@$$w0rd -out server.key 4096
openssl rsa -in server.key -out server.key.insecure -passin pass:P@$$w0rd
mv server.key server.key.secure
mv server.key.insecure server.key
openssl req -new -newkey rsa:4096 -x509 -nodes -days 365 -keyout server.key -out server.cert -subj "/C=SG/ST=Singapore/L=Singapore /O=Kok How Pte. Ltd./OU=TLSCerts/CN=localhost/emailAddress=funcoolgeek@gmail.com" -passin pass:P@$$w0rd
microk8s kubectl create secret generic server-key --from-file=server.key
microk8s kubectl create secret generic server-cert --from-file=server.cert
#openssl pkcs12 -export -out /tmp/localhost.pfx -inkey server.key -in server.crt -certfile server.crt -passout pass:AspNetCoreWebApi
