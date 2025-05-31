#!/bin/bash

if [ ! -d ..//home ]; then
	mkdir ../home
fi
if [ ! -f ../home/.registru.csv ]; then
	touch ../home/.registru.csv
	chmod 600 ../home/.registru.csv
fi
function meniu() {
echo "---Meniu principal---"
echo "1. Înregistrare"
echo "2. Autentificare"
echo "3. Generare raport"
echo "4. Iesire"
echo -n "Ce vrei să faci? (introduceți numărul corespunzător operațiunii) "
read actiune
while true 
do
	case "$actiune" in
		1)
			source inregistrare.sh
			return 0
			;;
		2)
			source autentificare.sh
			if [ "$?" != 0 ]; then
				source inregistrare.sh
			fi
			return 0
			;;
		3)
			bash generare_raport.sh
			return 0
			;;
		4)
			echo "La revedere"
			return 0
			;;
		*)
			echo -n "Nu există operațiunea. Introducți altă comandă! "
			read actiune
			;;
	esac
done
}

meniu
