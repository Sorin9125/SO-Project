#!/bin/bash

function autentificare() {
        echo -n "Introduceti numele: "
        read nume
        if  ! grep -q ",$nume," ../home/.registru.csv; then
                echo -n "Utilizatorul nu există. Vă rog să vă înregistrați!"
                return 1
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
        parola_utilizatorului=$(grep "$nume" ../home/.registru.csv | sed 's/^[^,]*,[^,]*,[^,]*,//' | sed 's/,.*//')
        while [ "$hash" != "$parola_utilizatorului" ]
        do
                echo -n "Parola nu este corecta! Reintroduceti parola: "
                read -s parola
                echo
                hash=$(echo -n "$parola" | sha256sum | sed 's/ .*//')
        done
        echo "Autentificarea a fost efectuată cu succes. Bun venit $nume"
        data=$(date)
        sed -i "/^[^,]*,$nume,/s/^\([^,]*,[^,]*,[^,]*,[^,]*\).*$/\1,$data/" ../home/.registru.csv
        cd ../home/"$nume"
        logged_in_users+=("$nume")
	echo "Pentru a te deloga te rog să execuți comanda source delogare.sh în directorul tău."
}

autentificare
