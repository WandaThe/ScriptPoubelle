#!/bin/bash

# Charge les actions (fonctions) depuis un autre fichier
source ./Script.sh

menu() {
    clear
    echo "1 creation des fichiers"
    echo "2 supp des fichiers"
    echo "3 restauration des fichiers"
    echo "4 vider la corbeille"
    echo "Q quitter"
    echo
    read -r -p "Action : " choix
    echo "$choix"
} # Fin de la fonction menu

while true; do
    choix="$(menu | tr '[:lower:]' '[:upper:]')"
    case "$choix" in
        1) action_creation ;;
        2) action_suppression ;;
        3) action_restauration ;;
        4) action_vider_corbeille ;;
        Q) exit 0 ;;
        *) echo "Choix invalide." ;;
    esac
    read -r -p "Appuyez sur Entrée pour continuer..."
done
# Fin de la boucle principale