#!/bin/bash

mkdir ../home
touch ../home/registru.csv
chmod 600 ../home/registru.csv
#logged_in_users=()

function inregistrare() {
	echo -n "Introduceți numele: "
	read nume
	while grep -q "$nume" ../home/registru.csv
	do
		echo -n "Utilizatorul deja exista! Introduceti alt nume: "
		read nume
	done
	echo -n "Introduceți email-ul: "
	read email
	while [[ ! "$email" =~ ^[a-zA-Z0-9_-]+@(gmail\.com|yahoo\.com|outlook\.com|icloud\.com)$ ]]
	do
		echo -n "Email-ul nu este valid! Introduceți altă adresa de mail: "
		read email
	done
	echo -n "Introduceți parola: "
	read -s parola_initiala
	echo
	hash1=$(echo -n "$parola_initiala" | sha256sum | sed 's/ .*//')
	echo -n "Reintroduceți parola: "
	read -s confirmare_parola
	echo
	hash2=$(echo -n "$confirmare_parola" | sha256sum | sed 's/ .*//')
	while [ "$hash1" != "$hash2" ]
	do
		echo -n "Parolele nu corespund. Reintroduceți parola: "
		read -s confirmare_parola
		echo
		hash2=$(echo -n "$confirmare_parola" | sha256sum | sed 's/ .*//')
	done
	id=$((RANDOM + RANDOM))
	echo "$id,$nume,$email,$hash1" >> ../home/registru.csv
	mkdir ../home/"$nume"
	echo "Inregistrarea a fost efectuata cu succes"
	#echo "Confirmare înregistrare" | mail -s "Înregistrarea a fost efectuată cu succes" "$email"
}


function logare() {

        echo -n "Introduceti numele: "
        read nume
        if  ! grep -q "$nume" ../home/registru.csv; then
                echo -n "Utilizatorul nu există. Vă rog să vă înregistrați!"
		echo
		inregistrare
		echo -n "Introduceti numele: "
		read nume
	fi
	for i in "${!logged_in_users[@]}"; do
		if [ "$nume" == "${logged_in_users[i]}" ]; then
			echo -n "Utilizatorul este deja logat!"
			echo
			return 0
		fi
	done
        echo -n "Introduceți parola: "
        read -s parola
	echo
        hash=$(echo -n "$parola" | sha256sum | sed 's/ .*//')
	parola_utilizatorului=$(grep "$nume" ../home/registru.csv | sed 's/^[^,]*,[^,]*,[^,]*,//' | sed 's/,.*//')
        while [ "$hash" != "$parola_utilizatorului" ]
        do
                echo -n "Parola nu este corecta! Reintroduceti parola: "
                read -s parola
		echo
                hash=$(echo -n "$parola" | sha256sum | sed 's/ .*//')
        done
	echo "Autentificarea a fost efectuată cu succes. Bun venit $nume"
	data=$(date)
	sed -i "/^[^,]*,$nume,/s/^\([^,]*,[^,]*,[^,]*,[^,]*\).*$/\1,$data/" ../home/registru.csv
	#cd ../home/"$nume"
	logged_in_users+=("$nume")
}

function delogare() {
	echo -n "Cine se deloghează? "
	read nume
	while ! grep -q "$nume" ../home/registru.csv
	do
		echo -n "Utilizatorul nu exista. Introduceti alt nume: "
		read nume
	done
	for i in "${!logged_in_users[@]}"; do
		if [ "$nume" == "${logged_in_users[i]}" ]; then
			unset logged_in_users[i]
			echo "Utilizatorul a fost delogat cu succes"
			return 0
		fi
	done
	echo -n "Utilizatorul nu este autentificat"
	echo
}

#logare
#inregistrare
delogare
