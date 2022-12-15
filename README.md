# asterisk-lenny

Ce projet vous permet de mettre en place un troll à call center en quelques instants. Lenny leur fera perdre un maximum de temps en les gardant le plus longtemps au bout du fil.

## Installation

Il vous suffit d'installer Docker sur votre machine et d'executer la commande suivante:

```
docker run -ti -p 5060:5060/udp \
--name asterisk-lenny --hostname asterisk-lenny \
-d --restart unless-stopped mickaelmonsieur/asterisk-lenny:latest

```

Asterisk écoutera sur le port UDP 5060 et toutes les adresses SIP (*@0.0.0.0:5060) répondront aux appels.

Quelques exemples d'URI valides : +3228889716@192.0.2.1:5060, 028889716@10.1.1.1, 9716@172.17.0.7:5060,...

Il nous vous reste plus qu'rediriger n'importe quel DID vers votre Asterisk sans devoir ajouter une extension dans le dialplan.

## Crédits

* Mango de toao.net
* crosstalk solutions
* Richard Klein pour les fichiers vocaux francophones de Robert, entre autre. https://m2mdevice.blogspot.com/2021/07/lenny-robert-sous-asteriskfreepbx.html
