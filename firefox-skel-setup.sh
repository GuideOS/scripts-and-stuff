#!/bin/bash

# Firefox-Konfiguration in /etc/skel einrichten
# Dieses Skript konfiguriert Firefox für neue Benutzer

set -e

echo "=== Firefox Skel-Konfiguration wird eingerichtet ==="

# 1. Verzeichnisstruktur erstellen
echo "Erstelle Verzeichnisstruktur..."
sudo mkdir -p /etc/skel/.mozilla/firefox/default.default

# 2. profiles.ini erstellen
echo "Erstelle profiles.ini..."
sudo tee /etc/skel/.mozilla/firefox/profiles.ini > /dev/null <<'EOF'
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=default.default
Default=1
EOF

# 3. user.js mit Voreinstellungen erstellen
echo "Erstelle user.js mit Voreinstellungen..."
sudo tee /etc/skel/.mozilla/firefox/default.default/user.js > /dev/null <<'EOF'
// Startseite
user_pref("browser.startup.homepage", "https://guideos.de");
user_pref("browser.startup.page", 1);

// Neue Tabs
user_pref("browser.newtabpage.enabled", true);

// Download-Einstellungen
user_pref("browser.download.useDownloadDir", true);
user_pref("browser.download.folderList", 1);

// Datenschutz
user_pref("privacy.donottrackheader.enabled", true);
user_pref("browser.contentblocking.category", "standard");

// Suchmaschine
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.suggest.enabled", true);

// Erweiterungen
user_pref("extensions.update.autoUpdateDefault", true);
user_pref("extensions.autoDisableScopes", 0);
user_pref("extensions.enabledScopes", 15);

// Telemetrie deaktivieren
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);

// Pocket deaktivieren
user_pref("extensions.pocket.enabled", false);
EOF

# 4. Berechtigungen setzen
echo "Setze Berechtigungen..."
sudo chmod -R 755 /etc/skel/.mozilla
sudo chmod 644 /etc/skel/.mozilla/firefox/profiles.ini
sudo chmod 644 /etc/skel/.mozilla/firefox/default.default/user.js

# 5. Zusammenfassung
echo ""
echo "=== Installation abgeschlossen! ==="
echo ""
echo "✓ Firefox-Profil in /etc/skel erstellt"
echo "✓ Voreinstellungen konfiguriert"
echo ""
echo "Alle neuen Benutzer erhalten automatisch diese Konfiguration."
echo ""
echo "Testen Sie mit:"
echo "  sudo useradd -m testuser"
echo "  sudo -u testuser firefox"
echo ""
