# Tasmota Turbo Backup ⚡

![tasmota](https://img.shields.io/badge/Tasmota-Backup-blue?style=flat-square)

Schnelle, saubere Backups deiner Tasmota-Geräte im Netzwerk – mit Turbo-Speed und Datum!

---

## Ziel

Dieses Projekt hilft dir, alle Tasmota-Geräte in deinem Netzwerk automatisch zu sichern.  
Backups werden im Format gespeichert:

tasmota-<HOSTNAME>-<BOARDID>-<FIRMWARE>_<YYYYMMDD>.dmp

Kein Chaos mehr mit kryptischen Dateinamen – nur saubere, gut sortierbare Backups.

---

## Voraussetzungen

1. Linux / macOS (Windows geht auch mit WSL)  
2. Python 3.8+  
3. nmap und fping installiert  
4. Tasmota-Geräte erreichbar im Netzwerk  
5. [decode-config](https://github.com/tasmota/decode-config.git)  

---

## Installation von decode-config

1. Repository klonen:

git clone https://github.com/tasmota/decode-config.git ~/decode-config

2. Virtuelle Umgebung erstellen (empfohlen):

cd ~/decode-config          # zuerst in das Verzeichnis wechseln
python3 -m venv venv        # virtuelle Umgebung erstellen
source venv/bin/activate    # virtuelle Umgebung aktivieren

Oder Turbobefehl:  cd ~/decode-config && python3 -m venv venv && source venv/bin/activate

3. Abhängigkeiten installieren:

pip install --upgrade pip
pip install -r requirements.txt
# Falls du requirements.txt nicht hast, einfach:
pip install configargparse requests

4. Testen:

python decode-config.py --help

Wenn die Hilfe angezeigt wird, bist du bereit für Turbo-Backup! 🎉

---

## Tasmota Turbo Backup Script

Dateiname: tasmota_turbo_backup.sh  

**Features:**

- Scannt dein Netzwerk automatisch nach Tasmota-Geräten  
- Backup im sauberen Format mit Datum  
- Router-IP wird automatisch ausgeschlossen  
- Parallele Backups für Turbo-Speed  
- Fallback mit fping, falls nmap nichts findet  

---

### Anpassung für dein Netzwerk

Im Script:

# Subnetz anpassen, z. B. 192.168.1.0/24 oder 10.0.0.0/24
SUBNET="192.168.178.0/24"

# Router-IP eintragen, damit sie nicht gescannt wird
ROUTER_IP="192.168.178.1"

Optional:

- CONCURRENCY → Anzahl paralleler Backups  
- PER_HOST_TIMEOUT → Timeout pro Gerät  

---

### Nutzung

1. Script ausführbar machen:

chmod +x tasmota_turbo_backup.sh

2. Script ausführen:

./tasmota_turbo_backup.sh

3. Backup-Ergebnisse prüfen:

ls -l ~/decode-config/tasmota/

Beispiel für eine Backup-Datei:

tasmota-Kaffee-0438-15.1.0_20251024.dmp

---

## Hinweis

Dieses Script ist professionell, schnell, sauber, und ein bisschen witzig – damit auch dein Netzwerk Spaß hat 😎.  
Es kann problemlos auf verschiedene Subnetze angepasst werden.

---

## Lizenz

MIT License

Copyright (c) 2025 DeinName

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

(The rest of MIT License text)

---

## Mitwirken

Fühl dich frei, das Script zu verbessern, Fehler zu melden oder lustige Emojis einzubauen 😄.  

Viel Spaß beim Backup deiner Tasmota-Geräte! ⚡
