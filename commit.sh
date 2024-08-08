#!/bin/bash

# Vérifier si un argument a été fourni
if [ $# -eq 0 ]; then
    echo "Usage: $0 <fichier>"
    exit 1
fi

FILE=$1
WEBHOOK_URL="https://discord.com/api/webhooks/1271217328918630400/0BO2Jg2-xLeM5MT27AwnwmZ0SFPuzYB3f8gXwZR8JSW2Azlmo1gV1C8SfCbDDw8jVSB8"
LAST_CONTENT_FILE=".last_content_$FILE"

# Vérifier si le fichier existe
if [ ! -f "$FILE" ]; then
    echo "Le fichier $FILE n'existe pas."
    exit 1
fi

# Obtenir le contenu actuel du fichier
NEW_CONTENT=$(cat "$FILE")

# Obtenir le contenu précédent du fichier
if [ -f "$LAST_CONTENT_FILE" ]; then
    OLD_CONTENT=$(cat "$LAST_CONTENT_FILE")
else
    OLD_CONTENT=""
fi

# Générer le diff
DIFF=$(diff --color=never <(echo "$OLD_CONTENT") <(echo "$NEW_CONTENT"))

# S'il y a des différences, envoyer à Discord et mettre à jour le fichier de contenu précédent
if [ ! -z "$DIFF" ]; then
    # Préparer le message pour Discord
    MESSAGE="Modifications dans $FILE:"
    
    # Échapper les caractères spéciaux dans le diff
    ESCAPED_DIFF=$(echo "$DIFF" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
    
    # Construire le JSON
    JSON_PAYLOAD=$(cat <<EOF
{
  "content": "$MESSAGE",
  "embeds": [{
    "title": "Diff",
    "description": "\`\`\`diff\n$ESCAPED_DIFF\n\`\`\`"
  }]
}
EOF
)

    # Envoyer le message à Discord
    curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$WEBHOOK_URL"

    # Mettre à jour le fichier de contenu précédent
    echo "$NEW_CONTENT" > "$LAST_CONTENT_FILE"
fi
