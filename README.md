# Tasmota Turbo Backup ⚡

![tasmota](https://img.shields.io/badge/Tasmota-Backup-blue?style=flat-square)

Schnelle, saubere Backups deiner Tasmota-Geräte im Netzwerk – mit Turbo-Speed und Datum!

---

## Inhaltsverzeichnis

- [Ziel](#ziel)
- [Voraussetzungen](#voraussetzungen)
- [Installation von decode-config und virtuelle Umgebung](#installation-von-decode-config-und-virtuelle-umgebung)
- [Installation von nmap und fping](#installation-von-nmap-und-fping)
- [Tasmota Turbo Backup Script hinzufügen](#tasmota-turbo-backup-script-hinzufügen)
- [Nutzung mit virtueller Umgebung](#nutzung-mit-virtueller-umgebung)
- [**Nutzung ohne virtuelle Umgebung (venv)**](#nutzung-ohne-virtuelle-umgebung-venv)
- [Anpassung für dein Netzwerk](#anpassung-für-dein-netzwerk)
- [Hinweise und Fehlerbehandlung](#hinweise-und-fehlerbehandlung)
- [Benutzer zur sudo-Gruppe hinzufügen (Root-Rechte)](#benutzer-zur-sudo-gruppe-hinzufügen-root-rechte)
- [Lizenz](#lizenz)
- [Mitwirken](#mitwirken)

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
~~~
~~~
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

##  Installation von nmap und fping

~~~
sudo apt update
~~~
~~~
sudo apt install -y nmap fping
~~~

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
 
Jedes Mal nach dem Login oder in einem neuen Terminal

~~~
cd ~/decode-config  # ins Projektverzeichnis wechseln
~~~
~~~
source venv/bin/activate # venv aktivieren
~~~
~~~
./tasmota_turbo_backup.sh

~~~
 

Features:

- Scannt dein Netzwerk automatisch nach     Tasmota-Geräten  
- Backup im sauberen Format mit Datum  
- Router-IP wird automatisch ausgeschlossen  
- Parallele Backups für Turbo-Speed  
- Fallback mit fping, falls nmap nichts findet  

---

### Anpassung für dein Netzwerk

Im Script:

# Subnetz anpassen, z. B. 192.168.1.0/24 
SUBNET="192.168.xxx.0/24"

# Router-IP eintragen, damit sie nicht gescannt wird
ROUTER_IP="192.168.xxx.1"

Optional:

- CONCURRENCY → Anzahl paralleler Backups  
- PER_HOST_TIMEOUT → Timeout pro Gerät  

---

### Nutzung

1. Script ausführbar machen:
~~~
chmod +x tasmota_turbo_backup.sh
~~~
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

## ⚠️ Fehler: Virtuelle Umgebung schon aktiv

Wenn du beim Erstellen der virtuellen Umgebung so eine Meldung bekommst:

- bash: /home/userX/decode-config/venv/bin/python3: Datei oder Verzeichnis nicht gefunden

…liegt das meistens daran, dass du schon (venv) aktiviert hattest, bevor du die Umgebung überhaupt erstellt hast.

(venv) im Prompt bedeutet: Die Shell denkt, eine virtuelle Umgebung sei aktiv.

python3 -m venv venv versucht aber genau diese Umgebung neu zu erstellen.


💡 Lösung (so wie ein Profi 😎):

~~~
# Alte Umgebung deaktivieren
deactivate

# Kaputtes venv löschen
rm -rf venv

~~~


## ⚠️ Fehler, wenn beim Start folgende Meldung erscheint:

~~~
./tasmota_turbo_backup.sh
1) Scanne Hosts mit offenem Port 80...
./tasmota_turbo_backup.sh: Zeile 38: nmap: Kommando nicht gefunden.
Keine Hosts gefunden. Fallback: fping-Scan...
~~~
bedeutet das, dass nmap nicht installiert oder nicht im PATH ist

### Hinweis: Auf manchen Systemen benötigt fping spezielle Rechte, damit Nicht-Root-Nutzer ICMP-Anfragen senden können. Du kannst die nötige Berechtigung mit setcap setzen:


~~~
sudo apt install -y libcap2-bin    # falls setcap noch nicht vorhanden ist
~~~
~~~
sudo setcap cap_net_raw+ep "$(command -v fping)"
~~~

# Kurz gesagt:
Wenn du alle Funktionen des Skripts nutzen willst, ist es am einfachsten, Root oder einen sudo-fähigen Benutzer zu verwenden.Das ist die einfachste möglichkeit. 

### Benutzer zur `sudo`-Gruppe hinzufügen (Root-Rechte)

Falls ein normaler Benutzer keine `sudo`-Rechte hat, melde dich einmal als **root** an und führe folgende Befehle aus:
~~~
als root z.B.  
~~~
~~~
ssh root@hostname
~~~
~~~
usermod -aG sudo <BENUTZERNAME>
~~~
Abmelden und wieder als dieser Benutzer einloggen, damit die Gruppenänderung aktiv wird:
exit
dann erneut als <BENUTZERNAME> anmelden

Überprüfen:
~~~
groups         # sollte "sudo" anzeigen
~~~

~~~
sudo whoami    # sollte "root" zurückgeben
~~~

⚠️ Achtung: Ein Benutzer mit sudo-Rechten kann alle Systembefehle ausführen. Verwende diese Rechte nur, wenn du die volle Kontrolle über das System hast.



---

## Nutzung ohne virtuelle Umgebung (venv)

Wenn du die virtuelle Umgebung nicht verwenden möchtest, z.B. weil die Python-Abhängigkeiten bereits systemweit installiert sind, kannst du das Skript direkt ausführen. Hier ist eine Schritt-für-Schritt-Anleitung:


## 1️⃣ Voraussetzungen prüfen
## Python 3.8+ muss installiert sein
~~~
python3 --version
~~~

## pip installieren / aktualisieren
~~~
python3 -m pip install --upgrade pip
~~~

## Benötigte Python-Pakete systemweit installieren
~~~
python3 -m pip install configargparse requests
~~~

## Auf Ubuntu/Debian, falls pip fehlt
~~~
sudo apt update
~~~
~~~
sudo apt install python3-pip -y
~~~

## Tools nmap und fping installieren
~~~
sudo apt update
~~~
~~~
sudo apt install -y nmap fping
~~~
## Optional: fping Rechte setzen
~~~
sudo apt install -y libcap2-bin
~~~
~~~
sudo setcap cap_net_raw+ep "$(command -v fping)"
~~~
## 2️⃣ decode-config installieren
~~~
git clone https://github.com/tasmota/decode-config.git ~/decode-config
cd ~/decode-config
~~~
## 3️⃣ Turbo Backup Script herunterladen
~~~
wget https://raw.githubusercontent.com/jogiesp/tasmota_turbo_backup/main/tasmota_turbo_backup.sh -O tasmota_turbo_backup.sh
chmod +x tasmota_turbo_backup.sh
~~~
## 4️⃣ Backup starten (direkt, ohne venv)
~~~
cd ~/decode-config
./tasmota_turbo_backup.sh
~~~

## Backups werden im Format erstellt:
## tasmota-HOSTNAME-BOARDID-FIRMWARE-YYYYMMDD.dmp

## 5️⃣ Hinweise
## - Vorteil ohne venv: Einfachheit, keine Aktivierung nötig
## - Nachteil: System-Python beeinflusst Pakete, Versionen sind nicht isoliert
## - Für andere Rechner kann venv sinnvoll sein

## 6️⃣ Optional: sudo-Rechte prüfen, falls Fehler auftreten
# Als root anmelden
~~~
ssh root@hostname
~~~
## Benutzer zur sudo-Gruppe hinzufügen
~~~
usermod -aG sudo <BENUTZERNAME>
~~~
## Abmelden und wieder als Benutzer einloggen
~~~
exit
~~~
~~~
ssh <BENUTZERNAME>@hostname
~~~
## Prüfen
~~~
groups         # sollte "sudo" 
anzeigen
~~~
~~~
sudo whoami    # sollte "root" zurückgeben
~~~
## ⚠️ Achtung: Sudo-Rechte erlauben vollen Systemzugriff. Nur für vertrauenswürdige Benutzer verwenden.





## Lizenz

MIT License

Copyright (c) 2025 jogiesp

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
