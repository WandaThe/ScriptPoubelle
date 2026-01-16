# #!/bin/bash

# # Charge les actions (fonctions) depuis un autre fichier
# source ./Script.sh

# menu() {
#     clear
#     echo "1 creation des fichiers"
#     echo "2 supp des fichiers"
#     echo "3 restauration des fichiers"
#     echo "4 vider la corbeille"
#     echo "Q quitter"
#     echo
#     read -r -p "Action : " choix
#     echo "$choix"
# } # Fin de la fonction menu

# while true; do
#     choix="$(menu | tr '[:lower:]' '[:upper:]')"
#     case "$choix" in
#         1) action_creation ;;
#         2) action_suppression ;;
#         3) action_restauration ;;
#         4) action_vider_corbeille ;;
#         Q) exit 0 ;;
#         *) echo "Choix invalide." ;;
#     esac
#     read -r -p "Appuyez sur Entrée pour continuer..."
# done
# # Fin de la boucle principale

---------------------------------------

#!/bin/bash

echo "DEBUG: Je lance $ACTIONS"
ls -l "$ACTIONS"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ACTIONS="$SCRIPT_DIR/script.sh"

if [ ! -x "$ACTIONS" ]; then
  chmod +x "$ACTIONS" 2>/dev/null
fi

pause() {
  read -r -p "Appuyez sur Entrée pour continuer..."
}

while true; do
  clear
  echo "1 creation des fichiers"
  echo "2 supp des fichiers"
  echo "3 restauration des fichiers"
  echo "4 vider la corbeille"
  echo "Q quitter"
  echo
  read -r -p "Action : " choix
  choix="$(echo "$choix" | tr '[:lower:]' '[:upper:]')"

  case "$choix" in
    1)
      "$ACTIONS" create
      pause
      ;;
    2)
      read -r -p "Fichiers a supprimer (1 a 10, separes par des espaces) : " -a files
      "$ACTIONS" delete "${files[@]}"
      pause
      ;;
    3)
      "$ACTIONS" restore
      pause
      ;;
    4)
      "$ACTIONS" empty
      pause
      ;;
    Q)
      exit 0
      ;;
    *)
      echo "Choix invalide."
      pause
      ;;
  esac
done
