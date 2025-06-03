# -----------------------------------------------------------------------------
# Script d'automatisation pour connecter un serveur Proxmox à Internet
# via le partage de connexion USB d’un téléphone.
#
# Fonctionnement :
# Ce script détecte automatiquement l’interface réseau USB (généralement nommée 
# "enx..." ou "usb..."), la configure pour qu’elle n’ait plus d’adresse IP propre,
# puis l’ajoute à un bridge Proxmox (dans mon cas "vmbr1", qui correspond à l'interface WAN d'une VM pfSense) afin de permettre aux 
# machines virtuelles ou conteneurs de l’utiliser pour accéder à Internet.
#
# Utilisation typique :
# - Brancher le téléphone en USB.
# - Activer le partage de connexion USB.
# - Rendre le script exécutable : chmod u+x Auto_USB_Share.sh
# - Lancer ce script en root sur le serveur Proxmox : ./Auto_USB_Share.sh
#
# Création :
# PhOeNiX
# Web Site : S3curity.info
# YouTube : PhOeNiX v8.3
# -----------------------------------------------------------------------------

#!/bin/bash

# Nom du bridge Proxmox auquel on veut rattacher l'interface USB
BRIDGE="vmbr1"

# Pause pour laisser le temps à l'interface de s'initialiser
sleep 2

# Détection automatique de l'interface USB de type 'enx' avec une adresse MAC
IFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^enx|^usb' | head -n 1)

# Vérifie qu'une interface a bien été détectée
if [ -z "$IFACE" ]; then
  echo "Aucune interface USB détectée"
  exit 1
fi

echo "Interface détectée : $IFACE"

# Supprime toutes les adresses IP de l'interface
ip addr flush dev "$IFACE"

# Désactive l'interface
ip link set "$IFACE" down

# Ajoute l'interface au bridge Proxmox
brctl addif "$BRIDGE" "$IFACE"

# Réactive l'interface
ip link set "$IFACE" up

echo "Interface $IFACE ajoutée au bridge $BRIDGE et activée"
