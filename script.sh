#!/bin/bash

mkdir ../home
touch ../home/registru.csv
chmod 600 ../home/registru.csv

function inregistrare() {
  echo -n "Introduceti numele: "
  read nume
  while grep "$nume" ../home/registru.csv
     do
       echo -n "Utilizatorul deja exista! Introduceti alt nume: "
       read nume
     done
   echo -n "Introduceti email-ul: "
   read email
   while [[ ! "$email" =~ ^[a-zA-Z0-9_-]+@(gmail\.com|yahoo\.com|outlook\.com|icloud\.com)$ ]]
     do
       echo -n "Email-ul nu este valid! Introduceti alta adresa de mail: "
       read email
     done
   echo -n "Introduceti parola: "
   read parola_initiala
   hash1=$(echo -n "$parola_initiala" | sha256sum | sed 's/ .*//')
   echo -n "Reintroduceti parola: "
   read confirmare_parola
   hash2=$(echo -n "$confirmare_parola" | sha256sum | sed 's/ .*//')
   while [ "$hash1" != "$hash2" ]
     do
       echo -n "Parolele nu corespund. Reintroduceti parola: "
       read confirmare_parola
       hash2=$(echo -n "$confirmare_parola" | sha256sum | sed 's/ .*//')
     done
   id=$((RANDOM + RANDOM))
   echo "$id,$nume,$email,$hash1" >> ../home/registru.csv
   mkdir ../home/"$nume"
   #echo "Confirmare inregistrare" | mail -s "Inregistrarea a fost efectuata cu succes" "$email"
}

inregistrare
