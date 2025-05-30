#!/bin/bash

if [ ! -d ../home ]; then
	mkdir ../home
fi
if [ ! -f ../home/.registru.csv ]; then
	touch ../home/.registru.csv
	chmod 600 ../home/.registru.csv
fi



#logare
#inregistrare
#delogare
