# VFS
Outils de vérification système en CMD.

Ce script, compatible Windows 10 et 11, vous permet de lancer des commandes de maintenance.

Il permet aussi quelques paramétrages pratiques, et quelques petits plus à découvrir.




Voici l'architecture des menus de ce script.

                                    
                                    ┌──────────────────────────────────────────────────┐
                                    │       ARCHITECTURE  DES  MENUS  DU  SCRIPT       │
                                    └──────────────────────────────────────────────────┘

    ┌────────────────── 1. Vérifications ──────────────────┐     ┌────────────────── 2. Outils ─────────────────────────┐
    │                                                      │     │                                                      │
    │  - CHKDSK          - DISM              - SFC         │     │  - DNS             - Update            - BOOT        │
    │  - SIGNVERIF       - Antivirus         - RAM         │     │  - Pilotes         - Restauration                    │
    │                                                      │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘

    ┌────────────────── 3. Optimisations ──────────────────┐     ┌────────────────── 4. Automatisations ────────────────┐
    │                                                      │     │                                                      │
    │  - Icône Bureau    - Télémétrie        - Horloge     │     │  - AutoLogin       - Installation                    │
    │  - Filigrane       - Hibernation       - TRIM        │     │                                                      │
    │  - Restauration    - Bloat                           │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘

    ┌────────────────── 5. Nettoyage ──────────────────────┐     ┌────────────────── 6. Informations ───────────────────┐
    │                                                      │     │                                                      │
    │  - Temporaire      - LOGs              - Cache Store │     │  - Batterie        - Indice Perf       - SMART       │
    │  - Win Update      - Spooler           - DNS         │     │  - Rapport         - WiFi              - Erreurs     │
    │  - Winsock         - Proto IP                        │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘

