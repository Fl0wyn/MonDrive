z=$(\df --type=ext4 | sed '1d' | tr -s ' ' ';')

x() {
    for i in $z; do
        i=$(echo $i | tr -s ';' ' ')

        VolumeName=$(echo $i | awk '{print $1}')
        DeviceID=$(echo $i | awk '{print $6}')
        FreeSpace=$(echo $i | awk '{print $4}')
        Size=$(echo $i | awk '{print $2}')

        y() {
            echo "{"
            echo '"VolumeName": "'$VolumeName'",'
            echo '"DeviceID": "'$DeviceID'",'
            echo '"FreeSpace": "'$FreeSpace'",'
            echo '"Size": "'$Size'"'
            echo "},"
        }
        y
    done
}

# Supprimer le dernier caractère de la dernière ligne et ajouter [ au début
x | sed '$ s/.$//; 1i\['
echo "]"
