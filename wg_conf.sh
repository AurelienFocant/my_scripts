#!/bin/bash

printf "What is the first letter of your first name? "
read letter

case $letter in
	v|V)
		printf "Hi Vicente\n"
		address=10.6.0.17/32
		;;
	l|L)
		printf "Hi Leo\n"
		address=10.6.0.18/32
		;;
	c|C)
		printf "Hi Cameronne\n"
		address=10.6.0.19/32
		;;
	*)
		printf "Wrong user, sorry\n"
		exit 1
		;;
esac


serverPublicKey=/xWa1CDzGvgSqYFYwxtEAffUJyxBehcYSepjCdXeCQ0=
wg_dir=$HOME/wire
keys_dir=$wg_dir/keys
privateKey=$keys_dir/privateKey
publicKey=$keys_dir/publicKey
configFile=${wg_dir}/wgAurel.conf

mkdir -p $keys_dir
wg genkey | tee $privateKey | wg pubkey > $publicKey


<<- EOF cat >$configFile
	[Interface]
	PrivateKey = $(cat $privateKey)
	Address = $address
	DNS = 1.1.1.1

	[Peer]
	PublicKey = $serverPublicKey
	Endpoint = born2vpn.duckdns.org:47183
	AllowedIPs = 0.0.0.0/0
	PersistentKeepAlive = 25
EOF


<<- EOF cat

	-- Your Wireguard config file has been created at
	$configFile

	-- Use it with the GUI Wireguard app !

	-- Or if you want to use the cli, use:
	sudo wg-quick up $configFile

	-- You can then see the interface with
	sudo wg show

	-- And finally disconnect with
	sudo wg-quick down $configFile

EOF
