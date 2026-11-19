#!/bin/bash

set -e

# install easy-rsa
sudo apt install -y easy-rsa

#Forward SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -A INPUT -p tcp --dport 443 -j DROP



PKI_DIR="/home/$USER/easy-rsa"
CA_CERT=$PKI_DIR/pki/ca.crt

# Check file CRT
if [ -f "$CA_CERT" ]; then
	echo "File .crt exist at $CA_CERT"
	exit 0
fi

echo "PKI Initialization..."

# Check directory easy-rsa
if [ ! -d /usr/share/easy-rsa ]; then
	echo "ERROR! easy-rsa not installed, that directory and file is not exist.Needed sudo apt install easy-rsa" >&2
	exit 1
fi


# Check symbolic
if [ -d $PKI_DIR ]; then
	echo "Symbolic Directory exist"
	exit 0
else
	mkdir -p "$PKI_DIR"
	ln -s /usr/share/easy-rsa/* "$PKI_DIR/"

fi

echo "PKI Initialization at $PKI_DIR"

cd $PKI_DIR

# Check vars file, init-pki
#if [ -f $PKI_DIR/vars ]; then
#	easyrsa init-pki
#	easyrsa build-ca
#	echo "PKI Allrigt. CA:$CA_CERT "
#else
#	echo "needed vars file"
#	exit 0
