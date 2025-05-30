#!/bin/bash

function generare_raport() {
	if [ ! -f ../home/"$1"/raport.txt ]; then
		touch ../home/"$1"/raport.txt
		chmod 640 ../home/"$1"/raport.txt
	fi
	numar_fisiere=$(find ../home/"$1" -type f | wc -l)
	numar_directoare=$(find ../home/"$1" -type d | wc -l)
	dimensiunea_totala=$(du -sh ../home/"$1"  | sed 's/	.*//')
	echo "Raportul pentru $nume" > ../home/"$1"/raport.txt
	echo "Numărul de  fișiere: $numar_fisiere" >> ../home/"$1"/raport.txt
	echo "Numărul de directoare: $numar_directoare" >> ../home/"$1"/raport.txt
	echo "Dimensiunea totală a fișierelor: $dimensiunea_totala" >> ../home/"$1"/raport.txt
}

echo -n "Introduceți numele: "
	read nume
        while ! grep -q ",$nume," ../home/.registru.csv
        do
		echo -n "Utilizatorul nu există. Vă rog să introduceți alt nume: "
                read nume
        done

generare_raport "$nume" &
