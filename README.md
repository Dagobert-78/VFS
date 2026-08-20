# VFS
Outils de vérification système en CMD.

Ce script, compatible Windows 10 et 11, vous permet de lancer des commandes de maintenance.

Il permet aussi quelques paramétrages pratiques, et quelques petits plus à découvrir.




Voici l'architecture des menus de ce script.

```
                                    ┌──────────────────────────────────────────────────┐
                                    │       ARCHITECTURE  DES  MENUS  DU  SCRIPT       │
                                    └──────────────────────────────────────────────────┘

  ┌─────────────────── 1. Vérifications ───────────────────┐     ┌─────────────────── 2. Outils ──────────────────────────┐
  │                                                        │     │                                                        │
  │  - CHKDSK          - DISM            - SFC             │     │  - DNS             - Update          - BOOT            │
  │  - SIGVERIF        - Antivirus       - Anti-Malware    │     │  - Pilotes         - Restauration                      │
  │  - RAM                                                 │     │                                                        │
  └────────────────────────────────────────────────────────┘     └────────────────────────────────────────────────────────┘

  ┌─────────────────── 3. Optimisations ───────────────────┐     ┌─────────────────── 4. Automatisations ─────────────────┐
  │                                                        │     │                                                        │
  │  - Icône Bureau    - Filigrane      - Télémétrie       │     │  - AutoLogin       - Installation                      │
  │  - Hibernation     - Horloge        - TRIM             │     │                                                        │
  │  - Restauration    - Flèche link    - Services Windows │     │                                                        │
  │  - Bloat                                               │     │                                                        │
  └────────────────────────────────────────────────────────┘     └────────────────────────────────────────────────────────┘

  ┌─────────────────── 5. Nettoyage ───────────────────────┐     ┌─────────────────── 6. Informations ────────────────────┐
  │                                                        │     │                                                        │
  │  - Temporaire      - Clean MGR       - LOGs            │     │  - Batterie        - Indice Perf     - SMART           │
  │  - Cache Store     - Win Update      - Spooler         │     │  - Rapport         - WiFi            - Erreurs         │
  │  - DNS             - Winsock         - Protocole IP    │     │                                                        │
  │  - Cartes réseaux                                      │     │                                                        │
  └────────────────────────────────────────────────────────┘     └────────────────────────────────────────────────────────┘

```
