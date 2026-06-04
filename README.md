# VFS
Outils de vérification système en CMD

Ce script, compatible Windows 10 et 11, vous permet de lancer des commandes de maintenance.

Il permet aussi quelques paramétrages pratiques, et quelques petits plus à découvrir.




Voici l'architecture des menus de ce script.

                                 1. Vérifications                         2. Outils
                                         |                                    |
                             ┌──────────────────────┐             ┌───────────────────────┐
                             |       |      |       |             |       |       |       |
                          CHKDSK   DISM   SFC   SIGNVERIF        DNS   Update   BOOT   Pilotes


                                                     3. Optimisations
                                                            |
                          ┌───────────────────────────────────────────────────────────────────┐
                          |             |            |            |           |        |      |
                     Icône Bureau   Filigrane   Télémétrie   Hibernation   Horloge   TRIM   Bloat


                4. Automatisations                                    5. Nettoyage
                         |                                                  |
                  ┌─────────────┐               ┌────────────────────────────────────────────────────────┐
                  |             |               |         |          |             |              |      |
              AutoLogin   Installation      Temporaire   LOG   Cache Store   Windows Update   Spooler   DNS


                                                   6. Informations
                                                          |
                                      ┌───────────────────────────────────────┐
                                      |            |         |        |       |
                                  Batterie   Indice Perf   SMART   Rapport   WiFi
