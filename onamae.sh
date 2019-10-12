#!/bin/bash

# account information
userId='0123456'
password='password'

# domain
hosts=('' 'www' 'site1' 'site2')
domain='example.com'

ipAddr=`curl 'ipinfo.io/ip'`
for host in hosts; do
	cat <<- EOS | openssl s_client -connect ddnsclient.onamae.com:65010 -quiet
	LOGIN
	USERID:$userId
	PASSWORD:$password
	.
	MODIP
	HOSTNAME:$host
	DOMNAME:$domain
	IPV4:$ipAddr
	.
	LOGOUT
	.
	EOS
done
