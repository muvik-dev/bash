#!/bin/bash

echo "This is a simple script, good luck!)"
echo " -------------------------------------------------"
echo "Ниже вы сможете увидеть свой адрес кошелька"
echo " -------------------------------------------------"
sui keytool list
echo " -------------------------------------------------"
read -p "Введите адрес получения токенов: " DEPOSIT_ADDRESS

echo " -------------------------------------------------"
read -p "Введите id токена (id можно узнать в https://explorer.devnet.sui.io/ ) (В поиске вводите ваш адрес кошелька) ID токена можно увидеть нажав на Type SUI - Object ID: " TOKEN_ID

echo " -------------------------------------------------"
read -p "Введите количество транзакций: " NUMBER_OF_TRANSACTIONS

echo " -------------------------------------------------"
echo "На адрес $DEPOSIT_ADDRESS будет отправлено $NUMBER_OF_TRANSACTIONS транзакций. Диапазон монет будет от 1 до 100"

sleep 1

for (( i=1; i<=$NUMBER_OF_TRANSACTIONS; i++ ))
do
  sui client transfer-sui --to $DEPOSIT_ADDRESS --sui-coin-object-id $TOKEN_ID --gas-budget 400 --amount $(( $RANDOM % 100 + 1 ))
done
