set -e

YELLOW_B='\033[1;38;5;227m'
PURPLE='\033[38;5;141m'
GREEN='\033[32m'
NC='\033[0m'
#99 105 141 147
#141 147
printf "${YELLOW_B}WARNING: This will switch to 'main' and discard ALL uncommitted changes.${NC}\n"
read -p "Do you want to continue? [Y/n] " confirm

if [ "$confirm" != "Y" ]; then
  echo "Aborted."
  exit 1
fi

printf "${PURPLE}Hard reset to main branch${NC}\n"
git switch main
git reset --hard

printf "${PURPLE}Building app...${NC}\n"
npm run build

printf "${PURPLE}Deploying files to server${NC}\n"
scp -r dist/* site@midnightzada.com:/var/www/midnightzada.com/

printf "${GREEN}✓ Deployment complete!${NC}\n"