#! bin/bash

function logare() {
	touch ../home/deja_logati.csv
	chmod 600 ../home/deja_logati.csv

	echo "Logare"

	echo -n "Mailul: "
	read mail
	while  grep "$mail" ../home/registru.csv || grep "$mail" ../home/deja_logati
	do
		if grep "$mail" ../home/deja_logati.csv; then
			echo -n "User-ul este deja logat! Introduceti alt mail: "
			read mail
		else
			echo -n  "Mailul este gresit! Introduceti alt mail: "
			read mail
		fi
	done

	echo -n "Parola: "
	read parola
	hash = $(echo -n "parola" | sha256sum | sed 's/ .*//')
	while grep "$hash" ../home/registru.csv
	do
		echo -n "Parola nu este corecta! Reintroduceti parola: "
		read parola
		hash = $(echo -n "parola" | sha256sum | sed 's/ .*//')
	done

	touch ../home/last_login.csv
	chmod 600 ../home/last_login.csv

	if grep "$mail" ../home/last_login.csv; then
		sed -i "s/^$mail:*/$mail: $(date +%Y-%m-%d/" last_login.csv
	else
		echo "$mail: $(date +%Y-%m-%d)" >> ../home/last_login.csv
	fi

	if [ ! grep "$mail" ../home/deja_logati.csv ] ; then
		echo "$mail: $(date +%Y-%m-%d)" >> ../home/deja_logati.csv
	fi
}

logare
#nu merge linia 42
