#!/bin/bash

function inregistrare() {
        echo -n "Introduceți numele: "
        read nume
        while grep -q ",$nume," ../home/.registru.csv
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
        data=$(date)
	echo "$id,$nume,$email,$hash1,$data" >> ../home/.registru.csv
        mkdir ../home/"$nume"
	cp delogare.sh ../home/"$nume"
        echo "Înregistrarea a fost efectuată cu succes"
	cd ../home/"$nume"
	logged_in_users+=("$nume")
	echo "Pentru a te deloga te rog să execuți comanda source delogare.sh în directorul tău."
        echo "Confirmare înregistrare" | mail -s "Înregistrarea a fost efectuată cu succes!" "$email"
	if mailq | grep -B 3 "$email" | grep "No route to host"; then
		echo "Mail-ul nu s-a putut trimite!"
	fi
}

inregistrare
