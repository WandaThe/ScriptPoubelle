#!/bin/bash 

usage() { # Fonction d'affichage de l'usage du script
    echo "ERREUR : Nombre d'arguments invalide." # Message d'erreur
    echo "USAGE : $0 [fichier1] [fichier2] ... [fichier10]" # Affichage de l'usage
    echo "----------------------------------------------------------------------" # Ligne de séparation
    echo "Le script accepte entre 1 et 10 fichiers en arguments." # Explication
    echo "Exemple : $0 fichier1 fichier2" # Exemple d'utilisation

    exit 1 # Sortie avec code d'erreur
} # Fin de la fonction usage

if [ "$#" -lt 1 ] || [ "$#" -gt 10 ]; then # Vérification du nombre d'arguments
    usage # Appel de la fonction usage en cas d'erreur
    echo "Création des 10 fichiers (fichier1 à fichier10)" # Message d'information
    for ((i=1;i<=10;i=i+1)); do # Boucle pour créer 10 fichiers
        touch "fichier$i" # Création du fichier
    done #  Fin de la boucle
    echo "Fichiers créés avec succès." # Message de succès
fi #    Fin de la vérification du nombre d'arguments

for fichier in "$@"; do # Boucle pour vérifier chaque argument
    if [ ! -f "$fichier" ]; then # Vérification si le fichier existe et est un fichier standard
        echo "Erreur : Le fichier '$fichier' n'existe pas ou n'est pas un fichier standard." # Message d'erreur
        exit 2 # Sortie avec code d'erreur
    fi # Fin de la vérification du fichier
done # Fin de la boucle de vérification des fichiers

DOSSIER_TRASH="/home/$USER/trash" # Définition du dossier de destination

if [ ! -d "$DOSSIER_TRASH" ];   then # Vérification si le dossier de destination existe
    mkdir -p "$DOSSIER_TRASH" # Création du dossier de destination s'il n'existe pas
    echo "Dossier $DOSSIER_TRASH créé." # Message d'information
fi # Fin de la vérification du dossier de destination

DATEFORMAT=$(date +"%d%m%Y%H_%M") # Format de la date pour le nom de l'archive
NOMARCHIVE="archive$DATE_FORMAT.tar.gz"     # Nom de l'archive avec la date
CHEMIN_COMPLET="$DOSSIER_TRASH/$NOM_ARCHIVE" # Chemin complet de l'archive


echo "Création de l'archive : $CHEMIN_COMPLET" # Message d'information

tar -c (create) -z (gzip) -f (file) # Crée une archive compressée avec gzip
tar -czf "$CHEMIN_COMPLET" "$@" # Commande tar pour créer l'archive avec les fichiers passés en arguments

Vérification si la commande tar a réussi ($? contient le code de retour de la dernière commande)
if [ $? -eq 0 ]; then # Si la commande a réussi
    echo "Archivage réussi !" # Message de succès
else # Sinon
    echo "Erreur critique lors de la création de l'archive." # Message d'erreur
    exit 3 # Sortie avec code d'erreur
fi # Fin de la vérification de la commande tar

echo "----------------------------------------------------------------------" # Ligne de séparation
read -p "Voulez-vous supprimer les fichiers originaux passés en arguments ? (o/n) : " reponse # Demande de confirmation pour supprimer les fichiers originaux

case "$reponse" in # Traitement de la réponse
    [oO] | [oO][uU][iI] ) # Si la réponse est oui
        rm "$@" #Suppression des fichiers originaux
        echo "Les fichiers originaux ont été supprimés." # Message de confirmation
        ;; # Fin du cas oui
    * ) # Pour toute autre réponse
        echo "Fichiers originaux conservés." # Message de confirmation
        ;; # Fin du cas par défaut
esac # Fin du traitement de la réponse

exit 0 # Sortie réussie du script

# Fin du script