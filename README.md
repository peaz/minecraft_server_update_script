# Minecraft Server Update Script

A script to check and download the latest Minecraft server.jar.
This script was developed and tested to work with macOS Catalina zsh 5.7.1 (x86_64-apple-darwin19.0)
While not tested, this script should also work on a Linux box.

Why this script? Why not this gets you the download in less than a minute vs needing to open the browser and look for the Minecraft Server download page, then download the server.jar and then moving it to the right directory.

:)

# Pre-requistes
This script assumes that **wget** and **jq** is already installed on your Mac. 
- [wget](https://www.gnu.org/software/wget/)
- [jq](https://stedolan.github.io/jq/)

I recommend using [Homebrew](http://brew.sh/) to install both **wget** and **jq** if you don't already have them.

Instructions on installing Homebrew can be found at at this [link](https://brew.sh). Once installed, run the follwing command to install both **wget** and **jq**.
```bash
brew install jq wget
```

# Using this script

Just move the update_server.sh to the same directory where your Minecraft server.jar file is located.
Then set the permissions for the script file to be executable.
```bash
chmod +x update_server.sh
```

Then just run the script. 
```bash
./update_server.sh
```

## Note
On the first run, the script will initialise itself by creating a current_ver.txt file and a backups directory if they are not found. It will then also proceed to download the current release of server.jar and move your existing copy to the backups directory as server_0.jar. This is because the script does not already have a reference of the exsiting version which is what the current_ver.txt files is for.

If you do not want the script to unnecessarily download the same version, then manually create a current_ver.txt file with the existing version in the file. 

Example below:-
```bash
echo 1.15.1 > current_ver.txt
```

[Blog post link](https://www.atpeaz.com/using-a-script-to-update-the-minecraft-server-jar/)
