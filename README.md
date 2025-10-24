# Tasmota Turbo Backup ⚡

![tasmota](https://img.shields.io/badge/Tasmota-Backup-blue?style=flat-square)

Schnelle, saubere Backups deiner Tasmota-Geräte im Netzwerk – mit Turbo-Speed und Datum!

---

## Ziel

Dieses Projekt hilft dir, alle Tasmota-Geräte in deinem Netzwerk automatisch zu sichern.  
Backups werden im Format gespeichert:

tasmota-HOSTNAME-BOARDID-FIRMWARE-YYYYMMDD.dmp

Kein Chaos mehr mit kryptischen Dateinamen – nur saubere, gut sortierbare Backups.

---

## Voraussetzungen

1. Linux / macOS (Windows geht auch mit WSL)  
2. Python 3.8+  
3. nmap und fping installiert  
4. Tasmota-Geräte erreichbar im Netzwerk  
5. [decode-config](https://github.com/tasmota/decode-config.git)  

---

## Installation von decode-config und virtuelle Umgebung

1. Repository klonen:
~~~
git clone https://github.com/tasmota/decode-config.git ~/decode-config
~~~
2. In das Verzeichnis wechseln:
~~~
cd ~/decode-config
~~~
3. Python 3 und das venv-Modul sicherstellen (für Ubuntu/Debian):
~~~
sudo apt update
sudo apt install python3 python3-venv python3-pip -y
~~~
4. Virtuelle Umgebung erstellen:
~~~
python3 -m venv venv
~~~
Hinweis: Verwende keine &&-Verkettung, damit eventuelle Fehler sofort sichtbar sind.

5. Virtuelle Umgebung aktivieren:
~~~
source venv/bin/activate
~~~
Die Shell zeigt nun (venv) am Anfang der Zeile an, was bedeutet, dass die virtuelle Umgebung aktiv ist.

6. Abhängigkeiten installieren:
~~~
pip install --upgrade pip
~~~
~~~
pip install -r requirements.txt
~~~

# Falls requirements.txt fehlt:
~~~
pip install configargparse requests
~~~
7. Testen, ob alles funktioniert:
~~~
python decode-config.py --help
~~~
Wenn die Hilfe angezeigt wird, bist du bereit für Turbo-Backup! 🎉

---

## Tasmota Turbo Backup Script hinzufügen

Nachdem du decode-config installiert hast, kannst du das Turbo Backup Script direkt aus GitHub laden und in dein ~/decode-config-Verzeichnis legen.

Führe dazu einfach Folgendes aus:
~~~
cd ~/decode-config
~~~
~~~
wget https://raw.githubusercontent.com/jogiesp/tasmota_turbo_backup/main/tasmota_turbo_backup.sh -O tasmota_turbo_backup.sh
~~~
~~~
chmod +x tasmota_turbo_backup.sh
~~~
Starte dann einfach dein Backup (nach Anpassung deiner virtuellen Umgebung):
 
 - source venv/bin/activate
 - ./tasmota_turbo_backup.sh


Features:

- Scannt dein Netzwerk automatisch nach   Tasmota-Geräten  
- Backup im sauberen Format mit Datum  
- Router-IP wird automatisch ausgeschlossen  
- Parallele Backups für Turbo-Speed  
- Fallback mit fping, falls nmap nichts findet  

---

### Anpassung für dein Netzwerk

Im Script:

# Subnetz anpassen, z. B. 192.168.1.0/24 oder 10.0.0.0/24
SUBNET="192.168.xxx.0/24"

# Router-IP eintragen, damit sie nicht gescannt wird
ROUTER_IP="192.168.xxx.1"

Optional:

- CONCURRENCY → Anzahl paralleler Backups  
- PER_HOST_TIMEOUT → Timeout pro Gerät  

---

### Nutzung

1. Script ausführbar machen:

- chmod +x tasmota_turbo_backup.sh

2. Script ausführen:
~~~
./tasmota_turbo_backup.sh
~~~
3. Backup-Ergebnisse prüfen:
~~~
ls -l ~/decode-config/tasmota/
~~~
Beispiel für eine Backup-Datei:
tasmota-Kaffee-0438-15.1.0_20251024.dmp

---

## Hinweis

Dieses Script ist extremprofessionell, schnell, sauber, und ein bisschen witzig – damit auch dein Netzwerk Spaß hat 😎.  
Es kann problemlos auf verschiedene Subnetze angepasst werden.
---
Wenn du beim Scan Meldungen siehst wie
ERROR 418 (@4596): Error on http GET request for ... - Unknown code,
keine Sorge, das ist kein echter Fehler.
Der Decoder hat nur kurz gedacht: "Hey, das sieht aus wie ein Tasmota" 
war’s aber nicht. Also einfach ignorieren . 🚀
---

⚠️ Fehler: Virtuelle Umgebung schon aktiv

Wenn du beim Erstellen der virtuellen Umgebung so eine Meldung bekommst:

bash: /home/userX/decode-config/venv/bin/python3: Datei oder Verzeichnis nicht gefunden

…liegt das meistens daran, dass du schon (venv) aktiviert hattest, bevor du die Umgebung überhaupt erstellt hast.

(venv) im Prompt bedeutet: Die Shell denkt, eine virtuelle Umgebung sei aktiv.

python3 -m venv venv versucht aber genau diese Umgebung neu zu erstellen.


💡 Lösung (so wie ein Profi 😎):

~~~
# Alte Umgebung deaktivieren
deactivate

# Kaputtes venv löschen
rm -rf venv

# Neue virtuelle Umgebung erstellen
python3 -m venv venv

# Aktivieren
source venv/bin/activate
~~~



## Lizenz

MIT License

Copyright (c) 2025 jogi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

---

## Mitwirken

Fühl dich frei, das Script zu verbessern, Fehler zu melden oder lustige Emojis einzubauen 😄.  

Viel Spaß beim Backup deiner Tasmota-Geräte! ⚡
