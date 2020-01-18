
# Initiliaze and create a current_ver.txt file and backups directory if it does not exist
if [ ! -f current_ver.txt ]
then
    echo 0 > current_ver.txt
fi

if [ ! -d backups ]
then
    mkdir backups
fi

# Read the current version of the local server
CURRENT_VER=$(cat current_ver.txt)
echo Current Version: $CURRENT_VER

# Get the updated version_manifest.json
wget -qN https://launchermeta.mojang.com/mc/game/version_manifest.json

# Get the latest release version number
VER=$(jq -r '.latest.release' version_manifest.json)
echo Latest Version: $VER

if [ $CURRENT_VER != $VER ]
then
    # Create the temp script to extract the latest <version>_manifest.json
    echo "jq -r '.versions[] | select(.id == \"$VER\") | .url' version_manifest.json" > MANIFESTJQ.sh
    chmod +x MANIFESTJQ.sh

    # Run the temp script and download the latest <version>_manifest.json
    MANIFEST_URL=$(./MANIFESTJQ.sh)
    echo URL: $MANIFEST_URL
    wget -qN $MANIFEST_URL

    # Create the temp script to extract the latest server download URL from the <version>_manifest.json
    echo "jq -r .downloads.server.url $VER.json" > DOWNLOADJQ.sh
    chmod +x DOWNLOADJQ.sh

    # Make a backup copy of the current server.jar
    mv server.jar backups/server_$CURRENT_VER.jar

    # Run the temp script and download the latest server.jar
    DOWNLOAD_URL=$(./DOWNLOADJQ.sh)
    echo URL: $DOWNLOAD_URL
    wget $DOWNLOAD_URL

    # update the current_ver.txt to the latest version number 
    echo $VER > current_ver.txt

    # Clean up code
    rm DOWNLOADJQ.sh
    rm MANIFESTJQ.sh
    rm version_manifest.json
    rm $VER.json
else
    echo "Current server version is the latest already."
    rm version_manifest.json
fi