#!/bin/bash
# Turbo-Backup aller Tasmota-Geräte
# ---------------------------------
# Dieses Script sichert alle Tasmota-Geräte im lokalen Netzwerk.
# Backups werden im Format:
# tasmota-<HOSTNAME>-<BOARDID>-<FIRMWARE>_<YYYYMMDD>.dmp
# im Ordner ~/decode-config/tasmota gespeichert.
#
# Hinweise für andere Nutzer:
# 1) Passen Sie das SUBNET und ROUTER_IP unten an Ihr Netzwerk an.
# 2) Stellen Sie sicher, dass decode-config.py und ggf. die virtuelle Umgebung vorhanden sind.
# 3) CONCURRENCY und PER_HOST_TIMEOUT können je nach Netzwerk/Hardware angepasst werden.

BACKUP_DIR=~/decode-config/tasmota
mkdir -p "$BACKUP_DIR"

# Virtuelle Umgebung aktivieren (optional)
if [ -f ~/decode-config/venv/bin/activate ]; then
  source ~/decode-config/venv/bin/activate
fi

# ================================
# ANPASSUNG FÜR ANDERE NUTZER HIER
# ================================
# Subnetz anpassen, z. B. 192.168.1.0/24 oder 10.0.0.0/24
SUBNET="192.168.178.0/24"

# Router-IP eintragen, damit sie nicht gescannt wird
ROUTER_IP="192.168.178.1"
# ================================

CONCURRENCY=10               # Anzahl paralleler Backups
PER_HOST_TIMEOUT=20          # Timeout pro Gerät in Sekunden
TODAY=$(date +%Y%m%d)       # Datum YYYYMMDD

echo "1) Scanne Hosts mit offenem Port 80..."
# nmap scan, Router IP wird gefiltert
nmap -p 80 --open -T4 --max-retries 1 -oG - $SUBNET \
  | awk '/Ports:/{print $2}' | grep -v "^$ROUTER_IP$" > /tmp/tasmota_candidates.txt

# fallback: fping wenn kein Host gefunden
if [ ! -s /tmp/tasmota_candidates.txt ]; then
  echo "Keine Hosts gefunden. Fallback: fping-Scan..."
  # IP-Bereich 2-254 anpassen falls nötig
  fping -a -g 192.168.178.2 192.168.178.254 2>/dev/null | grep -v "^$ROUTER_IP$" > /tmp/tasmota_candidates.txt || true
fi

echo "Gefundene Kandidaten:"
cat /tmp/tasmota_candidates.txt || true

# Funktion: Backup für eine IP
backup_one() {
  ip="$1"
  echo "==> Starte Backup für $ip"
  python ~/decode-config/decode-config.py -s "$ip" -t dmp \
    --backup-file "$BACKUP_DIR/tasmota-@H-@f-@v_$TODAY.dmp"
  rc=$?
  if [ $rc -eq 0 ]; then
    echo "Backup erfolgreich: $ip"
  else
    echo "Fehler bei $ip (Exit $rc)"
  fi
}

export -f backup_one
export BACKUP_DIR
export PER_HOST_TIMEOUT
export TODAY

# Parallele Ausführung
if command -v parallel >/dev/null 2>&1; then
  cat /tmp/tasmota_candidates.txt | parallel -j $CONCURRENCY --no-notice backup_one {}
else
  cat /tmp/tasmota_candidates.txt | xargs -P $CONCURRENCY -I{} bash -c 'backup_one "$@"' _ {}
fi

echo "Fertig! Alle Backups liegen in $BACKUP_DIR"
