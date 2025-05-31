#!/bin/bash

#cd ../
#cale=$(pwd)
#echo "$cale"

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
echo "3. Delogare"
echo "4. Generare raport"
echo "5. Iesire"
echo -n "Ce vrei să faci? (introduceți numărul corespunzător operațiunii) "
#while true 
#do
	read actiune
	case "$actiune" in
		1)
			bash inregistrare.sh
			;;
		2)
			source autentificare.sh
			if [ "$?" != 0 ]; then
				bash inregistrare.sh
			fi
			
			;;
		3)
			source delogare.sh
			;;
		4)
			bash generare_raport.sh
			;;
		5)
			echo "La revedere"
			return 0
			;;
		*)
			echo "Nu există operațiunea"
			;;
	esac
#done
}

meniu
