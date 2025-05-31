#!/bin/bash

function delogare() {

#        echo -n "Cine se deloghează? "
#        read nume
#        while ! grep -q ",$nume," ../home/.registru.csv
#        do
#                echo -n "Utilizatorul nu exista. Introduceti alt nume: "
#                read nume
#        done
	nume=$(basename "$(pwd)")
        for i in "${!logged_in_users[@]}"
	do
                if [ "$nume" == "${logged_in_users[i]}" ]; then
                        unset logged_in_users[i]
                        echo "Utilizatorul $nume a fost delogat cu succes"
                        cd ../../SO-Project
			return 0
                fi
        done
        echo -n "Utilizatorul nu este autentificat"
        echo
}

delogare
