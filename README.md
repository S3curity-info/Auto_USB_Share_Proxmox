Script d'automatisation pour connecter un serveur Proxmox à Internet via le partage de connexion USB d’un téléphone.

Fonctionnement :
Ce script détecte automatiquement l’interface réseau USB (généralement nommée  "enx..." ou "usb..."), la configure pour qu’elle n’ait plus d’adresse IP propre, puis l’ajoute à un bridge Proxmox (dans mon cas "vmbr1", qui correspond à l'interface WAN d'une VM pfSense) afin de permettre aux  machines virtuelles ou conteneurs de l’utiliser pour accéder à Internet.

Utilisation typique :
- Brancher le téléphone en USB.
- Activer le partage de connexion USB.
- Rendre le script exécutable : chmod u+x Auto_USB_Share.sh
- Lancer ce script en root sur le serveur Proxmox : ./Auto_USB_Share.sh

Création :
PhOeNiX
Web Site : S3curity.info
YouTube : PhOeNiX v8.3
