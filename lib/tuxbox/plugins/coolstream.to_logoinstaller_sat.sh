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
	rm -f /tmp/.coolstream.to_logo_updater
fi
touch /tmp/.coolstream.to_logo_updater

#Logos von Coolstream.to herunterladen:
echo ""
echo "Download..."

wget -q -P /tmp -T 30 http://www.coolstream.to/coolstream.to/logos/Logos.zip


#Alte Logos loeschen und neue Logos installieren:
echo "Entpacken..."

rm -f "$LOGOPATH"/*.png
unzip -q -o /tmp/Logos.zip -d "$LOGOPATH"


#Aufraeumen:
rm -f /tmp/Logos.zip
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

