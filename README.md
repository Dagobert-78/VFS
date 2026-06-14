# VFS
Outils de vérification système en CMD.

Ce script, compatible Windows 10 et 11, vous permet de lancer des commandes de maintenance.

Il permet aussi quelques paramétrages pratiques, et quelques petits plus à découvrir.




Voici l'architecture des menus de ce script.

                                    ┌──────────────────────────────────────────────────┐
                                    │       ARCHITECTURE  DES  MENUS  DU  SCRIPT       │
                                    └──────────────────────────────────────────────────┘

    ┌────────────────── 1. Vérifications ──────────────────┐     ┌───────────────────── 2. Outils ──────────────────────┐
    │                                                      │     │                                                      │
    │  - CHKDSK          - SIGNVERIF         - Antivirus   │     │  - DNS             - Update            - BOOT        │
    │  - DISM            - SFC               - RAM         │     │  - Pilotes         - Restore                         │
    │                                                      │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘

    ┌────────────────── 3. Optimisations ──────────────────┐     ┌───────────────── 4. Automatisations ─────────────────┐
    │                                                      │     │                                                      │
    │  - Icône Bureau    - Télémétrie        - Horloge     │     │  - AutoLogin       - Installation                    │
    │  - Filigrane       - Hibernation       - TRIM        │     │                                                      │
    │  - Bloat                                             │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘

    ┌──────────────────── 5. Nettoyage ────────────────────┐     ┌────────────────── 6. Informations ───────────────────┐
    │                                                      │     │                                                      │
    │  - Temporaire      - Win Update        - Winsock     │     │  - Batterie        - SMART             - WiFi        │
    │  - LOG             - Spooler           - Proto IP    │     │  - Indice Perf     - Rapport           - Erreurs     │
    │  - Cache Store     - DNS                             │     │                                                      │
    └──────────────────────────────────────────────────────┘     └──────────────────────────────────────────────────────┘
