#!/bin/sh

echo "Installation der Coolstream.to Senderlogos, einen Moment bitte..."

if [ -e /bin/msgbox ]
then
	msgbox popup="Installation der Coolstream.to Senderlogos. Dieser Vorgang verlaeuft automatisch im Hintergrund. Einen Moment bitte." --timeout=10 --title="Installation/Update der Coolstream.to Senderlogos" > /dev/null
fi


#Logoverzeichnis ermitteln:
for line in $(cat /var/tuxbox/config/neutrino.conf)
do
	LOGOPATH=$(echo $line | cut -d= -f1)
	if [ "$LOGOPATH" == "logo_hdd_dir" ]
	then
		LOGOPATH=$(echo $line | cut -d= -f2)
		break
	fi	
done

if [ "$LOGOPATH" == "/var/share/icons/logo" ] && [ ! -d /var/share/icons/logo ]
then
	if [ ! -d /usr/share/tuxbox/neutrino/icons/logo ]
	then
		mkdir -p /usr/share/tuxbox/neutrino/icons/logo
	fi
	
	if [ ! -d /var/share/icons ]
	then
		mkdir -p /var/share/icons	
	fi
		
	ln -s /usr/share/tuxbox/neutrino/icons/logo /var/share/icons/
fi


#Sofern vorherige Installation fehlgeschlagen:
if [ -e /tmp/.coolstream.to_logo_updater ]
then
	rm -f /tmp/Logos.zip
	rm -f /tmp/Symlinks.txt
	rm -f /tmp/*.symlinks
	rm -f "$LOGOPATH"/test.txt
	rm -f "$LOGOPATH"/testlink.txt
	rm -f /tmp/.coolstream.to_logo_updater
fi
touch /tmp/.coolstream.to_logo_updater

#Logos von Coolstream.to herunterladen:
echo ""
echo "Download..."

wget -q -P /tmp -T 30 http://www.coolstream.to/coolstream.to/logos/Logos.zip
wget -q -P /tmp -T 30 http://www.coolstream.to/coolstream.to/logos/symlinks/Symlinks.txt


#Alte Logos loeschen und neue Logos installieren:
echo "Entpacken..."

rm -f "$LOGOPATH"/*.png
unzip -q -o /tmp/Logos.zip -d "$LOGOPATH"

#Speicherverzeichnis testen (Datentraeger/Netzlaufwerk):
touch "${LOGOPATH}/test.txt"
ln -s "${LOGOPATH}/test.txt" "${LOGOPATH}/testlink.txt" 2> "${LOGOPATH}/test.txt"

echo "Links erzeugen..."

LINKTYPE=$(tail -n 1 "$LOGOPATH"/test.txt)
if [ "$LINKTYPE" == "ln: ${LOGOPATH}/testlink.txt: Operation not supported" ]
then
	rm -f "$LOGOPATH"/test.txt

	#Hardlinks erstellen:
	for line in $(cat /tmp/Symlinks.txt)
	do
		SYMLINKFILE=$(echo $line)
		wget -q -P /tmp -T 30 "http://www.coolstream.to/coolstream.to/logos/symlinks/${SYMLINKFILE}"
	
		for symlink in $(cat /tmp/"${SYMLINKFILE}")
		do
			TARGET=$(echo $symlink | cut -d= -f1)
			LINK=$(echo $symlink | cut -d= -f2)
		
			if [ -e "${LOGOPATH}/${TARGET}.png" ] && [ ! -e "${LOGOPATH}/${LINK}.png" ]
			then
				ln "${LOGOPATH}/${TARGET}.png" "${LOGOPATH}/${LINK}.png"
			fi

		done
	
		rm -f /tmp/"$SYMLINKFILE"
	done
else
	rm -f "$LOGOPATH"/test.txt
	rm -f "$LOGOPATH"/testlink.txt

	#Symlinks erstellen:
	for line in $(cat /tmp/Symlinks.txt)
	do
		SYMLINKFILE=$(echo $line)
		wget -q -P /tmp -T 30 "http://www.coolstream.to/coolstream.to/logos/symlinks/${SYMLINKFILE}"
	
		for symlink in $(cat /tmp/"${SYMLINKFILE}")
		do
			TARGET=$(echo $symlink | cut -d= -f1)
			LINK=$(echo $symlink | cut -d= -f2)
		
			if [ -e "${LOGOPATH}/${TARGET}.png" ] && [ ! -e "${LOGOPATH}/${LINK}.png" ]
			then
				ln -s "${LOGOPATH}/${TARGET}.png" "${LOGOPATH}/${LINK}.png"
			fi

		done
	
		rm -f /tmp/"$SYMLINKFILE"
	done
fi


#Aufraeumen:
rm -f /tmp/Logos.zip
rm -f /tmp/Symlinks.txt
rm -f /tmp/.coolstream.to_logo_updater


#Installation abschliessen:
echo ""
echo "Die Senderlogos wurden erfolgreich installiert!"
echo "###### Optimum Assistance - Be Part of it: www.coolstream.to ######"
echo ""

if [ -e /bin/msgbox ]
then
	msgbox popup="Alle Senderlogos stehen nun zur Verfuegung. Viel Spass wuenscht das Team von Coolstream.to!" --timeout=10 --title="Installation erfolgreich abgeschlossen" > /dev/null
fi

exit 0


# Visit: www.coolstream.to

