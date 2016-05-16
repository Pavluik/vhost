#!/bin/bash

### parameters
## @TODO: add path configuration to startup window
host=$1
command=$2
database=$3
sitesEnable='/etc/apache2/sites-enabled/'
sitesAvailable='/etc/apache2/sites-available/'
hostDir='/var/www/'
hostPattern='^[a-zA-Z0-9._\-]+$'
availableCommands=( add del delete )
indexTemplate='<html>
<head></head>
<body>
    <div style="text-align: center; position: absolute; top: 50%; width: 500px; height: 200px; margin-top: -100px; margin-left: -250px; left: 50%;">
        <h1>Created by <span style="color: #ffd327;">OYi</span>VirtualHost</h1>
        <div>
            <span style="vertical-align: middle;font-size: 20px;padding-right: 6px;">Powered by </span>
            <a href="http://otakoyi.com/website-development/" style="text-decoration: none; color: #ffd327;" target="_blank">
                <img src="data:image/jpg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4QDQRXhpZgAASUkqAAgAAAADABIBAwABAAAAAQAAADEBAgAHAAAAMgAAAGmHBAABAAAAOgAAAAAAAABQaWNhc2EAAAYAAJAHAAQAAAAwMjIwAaADAAEAAAABAAAAAqAEAAEAAACcAAAAA6AEAAEAAAAjAAAABaAEAAEAAACqAAAAIKQCACEAAACIAAAAAAAAAGY1OThhMDg3YmVjZWE5ZjUwMDAwMDAwMDAwMDAwMDAwAAACAAEAAgAEAAAAUjk4AAIABwAEAAAAMDEwMAAAAAD/4QNBaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA1LjEuMiI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6QkVCMEU3ODFEOTQ3RTQxMTg3MTBBODgzQzYxRDY3NzUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODdEQTFGRTM0N0UwMTFFNDgxMEREQUIxMTJCQTAwMDQiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6ODdEQTFGRTI0N0UwMTFFNDgxMEREQUIxMTJCQTAwMDQiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1w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"
                     style="vertical-align: middle;"
                >
            </a>
        </div>
    <div>
</body>
</html>'
### ENDparameters

### functions
function getAvailableCommandsString()
{
    availableCommandsString="["
    for command in "${availableCommands[@]}"
    do
        availableCommandsString+=$command'|'
    done

    echo ${availableCommandsString::-1}']'
}
function isAvailable()
{
    command=$1
    result=1
    for availableCommand in "${availableCommands[@]}"
    do
        if [ "$availableCommand" == "$command" ]; then
            result=0
        fi
    done
    return $result
}
function createConfigFile()
{
    host=$1
    if ! echo "<VirtualHost *:80>
  ServerAdmin admin@localhost
  ServerName $host
  ServerAlias www.$host
  DocumentRoot $hostDir$host
  <Directory $hostDir$host>
    Options All
    AllowOverride All
  </Directory>
</VirtualHost>" > $sitesAvailable$host.conf
    then
        echo -e $"\n \e[31mERROR: Creating \e[1m$sitesAvailable$host.conf\e[0m\e[31m file failed.\e[0m"
        return 1
    else
        echo -e $"\n \e[32mNew virtual host config \e[1m$sitesAvailable$host.conf\e[0m \e[32mcreated.\e[0m\n"
        return 0
    fi

}
function addToHosts()
{
    host=$1
    if ! echo "127.0.0.1	$host" >> /etc/hosts; then
        echo $"\n \e[31mERROR: Not able to write in \e[1m/etc/hosts\e[0m"
        return 1
    else
        echo -e $"\n \e[32mHost \e[1m$host\e[0m\e[32m added to /etc/hosts config file.\e[0m"
        return 0
    fi
}
function createFolder()
{
    host=$1
    if [ -d "$hostDir$host" ]; then
        echo -e "\n \e[33mWarning: Folder \e[1m$hostDir$host\e[0m\e[33m has already exist\e[0m"
    else
        sudo mkdir $hostDir$host ## creats directory with sudo as an owner
        sudo chmod -R 0777 $hostDir$host
        echo -e "\n \e[32mDirectory \e[1m$hostDir$host\e[0m \e[32mcreated.\e[0m\n"
        echo $indexTemplate > "$hostDir$host/index.html"
        sudo chmod -R 0777 "$hostDir$host/index.html"
    fi
}
function createHost()
{
    host=$1
    if [ -f "$sitesAvailable$host.conf" ]; then
        echo -e "\n \e[31mERROR: \e[1m$host\e[0m\e[31m has already configured as your virtual host\e[0m"
        exit
    fi
    echo -e "\nCreating virtual host \e[1;39;42m$host\e[0m..."
    if ! createConfigFile $host; then
        exit
    fi
    if ! addToHosts $host; then
        exit
    fi
    if ! createFolder $host; then
        exit
    fi
    sudo a2ensite $host.conf
    echo "Restarting Apache2"
    /etc/init.d/apache2 restart
    echo -e "\n \e[32mCheck new host with your browser\e[0m \e[34mhttp://$host\e[0m"
}
function createDatabase()
{
    database=$1
    echo -e "\n Creating database...\n You will be asked for database user password"
    mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS $database"
    echo -e "\n \e[32mDatabase \e[1m$database\e[0m \e[32mcreated.\e[0m"
}
function deleteConfigFile()
{
    host=$1
    sudo rm $sitesAvailable$host.conf
    echo -e $"\n \e[32mVirtual host config \e[1m$sitesAvailable$host.conf\e[0m \e[32mdeleted.\e[0m\n"
}
function deleteFromHosts()
{
    host=$1
    sudo sed -i "/127.0.0.1\s$host/d" /etc/hosts
}
function deleteFolder()
{
    host=$1
    if ! [ -d "$hostDir$host" ]; then
        echo -e "\n \e[33mWarning: Folder \e[1m$hostDir$host\e[0m\e[33m does not exist\e[0m"
    else
        sudo rm -R $hostDir$host
        echo -e "\n \e[32mDirectory \e[1m$hostDir$host\e[0m \e[32mdeleted.\e[0m\n"
    fi
}
function deleteHost()
{
    host=$1
    if ! [ -f "$sitesAvailable$host.conf" ]; then
        echo -e "\n \e[31mERROR: \e[1m$host\e[0m\e[31m has not configured as your virtual host\e[0m\n"
        exit
    fi
    echo -e "\n Deleting virtual host \e[1;39;42m$host\e[0m and directory \e[1m$hostDir$host\e[0m.\n"
    if ! deleteConfigFile $host; then
        exit
    fi
    if ! deleteFromHosts $host; then
        exit
    fi
    if ! deleteFolder $host; then
        exit
    fi
    sudo a2dissite $host.conf
    /etc/init.d/apache2 restart
    echo -e "\n \e[32mVirtual host \e[1m$host\e[0m \e[32mdeleted.\e[0m"
}
function deleteDatabase()
{
    database=$1
    echo -e "\n Deleting database...\n You will be asked for database user password"
    mysql -uroot -p -e "DROP DATABASE IF EXISTS $database"
    echo -e "\n \e[32mDatabase \e[1m$database\e[0m \e[32mdeleted.\e[0m"
}
### ENDfunctions

### collecting input data
if [ $(whoami) != 'root' ]; then #root user condition
    echo -e "\n \e[33mPermission denided. Need to run as root-user\n Use: sudo vhost.sh \e[90m<domain> <operation>\e[0m\n"
    exit
fi

if [[ -z $host && -z $command ]]; then
echo -e "\n\e[94m     #####################################################################
     #                                                                   #
     #                     \e[1mWELCOME to \e[93mOYiVirtualHost\e[94m\e[21m                     #
     #  Creating virtual host, MySQL database, local project folder and  #
     #                     apache2 configuration                         #
     #                                                                   #
     #####################################################################\e[0m"
fi
while [[ ! "$host" =~ $hostPattern ]] || ! isAvailable $command ; do
    if [[ -z $host && -z $command ]]; then
        echo -e "\n \e[32mPlease insert hostname and operation to run:\e[0m\n"
        read hostInput operInput databaseInput
        host=$hostInput
        command=$operInput
        database=$databaseInput
    fi

    while [[ ! "$host" =~ $hostPattern ]]; do
        echo -e " Remember that hostname can't be empty and must contain \e[91monly\e[0m:
        - \e[93malphanumeric lowercase/uppercase characters\e[0m
        - \e[93mnumbers\e[0m
        - \e[93mspecial\e[0m characters like \e[43;91m_\e[0m \e[43;91m.\e[0m \e[43;91m-\e[0m\n"
        read hostInput
        host=$hostInput
    done

    while ! isAvailable $command; do
        if ! isAvailable $command; then
            if [ ! -z $command ]; then
                echo -e " Unknown command \e[31m$command\e[0m for \e[1;39;42m$host\e[0m"
            fi
            commandList=$(getAvailableCommandsString)
            echo -e " Available commands (lowercase only): \e[32m$commandList\e[0m"
        fi
        echo -e " \e[32mPlease insert operation for hostname \e[1;39;42m$host\e[0m:"
        read operInput
        command=$operInput
    done
done
### ENDcollecting input data

### controller
case $command in
"add")
    createHost $host
    if [[ ! -z $database ]]; then
        createDatabase $database
    fi
   ;;
"del" | "delete")
    echo -e " Are you sure? (y/n)\n"
    read answerInput
    answer=${answerInput,,}
    if [[ $answer == "y" || $answer == "yes" ]]; then
        deleteHost $host
        if [[ ! -z $database ]]; then
            deleteDatabase $database
        fi
    else
        echo -e "\n Canceled.\n"
    fi
   ;;
*)
    echo -e "\n Something goes wrong.\n" # @TODO: add github link
    ;;
esac
### ENDcontroller

echo -e "\n Thanks for usage!\n" # @TODO: add github link
exit