@echo off
setlocal EnableDelayedExpansion
mode con cols=125 lines=30
chcp 850 >nul
set "SOFT_version=5.2.3.0"
title VÇrification Fichiers Systäme v%SOFT_version% by Dagobert_78

echo.
echo.                        Lancement des vÇrifications initiales...
::  DÇtermination de la version de Windows
call :WINVER
if %compatible% LSS 7 goto ERREUR_A
::  Demande des droits administrateur - Ne fonctionne pas si mis en routine
echo.
echo.   Activation des droits administrateur...
timeout /t 1 >nul
set _elev=
if /i "%~1"=="-el" set _elev=1
set _PSarg="""%~f0""" -el %_args% && set "nul=>nul 2>&1"
%nul% reg query HKU\S-1-5-19 || (
if not defined _elev %nul% powershell.exe "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
	echo.
	echo.
	echo.                        *****   êCHEC   *****
	echo.
	echo.           Veuillez rouvrir ce script en tant qu'administrateur.
	echo.
    echo. Appuyez sur une touche pour quitter...
    timeout /t 60 >nul
    exit
)
echo.                                               OK

::  Initialisation des variables de fonctionnement - Mises au dÇbut car modifiÇes Ö chaque version
set "SOFT_build=111"
set "SOFT_Channel=Finale"
set "SOFT_Channel_version="
set "SOFT_taille=238 775"

::   NÇcessite les routines de test en fin de script
::  1 : Affichages des variables
::  2 : calcul des temps
set "Mode_Test="
if defined Mode_Test mode con cols=125 lines=145

if "%Mode_Test%"=="2" goto TEST_1
call :VAR_SOFT

::  Initialisation des clefs si absentes ou vide dans la Base de Registre
echo.
echo.   VÇrification des paramätres du script...
call :LAST_RUN
call :REG_PARA
call :FOLDERS
echo.                                               OK
echo.
echo.   VÇrification de la version de Windows...
call :EDITION
call :ARCH
call :WIN_LANG
echo.                                               OK
::  VÇrifications de la prÇsence de certaines commandes
call :POWERSH
call :INTERNET
echo.
echo.   VÇrification des fonctions disponibles...
call :WMIC
call :WINGET
call :WD_test
echo.                                               OK
call :TEXTES
call :HORODATA
call :BOOT_MAJ
:TEST_1B

::  Permet de garder la date du prÇcÇdent lancement
set "Last_Run_Soft=!Last_Run_%Script_V%!"

set "boot="
if "%Mode_Test%"=="2" call :TEST_2
goto ACCUEIL

::  ::::::::::::::::::::::::
::  ::   PAGE D'ACCUEIL   ::
::  ::::::::::::::::::::::::

:ACCUEIL
cls
echo.
echo.                                  /⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø\
echo.                          Oƒƒƒƒƒƒ≥ ≥                                              ≥ ≥ƒƒƒƒƒƒO    
echo.   %Mode_Test_Texte_1%    Oƒƒƒƒƒƒ≥ ≥   VÇrifications et Outils Systäme v%versi%   ≥ ≥ƒƒƒƒƒƒO    %Mode_Test_Texte_1%
echo.                          Oƒƒƒƒƒƒ≥ ≥                                   %SCTV%     ≥ ≥ƒƒƒƒƒƒO
echo.                                  \¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ/
echo.
echo. Dagobert_78 vous propose son p'tit script d'outils systäme pour votre %WINVER% %EDITION% %ARCH% %WIN_LANG%.
echo.
echo.                                                        Dernier lancement : %Last_Run_Soft%
echo.
echo. 1. VÇrifications Systämes
echo. 2. Outils Systämes                                   %winget_TXT%
echo. 3. Optimisations                                     %internet_TXT%
echo. 4. Automatisations                                   %wmic_TXT%
echo. 5. Nettoyage                                         %powershell_TXT%
echo. 6. Informations systämes
echo.                                                      %INFO_RELEASE%
echo. 9. Quoi de neuf Docteur
echo. A. Architecture des menus
echo. P. Paramätres
echo. C. CrÇdit                                     %Info_Compatibilite_Win7%
echo.
echo. Q. Quitter
echo.
if defined Accueil_Optimise goto ACCUEIL2
::  On prÇ-charge les donnÇes, puis on lance les menus
call :LIRE_PAR "Update_Notify Restauration_Valeur"
call :LIRE_DAT
call :FILI_ETA
call :TELE_ETA
call :NAVI_ETA
call :HIBE_ETA
call :HEUR_ETA
call :TRIM_ETA
call :SAVO_ETA
if "%WIN_LANG%"=="FR" call :REST_ETA
call :FLEC_ETA
::  Signifie que les Çtat sont connu et inutile de les recharger dans le menu Accueil
set "Accueil_Optimise=1"
::  Fin du prÇ-chargement des donnÇes
:ACCUEIL2
choice /c 1234569APCQM /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"

::  Mise Ö jour du Last_Run seulement si on va dans un menu utile
if %CHOIX% LEQ 6 call :MAJ_DATE %Script_V%
if "%CHOIX%"=="3" set "Accueil_Optimise="

if "%CHOIX%"=="1"  goto CHECK2
if "%CHOIX%"=="2"  goto OUTILS2
if "%CHOIX%"=="3"  goto OPTIM3
if "%CHOIX%"=="4"  goto AUTOM2
if "%CHOIX%"=="5"  goto CLEANER2
if "%CHOIX%"=="6"  goto INFOR2
if "%CHOIX%"=="7"  goto QUOI29
if "%CHOIX%"=="8"  goto ARCHMENU
if "%CHOIX%"=="9"  goto PARAM3
if "%CHOIX%"=="10" goto CREDIT_1
if "%CHOIX%"=="11" goto FIN
if "%CHOIX%"=="12" call :FIN_INAC
goto ACCUEIL


::  ::::::::::::::::::::::::::
::  DEBUT DES MENUS PRINCIPAUX
::  ::::::::::::::::::::::::::

:CHECK
if "%Mode_Test%"=="2" set "TEMPS_0=%time:~3%"
::  RÇcupÇration des Last_Run
call :LIRE_DAT
:CHECK2
if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ VÇrifications Systämes ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
               echo.                                      dernier lancement
               echo. 1. Disques [chkdsk]                    %Last_Run_CHKDSK%
               echo. 2. Fichiers Images Systäme [DISM]      %Last_Run_DISM%
               echo. 3. Fichiers Systäme [SFC]              %Last_Run_SFC%
               echo. 4. Signatures NumÇriques [sigverif]    %Last_Run_SIGVERIF%
if "%WD%"=="1" echo. 5. Analyse antivirus                   %Last_Run_WIN_DEFENDER%
               echo. 6. Analyse des malwares [MRT]          %Last_Run_MRT%
               echo. 7. Analyse de la RAM                   %Last_Run_RAM%
               echo. 0. Retour
echo.
if "%Mode_Test%"=="2" set "TEMPS_2=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_3
choice /c 12345670M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous vÇrifier ? "
set "CHOIX=%ERRORLEVEL%"
               if "%CHOIX%"=="1" goto CHKDSK
               if "%CHOIX%"=="2" goto DISM2
               if "%CHOIX%"=="3" goto SFC
               if "%CHOIX%"=="4" goto SIGNA
if "%WD%"=="1" if "%CHOIX%"=="5" goto DEFENDE
               if "%CHOIX%"=="6" goto MRT
               if "%CHOIX%"=="7" goto SCANRAM
               if "%CHOIX%"=="8" goto ACCUEIL
               if "%CHOIX%"=="9" call :FIN_INAC
goto CHECK2


:OUTILS
if "%Mode_Test%"=="2" set "TEMPS_0=%time:~3%"
::  RÇcupÇration des Last_Run
call :LIRE_DAT
:OUTILS2
if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
::  Regroupement des multiples IF ici plutìt que dans le menu
set "MENU_1=0"
set "MENU_2=0"
if "%powershell%"=="1" (
    if %compatible% GEQ 10 set "MENU_1=1"
)
if "%winget%"=="1" (
    if "%internet%"=="1" set "MENU_2=1"
)
:OUTILS3
if "%Mode_Test%"=="2" set "TEMPS_2=%time:~3%"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Outils Systäme ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
                       echo.                                     dernier lancement
if "%MENU_1%"=="1"     echo. 1. Modifier les DNS                   %Last_Run_DNS%
if "%MENU_2%"=="1"     echo. 2. Mises Ö jours tiers                %Last_Run_UPDATE%
if %compatible% GEQ 10 echo. 3. Extraction des pilotes             %Last_Run_DRIVERS%
if "%powershell%"=="1" echo. 4. CrÇer un point de restauration     %Last_Run_CHECK_POINT%
                       echo. 5. RedÇmarrage
                       echo. 0. Retour
echo.
if "%Mode_Test%"=="2" set "TEMPS_3=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_4
choice /c 123450M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" if "%MENU_1%"=="1"     goto DNS
if "%CHOIX%"=="2" if "%MENU_2%"=="1"     goto UPDATE
if "%CHOIX%"=="3" if %compatible% GEQ 10 goto DRIVERS
if "%CHOIX%"=="4" if "%powershell%"=="1" call :RESTOR
if "%CHOIX%"=="5"                        goto M_REDEM
if "%CHOIX%"=="6"                        goto ACCUEIL
if "%CHOIX%"=="7"                        call :FIN_INAC
goto OUTILS3


:OPTIM
::  RÇcupÇration des Last_Run
call :LIRE_DAT
:OPTIM2
call :LOADING
call :SAVO_ETA
call :FILI_ETA
call :TELE_ETA
call :NAVI_ETA
call :HIBE_ETA
call :HEUR_ETA
call :TRIM_ETA
if "%WIN_LANG%"=="FR" call :REST_ETA
call :FLEC_ETA
:OPTIM3
if "%Mode_Test%"=="2" call :TEST_5
call :LOADING
call :COM_ETA 2
call :COM_ETA 1

:OPTIM4
::  set "Telemetrie_TMP="

::  Regroupement des multiples IF ici plutìt que dans le menu
::  Mise Ö 0 des MENU_x  et pas Ö vide sinon plante avec les GEQ, LEQ, LSS, ....
for %%a in (1 2 3 4 5 6 7 8 9 A B) do (set "MENU_%%a=0")

if not "%SAVOIR_LVL%"=="1" (
    if %compatible% GEQ 10    set "MENU_1=1"
)
if not "%TESTSIGN_LVL%"=="1"  set "MENU_2=1"
if not "%Telemetrie_Windows_LVL%"=="1"      set "MENU_3=1"
if "%Telemetrie_Windows_LVL%"=="1" (
    if not "%Telemetrie_Services_LVL%"=="1" set "MENU_3=2"
    if "%Telemetrie_Services_LVL%"=="1" (
        if not "%Telemetrie_Navigateurs_LVL%"=="1" set "MENU_3=3"
    )
)
if not "%HIBERFIL_LVL%"=="1"  set "MENU_4=1"
if not "%HEURE_LVL%"=="1"     set "MENU_5=1"
if not "%TRIM_LVL%"=="1" (
    if %compatible% GEQ 10    set "MENU_6=1"
)

::  SI restauration dÇsactivÇe OU SI restauration activÇe, mais infÇrieur Ö mini en Go
if not "%WIN_LANG%"=="FR"       set "MENU_7=1"
if "%WIN_LANG%"=="FR" (
    if not "%RESTOR_LVL%"=="1"  set "MENU_7=2"
    if "%RESTOR_LVL%"=="1" (
        if %RESTOR_TMP_2% LSS %Restauration_mini% set "MENU_7=3"
    )
)
if "%MENU_7%"=="0" (
    if not "%Restauration_Valeur%"=="%RESTOR_TMP_2%" set "MENU_7=4"
)
if not "%Fleche_Etat%"=="1"  set "MENU_8=1"
if not "%Services_LVL%"=="1" set "MENU_9=1"
if not "%Taches_LVL%"=="1"   set "MENU_A=1"
if "%winget%"=="1" (
  if "%powershell%"=="1" (
    if "%internet%"=="1"     set "MENU_B=1"
  )  
)

::  Ceci change la fonction ET du IF, en fonction OU via une boucle FOR
::  Empàche le choix "Tout optimiser" si rien n'est faisable
::  Si un seul MENU_x=1 alors TOUT est disponible
set "TOUT="
for %%a in (1 2 3 4 5 6 7 8 9) do (if "!MENU_%%a!"=="1" set "TOUT=1")

::  Empàche le choix "RÇtablir" si rien n'est faisable
::  Si un seul MENU_x=0 alors RÇTABLIR est disponible
set "RIEN="
for %%a in (1 2 3 4 5 6 7 8 9) do (if "!MENU_%%a!"=="0" set "RIEN=1")

:OPTIM5
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Optimisations ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
if "%MENU_1%"=="1" echo. 1. Enlever du Bureau l'icìne "En savoir plus sur cette image"
if "%MENU_2%"=="1" echo. 2. DÇsactiver le filigrane "Activer Windows" en bas Ö droite du bureau
if "%MENU_3%"=="1" echo. 3. Anonymiser la tÇlÇmÇtrie    [ actuellement Ö %Telemetrie_TMP%/3 ]
if "%MENU_3%"=="2" echo. 3. DÇsactiver les services de tÇlÇmÇtrie
if "%MENU_3%"=="3" echo. 3. DÇsactiver la tÇlÇmÇtrie des navigateurs
if "%MENU_4%"=="1" echo. 4. DÇsactiver la Veille prolongÇe
if "%MENU_5%"=="1" echo. 5. Activer l'horloge rÇelle sous Windows
if "%MENU_6%"=="1" echo. 6. Activer le TRIM
if "%MENU_7%"=="1" echo. 7. Confirmer l'activation de la Restauration Systäme
if "%MENU_7%"=="2" echo. 7. Activer la Restauration Systäme
if "%MENU_7%"=="3" echo. 7. Augmenter la Restauration Systäme    [ actuellement Ö %RESTOR_TMP_2% Go ]
if "%MENU_7%"=="4" echo. 7. RÇgler la Restauration Systäme Ö %Restauration_Valeur% Go  [ actuellement Ö %RESTOR_TMP_2% Go ]
if "%MENU_8%"=="1" echo. 8. Supprimer la fläche des raccourcis
if "%MENU_9%"=="1" echo. 9. DÇsactiver les Services inutiles
if "%MENU_A%"=="1" echo. A. DÇsactiver les TÉches PlanifiÇes inutiles
echo.
if "%MENU_B%"=="1" echo. B. Enlever les Bloat                    - lancÇ le %Last_Run_DEBLOAT%
echo.
if "%TOUT%"=="1"   echo. T. Tout optimiser [sauf les Bloat]
if "%RIEN%"=="1"   echo. R. RÇtablir ce qui a ÇtÇ dÇfait
echo. 0. Retour
echo.
choice /c 123456789ABTR0M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1"   if "%MENU_1%"=="1"  call :SAVO_INJ
if "%CHOIX%"=="2"   if "%MENU_2%"=="1"  set "TESTSIGN_TMP=OFF" && call :FILIG
if "%CHOIX%"=="3"   if %MENU_3% GEQ 1   call :TELE_INJ
if "%CHOIX%"=="4"   if "%MENU_4%"=="1"  call :HIBERN_0
if "%CHOIX%"=="5"   if "%MENU_5%"=="1"  call :HEUR_INJ
if "%CHOIX%"=="6"   if "%MENU_6%"=="1"  set "TRIM_TMP=0" && set "TRIM_TXT=A" && call :TRIM
if "%CHOIX%"=="7"   if "%MENU_7%"=="1"  call :RESTOR_B
if "%CHOIX%"=="7"   if "%MENU_7%"=="2"  call :RESTOR_B
if "%CHOIX%"=="7"   if %MENU_7% GEQ 3   call :RESTOR_C
if "%CHOIX%"=="8"   if "%MENU_8%"=="1"  call :FLECH
if "%CHOIX%"=="9"   if "%MENU_9%"=="1"  call :COM_1 2
if "%CHOIX%"=="10"  if "%MENU_A%"=="1"  call :COM_1 1
if "%CHOIX%"=="11"  if "%MENU_B%"=="1"  goto DEBLOAT
if "%CHOIX%"=="12" if "%TOUT%"=="1" (
    set "Tout_Optimiser=1"
    if "%MENU_1%"=="1"  call :SAVO_INJ
    if "%MENU_2%"=="1"  set "TESTSIGN_TMP=OFF" && call :FILIG
    if %MENU_3% GEQ 1   call :TELE_INJ
    if "%MENU_4%"=="1"  call :HIBERN_0
    if "%MENU_5%"=="1"  call :HEUR_INJ
    if "%MENU_6%"=="1"  set "TRIM_TMP=0" && set "TRIM_TXT=A" && call :TRIM
    if "%MENU_7%"=="1"  call :RESTOR_B
    if "%MENU_7%"=="2"  call :RESTOR_B
    if %MENU_7% GEQ 3   call :RESTOR_C
    if "%MENU_8%"=="1"  call :FLECH
    if "%MENU_9%"=="1"  call :COM_1 2
    if "%MENU_A%"=="1"  call :COM_1 1
    set "Tout_Optimiser="
)
if "%CHOIX%"=="13" if "%RIEN%"=="1" goto RETABLI2
if "%CHOIX%"=="14"                  goto ACCUEIL
if "%CHOIX%"=="15"                  call :FIN_INAC
goto OPTIM4


:AUTOM
call :LIRE_DAT
:AUTOM2
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Automatisations ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. 1. AutoLogin au dÇmarrage du PC   - modifiÇ le %Last_Run_AUTOLOGIN%
echo. 2. Installer des logiciels
echo. 0. Retour
echo.
choice /c 120M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" (
    setlocal
    goto AUTOLOG
)
if "%CHOIX%"=="2" goto INSTALL
if "%CHOIX%"=="3" goto ACCUEIL
if "%CHOIX%"=="4" call :FIN_INAC
goto AUTOM2


:CLEANER
if "%Mode_Test%"=="2" set "TEMPS_0=%time:~3%"
call :LOADING
if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
call :LIRE_DAT
:CLEANER2
if "%Mode_Test%"=="2" set "TEMPS_2=%time:~3%"
::  Regroupement des multiples IF ici plutìt que dans le menu
::  Mise Ö 0 des MENU_x  et pas Ö vide sinon plante avec les GEQ, LEQ, LSS, ....
for %%a in (3) do (set "MENU_%%a=0")

if exist "%windir%\Logs\CBS\CBS*.log" set "MENU_3=1"
:CLEANER3
if "%Mode_Test%"=="2" set "TEMPS_3=%time:~3%"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Outils de nettoyage ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
                       echo.                                                      dernier lancement
                       echo. 1. Effacer les fichiers temporaires                    %Last_Run_TEMPORAIRE%
                       echo. 2. Nettoyage par Clean MGR                             %Last_Run_CLEAN_MGR%
if "%MENU_3%"=="1"     echo. 3. Effacer les LOG de SFC et DISM                      %Last_Run_LOG%
if %compatible% GEQ 10 echo. 4. Effacer le cache du Microsoft Store                 %Last_Run_DEL_STORE%
                       echo. 5. RÇinitialiser les services Windows Update           %Last_Run_SERVICE_UPDATE%
                       echo. 6. Nettoyer le Spooler d'impression, pour tata Sophie  %Last_Run_DEL_SPOOLER%
                       echo. 7. Effacer le cache des DNS                            %Last_Run_DEL_CLEAR_DNS%
                       echo. 8. RÇinitialisation du catalogue Winsock               %Last_Run_DEL_WINSOCK%
                       echo. 9. RÇinitialisation du protocole IP                    %Last_Run_DEL_PROTO_IP%
                       echo. A. RÇinitialisation compläte des cartes rÇseaux        %Last_Run_RAZ_CARTE_RESEAU%
                       echo. 0. Retour
echo.
if "%Mode_Test%"=="2" set "TEMPS_4=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_6

choice /c 123456789A0M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1"                        goto TEMP
if "%CHOIX%"=="2"                        goto CMGR_DEL
if "%CHOIX%"=="3" if "%MENU_3%"=="1"     goto DEL_LOG
if "%CHOIX%"=="4" if %compatible% GEQ 10 goto STORE
if "%CHOIX%"=="5"                        goto REP_WU
if "%CHOIX%"=="6"                        goto SPOOLER0
if "%CHOIX%"=="7"                        call :CLEARDNS
if "%CHOIX%"=="8"                        goto WINSOCK
if "%CHOIX%"=="9"                        goto PROTOIP
if "%CHOIX%"=="10"                       goto RAZ_NET
if "%CHOIX%"=="11"                       goto ACCUEIL
if "%CHOIX%"=="12"                       call :FIN_INAC
goto CLEANER3


:INFOR
if "%Mode_Test%"=="2" set "TEMPS_0=%time:~3%"
call :LIRE_DAT

:INFOR2
if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
::  Regroupement des multiples IF ici plutìt que dans le menu
set "MENU_2=0"
if "%powershell%"=="1" (
    if %compatible% GEQ 10 set "MENU_2=1"
)

if not "%powershell%"=="1" (
    if "%compatible%"=="7" set "MENU_2=1"    
)
:INFOR3
if "%Mode_Test%"=="2" set "TEMPS_2=%time:~3%"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Informations Systämes ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
                       echo.                                dernier lancement
if %compatible% GEQ 10 echo. 1. Batterie [si PC portable]     %Last_Run_BATTERIE%
if "%MENU_2%"=="1"     echo. 2. Indice de performance         %Last_Run_INDICE%
                       echo. 3. êtat SMART des disques        %Last_Run_SMART%
                       echo. 4. Rapport systäme
if "%WIN_LANG%"=="FR"  echo. 5. Clef WiFi                     %Last_Run_WIFI%
if "%powershell%"=="1" echo. 6. Erreurs Critiques Systäme     %Last_Run_BSOD%
                       echo. 0. Retour
echo.
if "%Mode_Test%"=="2" set "TEMPS_3=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_7

choice /c 1234560M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"

if "%CHOIX%"=="1" if %compatible% GEQ 10 goto BATT
if "%CHOIX%"=="2" if "%MENU_2%"=="1"     goto INDICE
if "%CHOIX%"=="3"                        goto SMART
if "%CHOIX%"=="4"                        goto RAPPORT
if "%CHOIX%"=="5" if "%WIN_LANG%"=="FR"  goto WIFI
if "%CHOIX%"=="6" if "%powershell%"=="1" goto BSOD
if "%CHOIX%"=="7"                        goto ACCUEIL
if "%CHOIX%"=="8"                        call :FIN_INAC
goto INFOR3


:PARAM
if "%Mode_Test%"=="2" set "TEMPS_0=%time:~3%"
call :LIRE_DAT
if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
call :LIRE_PAR "Update_Notify Restauration_Valeur"
:PARAM2
if "%Mode_Test%"=="2" set "TEMPS_2=%time:~3%"
::  call :REST_ETA

:PARAM3
if "%Mode_Test%"=="2" set "TEMPS_3=%time:~3%"
::  Regroupement des multiples IF ici plutìt que dans le menu
set "MENU_1=2"
set "MENU_3=0"
if "%Update_Notify%"=="0" set "MENU_1=1"

if "%powershell%"=="1" (
  if "%internet%"=="1" (
    if %compatible% GEQ 7 set "MENU_3=1"
  )
)  

:PARAM4
if "%Mode_Test%"=="2" set "TEMPS_4=%time:~3%"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Paramätres du script ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
if "%MENU_1%"=="1"    echo. 1. Activer la notification de mise Ö jour
if "%MENU_1%"=="2"    echo. 1. DÇsactiver la notification de mise Ö jour
if %compatible% GEQ 7 echo. 2. Choix du canal de mise Ö jour         
if "%MENU_3%"=="1"    echo. 3. VÇrifier si mise Ö jour disponible                     [ fait le %Last_Run_UPDATE_SCRIPT% ]
                      echo. 4. Effacer les traces registre du script         
                      echo. 5. RÇgler la valeur par dÇfaut de la restauration systäme [ actuellement Ö %Restauration_Valeur% Go ]         
                      echo. 6. Configurer Clean MGR                                   [ fait le %Last_Run_CLEAN_MGR_SET% ]
                      echo. 7. Configurer le temps d'inactivitÇ pour fermer le script [ actuellement Ö %Tempo_Inactif% secondes ]         
                      echo. 8. Choisir quels Services Windows seront dÇsactivÇs
                      echo. 9. Choisir quelles TÉches PlanifiÇes seront dÇsactivÇes
echo. 0. Retour
echo.
if "%Mode_Test%"=="2" set "TEMPS_5=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_8

choice /c 1234567890M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if not "%MENU_1%"=="0" if "%CHOIX%"=="1" goto NOTIFY
if %compatible% GEQ 7  if "%CHOIX%"=="2" goto CHAN_CHO
if "%MENU_3%"=="1"     if "%CHOIX%"=="3" cls && call :VFS_2
                       if "%CHOIX%"=="4" goto DEL_REG
                       if "%CHOIX%"=="5" goto RESTOR_E
                       if "%CHOIX%"=="6" goto CMRG_SET
                       if "%CHOIX%"=="7" goto INACTIF
                       if "%CHOIX%"=="8" set "Elements_ID=2" && goto COM_AFF
                       if "%CHOIX%"=="9" set "Elements_ID=1" && goto COM_AFF
                       if "%CHOIX%"=="10" goto ACCUEIL
                       if "%CHOIX%"=="11" call :FIN_INAC
goto PARAM4

::  ::::::::::::::::::::::::
::  FIN DES MENUS PRINCIPAUX
::  ::::::::::::::::::::::::


::  :::::::::::::::::::::::::::
::  DEBUT DES MENUS SECONDAIRES
::  :::::::::::::::::::::::::::

:DISM
call :LIRE_DAT
:DISM2
setlocal

::  Tous les DISM sont compatible Windows 8.1
set "DISM_variable_1=ScanHealth.                       ≥.SCAN"
set "DISM_variable_2=CheckHealth.                      ≥.CHECK"
set "DISM_variable_3=RestoreHealth.                    ≥.RESTORE"
set "DISM_variable_4=StartComponentCleanup.            ≥.CLEANUP"
set "DISM_variable_5=AnalyzeComponentStore.            ≥.ANALYSE"
set "DISM_variable_6=StartComponentCleanup /ResetBase. ≥.RESET"
:DISM3
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Fichiers Images Systäme ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.                                                                          dernier lancement
  echo. 1. Scanner l'image                     [ScanHealth]                        %Last_Run_DISM_SCAN%
if %compatible% GEQ 10 (
  echo. 2. VÇrifier si l'image est endommagÇe  [CheckHealth]                       %Last_Run_DISM_CHECK%
  echo. 3. RÇparer les fichiers Image          [RestoreHealth]                     %Last_Run_DISM_RESTORE%
  echo. 4. Nettoyer les composants remplacÇs   [StartComponentCleanup]             %Last_Run_DISM_CLEANUP%
  echo. 5. Analyser le magasin de composants   [AnalyzeComponentStore]             %Last_Run_DISM_ANALYSE%
  echo. 6. Nettoyer le magasin de composants   [StartComponentCleanup /ResetBase]  %Last_Run_DISM_RESET%
  echo. T. Tout faire
)
echo. 0. Retour
echo.
choice /c 123456T0M /t %Tempo_Inactif% /d M /n /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" goto DISM_0
if %CHOIX% LEQ 7  if %compatible% GEQ 10 goto DISM_0
if "%CHOIX%"=="8" (
    endlocal
    goto CHECK
)
if "%CHOIX%"=="9" call :FIN_INAC
goto DISM3


:RETABLI
call :LOADING

call :SAVO_ETA
call :FILI_ETA
call :TELE_ETA
call :HIBE_ETA
call :HEUR_ETA
call :TRIM_ETA
if "%WIN_LANG%"=="FR"  call :REST_ETA
call :FLEC_ETA
call :COM_ETA 2
call :COM_ETA 1

::    ∑ utliser si tous les xxx_ETA sont connus et Ö jour.
:RETABLI2
::  Regroupement des multiples IF ici plutìt que dans le menu
::  Mise Ö 0 des MENU_x
for %%a in (1 3 6 7) do (set "MENU_%%a=0")

if "%SAVOIR_LVL%"=="1" (
  if %compatible% GEQ 10  set "MENU_1=1" 
)
if not "%Telemetrie_Windows_LVL%"=="0" set "MENU_3=1"
if "%TRIM_LVL%"=="1" (
  if %compatible% GEQ 10  set "MENU_6=1" 
)
if not "%WIN_LANG%"=="FR" set "MENU_7=1"
if "%WIN_LANG%"=="FR" (
  if "%RESTOR_LVL%"=="1"  set "MENU_7=2" 
)

:RETABLI3
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ DÇsactivation des Optimisations ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
if "%MENU_1%"=="1"         echo. 1. RÇtablir l'icìne "En savoir plus sur cette image" sur le bureau
if "%TESTSIGN_LVL%"=="1"   echo. 2. RÇactiver le filigrane "Activer Windows" sur le bureau
if "%MENU_3%"=="1"         echo. 3. RÇtablir la tÇlÇmÇtrie  [actuellement Ö %Telemetrie_TMP%/3]
if "%HIBERFIL_LVL%"=="1"   echo. 4. RÇactiver la Veille prolongÇe
if "%HEURE_LVL%"=="1"      echo. 5. RÇtablir l'horloge virtuelle sous Windows
if "%MENU_6%"=="1"         echo. 6. DÇsactiver le TRIM  [non recommandÇ]
if "%MENU_7%"=="1"         echo. 7. Forcer la dÇsactivation de la Restauration Systäme  [non recommandÇ]
if "%MENU_7%"=="2"         echo. 7. DÇsactiver la Restauration Systäme  [non recommandÇ]
if "%Fleche_Etat%"=="1"    echo. 8. RÇtablir la fläche des raccourcis
if "%Services_LVL_2%"=="1" echo. 9. RÇactiver les Services dÇsactivÇs
if "%Taches_LVL_2%"=="1"   echo. A. RÇactiver les TÉches PlanifiÇes dÇsactivÇes
echo. 0. Retour
echo.
choice /c 123456789A0M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" if "%MENU_1%"=="1"         call :SAVO_INJ
if "%CHOIX%"=="2" if "%TESTSIGN_LVL%"=="1"   set "TESTSIGN_TMP=ON" && call :FILIG
if "%CHOIX%"=="3" if "%MENU_3%"=="1"         goto TELE_RAZ
if "%CHOIX%"=="4" if "%HIBERFIL_LVL%"=="1"   goto HIBERN_1
if "%CHOIX%"=="5" if "%HEURE_LVL%"=="1"      call :HEUR_INJ
if "%CHOIX%"=="6" if "%MENU_6%"=="1"         set "TRIM_TMP=1" && set "TRIM_TXT=DÇsa" && call :TRIM_D
if "%CHOIX%"=="7" if "%RESTOR_LVL%"=="1"     goto RESTOR_D
if "%CHOIX%"=="8" if "%Fleche_Etat%"=="1"    call :FLECH
if "%CHOIX%"=="9" if "%Services_LVL_2%"=="1" set "Elements_ID=2" && goto :COM_0
if "%CHOIX%"=="10" if "%Taches_LVL_2%"=="1"  set "Elements_ID=1" && goto :COM_0
if "%CHOIX%"=="11"                           goto OPTIM4
if "%CHOIX%"=="12"                           call :FIN_INAC
goto RETABLI2


:DNS
setlocal
:DNS1
set "WL_DNS=%WL_VFS%\DNS_Save"
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Modification des DNS ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. Changer les DNS permet de contourner certains blocages de votre FAI.
echo.
echo.
echo.          Voici l'Çtat de vos DNS :

if "%Mode_Test%"=="2" set "TEMPS_1=%time:~3%"
call :DNSDETED
if "%Mode_Test%"=="2" call :TEST_9

echo.
if "%carte_reseau%"=="1" (
    echo. 1. Personnaliser vos DNS   - modifiÇ le %Last_Run_DNS%
    echo. 2. Mettre TOUS les DNS en automatique
)
echo. 0. Retour
echo.
if "%carte_reseau%"=="1" set "KEY=M021"
if "%carte_reseau%"=="0" set "KEY=M0"
choice /c %KEY% /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%carte_reseau%"=="1" (
    if "%CHOIX%"=="4" goto DNSMOD
    if "%CHOIX%"=="3" goto DNSAUTO
)
if "%CHOIX%"=="2" (
    endlocal
    goto OUTILS
)
if "%CHOIX%"=="1" call :FIN_INAC
goto DNS1


:AUTOLOG
call :AUTO_ETA
call :AUTO_QUI
call :AUTO_PAS
:AUTOLOG2
cls
echo.
echo.
echo.      ⁄ƒƒƒƒ AUTO LOGIN WINDOWS ƒƒƒƒø
echo.      ≥                            ≥
if "%AUTOLOG_LVL%"=="1" echo.      ≥      êtat : ACTIF          ≥
if "%AUTOLOG_LVL%"=="0" echo.      ≥      êtat : INACTIF        ≥

if "%AUTOLOG_LVL%"=="1" (
  if defined AUTOLOG_QUI     echo.      ≥      Pour : %AUTOLOG_QUI%
  if not defined AUTOLOG_QUI echo.      ≥      Pour : [vide]         ≥
)
if "%AUTOLOG_LVL%"=="1" (
  if defined AUTOLOG_PASS     echo.      ≥      MdP  : ***********    ≥
  if not defined AUTOLOG_PASS echo.      ≥      MdP  : [vide]         ≥
)
if "%AUTOLOG_LVL%"=="0" (
  echo.      ≥                            ≥
  echo.      ≥                            ≥  
)
echo.      ≥                            ≥
echo.      ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
if "%AUTOLOG_LVL%"=="1" (
                            echo. 1. Modifier AutoLogin
                            echo. 2. Supprimer AutoLogin
                            echo. 3. DÇsactiver AutoLogin
    if defined AUTOLOG_PASS echo. 4. Afficher le mot de passe
)

if "%AUTOLOG_LVL%"=="0" (
    echo. 1. Configurer AutoLogin
    echo. 3. Activer AutoLogin
)

echo. 0. Retour
echo.
choice /c 12340M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" goto AUTO_SET
if "%CHOIX%"=="2" goto AUTO_DEL
if "%CHOIX%"=="3" goto AUTO_DES
if "%CHOIX%"=="4" goto AUTO_AFF
if "%CHOIX%"=="5" (
    endlocal & set "Last_Run_AUTOLOGIN=%Last_Run_AUTOLOGIN%"
    goto AUTOM2
)
if "%CHOIX%"=="6" call :FIN_INAC
goto AUTOLOG


:UPDATE
cls 
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Mises Ö jour tiers ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. Ce menu vous permet de mettre Ö jour tous plein de logiciels.
echo.
echo.
echo.
echo. 1. Voir les mises Ö jour disponibles
echo. 2. Effectuer toutes les mises Ö jour
echo. 0. Retour
echo.
choice /c 120M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" goto UPDATE_A
if "%CHOIX%"=="2" goto UPDATE_B
if "%CHOIX%"=="3" goto OUTILS3
if "%CHOIX%"=="4" call :FIN_INAC
goto UPDATE


:UPDATE_A
::  Affichage simplifiÇ de winget update : Nom, Version, Disponible, 20 lignes par page
if not "%winget%"=="1" (
    echo.
    echo.   Winget n'est pas disponible sur ce PC.
    timeout /t 3 >nul
    goto UPDATE
)
setlocal
cls
echo.
echo.
echo.                     Recherche des mises Ö jour en cours .....
echo.

::  Remise Ö zÇro de toutes les variables UPD_
for /f "delims==" %%V in ('set UPD_ 2^>nul') do set "%%V="
set "UPD_ST=0"
set "UPD_NB=0"
set "UPD_LN=0"
set "UPD_PP=16"
set "UPD_B=                                                    "

::  Winget rÇpond en UTF-8 : la page de codes passe en 65001 le temps de lire sa rÇponse
::  Entre chcp 65001 et le retour Ö la page d'origine : aucun accent, aucun CALL, aucun GOTO
for /f "tokens=2 delims=:" %%a in ('chcp') do for %%b in (%%a) do set "UPD_CP=%%b"
chcp 65001 >nul
for /f "delims=" %%L in ('winget update --accept-source-agreements 2^>nul') do (
    set /a UPD_LN+=1
    set "UPD_L!UPD_LN!=%%L"
)
chcp %UPD_CP% >nul

::  Analyse des lignes mÇmorisÇes, une par une
for /L %%i in (1,1,%UPD_LN%) do (
    set "UPD_L=!UPD_L%%i!"
    call :UPD_LIN
)

if "%Mode_Test%"=="1" (
    echo. [test] lignes lues : %UPD_LN%   ID : %UPD_PID%   Version : %UPD_PVE%   Disponible : %UPD_PDI%
    pause
)
if "%UPD_ST%"=="9" (
    echo.
    echo.   Format de winget non reconnu, affichage natif complet :
    echo.
    winget update
    echo.
    pause
    goto UPD_FIN
)
if "%UPD_NB%"=="0" (
    echo.
    echo.   Aucune mise Ö jour disponible.
    timeout /t 3 >nul
    goto UPD_FIN
)

set "UPD_PG=0"
set /a "UPD_TP=(UPD_NB+UPD_PP-1)/UPD_PP"
:UPD_LIST
set /a "UPD_A=UPD_PG*UPD_PP+1"
set /a "UPD_Z=UPD_A+UPD_PP-1"
if %UPD_Z% GTR %UPD_NB% set "UPD_Z=%UPD_NB%"
set /a "UPD_PN=UPD_PG+1"
:UPD_LIS
set "KEY=0M"
cls
echo.
echo.                     Mises Ö jour disponibles : %UPD_NB%
echo.
set "UPD_Y=Nom!UPD_B!"
set "UPD_W=Version!UPD_B!"
set "UPD_S=!UPD_B: =-!"
echo.   N    !UPD_Y:~0,48!  !UPD_W:~0,18!  Disponible
echo.   ---  !UPD_S:~0,48!  !UPD_S:~0,18!  !UPD_S:~0,10!
for /L %%i in (%UPD_A%,1,%UPD_Z%) do (
    set "UPD_X=%%i!UPD_B!"
    set "UPD_Y=!UPD_N%%i!!UPD_B!"
    set "UPD_W=!UPD_V%%i!!UPD_B!"
    echo.   !UPD_X:~0,3!  !UPD_Y:~0,48!  !UPD_W:~0,18!  !UPD_D%%i!
)
echo.
if %UPD_TP% GEQ 2 set "pageXsurX=   Page %UPD_PN% sur %UPD_TP%"
echo.%pageXsurX%
echo.
if %UPD_NB% GEQ 1 (
    echo. T. Tout mettre Ö jour
    set "KEY=%KEY%T"
)
if %UPD_Z% LSS %UPD_NB% (
    echo. S. Suivantes
    set "KEY=%KEY%S"
) 
echo. 0. Retour
echo.
choice /c %KEY% /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" goto UPD_FIN
if %UPD_Z% LSS %UPD_NB% set /a UPD_PG+=1
if "%CHOIX%"=="3" (
    endlocal 
    goto UPDATE_B
)
if "%CHOIX%"=="4" goto UPD_LIST
if "%CHOIX%"=="2" call :FIN_INAC
goto UPD_LIS


:UPD_FIN
endlocal
goto UPDATE


:UPD_LIN
::  Traite une ligne UPD_L    UPD_ST = 0 attente du tableau, 1 lecture des lignes, 2 tableau fini, 9 format inconnu
if "%UPD_ST%"=="1" goto UPD_ROW
if not "%UPD_ST%"=="0" goto :EOF
::  La ligne de tirets suit la ligne d'en-tàte, on mÇmorise donc la ligne prÇcÇdente
if "!UPD_L:-----=!"=="!UPD_L!" (
    set "UPD_PRV=!UPD_L!"
    goto :EOF
)
::  Position des colonnes dans l'en-tàte, titres en franáais ou en anglais
set "UPD_HDR=!UPD_PRV!"
set "UPD_T=Dispo"
if /i not "%WIN_LANG%"=="FR" set "UPD_T=Avail"
call :UPD_POS UPD_PID "ID" 2
call :UPD_POS UPD_PVE "Version" 7
call :UPD_POS UPD_PDI "%UPD_T%" 5
set "UPD_ST=1"
if not defined UPD_PID set "UPD_ST=9"
if not defined UPD_PVE set "UPD_ST=9"
if not defined UPD_PDI set "UPD_ST=9"
if "%UPD_ST%"=="9" goto :EOF
set /a "UPD_WVE=UPD_PDI-UPD_PVE"
set /a "UPD_M1=UPD_PID-1"
set /a "UPD_M2=UPD_PDI-1"
goto :EOF


:UPD_ROW
::  Une vraie ligne de donnÇes a un espace juste avant les colonnes ID et Disponible, sinon c'est la fin du tableau
if not "!UPD_L:~%UPD_M1%,1!"==" " set "UPD_ST=2"
if not "!UPD_L:~%UPD_M2%,1!"==" " set "UPD_ST=2"
if "%UPD_ST%"=="2" goto :EOF
set "UPD_NOM=!UPD_L:~0,%UPD_PID%!"
set "UPD_VER=!UPD_L:~%UPD_PVE%,%UPD_WVE%!"
set "UPD_DIS=-"
for /f "tokens=1" %%a in ("!UPD_L:~%UPD_PDI%!") do set "UPD_DIS=%%a"
set /a UPD_NB+=1
set "UPD_N%UPD_NB%=!UPD_NOM!"
set "UPD_V%UPD_NB%=!UPD_VER!"
set "UPD_D%UPD_NB%=%UPD_DIS%"
goto :EOF

:UPD_POS
::  %1 = variable rÇsultat    %2 = titre cherchÇ    %3 = longueur du titre
::  Position du titre dans UPD_HDR, sans tenir compte de la casse
set "%~1="
for /L %%i in (0,1,250) do (
    if /i "!UPD_HDR:~%%i,%~3!"=="%~2" (
        set "%~1=%%i"
        goto :EOF
    )
)
goto :EOF


:M_REDEM
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Menu de redÇmarrage ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. 1. AccÇder au dÇmarrage avancÇ
echo. 2. RedÇmarrage normal du PC
echo. 3. Annuler un redÇmarrage programmÇ
echo. 0. Retour
echo.
choice /c 1230M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" set "Reboot_TXT=avancÇ"
if "%CHOIX%"=="2" set "Reboot_TXT=normal"
if  %CHOIX% LEQ 2 goto RESTART
if "%CHOIX%"=="3" call :NORESTAR
if "%CHOIX%"=="4" goto OUTILS3
if "%CHOIX%"=="5" call :FIN_INAC
goto M_REDEM


:CHAN_CHO
call :LIRE_PAR "Update_Channel_LVL"
call :CHANNEL

if "%Update_Channel_LVL%"=="3" set "Update_Channel_TXT=Finale  [recommandÇ]"
if "%Update_Channel_LVL%"=="2" set "Update_Channel_TXT=RC  [risquÇ mais amusant]"
if "%Update_Channel_LVL%"=="1" set "Update_Channel_TXT=Bàta  [träs risquÇ, non recommandÇ]"

cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Niveau des mises Ö jour ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. Ce menu vous permet d'accÇder aux versions Bàta et RC, risquÇ, mais c'est amusant de tester les nouvelles fonctions.
echo.
echo.
echo.          canal actuel : %Update_Channel_TXT%
echo.
if not "%Update_Channel_LVL%"=="3" echo. 1. Versions Finales uniquement   - recommandÇe
if not "%Update_Channel_LVL%"=="2" echo. 2. Versions RC
if not "%Update_Channel_LVL%"=="1" echo. 3. Versions Bàta   - non recommandÇe
echo. 0. Retour
echo.
choice /c 1230M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que choisissez-vous ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" set "Update_Channel_TMP=3"
if "%CHOIX%"=="2" set "Update_Channel_TMP=2"
if "%CHOIX%"=="3" set "Update_Channel_TMP=1"
if "%CHOIX%"=="4" goto PARAM4
if "%CHOIX%"=="5" call :FIN_INAC && goto CHAN_CHO

if "%Update_Channel_LVL%"=="%Update_Channel_TMP%" goto CHAN_CHO
goto CHAN_D


:WIFI
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Clefs WiFi sauvegardÇes ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. 1. Afficher tous les rÇseaux et leurs clefs
echo. 2. Sauvegarder tous les rÇseaux dans un fichier    - fait le %Last_Run_WIFI%
echo. 0. Retour
echo.
choice /c 120M /n /t %Tempo_Inactif% /d M /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="1" goto WIFI_AFF
if "%CHOIX%"=="2" goto WIFI_SAV
if "%CHOIX%"=="3" goto INFOR3
if "%CHOIX%"=="4" call :FIN_INAC
goto WIFI


:RESTOR_E
::  RÇglage manuel de la valeur par dÇfaut de la Restauration Systäme
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Valeur de la Restauration Systäme ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo. Veuillez indiquer la valeur par dÇfaut souhaitÇe de la Restauration Systäme.
echo. En espace disque occupÇ, entre %Restauration_mini% et %Restauration_maxi% Go.
echo.
echo. RÇglage actuel : %Restauration_Valeur% Go
echo. Espace occupÇ  : %RESTOR_USED% Go
echo.
echo.
echo. 0. Retour
echo.

::  Si PowerShell OK, appel de l'inactivitÇ
set "Restauration_Valeur_TMP="
if "%PowerShell%"=="1" call :TIMEOUT1 Restauration_Valeur_TMP " - Entrez la valeur dÇsirÇe" %Tempo_Inactif% M
if "%PowerShell%"=="0" set /p "Restauration_Valeur_TMP= - Entrez la valeur dÇsirÇe : " 

if "%Restauration_Valeur_TMP%"=="0"    goto PARAM4
if /i "%Restauration_Valeur_TMP%"=="M" call :FIN_INAC && goto RESTOR_E
if not defined Restauration_Valeur_TMP goto RESTOR_E
echo.
goto RESTOR_F


:CMRG_SET
::  RÇglage de Clean MGR
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ RÇglage de Clean MGR ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. Dans la fenàtre qui va s'ouvrir, veuillez cocher les ÇlÇments que vous souhaitez nettoyer.
echo.
echo. Perso, je recommande de tout cocher sauf la corbeille.
echo.
echo. Appuyez sur une touche pour continuer ...
timeout /t 60 >nul
cleanmgr /SAGESET:666
call :MAJ_DATE CLEAN_MGR_SET
goto PARAM4


:INACTIF
::  RÇglage manuel de la valeur de l'inactivitÇ dans le script
cls
echo.
echo.                                        ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                        ≥ Tempo de l'inactivitÇ ≥
echo.                                        ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. En cas d'inactivitÇ dans le script, celui se fermera tout seul.
echo. Vous pouvez dÇfinir le temps d'inactivitÇ de 30 Ö 999 secondes
echo. Actuellement rÇglÇe Ö %Tempo_Inactif% secondes.
echo.
echo. 0. Retour
echo.
::  Si PowerShell OK, appel de l'inactivitÇ
set "Tempo_Inactif_TMP="
if "%PowerShell%"=="1" call :TIMEOUT1 Tempo_Inactif_TMP " - Entrez la durÇe dÇsirÇe" %Tempo_Inactif% M
if "%PowerShell%"=="0" set /p "Tempo_Inactif_TMP= - Entrez la durÇe dÇsirÇe : " 
if "%Tempo_Inactif_TMP%"=="0"    goto PARAM4
if /i "%Tempo_Inactif_TMP%"=="M" call :FIN_INAC && goto INACTIF
if not defined Tempo_Inactif_TMP goto INACTIF
echo.
goto INACTIF0

::  :::::::::::::::::::::::::
::  FIN DES MENUS SECONDAIRES
::  :::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE 1.VERIFICATION SYSTEMES
::  :::::::::::::::::::::::::::::::::

:CHKDSK
set "CHECK="
set "IDX="
set "PARTITION="
set "CHKDSK_OPT="
::  DÇfinit une variable contenant toutes les lettres de l'alphabet.
set "ALPHABET=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
cls
echo.
echo.                      ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                      ≥ VÇrification des Disques ≥
echo.                      ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.
echo.
echo. 1. VÇrifier toutes les partitions
echo. 0. Retour
echo.
choice /c %ALPHABET%01 /n /t 30 /d 0 /m "%NBSP%- Quelle partition voulez-vous vÇrifier ? "
::  RÇcupäre le code de retour de choice (1-28) et le convertit en indice 0-27
set /a IDX=%ERRORLEVEL%-1
if "%IDX%"=="27" set "CHECK=TOUT" && goto CHKDSK_A
if "%IDX%"=="26" goto CHECK2

::  Extrait la lettre correspondant Ö l'indice choisi et ajoute le caractäre : (ex. C:).
set "PARTITION=!ALPHABET:~%IDX%,1!:"

if not exist "%PARTITION%\" (
    echo.
    echo.
    echo.           ########    Partition %PARTITION% inexistante    ########
    timeout /t 3 >nul
    goto CHKDSK
)
:CHKDSK_A
echo.
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous effectuer un scan approfondi, donc plus long ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 set "CHKDSK_OPT=/F"
if %CHOIX% LEQ 2 set "CHKDSK_OPT=/F /R"
echo.
echo.
if "%CHECK%"=="TOUT" (
  for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%a:\" (
      cls
      echo.
      echo.
      echo.      Lancement de CHKDSK %%a: %CHKDSK_OPT%
      echo. 
      echo. 
      CHKDSK %%a: %CHKDSK_OPT%
    )
    if "%%a"=="Z" (
      echo.
      echo.
      echo.
      echo.         VÇrification terminÇe.
      goto CHKDSK_B
    )
  )
)
cls
echo.
echo.
echo. Lancement de CHKDSK %PARTITION% %CHKDSK_OPT%
echo.
chkdsk %PARTITION% %CHKDSK_OPT%
set "CHKDSK_RC=%ERRORLEVEL%"
echo.
echo.
echo.
if "%CHKDSK_RC%"=="0" echo.                  [OK]      Aucune erreur trouvÇe sur  %PARTITION%\
if "%CHKDSK_RC%"=="1" echo.                  [OK]      Erreurs trouvÇes et corrigÇes sur  %PARTITION%\
if "%CHKDSK_RC%"=="2" echo.                  [OK]      Nettoyage effectuÇ sur  %PARTITION%\
if "%CHKDSK_RC%"=="3" echo.                  [INFO]      Scan non effectuÇ ou planifiÇ au prochain redÇmarrage, pour  %PARTITION%\
:CHKDSK_B
echo.
echo.
echo.
echo.                                          Retour au menu...
echo.
call :MAJ_DATE CHKDSK
timeout /t 4 >nul
if "%CHECK%"=="TOUT" goto CHECK2
goto CHKDSK


:DISM_0
call :HORODATA
set "File=VFS_DISM_run_%horodata%"
::  CrÇation d'un script intermÇdiaire pour le lancement de DISM
(
echo @echo off
echo title Maintenance DISM - VFS v%SOFT_version% by Dagobert_78
echo setlocal EnableDelayedExpansion
echo mode con cols=101 lines=25
echo set "DISM_count=0"
echo cls
echo :RETRY
echo set /a DISM_count+=1
echo call :CBS_SAVE
echo set "DISM_STAT=INCONNU"
echo cls
echo rem  Lancement des commandes DISM
echo echo.
echo echo.
) > "%APPDATA%\VFS\%File%.bat"

if "%CHOIX%"=="7" (
    echo for /L %%%%Z in ^(1,1,6^) do ^(
    echo     for /f "tokens=1,2,3 delims=." %%%%A in ^("^!DISM_variable_%%%%Z^!"^) do ^(
    echo         echo.    ⁄ƒƒƒƒƒø     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo         echo.    ≥ %%%%Z/6 ≥     ≥ ExÇcution de "DISM /Online /Cleanup-Image /%%%%A"%%%%B
    echo         echo.    ¿ƒƒƒƒƒŸ     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    echo         DISM /Online /Cleanup-Image /%%%%A
    echo         timeout /t 2 ^>nul
    echo         reg add "%WL_VFS%" /v Last_Run_DISM_%%%%C /t REG_SZ /d "%data2%" /f ^>nul
    echo     ^)
    echo ^)
) >> "%APPDATA%\VFS\%File%.bat"

if not "%CHOIX%"=="7" (
    echo for /f "tokens=1,2,3 delims=." %%%%A in ^("%%DISM_variable_%CHOIX%%%"^) do ^(
    echo    echo.    ⁄ƒƒƒƒƒø     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo    echo.    ≥ 1/1 ≥     ≥ ExÇcution de "DISM /Online /Cleanup-Image /%%%%A"%%%%B
    echo    echo.    ¿ƒƒƒƒƒŸ     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    echo    DISM /Online /Cleanup-Image /%%%%A
    echo    timeout /t 2 ^>nul
    echo    reg add "%WL_VFS%" /v Last_Run_DISM_%%%%C /t REG_SZ /d "%data2%" /f ^>nul
    echo ^)
) >> "%APPDATA%\VFS\%File%.bat"

(
echo echo.
echo echo.
echo echo.
echo echo.      Commandes DISM terminÇes.
echo echo.
echo reg add "%WL_VFS%" /v Last_Run_DISM /t REG_SZ /d "%data2%" /f ^>nul
echo.
echo if defined CBS_SAVE_Erreur ^(
echo   timeout /t 30 ^>nul
echo   exit
echo ^)
echo rem  Petite pause pour àtre sñr que CBS est flushÇ
echo timeout /t 2 ^>nul
echo.
echo rem  non analyse des erreurs
echo if "%CHOIX%"=="2" timeout /t 120 ^>nul ^&^& exit
echo if "%CHOIX%"=="4" timeout /t 120 ^>nul ^&^& exit
echo if "%CHOIX%"=="5" timeout /t 120 ^>nul ^&^& exit
echo.
echo rem  Analyses des erreurs
echo rem  Analyse des Çchecs [prioritaires]
echo findstr /i /c:"Cannot repair member file" /c:"Could not reproject corrupted file" /c:"Repair failed" /c:"Warning: Overlap: Directory" "%CBS%" ^>nul ^&^& set "DISM_STAT=2"
echo.
echo rem  Si compteur d'erreur Ö 0
echo if "%%DISM_STAT%%"=="INCONNU" findstr /i /c:"Total Detected Corruption:    0" "%CBS%" ^>nul ^&^& set "DISM_STAT=0"
echo if "%%DISM_STAT%%"=="INCONNU" findstr /i /c:"Total Repaired Corruption:    0" "%CBS%" ^>nul ^&^& set "DISM_STAT=0"
echo.
echo rem  Si compteur d'erreur diffÇrent de 0
echo if "%%DISM_STAT%%"=="INCONNU" findstr /i /c:"Count of times corruption detected:" "%CBS%" ^>nul ^&^& set "DISM_STAT=1"
echo if "%%DISM_STAT%%"=="INCONNU" findstr /i /c:"Total Detected Corruption:" "%CBS%" ^>nul ^&^& set "DISM_STAT=1"
echo if "%%DISM_STAT%%"=="INCONNU" findstr /i /c:"Total Repaired Corruption:" "%CBS%" ^>nul ^&^& set "DISM_STAT=1"
echo.
echo if "%%DISM_STAT%%"=="INCONNU" set "DISM_STAT=0"
echo.
echo rem  RÇsultats
echo echo.
echo echo.
echo if "%%DISM_STAT%%"=="0" ^(
echo    echo.      ******    Aucun probläme dÇtectÇ.    ******
echo    timeout /t 30 ^>nul
echo    exit
echo ^)
echo echo.
echo echo.
echo echo.
echo if "%%DISM_STAT%%"=="1" ^(
echo     echo. Des fichiers Images Systäme ont ÇtÇ rÇparÇs, je vous recommande de le refaire.
echo     echo. Un redÇmarrage du PC est aussi recommandÇ une fois terminÇ.
echo ^)
echo if "%%DISM_STAT%%"=="2" ^(
echo     echo. Certains fichiers Images Systäme n'ont PAS pu àtre rÇparÇs, je vous recommande de relancer DISM.
echo     echo. En cas de soucis persistant, contactez votre administrateur systäme. Moi, c'est Dagobert.
echo ^)
echo echo.
echo echo.
echo if "%%DISM_count%%"=="1" choice /c %%OYN%% /n /t 20 /d O /m "%%NBSP%%- Voulez-vous re-exÇcuter une 2e fois DISM ?  [o/n] "
echo if not "%%DISM_count%%"=="1" choice /c %%OYN%% /n /t 20 /d N /m "%%NBSP%%- Voulez-vous encore exÇcuter DISM ?  [o/n] "
echo set "ERR_DISM=%%ERRORLEVEL%%"
echo if %%ERR_DISM%% LEQ 2 goto RETRY
echo exit
echo.
) >> "%APPDATA%\VFS\%File%.bat"

:: Appel des routines partagÇes
call :CBS_SA_1 %File%
call :STOP_S_1 %File%
call :HORODA_1 %File%

::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\%File%.bat"
timeout /t 3 >nul
goto DISM3


:CBS_SA_1
(
echo.
echo :CBS_SAVE
echo set "CBS_SAVE_Erreur="
echo rem  Renommage du CBS.log
echo cls
echo if not exist "%CBS%" goto :EOF
echo echo.
echo echo.  Tentative de sauvegarde du fichier CBS.log...
echo call :STOP_SVC TrustedInstaller
echo if "%%ERR_Running_TrustedInstaller%%"=="1" ^(
echo     call :HORODATA
echo     ren "%CBS%" "CBS_%%horodata%%.log" 2^>nul
echo     if not exist "%CBS%" ^(
echo         cls
echo         echo.
echo         echo. Sauvegarde rÇussie du fichier CBS.log.
echo         goto :EOF
echo     ^)
echo ^)
echo cls
echo echo.
echo echo. Sauvegarde impossible car le fichier est occupÇ.
echo set "CBS_SAVE_Erreur=1"
echo goto :EOF
echo.
) >> "%APPDATA%\VFS\%1.bat"
goto :EOF


:STOP_S_1
(
echo.
echo :STOP_SVC
echo rem   Permet d'arràter des Services
echo rem  %1 = nom du service
echo set "ERR_Present_%%1=1"
echo set "ERR_Running_%%1=1"
echo for /L %%%%B in ^(1,1,4^) do ^(
echo     REM  On vÇrifie si le Service est prÇsent
echo     sc query "%%1" ^>nul 2^>^&1
echo     set "ERR_Present_%%1=^!ERRORLEVEL^!"
echo     if "^!ERR_Present_%%1^!"=="0" ^(
echo         sc query "%%1" ^| findstr "RUNNING" ^>nul
echo         set "ERR_Running_%%1=^!ERRORLEVEL^!"
echo         if "^!ERR_Running_%%1^!"=="1" goto :EOF
echo         net stop "%%1" ^>nul 2^>^&1
echo     ^)
echo ^)
echo goto :EOF
echo.
) >> "%APPDATA%\VFS\%1.bat"
goto :EOF


:HORODA_1
(
echo.
echo :HORODATA
echo rem Routine horodatage pour nommer les fichiers
echo rem   au format AA.MM.DD_HHhMM.SSs
echo rem  On prend les 10 derniers caractäres de la date pour Çliminer "mer. "
echo for /f "tokens=1-4 delims=/ " %%%%a in ^("%%date:~-10%%"^) do set "jour=%%%%a" ^& set "mois=%%%%b" ^& set "annee=%%%%c"
echo for /f "tokens=1-3 delims=: " %%%%a in ^("%%time:,=.%%"^) do set "heure=%%%%a" ^& set "min=%%%%b" ^& set "sec=%%%%c"
echo set "horodata=%%annee%%.%%mois%%.%%jour%%_%%heure%%h%%min%%.%%sec%%s"
echo goto :EOF
echo.
) >> "%APPDATA%\VFS\%1.bat"
goto :EOF


:SFC
setlocal
::  SFC avec analyse CBS 
set "SFC_count=0"
:SFC_2
set "SFC_RC="
set "SFC_STAT=INCONNU"
call :CBS_SAVE

echo.
echo.      ExÇcution de "sfc /scannow"
echo.
sfc /scannow
set "SFC_RC=%ERRORLEVEL%"

if defined CBS_SAVE_Erreur (
  timeout /t 3 >nul
  endlocal
  call :MAJ_DATE SFC 
  goto CHECK2
)

set /a SFC_count+=1

::  Petite pause pour àtre sñr que CBS est flushÇ
timeout /t 2 >nul

::  Si erreur d'exÇcution, en utilisant le ERRORLEVEL de SFC
if not defined SFC_RC (
    set "SFC_STAT=3"
) else (
    if %SFC_RC% GEQ 3 set "SFC_STAT=3"
)
if "%SFC_STAT%"=="3" goto SFC_1

::  Analyse des Çchecs [prioritaires]
findstr /i ^
 /c:"Cannot repair member file" ^
 /c:"Could not reproject corrupted file" ^
 /c:"Repair failed" ^
 "%CBS%" >nul && set "SFC_STAT=2"

::  Si pas d'Çchec, chercher d'Çventuelles rÇparations
if "%SFC_STAT%"=="INCONNU" (
  findstr /i ^
   /c:"All files and registry keys listed in this transaction  have been successfully repaired" ^
   /c:"Repaired file:" ^
   "%CBS%" >nul && set "SFC_STAT=1"
)

::  Si rien trouvÇ
if "%SFC_STAT%"=="INCONNU" set "SFC_STAT=0"

::  RÇsultats
echo.
echo.
if "%SFC_STAT%"=="0" (
  echo.      ******    Aucun probläme dÇtectÇ.    ******
  endlocal
  call :MAJ_DATE SFC
  timeout /t 3 >nul
  goto CHECK2
)
:SFC_1
echo.
echo.
echo.
if "%SFC_STAT%"=="3" (
  echo.                    ******    Erreur d'exÇcution de SFC   ******
  echo.         Retour au menu
  endlocal
  timeout /t 4 >nul
  goto CHECK2
)

echo.
echo.
if "%SFC_STAT%"=="1" goto SFC_STA1
if "%SFC_STAT%"=="2" goto SFC_STA2
::  un petit relevÇ des variables pour sÇcuriser, au cas oó %SFC_STAT% aurait une valeur non prÇvue
echo.
echo.                    ******    ERREUR  dans le retour d'information de SFC    ******
echo.
echo.        SFC_RC : -%SFC_RC%- 
echo.         CHOIX : -%CHOIX%- 
echo.      SFC_STAT : -%SFC_STAT%- 
echo.           CBS : -%CBS%- 
echo.    ERRORLEVEL : -%ERRORLEVEL%- 
echo.     SFC_count : -%SFC_count%- 
echo.
echo.
echo.
echo.                               Appuyez sur une touche pour revenir au menu...
pause>NUL
endlocal
goto ACCUEIL


:SFC_STA1
echo. Des fichiers Systäme ont ÇtÇ rÇparÇs, je vous recommande de le refaire.
echo. Un redÇmarrage du PC est aussi recommandÇ une fois terminÇ.
echo.
echo.
if "%SFC_count%"=="1" choice /c %OYN% /n /t 20 /d O /m "%NBSP%- Voulez-vous re-exÇcuter une 2e fois SFC ?  [o/n] "
if not "%SFC_count%"=="1" choice /c %OYN% /n /t 20 /d N /m "%NBSP%- Voulez-vous encore reexÇcuter SFC ?  [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% LEQ 2 goto SFC_2
endlocal
goto CHECK2


:SFC_STA2
echo. Certains fichiers systäme n'ont PAS pu àtre reparÇs, je vous recommande de lancer DISM.
echo.
echo.
echo.
choice /c %OYN% /n /t 20 /d O /m "%NBSP%- Voulez-vous exÇcuter DISM [recommandÇ]  [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% LEQ 2 (
    endlocal
    goto DISM
)
endlocal
goto CHECK2


:SIGNA
start "" sigverif
call :MAJ_DATE SIGVERIF
goto CHECK2


:DEFENDE
setlocal
echo.
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous effectuer un scan approfondi, donc plus long ? [Oui/Non/Annuler]"
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 4 (
    endlocal
    goto CHECK2
)
if "%CHOIX%"=="3" set "DEFENDER_OPT=1" && set "DEFENDER_TXT=rapide"
if %CHOIX% LEQ 2  set "DEFENDER_OPT=2" && set "DEFENDER_TXT=compläte"

echo.
echo.    Lancement d'une analyse antivirus %DEFENDER_TXT% [Windows Defender]...
echo.    Cette opÇration s'exÇcutera en arriäre-plan...

::  CrÇation d'un script intermÇdiaire pour le lancement de Windows Defender
  (
  echo @echo off
  echo title Analyse antivirus - VFS v%SOFT_version% by Dagobert_78
  echo set "DEF_RESULT=inconnu"
  echo mode con cols=70 lines=20
  echo cls
  echo echo.
  echo echo.             Analyse antivirus %DEFENDER_TXT% avec Windows Defender
  echo echo.                          Veuillez patienter..
  echo echo.
  echo timeout /t 3 ^>nul
  echo "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType %DEFENDER_OPT%
  echo set "DEF_RESULT=%%ERRORLEVEL%%"
  echo echo.
  echo echo.
  echo :: InterprÇtation du rÇsultat
  echo if "%%DEF_RESULT%%"=="0" echo.    [SUCC‘S] Aucun logiciel malveillant trouvÇ.           
  echo if "%%DEF_RESULT%%"=="0" echo.             ou les menaces ont ÇtÇ correctement rÇsolues.
           
  echo if "%%DEF_RESULT%%"=="2" echo.    [ATTENTION] Une menace a ÇtÇ dÇtectÇe et n'a pas pu àtre rÇsolue, 
  echo if "%%DEF_RESULT%%"=="2" echo.                OU une erreur s'est produite durant l'analyse.
  echo if "%%DEF_RESULT%%"=="2" echo.                Veuillez vÇrifier l'historique de Windows Defender.
  
  echo :: SÇcuritÇ au cas oó un autre code d'erreur est renvoyÇ
  echo if not "%%DEF_RESULT%%"=="0" if not "%%DEF_RESULT%%"=="2" echo.    [êCHEC] L'analyse a renvoyÇ un code d'erreur inattendu : %%DEF_RESULT%%
  echo echo.  
  echo echo.                                                                            
  echo echo.
  echo reg add "%WL_VFS%" /v Last_Run_WIN_DEFENDER /t REG_SZ /d "%data2%" /f ^>nul
  echo if "%%DEF_RESULT%%"=="0" set "tempo=/t 120 /d N "
  echo choice /c OYN /n %%tempo%%/m "%NBSP%- Voulez-vous voir le rÇsultat de l'analyse ?  [o/n] "
  echo set "CHOIX=%%ERRORLEVEL%%"
  echo if %%CHOIX%% LEQ 2 copy "%ProgramData%\Microsoft\Windows Defender\Support\MPLog*.log" "%temp%\defender_vfs.log"
  echo if %%CHOIX%% LEQ 2 start notepad "%temp%\defender_vfs.log"
  echo timeout /t 1 ^>nul
  echo exit
  ) > "%APPDATA%\VFS\VFS_Defender_scan.bat"
    
::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\VFS_Defender_scan.bat"
endlocal
timeout /t 3 >nul
goto CHECK2
    

:MRT
setlocal
echo.
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous effectuer un scan complet, donc plus long ? [Oui/Non/Annuler]"
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 4 (
    endlocal
    goto CHECK2
)
if "%CHOIX%"=="3" set "MRT_OPT="     && set "MRT_TXT=rapide"
if %CHOIX% LEQ 2  set "MRT_OPT=/F:Y" && set "MRT_TXT=compläte"

echo.
echo.
echo.    Lancement de l'outil de suppression des logiciels malveillants [MRT]...
echo.    Cette opÇration s'exÇcutera en arriäre-plan...

::  CrÇation d'un script intermÇdiaire pour le lancement de MRT
  (
  echo @echo off
  echo title AntiMalware - VFS v%SOFT_version% by Dagobert_78
  echo set "MRT_RC="
  echo mode con cols=61 lines=13
  echo cls
  echo echo.
  echo echo.   Outil de suppression des logiciels malveillants - MRT
  echo echo.
  echo echo.           Analyse %MRT_TXT% anti-malware en cours...
  echo echo.                     Veuillez patienter
  echo echo.
  echo timeout /t 3 ^>nul
  echo start /wait MRT /Q %MRT_OPT%
  echo set "MRT_RC=%%ERRORLEVEL%%"
  echo echo.
  echo echo.
  echo :: InterprÇtation du rÇsultat
  echo if "%%MRT_RC%%"=="0" echo.    [OK]       Aucune infection dÇtectÇe    
  echo if "%%MRT_RC%%"=="1" echo.    [OK]       Infection dÇtectÇe et supprimÇe.     
  echo if "%%MRT_RC%%"=="2" echo.    [ATTENTION] Infection dÇtectÇe mais non supprimÇe        
  echo if %%MRT_RC%% GEQ 3  echo.    [ERREUR]   Code erreur inattendu : %%MRT_RC%%
  echo echo.  
  echo echo.
  echo echo.
  echo reg add "%WL_VFS%" /v Last_Run_MRT /t REG_SZ /d "%data2%" /f ^>nul
  echo if "%%MRT_RC%%"=="0" set "tempo=/t 60 /d N "
  echo choice /c OYN /n %%tempo%%/m "%NBSP%- Voulez-vous voir le rÇsultat de l'analyse ?  [o/n] "
  echo set "CHOIX=%%ERRORLEVEL%%"
  echo if %%CHOIX%% LEQ 2 start notepad "%windir%\debug\mrt.log"
  echo timeout /t 1 ^>nul
  echo exit
  ) > "%APPDATA%\VFS\VFS_MRT_scan.bat"
    
::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\VFS_MRT_scan.bat"
endlocal
goto CHECK2


:SCANRAM
echo.
echo.    Planification du Diagnostic de mÇmoire Windows...
start mdsched.exe
timeout /t 3 >nul
call :MAJ_DATE RAM
goto CHECK2


::  :::::::::::::::::::::::::::::::::
::  FIN ROUTINES DE 1.VERIFICATION SYSTEMES
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE 2.OUTILS SYSTEMES
::  :::::::::::::::::::::::::::::::::

:DNSMOD
set "V4="
set "V6="
set "serveur="
cls 
echo.
echo.
echo. 1. AdGuard     [recommandÇ car le plus filtrant]
echo. 2. Cloudflare  [le plus rapide]
echo. 3. Control D 
echo. 4. FDN
echo. 5. DNS Forge
echo. 6. dns0.eu
echo. 7. Google DNS
echo. 8. Open DNS
echo. 9. Quad9  [ fermeture le 24 novembre 2026 ]
::  echo. 9. NextDNS
::  echo. B. Gcore DNS
echo. A. Automatique [par dÇfaut]
echo. R. Restaurer des DNS sauvegardÇs
echo.
echo. 0. Retour
echo.
choice /c 123456789AR0 /n /t %Tempo_Inactif% /d 0 /m "%NBSP%- Quels DNS voulez-vous utilisÇs ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="12" goto DNS1
if "%CHOIX%"=="10" goto DNS_MEN
echo.                             Veuillez patienter .....
goto DNSMOD_1


:DNSAUTO
call :DNS_SAV
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-DnsClient | Set-DnsClientServerAddress -ResetServerAddresses"
echo.
echo.
echo.    Tous vos DNS IPv4 et IPv6 ont ÇtÇ remis par dÇfaut.
echo.
echo.
echo.
echo.                                     Retour au menu...
echo.
echo.
timeout /t 4 >nul
goto DNS1
 

:DNSMOD_1
::  DÇfinition des serveurs DNS
if "%CHOIX%"=="1" (
    set "V4=94.140.14.14, 94.140.15.15"
    set "V6=2620:119:35::35, 2a10:50c0::ad2:ff"
    set "serveur=AdGuard"
)
if "%CHOIX%"=="2" (
   set "V4=1.1.1.1, 1.0.0.1"
   set "V6=2606:4700:4700::1111, 2606:4700:4700::1001"
   set "serveur=Cloudflare"
)
if "%CHOIX%"=="3" (
    set "V4=76.76.2.0, 76.76.10.0"
    set "V6=2606:1a40::, 2606:1a40:1::"
    set "serveur=Control D"
)
if "%CHOIX%"=="4" (
    set "V4=80.67.169.12, 80.67.169.40"
    set "V6=2001:910:800::40, 2001:910:800::12"
    set "serveur=FDN"
)
if "%CHOIX%"=="5" (
    set "V4=49.12.67.122, 91.99.154.175"
    set "V6=2a01:4f8:c013:29d::122, 2a01:4f8:c010:8c35::175"
    set "serveur=DNS Forge"
)
if "%CHOIX%"=="6" (
    set "V4=193.110.81.0, 185.253.5.0"
    set "V6=2a0f:fc80::, 2a0f:fc81::"
    set "serveur=dns0.eu"
)
if "%CHOIX%"=="7" (
    set "V4=8.8.8.8, 8.8.4.4"
    set "V6=2001:4860:4860::8888, 2001:4860:4860::8844"
    set "serveur=Google"
)
if "%CHOIX%"=="8" (
    set "V4=208.67.222.222, 208.67.220.220"
    set "V6=2620:119:35::35, 2620:119:53::53"
    set "serveur=OpenDNS"
)
if "%CHOIX%"=="9" (
    set "V4=9.9.9.9, 149.112.112.112"
    set "V6=2620:fe::9, 2620:fe::fe"
    set "serveur=Quad9"
)
if "%CHOIX%"=="88888" (
    set "V4=95.85.95.85, 2.56.220.2"
    set "V6=2a03:90c0:999d::1, 2a03:90c0:9992::1"
    set "serveur=Gcore DNS"
)
if "%CHOIX%"=="888888" (
    set "V4=45.90.28.0, 45.90.30.0"
    set "V6=2a07:a8c0::, 2a07:a8c1::"
    set "serveur=NextDNS"
)
if "%CHOIX%"=="10" set "serveur=defaut"

cls
echo.
echo.  Cartes rÇseau actives :
echo.
set "carte_reseau=0"
for /f "tokens=3*" %%A in ('netsh interface show interface ^| findstr /i "Connect"') do (
    set /a carte_reseau+=1
    set "carte_!carte_reseau!=%%B"
    echo.  !carte_reseau!. %%B
)

if "%carte_reseau%"=="0" (
    echo.  [i] Aucune carte rÇseau active trouvÇe.
    timeout /t 3 >nul
    goto DNSMOD_2
)

echo.
set "CHOIX_CARTE="
set /p "CHOIX_CARTE=%NBSP%- SÇlectionner le numÇro de la carte (0 pour annuler) : "
::   Suppression des espaces Çventuels
if defined CHOIX_CARTE set "CHOIX_CARTE=%CHOIX_CARTE: =%"

if "%CHOIX_CARTE%"=="0" goto DNSMOD_2
if not defined carte_%CHOIX_CARTE% goto DNSMOD_1
echo.
echo.  Mise Ö jour de vos DNS en cours ...
set "carte_reseau=!carte_%CHOIX_CARTE%!"

call :DNS_SAV "%carte_reseau%"

if "%serveur%"=="defaut" (
    netsh interface ipv4 set dnsservers name="%carte_reseau%" source=dhcp >nul
    netsh interface ipv6 set dnsservers name="%carte_reseau%" source=dhcp >nul
) else (
    for /f "tokens=1,2 delims=," %%A in ("%V4%") do (
        netsh interface ipv4 set dnsservers name="%carte_reseau%" static %%A primary >nul
        netsh interface ipv4 add dnsservers name="%carte_reseau%" %%B index=2 >nul
    )
    for /f "tokens=1,2 delims=," %%A in ("%V6%") do (
        netsh interface ipv6 set dnsservers name="%carte_reseau%" static %%A primary >nul
        netsh interface ipv6 add dnsservers name="%carte_reseau%" %%B index=2 >nul
    )
)

cls
echo.
echo.
if not "%CHOIX%"=="10" set "MSG_DNS=Les DNS de %serveur% ont ÇtÇ appliquÇs"
if "%CHOIX%"=="10"     set "MSG_DNS=Les DNS par dÇfaut ont ÇtÇ appliquÇs"
echo.          %MSG_DNS% sur '%carte_reseau%'
set "MSG_DNS="

call :CLEARDNS
call :MAJ_DATE DNS
:DNSMOD_2
set "V4="
set "V6="
set "serveur="
goto DNS1


:DNSDETED
::   DÇtection DNS par interface
::  Cloudflare, Google, Quad9, OpenDNS, AdGuard, FDN, dns0.eu,
::  Control D, DNSforge, Orange, Bouygues, Free, SFR, Gcore DNS, NextDNS 

::   DÇtection DNS optimisÇe en un seul appel PowerShell
set "carte_reseau=0"

set "PSCODE=$adapters = Get-DnsClientServerAddress -AddressFamily IPv4; " ^
    "if (-not $adapters) { exit 1 }; " ^
    "$res = $adapters | ForEach-Object { " ^
    "  $dns = $_.ServerAddresses -join ', '; " ^
    "  if ($dns -match '1\.1\.1\.1|1\.0\.0\.1') { $p='Cloudflare' } " ^
    "  elseif ($dns -match '8\.8\.8\.8|8\.8\.4\.4') { $p='Google' } " ^
    "  elseif ($dns -match '208\.67\.222\.222|208\.67\.220\.220') { $p='OpenDNS' } " ^
    "  elseif ($dns -match '94\.140\.14\.14|94\.140\.15\.15') { $p='AdGuard' } " ^
    "  elseif ($dns -match '94\.140\.14\.15|94\.140\.15\.16') { $p='AdGuard Famille' } " ^
    "  elseif ($dns -match '94\.140\.14\.140|94\.140\.15\.141') { $p='AdGuard Blank' } " ^
    "  elseif ($dns -match '76\.76\.2\.|76\.76\.10\.') { $p='Control D' } " ^
    "  elseif ($dns -match '193\.110\.81\.0|185\.253\.5\.0') { $p='dns0.eu' } " ^
    "  elseif ($dns -match '49\.12\.67\.122|91\.99\.154\.175|176\.9\.93\.198|176\.9\.1\.117') { $p='DNSforge' } " ^
    "  elseif ($dns -match '49\.12\.223\.|49\.12\.43\.') { $p='DNSforge Clean' } " ^
    "  elseif ($dns -match '49\.12\.222\.|88\.198\.122\.154') { $p='DNSforge Hard' } " ^
    "  elseif ($dns -match '138\.199\.149\.149|78\.47\.71\.194') { $p='DNSforge Blank' } " ^
    "  elseif ($dns -match '80\.67\.169\.12|80\.67\.169\.40') { $p='FDN' } " ^
    "  elseif ($dns -match '95\.85\.95\.85|2\.56\.220\.2') { $p='Gcore DNS' } " ^
    "  elseif ($dns -match '45\.90\.28\.0|45\.90\.30\.0') { $p='NextDNS' } " ^
    "  elseif ($dns -match '9\.9\.9\.9|149\.112\.112\.112') { $p='Quad9  [ferme le 24.11.2026]' } " ^
    "  elseif ($dns -match '192\.168\.|10\.|172\.|127\.0\.0\.1') { $p='Routeur / Local' } " ^
    "  elseif ($dns -match '109\.0\.66\.10|109\.0\.66\.20|89\.2\.0\.') { $p='Local SFR' } " ^
    "  elseif ($dns -match '80\.10\.246\.2|80\.10\.246\.129') { $p='Orange' } " ^
    "  elseif ($dns -match '194\.158\.122\.10|194\.158\.122\.15') { $p='Bouygues Telecom' } " ^
    "  elseif ($dns -match '212\.27\.40\.240|212\.27\.40\.241') { $p='Free' } " ^
    "  elseif ($dns -match 'fec0\.0\.0\.0') { $p='Windows Default' } " ^
    "  else { $p='FAI ou Inconnu' }; " ^
    "  if ($dns) { [PSCustomObject]@{ Interface=$_.InterfaceAlias; DNS_IPv4=$dns; Fournisseur=$p } } " ^
    "}; " ^
    "if ($res) { $res | Format-Table -AutoSize; exit 0 } else { exit 1 }"

powershell -NoProfile -ExecutionPolicy Bypass -Command "%PSCODE%"
if "%ERRORLEVEL%"=="0" set "carte_reseau=1"
if not "%ERRORLEVEL%"=="0" (
    echo.
    echo.       Aucune carte rÇseau active dÇtectÇe.
    echo.       Modification des DNS non disponible.
    echo.
)
goto :EOF


:DNS_SAV
::  Sauvegarde dans le registre des DNS actuels, avant modification
::  %1 = nom de la carte    [vide = toutes les cartes]
set "DNS_NB=0"
set "PSCODE=$f = '%~1'; $r = 'HKLM:\SYSTEM\CurrentControlSet\Services\';"
set "PSCODE=%PSCODE% Get-NetAdapter | Where-Object { -not $f -or $_.Name -eq $f } | ForEach-Object {"
set "PSCODE=%PSCODE% $g = $_.InterfaceGuid;"
set "PSCODE=%PSCODE% $a = (Get-ItemProperty ($r + 'Tcpip\Parameters\Interfaces\' + $g) -ErrorAction SilentlyContinue).NameServer;"
set "PSCODE=%PSCODE% $b = (Get-ItemProperty ($r + 'Tcpip6\Parameters\Interfaces\' + $g) -ErrorAction SilentlyContinue).NameServer;"
set "PSCODE=%PSCODE% if ($a) { $a = $a -replace '\s+', ',' } else { $a = '-' };"
set "PSCODE=%PSCODE% if ($b) { $b = $b -replace '\s+', ',' } else { $b = '-' };"
set "PSCODE=%PSCODE% '' + $_.ifIndex + '|' + $_.Name + '|' + $a + '|' + $b }"

::  Une ligne par carte :  index|nom|DNS IPv4|DNS IPv6
for /f "tokens=1* delims=|" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "%PSCODE%" 2^>nul') do (
    ::  Orig_ n'est Çcrit qu'une seule fois, Prec_ est ÇcrasÇ Ö chaque fois
    reg query "%WL_DNS%" /v "Orig_%%A" >nul 2>&1 || reg add "%WL_DNS%" /v "Orig_%%A" /t REG_SZ /d "%%B" /f >nul
    reg add "%WL_DNS%" /v "Prec_%%A" /t REG_SZ /d "%%B" /f >nul
    set /a DNS_NB+=1
)
if "%DNS_NB%"=="0" (
    echo.
    echo.   [ATTENTION] Sauvegarde des DNS impossible.
    timeout /t 3 >nul
)
set "PSCODE="
goto :EOF


:DNS_MEN
cls
echo.
echo.
echo. 1. Revenir aux DNS prÇcÇdents   [avant la derniäre modification]
echo. 2. Revenir aux DNS d'origine    [avant la toute premiäre modification]
echo. 0. Retour
echo.
choice /c 120 /n /t 30 /d 0 /m "%NBSP%- Que voulez-vous faire ? "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="3" goto DNSMOD
set "DNS_SLOT=Prec"
if "%CHOIX%"=="2" set "DNS_SLOT=Orig"
goto DNS_CAR


:DNS_CAR
::  Choix de la carte rÇseau Ö restaurer    DNS_SLOT = Prec ou Orig
set "DNS_NB=0"

::  Efface les anciennes listes [Çvite de garder des cartes d'un passage prÇcÇdent]
for /f "delims==" %%V in ('set DNS_REC 2^>nul') do set "%%V="

cls
echo.
echo.                    Restauration des DNS sauvegardÇs
echo.
echo.
::  Une ligne par carte :  nom|DNS IPv4|DNS IPv6      [- = automatique]
for /f "tokens=2,*" %%A in ('reg query "%WL_DNS%" 2^>nul ^| findstr /i /c:"%DNS_SLOT%_"') do (
    for /f "tokens=1-3 delims=|" %%C in ("%%B") do (
        set /a DNS_NB+=1
        set "DNS_REC!DNS_NB!=%%B"
        set "AFF4=%%D"
        set "AFF6=%%E"
        if "%%D"=="-" set "AFF4=auto"
        if "%%E"=="-" set "AFF6=auto"
        echo. !DNS_NB!. %%C    IPv4 : !AFF4!    IPv6 : !AFF6!
    )
)

if "%DNS_NB%"=="0" (
    echo.   [i] Aucune sauvegarde trouvÇe.
    timeout /t 3 >nul
    goto DNS_MEN
)

echo.
echo. T. Toutes les cartes
echo. 0. Retour
echo.

::  Si PowerShell OK, appel de l'inactivitÇ
set "DNS_SEL="
::  On a dÇjÖ validÇ que PowerShell=1
call :TIMEOUT1 DNS_SEL " - NumÇro de la carte" %Tempo_Inactif% M
if defined DNS_SEL set "DNS_SEL=%DNS_SEL: =%"

if "%DNS_SEL%"=="0"    goto DNS_MEN
if /i "%DNS_SEL%"=="M" call :FIN_INAC && goto DNS_CAR
if /i "%DNS_SEL%"=="T" goto DNS_ALL

::  On vÇrifie l'unique prÇsence de chiffres, puis que la carte existe
for /f "delims=0123456789" %%V in ("%DNS_SEL%") do goto DNS_CAR
if not defined DNS_REC%DNS_SEL% goto DNS_CAR

echo.
echo.  Restauration des DNS en cours ...
call :DNS_APP "!DNS_REC%DNS_SEL%!"
goto DNS_FIN

:DNS_ALL
echo.
echo.  Restauration des DNS en cours ...
for /L %%i in (1,1,%DNS_NB%) do call :DNS_APP "!DNS_REC%%i!"

:DNS_FIN
call :CLEARDNS
call :MAJ_DATE DNS
for %%a in (DNS_SLOT DNS_SEL DNS_NB WL_DNS AFF4 AFF6) do (set "%%a=")
for /f "delims==" %%V in ('set DNS_REC 2^>nul') do set "%%V="
goto DNS1


:DNS_APP
::  Restaure une carte    %1 = "nom|DNS IPv4|DNS IPv6"
for /f "tokens=1-3 delims=|" %%C in ("%~1") do (
    call :DNS_SET ipv4 "%%C" "%%D"
    call :DNS_SET ipv6 "%%C" "%%E"
    echo.
    echo.   DNS restaurÇs sur '%%C'
)
goto :EOF


:DNS_SET
::  %1 = ipv4 ou ipv6    %2 = nom de la carte    %3 = DNS sÇparÇs par une virgule, ou - pour automatique
if "%~3"=="-" (
    netsh interface %~1 set dnsservers name="%~2" source=dhcp >nul
    goto :EOF
)
set "DNS_N=0"
for %%S in (%~3) do (
    set /a DNS_N+=1
    if !DNS_N! EQU 1 netsh interface %~1 set dnsservers name="%~2" static %%S primary >nul
    if !DNS_N! GTR 1 netsh interface %~1 add dnsservers name="%~2" %%S index=!DNS_N! >nul
)
goto :EOF


:CLEARDNS
setlocal
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous effacer le cache des DNS ? [o/n]"
set "CHOIX=%ERRORLEVEL%"

if %CHOIX% GEQ 3 (
    echo.
    echo.
    echo.       [i]  Le cache DNS n'a pas ÇtÇ effacÇ.
    endlocal
    timeout /t 3 >nul
    goto :EOF
)

echo.
echo.  [+]  Nettoyage du cache DNS en cours...
ipconfig /flushdns
timeout /t 1 >nul
endlocal
call :MAJ_DATE DEL_CLEAR_DNS
timeout /t 3 >nul
goto :EOF


:UPDATE_B
::  CrÇation d'un mini-script pour le lancement de Winget Update --all
  (
  echo @echo off
  echo title Winget Update - VFS v%SOFT_version% by Dagobert_78
  echo mode con cols=100 lines=13
  echo cls
  echo echo.
  echo echo.                Mises Ö jour tiers - Winget Update
  echo echo.
  echo winget update --all
  echo reg add "%WL_VFS%" /v Last_Run_UPDATE /t REG_SZ /d "%data2%" /f ^>nul
  echo timeout /t 3 ^>nul
  echo exit
  ) > "%APPDATA%\VFS\VFS_Update_All.bat"
    
::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\VFS_Update_All.bat"
goto UPDATE


:RESTART
setlocal
::  RedÇmarrage du PC
echo.
echo.
echo.    Le PC redÇmarrera en mode %Reboot_TXT% 10 secondes apräs.
echo.    Veuillez sauvegarder tous vos documents.
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Taper V pour valider ou 0 pour annuler : "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="22" (
    call :RESTARTV
    endlocal
    goto M_REDEM
)
echo.
echo.             RedÇmarrage non initiÇ.
endlocal
timeout /t 3 >nul
goto M_REDEM


:RESTARTV
setlocal
if "%Reboot_TXT%"=="normal" set "Reboot_OPT=/t 10"
if "%Reboot_TXT%"=="avancÇ" set "Reboot_OPT=/o /t 10"

::  CrÇation d'un script intermÇdiaire pour le compte Ö rebours
  (
  echo @echo off
  echo setlocal EnableDelayedExpansion
  echo title Compte Ö rebours du redÇmarrage en mode %Reboot_TXT% - VFS v%SOFT_version% by Dagobert_78
  echo mode con cols=70 lines=9
  echo cls
  echo echo.
  echo shutdown /r %Reboot_OPT%
  echo set "ERROR=%%ERRORLEVEL%%"
  echo if "%%ERROR%%"=="0" ^(
  echo     for /L %%%%i in ^(10,-1,0^) do ^(
  echo         if %%%%i GEQ 10 set "seconde=secondes ≥"
  echo         if %%%%i EQU 9  set "seconde=secondes  ≥"
  echo         if %%%%i LEQ 1  set "seconde=seconde   ≥"
  echo         cls
  echo         echo.
  echo         echo.              ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
  echo         echo.              ≥  RedÇmarrage %Reboot_TXT% dans %%%%i ^^!seconde^^!
  echo         echo.              ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
  echo         timeout /t 1 ^>nul
  echo         ^)
  echo     ^)
  echo if not "%%ERROR%%"=="0" echo.             RedÇmarrage non initiÇ.
  echo timeout /t 2 ^>nul
  echo exit
  ) > "%APPDATA%\VFS\restartv.bat"
    
::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\restartv.bat"

::  RedÇmarre l'ordinateur si l'utilisateur de touche rien.
::   Ne pas mettre de CHOICE qui limiterait les touches pour annuler.
echo.
echo.
echo.                      [  Appuyez sur une touche pour annuler le redÇmarrage programmÇ  ]
endlocal
pause>nul
goto NORESTAR


:NORESTAR
::  Annulation d'un redÇmarrage programmÇ
echo.
echo.
echo.    Annulation d'un redÇmarrage programmÇ....
echo.
echo.
shutdown /a
timeout /t 3 >nul
goto :EOF


:DRIVERS
setlocal
call :DESKTOP
call :HORODATA
set "BackupFolder=%DesktopPath%\Pilotes\Drivers_%USERNAME%_%horodata%"
set "COMPRESSION="
set "WIFI_Save="

mkdir "%BackupFolder%" >nul 2>&1
cls
echo.
echo.
::  Proposition de compresser si PowerShell existe
if "%powershell%"=="1" (
    echo.
    echo.
    choice /c %OYN% /n /t 10 /d O /m "%NBSP%- Voulez-vous, une fois extrait, compresser par 3 le dossier des pilotes. Peut àtre träs long  [o/n] ? "
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! LEQ 2 set "COMPRESSION=1"
)
echo.
echo. 
::  Proposition d'intÇgrer les clef Wi-Fi si Windows Franáais
if "%WIN_LANG%"=="FR" (
    choice /c %OYN% /n /t 10 /d O /m "%NBSP%- Voulez-vous y ajouter les clef Wi-Fi  [o/n] ?"
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! LEQ 2 set "WIFI_Save=1"
)
cls
echo.
echo.
choice /c %OYN% /n /t 20 /d O /m "%NBSP%- Voulez-vous lancer l'extraction des Pilotes ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
echo.
if %CHOIX% GEQ 3 (
    echo.    [INFO] Annulation de l'extraction des pilotes.
    endlocal
    timeout /t 4 >nul
    goto OUTILS3
)
cls
echo.
echo.
echo.  Lancement de l'extraction de TOUS les pilotes en cours....
echo.
echo.       Sauvegarde des pilotes vers :
echo.  %BackupFolder%
echo.                                                          Veuillez patienter....

::  Mini tempo pour laisser du temps Ö la crÇation du dossier
timeout /t 1 >nul

dism /online /export-driver /destination:"%BackupFolder%"

echo.
echo.  CrÇation de la liste des pilotes...
pnputil /enum-drivers > "%BackupFolder%\- Liste_des_Pilotes.txt"
echo.
echo.       Sauvegarde des Drivers terminÇe dans :
echo.  %BackupFolder%
echo.

if "%WIFI_Save%"=="1" (
    set "WIFI_FILE=%BackupFolder%\Cles_WiFi_%USERNAME%_%data%.txt"
    call :WIFI_SA2
)

::  Compression du dossier des pilotes si acceptÇ auparavant
if "%COMPRESSION%"=="1" (  
    echo. Compression ZIP en cours...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Compress-Archive -LiteralPath \"%BackupFolder%\" -DestinationPath \"%BackupFolder%.zip\" -Force"
    if exist "%BackupFolder%.zip" rd /s /q "%BackupFolder%"
    echo.
    echo.       Dossier pilotes compressÇs dans :
    echo.  %BackupFolder%.zip
)    
echo.
echo.                               Appuyez sur une touche pour revenir au menu...
endlocal
call :MAJ_DATE DRIVERS
timeout /t 60 >nul
goto OUTILS3


:RESTOR
::   CrÇation d'un point de restauration
set "P_Resto=VFS - Maintenance"
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d O /m "%NBSP%- Voulez-vous crÇer un point de restauration systäme ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
echo.
if %CHOIX% GEQ 3 (
    echo.    [INFO] Point de restauration non crÇÇ.
    timeout /t 4 >nul
    goto :EOF
)
goto RESTOR_1


:RESTOR_1
if not defined P_Resto set "P_Resto=%~1"
echo.
echo.    CrÇation d'un point de restauration systäme...

::  CrÇe un point de Restauration Systäme
::  powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description '%P_Resto%' -RestorePointType MODIFY_SETTINGS"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop'; " ^
    "$WarningPreference = 'Stop'; " ^
    "try { " ^
    "    Checkpoint-Computer -Description '%P_Resto%' -RestorePointType 'MODIFY_SETTINGS'; " ^
    "    exit 0 " ^
    "} catch { " ^
    "    if ($_.Exception.Message -match '1440|frÇquence|Frequency') { exit 2 } else { exit 1 } " ^
    "}"

set "ERR_Restor=%ERRORLEVEL%"
echo.
set "P_Resto="
if "%ERR_Restor%"=="0" (
    echo.    [INFO]   Point de restauration crÇÇ avec succäs.
    call :MAJ_DATE CHECK_POINT
) else if "%ERR_Restor%"=="2" (
    echo.    [INFO]   Un point de restauration a dÇjÖ ÇtÇ crÇÇ au cours des derniäres 24 heures.
) else (
    echo.    [êCHEC]   Impossible de crÇer le point de restauration - VÇrifiez si la protection systäme est activÇe.
    echo.
    echo.
    choice /c %OYN% /n /t 10 /d O /m "%NBSP%- Voulez-vous tenter d'activer la protection systäme ?  [o/n] "
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! LEQ 2 (
        call :RESTOR_B
        goto RESTOR_1
    )
    if !CHOIX! GEQ 3 (
        echo.
        echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
        echo.  ≥  DANGER - Votre PC n'est pas protÇgÇ par la Restauration Systäme  ≥
        echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    )
)
timeout /t 4 >nul
goto :EOF


::  :::::::::::::::::::::::::::::::::
::  FIN ROUTINES DE 2.OUTILS SYSTEMES
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE 3.OPTIMISATIONS
::  :::::::::::::::::::::::::::::::::

:SAVO_INJ
setlocal
::  Routine d'injection de la clef registre nÇcessaire
set "SAVOIR_TMP=1"

::  DÇsactive, si actif
if "%SAVOIR_LVL%"=="1" set "SAVOIR_TMP=0"

echo.
echo.
if "%SAVOIR_TMP%"=="1" echo.    L'icìne disparaåtra au rafraichissement du bureau.
if "%SAVOIR_TMP%"=="0" echo.    L'icìne rÇapparaåtra au rafraichissement du bureau.

::  Injection dans le registre  
reg add "%WL_Savoir%" /v %TYPE_Savoir% /t REG_DWORD /d "%SAVOIR_TMP%" /f

endlocal
call :SAVO_ETA
::  Tempo pour laisser le registre se mettre Ö jour
timeout /t 2 >nul
goto :EOF


:FILIG
setlocal
set "ERROR="
if "%TESTSIGN_TMP%"=="OFF" bcdedit -set TESTSIGNING OFF >nul 2>&1
if "%TESTSIGN_TMP%"=="ON" bcdedit /deletevalue TESTSIGNING >nul 2>&1
set "ERROR=%ERRORLEVEL%"

if "%ERROR%"=="1" (
    echo.
    echo. ERREUR : Secure Boot actif ou droits insuffisants.
    echo. L'opÇration a ÇchouÇ.
    echo.
    echo.
    echo. Veuillez dÇsactiver le dÇmarrage sÇcurisÇ --Secure Boot-- dans le BIOS. 
    echo.
    echo. Retenter la modification du Filigrane.
    echo.
    echo. Pensez Ö rÇactiver le dÇmarrage sÇcurisÇ une fois fini.
    echo.
    echo.
    echo.
    echo. Appuyez sur une touche pour continuer ...
    timeout /t 30 >nul
    goto :EOF
)
echo.
echo.
if "%TESTSIGN_TMP%"=="OFF" echo.    Le filigrane disparaitra au redÇmarrage du PC.
if "%TESTSIGN_TMP%"=="ON"  echo.    Le filigrane apparaitra au redÇmarrage du PC.
endlocal
call :FILI_ETA
timeout /t 2 >nul
goto :EOF


:TELE_RAZ
::   Activation de la TÇlÇmÇtrie
cls
echo.
echo.
::  Injection dans le registre  
reg add "%WL_Telemetrie%" /v %TYPE_Telemetrie% /t REG_DWORD /d "3" /f >nul 2>&1
echo.

call :TELE_ETA
echo.    La tÇlÇmÇtrie a ÇtÇ remise au niveau %Telemetrie_TXT%    %Telemetrie_TMP%/3  
timeout /t 1 >nul

::  Liste les services de TÇlÇmÇtrie Ö activer
set "Elements_a_activer=%Telemetrie_Services%"
set "Elements_a_activer_TXT=%Telemetrie_Services_TXT%"
set "Telemetrie_Services_Etat=0"
call :COM_0A 2

set "Telemetrie_Services_Etat="
set "Elements_ID="
call :TELE_ETA
::  Tempo pour laisser le registre se mettre Ö jour  
timeout /t 1 >nul
goto RETABLI2


:TELE_INJ
::   DÇsactivation de toutes les TÇlÇmÇtries

::  TÇlÇmÇtrie Windows
if not "%Telemetrie_Windows_LVL%"=="1" (
    rem   Injection dans le registre  
    reg add "%WL_Telemetrie%" /v %TYPE_Telemetrie% /t REG_DWORD /d "%Telemetrie_MINI%" /f >nul 2>&1
    echo.

    call :TELE_ETA
    echo.    La tÇlÇmÇtrie a ÇtÇ rÇglÇe au niveau %Telemetrie_TXT%    %Telemetrie_TMP%/3  
)
::  TÇlÇmÇtrie des Navigateurs
if not "%Telemetrie_Navigateurs_LVL%"=="1" call :NAVI_1


::  DÇsactivation des Services de TÇlÇmÇtrie Windows 
::   Liste les services de TÇlÇmÇtrie Ö dÇsactiver
if not "%Telemetrie_Services_LVL%"=="1" (
    set "Telemetrie_Services_Etat=1"
    call :COM_1 2
    set "Telemetrie_Services_Etat="
    set "Elements_ID="
    rem   Tempo pour laisser le registre se mettre Ö jour  
    timeout /t 1 >nul
)
call :NAVI_ETA
goto :EOF


:NAVI_1
::  TÇlÇmÇtrie des Navigateurs
if not "%Telemetrie_Navigateurs_LVL%"=="1" (
    set "REG_File=Navigateurs_Telemetrie_fix.reg"
    (
    echo Windows Registry Editor Version 5.00
    echo.
    ) > "%TEMP%\!REG_File!"

    REM   TÇlÇmÇtrie de Firefox
    if not "%Telemetrie_Firefox_LVL%"=="1" (
        (
        echo [%WL_Telemetrie_Firefox%]
        echo "DisableTelemetry"=dword:00000001
        echo "DisableFirefoxStudies"=dword:00000001
        echo "DisableDefaultBrowserAgent"=dword:00000001
        echo "DisableFeedbackCommands"=dword:00000001
        echo.
        ) >> "%TEMP%\!REG_File!"
    )

    REM   TÇlÇmÇtrie de Chrome
    if not "%Telemetrie_Chrome_LVL%"=="1" (
        (
        echo [%WL_Telemetrie_Chrome%]
        echo "MetricsReportingEnabled"=dword:00000000
        echo "UrlKeyedAnonymizedDataCollectionEnabled"=dword:00000000
        echo "UserFeedbackAllowed"=dword:00000000
        ) >> "%TEMP%\!REG_File!"
    )

    reg import "%TEMP%\!REG_File!" >nul 2>&1
    del /f /q "%TEMP%\!REG_File!" >nul 2>&1
    set "REG_File="
    echo.
    echo.     La TÇlÇmÇtrie des navigateurs est dÇsactivÇe.
    timeout /t 2 >nul
)
goto :EOF


:HIBERN_0
echo.
echo.
echo.    DÇsactivation de la veille prolongÇe.....
echo.
powercfg -h off
timeout /t 2 >nul
call :HIBE_ETA
goto :EOF


:HIBERN_1
echo.
echo.
echo.    Activation de la veille prolongÇe.....
echo.
echo.                              Veuillez patienter......
echo.
powercfg -h on
timeout /t 1 >nul
powercfg -h /size 50
powercfg -h /type full
timeout /t 2 >nul
call :HIBE_ETA
goto RETABLI2


:HEUR_INJ
::  DÇfinition des variables
set "HEURE_TMP=1"

::  DÇsactive, si actif
if "%HEURE_LVL%"=="1" set "HEURE_TMP=0"

echo.
echo.
if "%HEURE_TMP%"=="1" echo.    Activation de l'heure rÇelle...
if "%HEURE_TMP%"=="0" echo.    DÇsactivation de l'heure rÇelle...
echo.                                          Veuillez redÇmarrer le PC et rÇgler l'heure

::  Injection dans le registre  
reg add "%WL_Heure%" /v %TYPE_Heure% /t REG_DWORD /d "%HEURE_TMP%" /f

call :HEUR_ETA
::  Tempo pour laisser le registre se mettre Ö jour  
timeout /t 2 >nul
goto :EOF


:TRIM_D
echo.
echo.
choice /c %OYN% /n /t 5 /d N /m "%NBSP%- “tes-vous certain de vouloir dÇsactiver le TRIM ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 goto :EOF
:TRIM
echo.
echo.
echo.         %TRIM_TXT%ctivation du TRIM
fsutil behavior set DisableDeleteNotify %TRIM_TMP% >nul 2>&1
echo.
if "%TRIM_TMP%"=="1" (
    echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo.  ≥  DANGER  -  TRIM dÇsactivÇ  ≥
    echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
)
call :TRIM_ETA
timeout /t 3 >nul
goto :EOF


:RESTOR_B
set "RESTOR_LVL=0"
set "CALC_PCT=0"
echo.
::  Active la protection systäme sur le lecteur C: Ö faire avant de rÇgler la taille
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1
if "%WIN_LANG%"=="FR" call :REST_ETA
goto RESTOR_C


:RESTOR_C
if not "%boot%"=="1" (
    echo.
    echo.    Veuillez patienter ...
)
::  DÇfinition de la valeur de l'espace disponible pour la restauration Systäme [VSS]

::  On dÇfinie la valeur systäme depuis notre valeur dÇsirÇe, exemple 25% ou 15GB
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=%Restauration_Valeur%GB >nul 2>&1

::  On calcul le pourcentage par rapport Ö la taille du disque C:
for /f %%A in ('powershell -NoProfile -Command "[math]::Max(1, [math]::Round((%Restauration_Valeur%GB / (Get-Volume C).Size) * 100))"') do set "CALC_PCT=%%A"

::  25 Go = 25 * 1024 = 25600 Mo
if "%compatible%"=="11" (
    REM  Conversion des Go en Mo
    set /a CALC_MB=%Restauration_Valeur%*1024
    REM  RÇglage de l'espace via Point-in-time restore [PITR] responsable de la rÇinitialisation depuis le nouveau panneau Windows 11
    reg add "%WL_Restauration_Win11%" /v MaxGlobalSize_UX /t REG_DWORD /d !CALC_MB! /f >nul 2>&1
)

if "%boot%"=="1" goto :EOF

::  VÇrification
if not "%WIN_LANG%"=="FR" goto :EOF
call :REST_ETA
if "%RESTOR_LVL%"=="1" (
    call :MAJ_DATE CHECK_POINT_ACTIF
    echo.
    echo.    [OK] La protection est active et l'espace est rÇglÇ Ö %RESTOR_TMP_2% Go [soit %CALC_PCT%%% du disque].
)
if "%RESTOR_LVL%"=="0" echo.    [êCHEC] Impossible de configurer l'espace de restauration.

timeout /t 3 >nul
goto :EOF


:RESTOR_D
::  DÇsactivation de la restauration Systäme
echo.
echo.
choice /c %OYN% /n /t 5 /d N /m "%NBSP%- “tes-vous certain de vouloir dÇsactiver la restauration systäme ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 goto RETABLI2
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-ComputerRestore -Drive 'C:\'"
echo.
echo.      ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.      ≥  DANGER  -  Protection Systäme dÇsactivÇe  ≥
echo.      ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
if "%WIN_LANG%"=="FR"  call :REST_ETA
timeout /t 3 >nul
goto RETABLI2


:RESTOR_F
:: Injection de la valeur par dÇfaut de la Restauration Systäme

::  On vÇrifie l'unique prÇsence de chiffre
for /f "delims=0123456789" %%V in ("%Restauration_Valeur_TMP%") do goto RESTOR_E

::  La valeur doit àtre comprise entre mini et maxi en Go, sinon, on corrige
if %Restauration_Valeur_TMP% LSS %Restauration_mini% set "Restauration_Valeur_TMP=%Restauration_mini%"
if %Restauration_Valeur_TMP% GTR %Restauration_maxi% set "Restauration_Valeur_TMP=%Restauration_maxi%"

::  Si la valeur est la màme, on ne change rien
if "%Restauration_Valeur_TMP%"=="%Restauration_Valeur%" (
    echo. Valeur non modifiÇe, nous conservons %Restauration_Valeur% Go.
    timeout /t 3 >nul
    goto PARAM
)

::  Si la nouvelle valeur est plu basse que l'ancienne
if %Restauration_Valeur_TMP% LSS %Restauration_Valeur% (
    echo. Vous dÇsirez baisser l'espace allouÇ Ö la Restauration Systäme de %Restauration_Valeur% Go vers %Restauration_Valeur_TMP% Go.
    if %Restauration_Valeur_TMP% GEQ %RESTOR_USED% echo. Vous ne perdrez pas de points de restauration, mais votre possibilitÇ de retour en arriäre sera rÇduite.
    if %Restauration_Valeur_TMP% LSS %RESTOR_USED% echo. Vous perdrez des points de restauration [espace occupÇ : %RESTOR_USED% Go ].
    echo.
    choice /c %OYN% /n /t 15 /d N /m "%NBSP%- Voulez-vous vraiment faire cela ? [o/n] "
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! GEQ 3 goto RESTOR_E
)

::  On applique la nouvelle valeur
reg add "%WL_VFS%" /v Restauration_Valeur /t REG_SZ /d "%Restauration_Valeur_TMP%" /f >nul 2>&1
echo.
echo.  Espace allouÇ modifiÇ de %Restauration_Valeur% Go vers %Restauration_Valeur_TMP% Go.
call :LIRE_PAR "Restauration_Valeur"
timeout /t 3 >nul
goto PARAM4


:FLECH
echo.
echo.
if "%Fleche_Etat%"=="0" (
    reg add "%WL_Fleche%" /v 29 /t REG_SZ /d "" /f >nul 2>&1
    echo.
    echo. La fläche des raccourcis disparaitra au prochain redÇmarrage du PC.
)

if "%Fleche_Etat%"=="1" (
    reg delete "%WL_Fleche%" /v 29 /f
    echo.
    echo. La fläche des raccourcis rÇapparaitra au prochain redÇmarrage du PC.
)
call :FLEC_ETA
timeout /t 3 >nul
goto :EOF


:COM_1
if not "%1"=="" set "Elements_ID=%1"
::   DÇsactivation des ÇlÇments, si sÇlectionnÇs
call :LOADING
call :COM_ETA %Elements_ID%

::  CrÇation de la liste
if "%Telemetrie_Services_Etat%"=="1" (
    set "Telemetrie_Services_NUM_TMP="
    set "Telemetrie_Services_TMP="
    REM   Mise Ö jour de la liste pour ne garder que ceux en LVL=0
    for %%A in (%Telemetrie_Services_NUM%) do (
        if "!%%A_LVL!"=="0" (
            set "Telemetrie_Services_NUM_TMP=!Telemetrie_Services_NUM_TMP! %%A"
            set "Telemetrie_Services_TMP=!Telemetrie_Services_TMP! . !element_%%A!"
        )
    )
    set "Numeros_a_desactiver=!Telemetrie_Services_NUM_TMP!"
    set "Liste_Services_Actif_TXT=!Telemetrie_Services_TMP!"
)

if not "%Telemetrie_Services_Etat%"=="1" set "Numeros_a_desactiver=!Liste_%Elements%_Actif_NUM!"

cls
echo.
echo. Voici les %Elements_Texte_1% qui vont àtre dÇsactivÇs :
echo.  !Liste_%Elements%_Actif_TXT!
echo.
echo.
choice /c %OYN% /n /t 20 /d N /m "%NBSP%- Taper V pour valider ou 0 pour annuler : "
set "CHOIX=%ERRORLEVEL%"
if not "%CHOIX%"=="22" goto :EOF
cls

::  CrÇation d'un point de restauration avant de dÇsactiver les ÇlÇments
if not "%Mode_Test%"=="1" call :RESTOR_1 "VFS - Desactivation de %Elements_Texte_3%"

::  DÇsactivation sous conditions
set "Elements_Disabled_TMP="
for %%A in (%Numeros_a_desactiver%) do (
    if "!%%A_LVL!"=="0" (
        echo.
        echo.  ⁄ƒƒƒƒƒ
        echo. ƒ¥ DÇsactivation de !element_%%A_TXT!
        echo.  ¿ƒƒƒƒƒ
        if "%Elements_ID%"=="1" schtasks /change /tn "!element_%%A!" /disable >nul 2>&1
        if "%Elements_ID%"=="2" (
            if "!%%A_Disabled!"=="0" (
                sc config "!element_%%A!" start= disabled >nul 2>&1
                timeout /t 1 >nul
            )
            if "!%%A_Arret!"=="0" net stop !element_%%A! >nul 2>&1
        )

        REM  Notons ceux qui ont ÇtÇ dÇsactivÇ
        set "Elements_Disabled_TMP=!Elements_Disabled_TMP!!element_%%A_TXT! "
        timeout /t 1 >nul
    )
)
::  build 107 rÇactivation forcÇe de ShellHWDetection car Service utile pour les Disques externes
sc query "ShellHWDetection" | findstr "RUNNING" >nul 2>&1
if "%ERRORLEVEL%"=="0" sc config "ShellHWDetection" start= auto >nul 2>&1

::    set "Liste_Elements_Actif_NUM="
echo.  OpÇration terminÇe ...  VÇrifications en cours ...
call :COM_NFO
call :COM_ETA %Elements_ID%
cls
echo.
if not defined Elements_Disabled_TMP (
    echo. %Elements_Texte_0% n'a ÇtÇ dÇsactivÇ.
    echo.
)
if defined Elements_Disabled_TMP (
    echo. Voici la liste des %Elements_Texte_1% que vous venez de tenter de dÇsactiver :
    echo.  %Elements_Disabled_TMP%.
)

if not defined Liste_%Elements%_Actif_TXT (
    echo.
    echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo.  ≥  Tout a ÇtÇ dÇsactivÇ  ≥
    echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
)

if defined Liste_%Elements%_Actif_TXT (
    if defined Liste_%Elements%_Inactif_TXT (
        echo.
        echo. Voici ce qui est dÇsactivÇ :
        echo.  !Liste_%Elements%_Inactif_TXT!
    )
    echo.
    echo. Voici ce qui est encore actif :
    echo.  !Liste_%Elements%_Actif_TXT!
)

echo.

::  ∑ ceux dÇjÖ notÇ dans le registre, on ajoute les derniers qui ont ÇtÇ dÇsactivÇs
::  Si prÇcÇdente liste vide, on la rempli
if not defined Elements_Disabled set "Elements_Disabled=%Elements_Disabled_TMP%"

::  Si prÇcÇdente liste non vide, on rajoute
if defined Elements_Disabled (
    REM  On ajouter en Çvitant les doublons
    for %%I in (%Elements_Disabled_TMP%) do (
        echo !Elements_Disabled! | findstr /i /w "%%I" >nul 2>&1
        if errorlevel 1 set "Elements_Disabled=!Elements_Disabled! %%I"
    )
)

call :2ESPACE Elements_Disabled

::  On injecte la nouvelle version de la liste, de ceux dÇsactivÇ, dans le registre
reg add "%WL_VFS%" /v "%Elements%_Disabled" /t REG_SZ /d "%Elements_Disabled%" /f
echo.
if "%Tout_Optimiser%"=="1" (
    timeout /t 3 >nul
    goto :EOF
)
::  On met Ö jour les 2 COM_ETA pour que :OPTIM ait les bonnes infos
call :COM_ETA 2
echo.                               Appuyez sur une touche pour revenir au menu...
call :COM_ETA 1
timeout /t 60 >nul
goto :EOF


:COM_0
if not "%1"=="" set "Elements_ID=%1"
::   Activation des ÇlÇments
call :LOADING
call :COM_ETA %Elements_ID%
cls
echo.
if not defined Elements_Disabled (
    echo. %Elements_Texte_0% ne semble avoir ÇtÇ dÇsactivÇ depuis ce script.
    echo. Ou alors l'info dans le registre a ÇtÇ effacÇe.
    echo.
    if defined Liste_%Elements%_Inactif_TXT (
        echo.
        echo. Cependant, je constate que des %Elements_Texte_1% sont dÇsactivÇs :
        echo. !Liste_%Elements%_Inactif_TXT!
        echo.
        echo.
        choice /c %OYN% /n /t 20 /d N /m "%NBSP%- Voulez-vous les rÇactiver [non recommandÇ]  [o/n] : "
        set "CHOIX=!ERRORLEVEL!"
        if !CHOIX! LEQ 2 call :COM_0B
        goto RETABLI2
    )
    if not defined Liste_%Elements%_Inactif_TXT (
        echo.                               Appuyez sur une touche pour revenir au menu...
        timeout /t 60 >nul
    )
    goto RETABLI2
)

if defined Elements_Disabled call :COM_0B
if not defined Elements_Disabled call :COM_0A
goto RETABLI2


:COM_0A
if not "%1"=="" set "Elements_ID=%1"
call :COM_ETA %Elements_ID%
:COM_0B

if "%Telemetrie_Services_Etat%"=="0" (
    set "Elements_a_activer=%Telemetrie_Services_NUM%"
    set "Elements_a_activer_TXT=%Telemetrie_Services_TXT%"
) else if "%Elements_Disabled_Sans_Sign_Moins%"=="" (
    set "Elements_a_activer=!Liste_%Elements%_Inactif!"
    set "Elements_a_activer_TXT=!Liste_%Elements%_Inactif_TXT!"
) else (
    set "Elements_a_activer=%Elements_Disabled_Sans_Sign_Moins%"
    set "Elements_a_activer_TXT=%Elements_Disabled_Sans_Sign_Moins%"
)

if not defined Elements_a_activer_TXT goto :EOF
cls
echo.
echo. Voici les %Elements_Texte_1% qui vont àtre rÇactivÇs :
echo. %Elements_a_activer_TXT%
echo. 
echo.
choice /c %OYN% /n /t 20 /d N /m "%NBSP%- Taper V pour valider ou 0 pour annuler : "
set "CHOIX=%ERRORLEVEL%"
if not "%CHOIX%"=="22" goto :EOF
cls

set "Numeros_a_activer="
set "Elements_Disabled_TMP="

::  Conversion Nom en NumÇro
call :NAM2NUM "%Elements_a_activer_TXT%" Numeros_a_activer

for %%A in (%Numeros_a_activer%) do (
    if "!%%A_Disabled!"=="1" (
        echo.
        echo.  ⁄ƒƒƒƒƒ
        echo. ƒ¥ Activation de !element_%%A_TXT! ...
        echo.  ¿ƒƒƒƒƒ
        if "%Elements_ID%"=="1" (
            schtasks /change /tn "!element_%%A!" /enable >nul 2>&1
            timeout /t 1 >nul
        )
        if "%Elements_ID%"=="2" (
            if "!%%A_Disabled!"=="1" (
                sc config "!element_%%A!" start= auto >nul 2>&1
                REM  Timeout pour laisser du temps Ö la rÇactivation
                timeout /t 1 >nul
            )
            if "!%%A_Arret!"=="1" net start !element_%%A! >nul 2>&1
        )
        REM  Notons ceux qui ont ÇtÇ activÇ
        set "Elements_Disabled_TMP=!Elements_Disabled_TMP!!element_%%A_TXT! "
    )
)
::  build 107 rÇactivation forcÇe de ShellHWDetection car Service utile pour les Disques externes
sc query "ShellHWDetection" | findstr "RUNNING" >nul 2>&1
if "%ERRORLEVEL%"=="0" sc config "ShellHWDetection" start= auto >nul 2>&1

call :2ESPACE Elements_Disabled_TMP
::  On met Ö jour la liste dans le registre
::  On rÇcupäre les infos du registre
call :COM_NFO

::  On enläve tout ce qu'on vient d'activer
for %%A in (%Elements_Disabled_TMP%) do (set "Elements_Disabled=!Elements_Disabled:%%A=!")

::  On rÇinjecte, en Çcrasant, la liste
reg add "%WL_VFS%" /v "%Elements%_Disabled" /t REG_SZ /d "%Elements_Disabled%" /f

::  On vÇrifie le dernier Çtat des ÇlÇments
call :COM_ETA %Elements_ID%

::  On affiche le rÇsultat
echo.
echo.
echo. Voici ceux que vous venez de tenter d'activer :
echo.  %Elements_a_activer_TXT%

if defined Liste_%Elements%_Actif_TXT (
    echo.
    echo. Voici ceux qui sont rÇellement activÇs :
    echo.  !Liste_%Elements%_Actif_TXT!
)

if defined Liste_%Elements%_Inactif_TXT (
    echo.
    echo. Voici ceux qui sont toujours dÇsactivÇs :
    echo.  !Liste_%Elements%_Inactif_TXT!
)

echo.
echo.
set "Telemetrie_%Elements%_Etat="
set "Elements_a_activer="
set "Numeros_a_activer="
set "Elements_Nombre="
echo. Appuyez sur une touche pour continuer ...
call :COM_ETA %Elements_ID%
timeout /t 60 >nul
goto :EOF


:DEBLOAT
::  Lancement d'un outil externe
echo.
echo.
echo.    Lancement de l'outil d'optimisation Win11 Anti-Bloat...
echo.    Cet outils s'exÇcutera dans une autre fenàtre...

::  CrÇation d'un script intermÇdiaire pour le lancement de  Win11 Anti-Bloat
(
  echo @echo off
  echo title Anti-BLoat - VFS v%SOFT_version% by Dagobert_78
  echo mode con cols=60 lines=10
) > "%APPDATA%\VFS\VFS_DEBLOAT.bat"
echo powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))" >> "%APPDATA%\VFS\VFS_DEBLOAT.bat"
(
  echo reg add "%WL_VFS%" /v Last_Run_DEBLOAT /t REG_SZ /d "%data2%" /f ^>nul
  echo exit
) >> "%APPDATA%\VFS\VFS_DEBLOAT.bat"

::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\VFS_DEBLOAT.bat"
timeout /t 2 >nul
goto OPTIM4

::  :::::::::::::::::::::::::::::::::
::  FIN ROUTINES DE 3.OPTIMISATIONS
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE 4.AUTOMATISATIONS
::  :::::::::::::::::::::::::::::::::

:AUTO_SET
set "USER="
set "PASS="
call :AUTO_COM
cls
echo.
::  si pas d'utilisateur, retour au menu
if "%USER_COUNT%"=="0" (
    echo.   Aucun utilisateur dÇtectÇ.
    echo.
    echo.
    echo.                               Appuyez sur une touche pour revenir au menu...
    timeout /t 60 >nul
    goto AUTOLOG
)

if "%USER_COUNT%"=="1"     echo. 1 seul utilisateur dÇtectÇ :
if not "%USER_COUNT%"=="1" echo. %USER_COUNT% utilisateurs dÇtectÇs :
echo.
for /L %%i in (1,1,%USER_COUNT%) do echo. %%i. !USR_%%i!

echo. 0. Retour
echo.

set "UID="
if "%PowerShell%"=="1" call :TIMEOUT1 UID " - NumÇro de l'utilisateur" %Tempo_Inactif% M
if "%PowerShell%"=="0" set /p "UID= - NumÇro de l'utilisateur : "
set "USER=!USR_%UID%!"
if "%UID%"=="0"    goto AUTOLOG
if /i "%UID%"=="M" call :FIN_INAC && goto AUTO_SET
if not defined USER goto AUTO_SET

::  Isolation de la saisie pour prÇserver les '!' et '^'
setlocal DisableDelayedExpansion
echo.
echo.
set "PASS="
if "%PowerShell%"=="1" call :TIMEOUT1 PASS " - Mot de passe pour %USER%" %Tempo_Inactif% M
if "%PowerShell%"=="0" set /p "PASS= - Mot de passe pour %USER% : "
if /i "%PASS%"=="M" (
    call :FIN_INAC
    rem   Fin de l'isolation de la saisie pour prÇserver les '!' et '^'
    endlocal
    goto AUTO_SET
)

goto AUTO_INJ


:AUTO_VAR
set "WL=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
set "TYPE_ETAT=AutoAdminLogon"
set "TYPE_QUI=DefaultUserName"
set "TYPE_PASS=DefaultPassword"
goto :EOF


:AUTO_QUI
::  Recherche de l'utilisateur
set "AUTOLOG_QUI="
call :AUTO_VAR

::  On regarde la valeur de DefaultUserName
for /f "tokens=2,*" %%A in ('reg query "%WL%" /v %TYPE_QUI% 2^>nul ^| find "REG_"') do set "AUTOLOG_QUI=%%B"
goto :EOF


:AUTO_PAS
::  Recherche du mot de passe
set "AUTOLOG_PASS="
call :AUTO_VAR

::  On regarde la valeur de DefaultPassword
for /f "tokens=2,*" %%A in ('reg query "%WL%" /v %TYPE_PASS% 2^>nul ^| find "REG_"') do set "AUTOLOG_PASS=%%B"
goto :EOF


:AUTO_INJ
echo.
echo.

::  êchappement des guillemets si le mot de passe n'est pas vide
if defined PASS set "PASS=%PASS:"=\"%"

echo.
call :AUTO_VAR

::  êcriture dans le Registre sous DisableDelayedExpansion
reg add "%WL%" /v DefaultUserName /t REG_SZ /d "%USER%" /f
reg add "%WL%" /v DefaultPassword /t REG_SZ /d "%PASS%" /f
reg add "%WL%" /v AutoAdminLogon /t REG_SZ /d 1 /f
::  Sera utile que dans le cas d'un PC sur Domaine
::  reg add "%WL%" /v DefaultDomainName /t REG_SZ /d "%COMPUTERNAME%" /f

::  Fin de l'isolation de la saisie pour prÇserver les '!' et '^'
endlocal

::  Petite tempo pour laisser le registre se mettre Ö jour  
call :MAJ_DATE AUTOLOGIN
timeout /t 1 >nul
goto AUTOLOG


:AUTO_COM
::  Comptage du nombre de dossiers Utilisateurs, hors Public.
cls
set "USER_COUNT=0"

for /d %%U in (C:\Users\*) do (
    if /i not "%%~nxU"=="Public" (
        set /a USER_COUNT+=1
        set "USR_!USER_COUNT!=%%~nxU"
    )
)
goto :EOF


:AUTO_AFF
::  Routine affichant les infos de l'auto Login
call :AUTO_ETA
setlocal DisableDelayedExpansion
call :AUTO_QUI
call :AUTO_PAS

::  Çchappement des caractäres qui font cracher le script
::  Ne pas mettre dans une boucle, sinon, bah, áa ne marche po
if defined AUTOLOG_QUI set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI%"
if defined AUTOLOG_QUI_TMP set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI_TMP:^=^^%"
if defined AUTOLOG_QUI_TMP set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI_TMP:&=^&%"
if defined AUTOLOG_QUI_TMP set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI_TMP:<=^<%"
if defined AUTOLOG_QUI_TMP set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI_TMP:>=^>%"
if defined AUTOLOG_QUI_TMP set "AUTOLOG_QUI_TMP=%AUTOLOG_QUI_TMP:|=^|%"

if defined AUTOLOG_PASS set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS%"
if defined AUTOLOG_PASS_TMP set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS_TMP:^=^^%"
if defined AUTOLOG_PASS_TMP set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS_TMP:&=^&%"
if defined AUTOLOG_PASS_TMP set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS_TMP:<=^<%"
if defined AUTOLOG_PASS_TMP set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS_TMP:>=^>%"
if defined AUTOLOG_PASS_TMP set "AUTOLOG_PASS_TMP=%AUTOLOG_PASS_TMP:|=^|%"

cls
echo.
echo.
echo.      ===== AUTO LOGIN WINDOWS =====
echo.      =                            =
if "%AUTOLOG_LVL%"=="1" echo.      =      êtat : ACTIF          =
if "%AUTOLOG_LVL%"=="0" echo.      =      êtat : INACTIF        =

if defined AUTOLOG_QUI     echo.      =      Pour : %AUTOLOG_QUI_TMP%
if not defined AUTOLOG_QUI echo.      =      Pour : [vide]         =

if defined AUTOLOG_PASS     echo.      =      MdP  : %AUTOLOG_PASS_TMP%
if not defined AUTOLOG_PASS echo.      =      MdP  : [vide]         =

echo.      =                            =
echo.      ==============================
echo.
timeout /t 1 >nul
goto AUTOLOG


:AUTO_DEL
if not "%AUTOLOG_LVL%"=="1" goto AUTOLOG
::  Suppression de l'AutoLogin
reg delete "%WL%" /v DefaultUserName /f >nul 2>&1
reg delete "%WL%" /v DefaultPassword /f >nul 2>&1
reg add "%WL%" /v AutoAdminLogon /t REG_SZ /d 0 /f >nul 2>&1
echo.
echo.
echo.
call :AUTO_ETA
if "%AUTOLOG_LVL%"=="0" (
    echo.   AutoLogin supprimÇ.
    call :MAJ_DATE AUTOLOGIN
    timeout /t 2 >nul
) else (
    echo.   ###   ERREUR   ###        AutoLogin non supprimÇ.
    timeout /t 4 >nul
)
goto AUTOLOG


:AUTO_DES
::  Activation ou DÇsactivation de l'AutoLogin
if "%AUTOLOG_LVL%"=="1" (
    set "AUTO_ACTIV=0"
) else (
    set "AUTO_ACTIV=1"
)

reg add "%WL%" /v AutoAdminLogon /t REG_SZ /d %AUTO_ACTIV% /f >nul 2>&1
echo.
echo.
echo.
call :AUTO_ETA
if "%AUTOLOG_LVL%"=="0" echo.   AutoLogin dÇsactivÇ.

if "%AUTOLOG_LVL%"=="1" (
    echo.   AutoLogin activÇ. 
    echo.
    if not defined AUTOLOG_QUI  echo.  Veuillez renseigner l'utilisateur   && timeout /t 1 >nul
    if not defined AUTOLOG_PASS echo.  Veuillez renseigner le mot de passe && timeout /t 1 >nul
)
call :MAJ_DATE AUTOLOGIN
timeout /t 2 >nul
goto AUTOLOG


:INSTALL
if "%internet%"=="0" (
    cls
    echo.
    echo.  Absence d'Internet, le choix des logiciels y sera restreint.
    timeout /t 4 >nul
    goto INSTALL2
)
     
if "%winget%"=="0" (
    cls
    echo.
    echo.  WINGET n'est pas encore initialisÇ, le choix des logiciels y sera restreint.
    timeout /t 4 >nul
    goto INSTALL2
)

::  Liste des logiciels installables avec Winget
setlocal
set "Install_NB=0"
for %%A in (
    "VLC#VideoLAN.VLC"
    "Foxit PDF#Foxit.FoxitReader"
    "Teamviewer Client#TeamViewer.TeamViewer.Host"
    "CPU-Z#CPUID.CPU-Z"
    "Crystal Disk Info#CrystalDewWorld.CrystalDiskInfo"
    "Chrome#Google.Chrome.EXE"
    "OCCT#OCBase.OCCT.Personal"
    "MÇga Sync#Mega.MEGASync"
    "Firefox#Mozilla.Firefox -e -l fr-FR --scope machine --override '-ms /MAINTENANCE_SERVICE=false /PreventRebootRequired=true'"
    "LibreOffice#TheDocumentFoundation.LibreOffice --override '/qb CREATEDESKTOPLINK=0 UI_LANGS=fr QUICKSTART=1 REGISTER_ALL_MSO_TYPES=1 REMOVE=gm_o_Extensions'"
    "WinSetView#LesFerch.WinSetView"
    "WinRAR#RARLab.WinRAR"
) do (
    set "LINE=%%~A"
    for /f "tokens=1,* delims=#" %%B in ("!LINE!") do (
        cls
        echo.
        echo.
        choice /c %OYN% /n /t 15 /d N /m "%NBSP%- Voulez-vous installer %%B ? [o/n] "
        if !ERRORLEVEL! LEQ 2 (
            set /a Install_NB+=1
            set "Install_ID!Install_NB!=%%C"
            set "Install_Name!Install_NB!=%%B"
        )
    )
)
::  CrÇation d'un script intermÇdiaire pour le lancement des installations
(
  echo @echo off
  echo title Installe Winget - VFS v%SOFT_version% by Dagobert_78
  echo mode con cols=120 lines=13
  echo cls
  echo echo.
  echo echo.   Installation de logiciels via Winget ...
  echo echo.
) > "%APPDATA%\VFS\VFS_Install_Winget.bat"

if %Install_NB% GEQ 1 (
    for /L %%i in (1,1,%Install_NB%) do (
        REM  Remplacement de ' par "
        set "Installateur=!Install_ID%%i:'="!"
        set "NomLogiciel=!Install_Name%%i!"
        echo winget install --id !Installateur! --accept-source-agreements --accept-package-agreements >> "%APPDATA%\VFS\VFS_Install_Winget.bat"

        if "!NomLogiciel!"=="Chrome" (
            echo echo. >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo echo. Injection de l'extension uBlock Origin Lite dans Chrome... >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo set "WL=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo reg add "%%WL%%" /v 1 /t REG_SZ /d "gebbipnihhhdaeeoifljgfljjfkipbne;https://clients2.google.com/service/update2/crx" /f ^>nul >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
        )
        if "!NomLogiciel!"=="Firefox" (
            echo echo. >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo echo. Injection de l'extension uBlock Origin dans Firefox... >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo set "WL=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox\ExtensionSettings\uBlock0@raymondhill.net" >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo reg add "%%WL%%" /v "installation_mode" /t REG_SZ /d "force_installed" /f ^>nul >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
            echo reg add "%%WL%%" /v "install_url" /t REG_SZ /d "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi" /f ^>nul >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
        )
    )
)
(
  echo timeout /t 5 ^>nul
  echo exit
) >> "%APPDATA%\VFS\VFS_Install_Winget.bat"
    
::  Lancement du script intermÇdiaire dans une autre fenàtre
start "" "%APPDATA%\VFS\VFS_Install_Winget.bat"

:INSTALL2
::  Force le rÇpertoire de travail avec celui oó se trouve le script
cd /d "%~dp0"

for %%a in (
    "WinRAR=..\..\Compression\WinRAR x64.exe"
    "SuperCopier=..\..\SuperCopier\SuperCopier.exe"
    "Spyware Blaster=Spyware Blaster.exe"
    "RogueKiller=RogueKiller_x86_x64.exe"
) do (
    for /f "tokens=1,2 delims==" %%b in (%%a) do (
        if exist "%%c" (
            cls
            echo.
            echo.
            choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous installer %%b ? [o/n] "
            set "CHOIX=!ERRORLEVEL!"
            if !CHOIX! LEQ 2 "%%c"
        )
    )
)
endlocal
goto AUTOM

::  :::::::::::::::::::::::::::::::::
::  FIN ROUTINES DE 4.AUTOMATISATIONS
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::
::  DEBUT ROUTINES DE 5.CLEANER
::  :::::::::::::::::::::::::

:TEMP
::  Effacement des fichiers temporaires de Windows
cls
echo.
echo.
echo. Suppression des fichiers temporaires de Windows.....

del /s /f /q "%TEMP%\*.*"
del /s /f /q "%SystemRoot%\Temp\*.*"
del /s /f /q "%SystemRoot%\Prefetch\*.*"

::  Effacement des dossiers
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i"
for /d %%i in ("%SystemRoot%\Temp\*") do rd /s /q "%%i"
echo.
echo.        *****   Fin de l'effacement des fichiers temporaires non verrouillÇs.   *****
call :MAJ_DATE TEMPORAIRE
timeout /t 3 >nul
goto CLEANER3


:CMGR_DEL
cls
echo.
echo.
echo.  Afin d'augmenter son efficacitÇ, pensez Ö configurer Clean MGR dans 'Paramätres'.
echo.
echo. Appuyez sur une touche pour continuer ...
timeout /t 60 >nul
start "" cleanmgr /sagerun:666
call :MAJ_DATE CLEAN_MGR
timeout /t 1 >nul
goto CLEANER3


:DEL_LOG
setlocal
cls
echo.
echo.
echo. Effacement des fichiers LOG de SFC et DISM .....
echo.
call :STOP_SVC TrustedInstaller
if "!ERR_Present_TrustedInstaller!"=="1" echo.    [INFO]  Service TrustedInstaller n'est pas prÇsent.
if "!ERR_Running_TrustedInstaller!"=="1" echo.    [OK]  Service TrustedInstaller est arràtÇ.
if "!ERR_Running_TrustedInstaller!"=="0" echo.    [ATTENTION]  Impossible d'arràter le Service TrustedInstaller.
timeout /t 1 >nul
echo.
echo.
if exist "%windir%\Logs\CBS\CBS*.log" del /s /f /q "%windir%\Logs\CBS\CBS*.log"
echo.
if not exist "%windir%\Logs\CBS\CBS*.log" echo.     [OK] Fichiers LOG du CBS effacÇs.
if exist "%windir%\Logs\CBS\CBS*.log"     echo.     [ERREUR] Il reste des fichiers LOG du CBS, rÇessayez ultÇrieurement.
endlocal
call :MAJ_DATE LOG
timeout /t 3 >nul
goto CLEANER2


:STORE
::  Effacement du cache du Store.
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous effacer le Cache du Microsoft Store ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 (
    endlocal
    goto CLEANER3
)

echo.
echo.
echo. Suppression du cache du Store de Windows.....
echo.
::  WSreset
start /wait wsreset.exe
set "ERR_WSreset=%ERRORLEVEL%"
timeout /t 1 >nul
if not "%ERR_WSreset%"=="0" (
    echo.     [ERREUR] WSReset a retournÇ le code %ERR_WSreset%.
    endlocal
)
if "%ERR_WSreset%"=="0" (
    echo.     [OK] Cache du Microsoft Store rÇinitialisÇ.
    endlocal
    call :MAJ_DATE DEL_STORE
)
taskkill /f /im WinStore.App.exe >nul 2>&1
timeout /t 3 >nul
goto CLEANER3


:REP_WU
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous rÇinitialiser les services Windows Update ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3  (
    endlocal
    goto CLEANER3
)

::  Arràt des Services
for %%A in (wuauserv cryptSvc bits msiserver) do (
    call :STOP_SVC %%A
    if "!ERR_Present_%%A!"=="1" echo.    [INFO]  Service %%A n'est pas prÇsent.
    if "!ERR_Running_%%A!"=="1" echo.    [OK]  Service %%A est arràtÇ.
    if "!ERR_Running_%%A!"=="0" echo.    [ATTENTION]  Impossible d'arràter le Service %%A.
)
echo.
echo.  Nettoyage en cours ...   Veuillez patienter ...
::  Nettoyage
if exist "C:\Windows\SoftwareDistribution.old" RD /S /Q "C:\Windows\SoftwareDistribution.old"
if exist "C:\Windows\System32\catroot2.old"    RD /S /Q "C:\Windows\System32\catroot2.old"
ren "C:\Windows\SoftwareDistribution" SoftwareDistribution.old
ren "C:\Windows\System32\catroot2" catroot2.old

::  RÇactivation des Services
for %%A in (wuauserv cryptSvc bits msiserver) do call :STRT_SVC %%A

echo.
echo.         RÇinitialisation de Windows Update terminÇe.....
endlocal
call :MAJ_DATE SERVICE_UPDATE
timeout /t 3 >nul
goto CLEANER3


:SPOOLER0
::  Nettoyage logiciel de l'imprimante, Fork de la v1.2
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous nettoyer le spooler d'impression ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3  (
    endlocal
    goto CLEANER3
)

::  Extinction de tous les services liÇs Ö l'impression
cls
echo.
echo.
echo.  Extinction de tous les services liÇs Ö l'impression ......
echo.

::  Arràt du spooler et PrintNotify et mise en variable de l'erreur pour ne pas lire l'erreur prÇcÇdente 
::  ne pas arràter RPCSS car Service vital de Windows

::  Arràt des Services
for %%A in (spooler PrintNotify) do (
    call :STOP_SVC %%A
    if "!ERR_Present_%%A!"=="1" echo.    [INFO]  Service %%A n'est pas prÇsent.
    if "!ERR_Running_%%A!"=="1" echo.    [OK]  Service %%A est arràtÇ.
    if "!ERR_Running_%%A!"=="0" echo.    [ATTENTION]  Impossible d'arràter le Service %%A.
)
timeout /t 1 >nul

::  Arràt de l'explorateur
echo.
taskkill /f /im explorer.exe >nul 2>&1
echo.    [OK]  Explorateur Windows arràtÇ

timeout /t 2 >nul

::  Script pour vider la liste d'impression
echo.
echo.
echo.  Vidage du spooler d'impression ......
echo.

::  Suppression des fichiers du spooler
del /q /f /s "%systemroot%\System32\spool\PRINTERS\*.*" >nul 2>&1
set "ERR_PRINTERS=%ERRORLEVEL%"
if "%ERR_PRINTERS%"=="0"     echo.    [OK]  Spooler vidÇ avec succäs
if not "%ERR_PRINTERS%"=="0" echo.    [ATTENTION]  Certains fichiers n'ont pas pu àtre supprimÇs
timeout /t 2 >nul

::  RedÇmarrage de tous les services arràtÇs
echo.
echo.
echo.  RedÇmarrage des services coupÇs ......
echo.

::  RedÇmarrage des Services
for %%A in (spooler PrintNotify) do (
    call :STRT_SVC %%A
    if "!ERR_Present_%%A!"=="1" echo.    [INFO]  Service %%A n'est pas prÇsent.
    if "!ERR_Running_%%A!"=="1" echo.    [ATTENTION]  Impossible de redÇmarrer le Service %%A.
    if "!ERR_Running_%%A!"=="0" echo.    [OK]  Service %%A est redÇmarrÇ.
)

timeout /t 1 >nul

::  RedÇmarrage de l'explorateur en dernier
start explorer.exe
echo.    [OK]  Explorateur Windows redÇmarrÇ
timeout /t 2 >nul
echo.
echo.
echo.  Le spooler d'impression a ÇtÇ nettoyÇ avec succäs.

::  Choix du redÇmarrage
echo.
echo.
call :MAJ_DATE DEL_SPOOLER
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous redÇmarrer maintenant ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3  (
    endlocal
    goto CLEANER3
)

::  Si OUI, redÇmarrage forcÇ
echo.
echo.
echo.                          Sauvegardez TOUS vos documents
echo.
echo. Appuyez sur une touche pour redÇmarrer le PC....
pause>NUL
endlocal
set "Reboot_TXT=normal"
call :RESTARTV
goto CLEANER3


:WINSOCK
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous rÇinitialiser le catalogue Winsock ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
echo.
if %CHOIX% GEQ 3 (
    echo.
    echo.
    echo.       [i]  Aucune modification n'a ÇtÇ effectuÇe.
    endlocal
    timeout /t 3 >nul
    goto CLEANER3
)
if %CHOIX% LEQ 2 (
    echo.  [+]  RÇinitialisation du catalogue Winsock en cours...
    netsh winsock reset >nul
    echo.
    echo.  [i]  Catalogue Winsock rÇinitialisÇ.
    call :MAJ_DATE DEL_WINSOCK
    echo.
    echo.
    echo.   Pensez Ö redÇmarrer votre PC une fois toutes vos opÇrations effectuÇes.
)
endlocal
timeout /t 3 >nul
goto CLEANER3

    
:PROTOIP
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous rÇinitialiser le protocole IP ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
echo.
if %CHOIX% GEQ 3 (
    echo.
    echo.
    echo.       [i]  Aucune modification n'a ÇtÇ effectuÇe.
    timeout /t 3 >nul
    endlocal
    goto CLEANER3
)
if %CHOIX% LEQ 2 (
    echo.  [+]  RÇinitialisation du protocole IP en cours...
    netsh int ip reset >nul
    echo.
    echo.  [i]  Protocole IP rÇinitialisÇ.
    call :MAJ_DATE DEL_PROTO_IP
    echo.
    echo.
    echo.   Pensez Ö redÇmarrer votre PC une fois toutes vos opÇrations faites.
)
endlocal
timeout /t 3 >nul
goto CLEANER3


:RAZ_NET
setlocal
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous rÇinitialiser toutes les cartes rÇseau ? [o/n]"
set "CHOIX=%ERRORLEVEL%"
echo.
if %CHOIX% GEQ 3 (
    echo.
    echo.
    echo.       [i]  Aucune modification n'a ÇtÇ effectuÇe.
    timeout /t 3 >nul
    endlocal
    goto CLEANER3
)

echo.  [+]  RÇinitialisation de toutes les cartes rÇseau et Modem en cours.....
echo.
::  DÇsactivation logique des cartes rÇseau et Modems
for /f "skip=3 tokens=1-3,*" %%A in ('netsh interface show interface') do (
    netsh interface set interface name="%%D" admin=disable >nul 2>&1
)

::  RedÇmarrage matÇriel PnP [Cartes rÇseau, WWAN et Modems 4G]
for %%C in (Net WWAN Modem) do (
    for /f "tokens=2 delims=:" %%I in ('pnputil /enum-devices /class %%C /device-ids 2^>nul ^| findstr /i "Instance ID"') do (
        pnputil /restart-device "%%I" >nul 2>&1
    )
)

timeout /t 3 >nul

::   RÇactivation logique des cartes rÇseau et Modems
for /f "skip=3 tokens=1-3,*" %%A in ('netsh interface show interface') do (
    netsh interface set interface name="%%D" admin=enable >nul 2>&1
)

::  Purge du cache DNS
ipconfig /flushdns >nul

echo.
echo.  [i]  Toutes les cartes rÇseau et les Modems ont ÇtÇ rÇinitialisÇs.
endlocal
call :MAJ_DATE RAZ_CARTE_RESEAU
call :MAJ_DATE DEL_CLEAR_DNS
timeout /t 2 >nul
goto CLEANER3

::  ::::::::::::::::::::::::::
::  FIN ROUTINES DE 5.CLEANER
::  ::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE 6.INFORMATIONS
::  :::::::::::::::::::::::::::::::::

:BATT
powercfg /batteryreport /output "%USERPROFILE%\battery-report.html"
timeout /t 1 >nul
if not exist "%USERPROFILE%\battery-report.html" (
    echo.
    echo. Erreur dans le rapport de la batterie. La batterie serait-elle morte ou Windows serait-il trop rÇcent ?
    timeout /t 4 >nul
    goto INFOR
)
start "" "%USERPROFILE%\battery-report.html"
call :MAJ_DATE BATTERIE
goto INFOR3


:INDICE
setlocal
cls
echo.
echo.
echo.       INDICE DE PERFORMANCE 
echo.-----------------------------------
if "%compatible%"=="7" (
    if "%powershell%"=="1" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-WmiObject Win32_WinSat | Select-Object CPUScore, DiskScore, GraphicsScore, MemoryScore, WinSPRLevel"
    )
    if "%powershell%"=="0" (
        echo.
        echo.
        for /f "tokens=2 delims==" %%A in ('wmic path Win32_WinSat get WinSPRLevel /value ^| find "="') do (
            for /f "delims=" %%B in ("%%A") do set "SCORE_GLOBAL=%%B"
        )
        echo. Note globale : %SCORE_GLOBAL%
    )
)

if %compatible% GEQ 10 if "%powershell%"=="1" ( 
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_WinSat | Select-Object CPUScore, DiskScore, GraphicsScore, MemoryScore, WinSPRLevel"
)

echo.                               Appuyez sur une touche pour revenir au menu...
endlocal
call :MAJ_DATE INDICE
timeout /t 60 >nul
goto INFOR3


:SMART
setlocal
set "ERROR_WMIC="
cls
echo.
echo.
echo.            êTAT DU SMART
echo.-------------------------------------
echo.
echo.
if "%wmic%"=="1" (
    wmic diskdrive get Caption, status
    REM  DÇtection du type de lecteur, si SATA / AHCI ERROR=0   si NVMe ou WMI non gÇrÇ ERROR <> 0
    wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus get Active, PredictFailure 2>nul | findstr /i "TRUE FALSE" >nul
    set "ERROR_WMIC=!ERRORLEVEL!"
    if "!ERROR_WMIC!"=="0" wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus get Active, PredictFailure, Reason
    if not "!ERROR_WMIC!"=="0" (
        if "%powershell%"=="1" (
            echo.        Disque NVME dÇtectÇ, recherche d'informations supplÇmentaires ...
            powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-PhysicalDisk | ForEach-Object { $c = $_ | Get-StorageReliabilityCounter; [PSCustomObject]@{ Nom = $_.FriendlyName; SantÇ = $_.HealthStatus; êtat = $_.OperationalStatus; Temp = $c.Temperature; Usure = $c.Wear } } | Format-Table -AutoSize"
        )
    )
)

if "%wmic%"=="0" (
    if "%powershell%"=="1" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, OperationalStatus, HealthStatus, @{N='Temp';E={($_ | Get-StorageReliabilityCounter).Temperature}} | Format-Table -AutoSize"
    )
)

if "%wmic%"=="0" (
    if "%powershell%"=="0" echo.  Commandes WMIC et PowerShell non disponible....
)
echo.
echo.                               Appuyez sur une touche pour revenir au menu...
endlocal
call :MAJ_DATE SMART
timeout /t 60 >nul
goto INFOR3


:RAPPORT
setlocal
cls
systeminfo
echo. Appuyez sur une touche pour continuer ...
timeout /t 60 >nul
cls
if "%powershell%"=="0" (
     if "%wmic%"=="1" (
        wmic logicaldisk get size,freespace,caption
    )
)

if "%powershell%"=="1" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-WmiObject Win32_LogicalDisk | Select-Object Caption, @{N='Taille(Go)';E={[math]::Round($_.Size/1GB,2)}}, @{N='Libre(Go)';E={[math]::Round($_.FreeSpace/1GB,2)}} | Format-Table -AutoSize"
)
echo. Appuyez sur une touche pour continuer ...
timeout /t 60 >nul
cls
driverquery
echo. Appuyez sur une touche pour continuer ...
endlocal
timeout /t 60 >nul
goto INFOR3


:WIFI_AFF
setlocal
::  Affichage de tous les rÇseaux Wifi enregistrÇs
cls
echo.
echo.      RÇseaux WiFi et leurs clefs
echo.
::  Changement de codage pour la gestion des accents
chcp 65001 >nul
set "NB_WIFI=0"
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr /i "Profil"') do (
    set "SSID=%%a"
    set "SSID=!SSID:~1!"
    set "CLE=[aucune]"
    if defined SSID (
        for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!SSID!" key^=clear 2^>nul ^| findstr /c:"  Contenu de la cl"') do (
            set "CLE=%%b"
            set "CLE=!CLE:~1!"
        )
        echo.  R√©seau : !SSID!  -  Clef : !CLE!
        set /a NB_WIFI+=1
    )
)
::   for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!SSID!" key^=clear 2^>nul ^| findstr /c:"  Contenu de la cl"') do (
::   for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!SSID!" key^=clear 2^>nul ^| findstr /c:"  Contenu de la cl"') do (
chcp 850 >nul
echo.
if "%NB_WIFI%"=="0" echo.               Aucune clef Wifi trouvÇe.
if "%NB_WIFI%"=="1" echo.               1 clef Wifi trouvÇe.
if %NB_WIFI% GEQ 2  echo.               %NB_WIFI% clefs Wifi trouvÇes.
echo.
echo.
echo.                               Appuyez sur une touche pour revenir au menu...
endlocal
timeout /t 60 >nul
goto WIFI


:WIFI_SAV
setlocal
::  Sauvegarde de tous les rÇseaux Wifi enregistrÇs
call :DESKTOP
call :HORODATA
set "WIFI_FILE=%DesktopPath%\Cles_WiFi_%USERNAME%_%data%.txt"
:WIFI_SA2
echo.
echo.  Sauvegarde en cours des clefs Wi-Fi...
set "NB_WIFI=0"
(
  echo.      clefs WiFi de %COMPUTERNAME% - %USERNAME% - %data2%
  echo.
  for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr /i "Profil"') do (
    set "SSID=%%a"
    set "SSID=!SSID:~1!"
    if defined SSID (
      set "CLE=[aucune]"
      for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!SSID!" key^=clear 2^>nul ^| findstr /c:"  Contenu de la cl"') do (
        set "CLE=%%b"
        set "CLE=!CLE:~1!"
      )
      echo.
      echo.  R√©seau : !SSID!
      echo.  Clef    : !CLE!
      set /a NB_WIFI+=1
    )
  )
  echo.
  if "!NB_WIFI!"=="0" echo.               Aucune clef Wifi trouv√©e.
  if "!NB_WIFI!"=="1" echo.               1 clef Wifi trouv√©e.
  if !NB_WIFI! GEQ 2  echo.               !NB_WIFI! clefs Wifi trouv√©es.
) > "%WIFI_FILE%"
echo.
echo.       Fichier sauvegardÇ :
echo.  %WIFI_FILE%
echo.
echo.
endlocal
call :MAJ_DATE WIFI
if "%WIFI_Save%"=="1" goto :EOF
timeout /t 4 >nul
goto WIFI


:BSOD
setlocal
echo.
echo.                     Recherche des Erreurs Systäme  .....   Veuillez patienter .....
::  DÇfinition de l'index de dÇpart [0 = les 3 plus rÇcentes]
set /a BSOD_SK=0

::  RÇcupÇration du nombre rÇel d'erreurs en cache [max 100]
for /f %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "@(Get-EventLog -LogName System -EntryType Error -Newest 100 -ErrorAction SilentlyContinue).Count"') do set /a "BSOD_TOT=%%A"

::  Si le journal est complätement vide
if "!BSOD_TOT!"=="0" (
    cls
    echo.
    echo.    Aucune erreur critique trouvÇe dans l'Observateur d'ÇvÇnements.
    endlocal
    timeout /t 3 >nul
    goto INFOR3
)
:BSOD_L
set "SEL_KEY="
cls
echo.
echo.                      ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                      ≥ Erreurs Critiques Systäme ≥
echo.                      ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
::  Calcul des numÇros d'erreurs
set /a DEB=%BSOD_SK%+1
set /a FIN=%BSOD_SK%+3
if %FIN% GTR %BSOD_TOT% set /a FIN=%BSOD_TOT%

echo.    Affichage des erreurs %DEB% Ö %FIN% sur %BSOD_TOT% trouvÇes :

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-EventLog -LogName System -EntryType Error -Newest 100 | " ^
    "Select-Object -Skip %BSOD_SK% -First 3 | " ^
    "Format-List TimeGenerated, Source, Message"

::  Construction dynamique du menu et des touches valides
set "CH_KEYS="
set "CH_TXT="

::  Si on n'est pas sur la premiäre page, On propose [P] PrÇcÇdentes
if %BSOD_SK% GTR 0 (
    set "CH_KEYS=%CH_KEYS%P"
    set "CH_TXT=  [P] PrÇcÇdentes  "
)

::  Si la page suivante contient encore des erreurs, On propose [S] Suivantes
set /a NEW_SK=%BSOD_SK%+3
if %NEW_SK% LSS %BSOD_TOT% (
    set "CH_KEYS=%CH_KEYS%S"
    set "CH_TXT=%CH_TXT%  [S] Suivantes  "
)

::  L'option [R] Retour est toujours prÇsente
set "CH_KEYS=%CH_KEYS%R"
set "CH_TXT=%CH_TXT%  [R] Retour"

choice /c %CH_KEYS% /n /t 60 /d R /m "%NBSP%                                   %CH_TXT%"
set "CHOIX=%ERRORLEVEL%"

::  Choix des touches possibles personnalisÇ
if "%CH_KEYS%"=="PSR" (
    if "%CHOIX%"=="1" set "SEL_KEY=P"
    if "%CHOIX%"=="2" set "SEL_KEY=S"
    if "%CHOIX%"=="3" set "SEL_KEY=R"
)
if "%CH_KEYS%"=="SR" (
    if "%CHOIX%"=="1" set "SEL_KEY=S"
    if "%CHOIX%"=="2" set "SEL_KEY=R"
)
if "%CH_KEYS%"=="PR" (
    if "%CHOIX%"=="1" set "SEL_KEY=P"
    if "%CHOIX%"=="2" set "SEL_KEY=R"
)
if "%CH_KEYS%"=="R" (
  if "%CHOIX%"=="1" set "SEL_KEY=R"
)

::  Traitement des actions
if "%SEL_KEY%"=="S" (
    set /a BSOD_SK+=3
    goto BSOD_L
)

if "%SEL_KEY%"=="P" (
    set /a BSOD_SK-=3
    goto BSOD_L
)

::  Nettoyage des variables avant le retour au menu INFOR
endlocal
call :MAJ_DATE BSOD
goto INFOR3

::  :::::::::::::::::::::::::::::::::
::  FIN ROUTINES DE 6.INFORMATIONS
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::  DEBUT ROUTINES DE P.PARAMETRES
::  :::::::::::::::::::::::::::::::::

:NOTIFY
::  Inverse l'Çtat de la notification de mise Ö jour du script
if "%Update_Notify%"=="1" (
    reg add "%WL_VFS%" /v Update_Notify /t REG_SZ /d "0" /f >nul 2>&1
    set "Update_Notify=0"
) else (
    reg add "%WL_VFS%" /v Update_Notify /t REG_SZ /d "1" /f >nul 2>&1
    set "Update_Notify=1"
)
goto PARAM3


:CHAN_D
::  Injection du nouveau canal de MAJ
reg add "%WL_VFS%" /v Update_Channel_LVL /t REG_SZ /d "%Update_Channel_TMP%" /f >nul 2>&1
echo.
echo.                   Modification  effectuÇe
timeout /t 3 >nul
goto CHAN_CHO


:VFS_1
::  VÇrification si nouvelle version
if "%internet%"=="0" goto :EOF

if not "%boot%"=="1" (
    echo.
    echo.    TÇlÇchargement des informations de mise Ö jour...
)

::  Effacement des variables prÇsentes dans VFS_update.bat
set "VFS_Last_Release_Importance="
for %%a in (Finale RC BETA) do (
    for %%b in (build version download taille Channel) do (
        set "VFS_Last_Release_%%b_%%a="
    )
)

if exist "%temp%\VFS_update.bat" del "%temp%\VFS_update.bat" >nul 2>&1

::  VFS_update2.bat  version 2 de VFS_update.bat
set "DL_ERR=1"
set "URL_Update=https://github.com/Dagobert-78/VFS/releases/download/Files_Update/VFS_update2.bat"

if "%compatible%"=="7" (
    bitsadmin /transfer "VFS_Update" /download /priority normal "%URL_Update%" "%temp%\VFS_update.bat" >nul 2>&1
    set "DL_ERR=!ERRORLEVEL!"
)

if %compatible% GEQ 10 (
    curl.exe -L -s -f -o "%temp%\VFS_update.bat" "%URL_Update%"
    set "DL_ERR=!ERRORLEVEL!"
)

::  VÇrification si erreur durant le tÇlÇchargement
call :DL_ERROR
if "%DL_ERREUR%"=="1" goto :EOF

if exist "%temp%\VFS_update.bat" call "%temp%\VFS_update.bat"

::  Pour sÇcuriser au cas oó une variable BUILD serait vide.
for %%a in (Finale RC BETA) do (
    if not defined VFS_Last_Release_build_%%a set "VFS_Last_Release_build_%%a=0"
)

::  Lignes de test pour simuler le fichier VFS_update.bat  -  DÇbut
::  Lignes de test  -  Fin

call :CHANNEL

call :VFS_7

::  On vÇrifie si une des variables est dÇfinie
if not defined VFS_Last_Release_build (
    echo.
    echo.
    echo.  Erreur 18 dÇtectÇe dans le fichier de mise Ö jour.
    timeout /t 3 >nul
    goto :EOF
)

::  On vÇrifie si une des variables est dÇfinie sur 0
if "%VFS_Last_Release_build%"=="0" (
    echo.
    echo.
    echo.  Erreur 19 prÇsente dans le fichier de mise Ö jour.
    timeout /t 3 >nul
    goto :EOF
)

if exist "%temp%\VFS_update.bat" del "%temp%\VFS_update.bat" >nul 2>&1
if %SOFT_build% LSS %VFS_Last_Release_build% cls
call :MAJ_DATE UPDATE_SCRIPT
goto :EOF


:VFS_2
call :LIRE_PAR "Update_Channel_LVL"
call :VFS_1

if not defined VFS_Last_Release_build goto :EOF
if "%DL_ERREUR%"=="1" goto :EOF

::  N'affiche les versions au dÇmarrage que si besoin
if not "%boot%"=="1" call :VFS_4
if "%boot%"=="1" (
    if %SOFT_build% LSS %VFS_Last_Release_build% call :VFS_4
    if %SOFT_build% GEQ %VFS_Last_Release_build% echo.                                               OK
)
echo.

::  DÇtection d'une version Finale plus rÇcente
if %SOFT_build% LSS %VFS_Last_Release_build% (
    echo.
    echo.                     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo.                     ≥ ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø ≥
    echo.                     ≥ ≥  Une mise Ö jour est disponible  ≥ ≥
    echo.                     ≥ ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ ≥
    echo.                     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    echo.
    echo.

    REM  Boucle qui Çvite de mettre Ö jour d'une BETA/RC vers une autre BETA/RC d'une version trop ÇloignÇe
    if %VFS_Last_Release_Channel_LVL% LEQ 2 (
        set /a VERSION_DIFF=%VFS_Last_Release_version_LVL% - %SOFT_version_LVL%

        REM  Suppression du - si la diffÇrence est nÇgative.
        set "VERSION_DIFF=%VERSION_DIFF:-=%"
        if !VERSION_DIFF! GTR 0 (
            echo.      Saut de mise Ö jour de test trop important
            echo.      Veuillez d'abord installer la derniäre version stable.
            if "%VFS_Last_Release_Channel%"=="BETA" echo.      Pour cela, changez le canal de mise Ö jour pour RC ou Finale.
            if "%VFS_Last_Release_Channel%"=="RC"   echo.      Pour cela, changez le canal de mise Ö jour pour Finale.
            echo.
            echo.               Canal actuel : %Update_Channel%
            echo.
            echo. Appuyez sur une touche pour continuer ...
            timeout /t 60 >nul
            goto :EOF
        )
    )  
    
    REM  Augmente la tempo d'inactivitÇ apräs une lecture du Quoi29
    set "TEMPO=10"
    if defined DEBUT set "TEMPO=90"
    
    choice /c %OYN% /n /t !TEMPO! /d N /m "%NBSP%- Voulez-vous installer la mise Ö jour ou [V]oir ce qu'elle vous apporte ? [o/n/V] "
    set "CHOIX_VFS2=!ERRORLEVEL!"
    if !CHOIX_VFS2! LEQ 2 call :VFS_3
    if "!CHOIX_VFS2!"=="22" goto Q29
    
    REM  On efface la variable qui nous indique qu'on est passÇ par Q29
    set "TEMPO="
    goto :EOF
)
if "%boot%"=="1" goto :EOF

::  Permet de revenir Ö la derniäre version Finale
if %VFS_Last_Release_Channel_LVL% GEQ %SOFT_Channel_LVL% goto VFS_5   

echo.
echo.   Il n'y a pas de mise Ö jour disponible dans votre canal.
echo.
echo. Appuyez sur une touche pour revenir au menu ...
timeout /t 60 >nul
goto :EOF  


:VFS_3
::   TÇlÇchargement de la derniäre version
set "DL_ERR=1"
echo.
echo.  TÇlÇchargement de la mise Ö jour...
echo.

if "%compatible%"=="7" (
    bitsadmin /transfer "Derniäre_Version" /download /priority normal "%VFS_Last_Release_download%" "%temp%\VFS_new.cmd" >nul 2>&1
    set "DL_ERR=!ERRORLEVEL!"
    )

if %compatible% GEQ 10 (
    curl.exe -L -s -f -o "%temp%\VFS_new.cmd" "%VFS_Last_Release_download%"
    set "DL_ERR=!ERRORLEVEL!"
)

::  VÇrification si erreur durant le tÇlÇchargement
call :DL_ERROR
if "%DL_ERREUR%"=="1" goto :EOF

::  VÇrification de l'intÇgritÇ du fichier tÇlÇchargÇ
call :VFS_6
if "%DL_ERREUR%"=="1" goto :EOF


::  Mise en Final du canal si MAJ est une finale.
if %SOFT_Channel_LVL% LEQ 2 (
    if %Update_Channel_LVL% LEQ 2 (
        if "%VFS_Last_Release_Channel%"=="Finale" (
            reg add "%WL_VFS%" /v Update_Channel_LVL /t REG_SZ /d "3" /f >nul
        )
    )
)

::  CrÇation d'un script intermÇdiaire pour la mise Ö jour
  (
  echo.@echo off
  echo mode con cols=60 lines=10
  echo echo.
  echo echo.       Mise Ö jour en cours.  Veuillez patienter  .....
  echo timeout /t 3 ^>nul
  echo copy /y "%temp%\VFS_new.cmd" "%~f0" ^>nul
  echo echo.
  echo echo.       Mise Ö jour terminÇe.  Lancement du script .....
  echo timeout /t 3 ^>nul
  echo start "" cmd /c "%~f0"
  echo start /b "" cmd /c del "%%~f0"
  echo exit
  ) > "%temp%\VFS_updater.bat"
    
::  Lancement du script intermÇdiaire puis fermeture
start "" "%temp%\VFS_updater.bat"
goto FIN_2


:VFS_4
::    Affichage des versions actuelle et disponible
if not "%boot%"=="1" cls
::   if %SOFT_build% GEQ %VFS_Last_Release_build% cls
echo.
echo.
echo.
echo.     Version actuelle : %SOFT_version% build %SOFT_build% %SOFT_Channel% %SOFT_Channel_Version% [%SOFT_taille_ko% ko]
echo.   Version disponible : %VFS_Last_Release_version% build %VFS_Last_Release_build% %VFS_Last_Release_Channel% %VFS_Last_Release_Channel_Version% [%VFS_Last_Release_taille% ko]
if %SOFT_build% LSS %VFS_Last_Release_build% echo.              UtilitÇ : %VFS_Last_Release_Importance%
echo. Canal de mise Ö jour : %Update_Channel% 
goto :EOF


:VFS_5
echo.
::  DÇtection d'une version plus ancienne, ce qui ne devrait pas arriver
if %SOFT_build% GTR %VFS_Last_Release_build% (
    echo.  Votre version semble plus rÇcente que celle proposÇe.
    echo.  Utile uniquement si vous avez des bugs importants avec la version actuelle.
    echo.
    echo.
    choice /c %OYN% /n /t 15 /d N /m "%NBSP%- Voulez-vous revenir Ö une version prÇcÇdente du script [NON RECOMMANDÇ] ? [o/n] "
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! LEQ 2 call :VFS_3
)

::  DÇtection d'une version identique
if "%SOFT_build%"=="%VFS_Last_Release_build%" (
    echo.  Vous avez dÇjÖ la derniäre version.
    echo.
    echo.
    choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous forcer la rÇinstallation du script ? [o/n] "
    set "CHOIX=!ERRORLEVEL!"
    if !CHOIX! LEQ 2 call :VFS_3
)
goto :EOF


:VFS_6
::  VÇrification de l'intÇgritÇ du fichier tÇlÇchargÇ

if not defined Hash_Attendu goto :EOF

set "Hash_Attendu=%VFS_Last_Release_SHA%"
set "FILE_PATH=%temp%\VFS_new.cmd"

::  Extraction du SHA256 avec certutil
set "Hash_Calcule="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%FILE_PATH%" SHA256 2^>nul') do (
    if not defined Hash_Calcule (
        set "HASH_RAW=%%H"
        REM  Suppression des espaces (nÇcessaire sous Windows 7 qui formate en octets sÇparÇs)
        set "Hash_Calcule=!HASH_RAW: =!"
    )
)

::  Contrìle d'intÇgritÇ
echo.
if /i "%Hash_Calcule%"=="%Hash_Attendu%" (
    echo.   [OK]  Empreinte SHA256 valide. Le fichier est authentique.
)

if /i not "%Hash_Calcule%"=="%Hash_Attendu%" (
    set "DL_ERREUR=1"
    echo.   [ERREUR]  FICHIER CORROMPU OU ALTêRê
    echo.   Attendu : %Hash_Attendu%
    echo.   Obtenu  : %Hash_Calcule%
    timeout /t 3 >nul
    del /f /q "%FILE_PATH%" >nul 2>&1
)
echo.
for /f %%A in (HASH_RAW Hash_Calcule Hash_Attendu FILE_PATH) do (set "%%A=")
goto :EOF


:VFS_7
if "%Mode_Test%"=="1" call :TEST_11
::      Permet de passer outre la restriction du Canal, si cela permet une version plus rÇcente
::  Pour cela, on change temporairement le canal de mise Ö jour

::  On sauvegarde l'ancien
set "Update_Channel_LVL_TMP=%Update_Channel_LVL%" 
set "Update_Channel_TMP=%Update_Channel%"
set "Channel_TMP="

::  Permet de privilÇgier FINALE si elle est plus rÇcente que RC
if "%Update_Channel%"=="RC" (
    REM   Si Finale >= RC
    if %VFS_Last_Release_build_Finale% GEQ %VFS_Last_Release_build_RC% (
        set "Update_Channel_LVL=3"
        set "Channel_TMP=1"
    )
)

::  Permet de privilÇgier Finale, Ö dÇfaut RC si elle est plus rÇcente que BETA
if "%Update_Channel%"=="BETA" (
    REM   Si RC >= Bàta
    if %VFS_Last_Release_build_RC% GEQ %VFS_Last_Release_build_BETA% (
        set "Update_Channel_LVL=2"
        set "Channel_TMP=1"
    )
    REM   Si Finale >= RC
    if %VFS_Last_Release_build_Finale% GEQ %VFS_Last_Release_build_RC% (
        set "Update_Channel_LVL=3"
        set "Channel_TMP=1"
    )
)

::  Permet de Update de BÇta vers BÇta màme si canal FINALE activÇ
if "%SOFT_Channel%"=="BETA" (
    if %Update_Channel_LVL% GEQ 2 (
        REM Garder l'ordre 1 > 2 > 3 pour priviligier la Finale
        REM   Si Bàta > Actuel
        if %VFS_Last_Release_build_BETA% GTR %SOFT_build% set "Update_Channel_LVL=1"
        REM   Si RC > Actuel
        if %VFS_Last_Release_build_RC% GTR %SOFT_build% set "Update_Channel_LVL=2"
        REM   Si Finale > Actuel
        if %VFS_Last_Release_build_Finale% GTR %SOFT_build% set "Update_Channel_LVL=3"
    )
    set "Channel_TMP=1"
)

::  Permet de Update de RC vers RC/Finale plus rÇcent quelques soit le canal activÇ
if "%SOFT_Channel%"=="RC" (
    if "%Update_Channel%"=="BETA" (
        REM   Si Finale >= RC
        if %VFS_Last_Release_build_RC% GEQ %SOFT_build% (
            set "Update_Channel_LVL=2"
            set "Channel_TMP=1"
        )
        if %VFS_Last_Release_build_Finale% GEQ %SOFT_build% (
            set "Update_Channel_LVL=3"
            set "Channel_TMP=1"
        )
    )
    REM   Permet de Update de RC vers RC màme si canal FINALE activÇ
    if "%Update_Channel%"=="Finale" (
        if %VFS_Last_Release_build_RC% GEQ %VFS_Last_Release_build_Finale% (
            set "Update_Channel_LVL=2"
            set "Channel_TMP=1"
        )
    )            
)

if "%Mode_Test%"=="1" call :TEST_12
::  On restore l'ancien
if defined Channel_TMP (
    call :CHANNEL
    set "Update_Channel_LVL=%Update_Channel_LVL_TMP%"
    set "Update_Channel=%Update_Channel_TMP%"
    set "Update_Channel_LVL_TMP=" 
    set "Update_Channel_TMP=" 
    set "Channel_TMP=" 
)
goto :EOF


:Q29
::    Routine pour rÇcupÇrer le Quoi de Neuf personnalisÇ
set "URL_Update=https://github.com/Dagobert-78/VFS/releases/download/Files_Update/VFS_Quoi29.bat"
if exist "%temp%\VFS_Quoi29.bat" del "%temp%\VFS_Quoi29.bat" >nul 2>&1

::  TÇlÇchargement puis rÇcupÇration du code erreur 
if "%compatible%"=="7" (
    bitsadmin /transfer "VFS_Quoi_de_Neuf" /download /priority normal "%URL_Update%" "%temp%\VFS_Quoi29.bat" >nul 2>&1
    set "DL_ERR=!ERRORLEVEL!"
)

if %compatible% GEQ 10 (
    curl.exe -L -s -f -o "%temp%\VFS_Quoi29.bat" "%URL_Update%"
    set "DL_ERR=!ERRORLEVEL!"
)

::  VÇrification si erreur durant le tÇlÇchargement
call :DL_ERROR
if "%DL_ERREUR%"=="1" goto VFS_2

::  On ajuste le numÇro de Build actuel pour ne prendre que les derniäres modifs 
set /a DEBUT=%SOFT_build%+1

::  On remplit le fichier Quoi de Neuf personnalisÇ
call "%temp%\VFS_Quoi29.bat" ENTETE
for /L %%A in (%VFS_Last_Release_build%,-1,%DEBUT%) do call "%temp%\VFS_Quoi29.bat" %%A

::  On vÇrifie si des info on ÇtÇ rÇcupÇrÇs
findstr /R "^[+*i#-]" "%temp%\VFS_Quoi_de_Neuf.txt" >nul 2>&1
set "ERROR=%ERRORLEVEL%"

if "%ERROR%"=="1" (
  (
    echo.
    echo.    Aucune information n'est disponible.
    ) >> "%temp%\VFS_Quoi_de_Neuf.txt"
  goto Q29_2
)

:: On tri le fichier pour ordonner les info dans cet ordre  +*i#- 
> "%temp%\VFS_Quoi_de_Neuf_sorted.txt" (
    REM  Conservation de l'en-tàte
    findstr /V /R /C:"^[+*i#-]" "%temp%\VFS_Quoi_de_Neuf.txt"
    REM  NouveautÇs (+)
    findstr /B /C:"+" "%temp%\VFS_Quoi_de_Neuf.txt"
    REM  Modifications / AmÇliorations (*)
    findstr /B /C:"*" "%temp%\VFS_Quoi_de_Neuf.txt"
    REM  Suppressions (-)
    findstr /B /C:"-" "%temp%\VFS_Quoi_de_Neuf.txt"
    REM  Informations (i)
    findstr /B /I /C:"i" "%temp%\VFS_Quoi_de_Neuf.txt"
    REM  Correction de bugs (#)
    findstr /B /C:"#" "%temp%\VFS_Quoi_de_Neuf.txt"
)

:: Remplacement du fichier d'origine par la version triÇe
move /y "%temp%\VFS_Quoi_de_Neuf_sorted.txt" "%temp%\VFS_Quoi_de_Neuf.txt" >nul

:Q29_2
::   Permet d'afficher les modifications apportÇes 
start notepad "%temp%\VFS_Quoi_de_Neuf.txt"
set "ERROR="
goto VFS_2


:CHANNEL
::    Conversion du canal de Lettre vers numÇrique
::  Variables du script
set "SOFT_Channel_LVL="
if "%SOFT_Channel%"=="Finale" set "SOFT_Channel_LVL=3"
if "%SOFT_Channel%"=="RC"     set "SOFT_Channel_LVL=2"
if "%SOFT_Channel%"=="BETA"   set "SOFT_Channel_LVL=1"

::  Choix du canal
set "Update_Channel="
if "%Update_Channel_LVL%"=="3" set "Update_Channel=Finale"
if "%Update_Channel_LVL%"=="2" set "Update_Channel=RC"
if "%Update_Channel_LVL%"=="1" set "Update_Channel=BETA"

::  Variables de VFS_update.bat
set "VFS_Last_Release_build=!VFS_Last_Release_build_%Update_Channel%!"
set "VFS_Last_Release_version=!VFS_Last_Release_version_%Update_Channel%!"
set "VFS_Last_Release_taille=!VFS_Last_Release_taille_%Update_Channel%!"
set "VFS_Last_Release_Channel=!VFS_Last_Release_Channel_%Update_Channel%!"
set "VFS_Last_Release_Channel_Version=!VFS_Last_Release_Channel_Version_%Update_Channel%!"
set "VFS_Last_Release_download=!VFS_Last_Release_download_%Update_Channel%!"
set "VFS_Last_Release_SHA=!VFS_Last_Release_SHA_%Update_Channel%!"

if defined VFS_Last_Release_Channel_LVL   set "VFS_Last_Release_Channel_LVL="
if "%VFS_Last_Release_Channel%"=="BETA"   set "VFS_Last_Release_Channel_LVL=1"
if "%VFS_Last_Release_Channel%"=="RC"     set "VFS_Last_Release_Channel_LVL=2"
if "%VFS_Last_Release_Channel%"=="Finale" set "VFS_Last_Release_Channel_LVL=3"

::  Version en pur numÇrique  1.22.3.44 devient 1223
::   Bug lors du set /a VERSION_DIFF=   si une version contient un 0 au dÇbut    ex : 5.1.02.2
for /f "tokens=1,2,3 delims=." %%A in ("%SOFT_version%") do (set "SOFT_version_LVL=%%A%%B%%C")
for /f "tokens=1,2,3 delims=." %%A in ("%VFS_Last_Release_version%") do (set "VFS_Last_Release_version_LVL=%%A%%B%%C")

::  VÇrification du niveau du canal
if not defined Update_Channel (
    echo. Erreur dans le canal de mise Ö jour.
    timeout /t 2 >nul
)
goto :EOF


:DEL_REG
::  Effacement des clefs VFS du registre
cls
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous vraiment effacer TOUTES les infos registre de ce script ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 goto PARAM4
echo.
echo.  Effacement des donnÇes de ce script prÇsente dans la base de registre Windows ...
echo.
::  Vide le registre VFS en conservant les sauvegardes DNS
reg delete "%WL_VFS%" /va /f
echo.
echo.
choice /c %OYN% /n /t 10 /d N /m "%NBSP%- Voulez-vous Çgalement effacer TOUTES les sauvegardes de vos DNS ? [o/n] "
set "CHOIX=%ERRORLEVEL%"
if %CHOIX% GEQ 3 goto DEL_REG1
echo.
reg delete "%WL_VFS%" /f
:DEL_REG1
echo.  Le script se fermera automatiquement une fois fini pour ne laisser aucune trace.
timeout /t 6 >nul
goto FIN 



:INACTIF0
::    Injection de la valeur de l'inactivitÇ

::  On vÇrifie l'unique prÇsence de chiffre
for /f "delims=0123456789" %%V in ("%Tempo_Inactif_TMP%") do goto INACTIF

::  La valeur doit àtre comprise entre 30 et 999s, sinon, on corrige
if %Tempo_Inactif_TMP% LSS 30  set "Tempo_Inactif_TMP=30"
if %Tempo_Inactif_TMP% GTR 999 set "Tempo_Inactif_TMP=999"

::  Si la valeur est la màme, on ne change rien
if "%Tempo_Inactif_TMP%"=="%Tempo_Inactif%" (
    echo.  Valeur non modifiÇe, nous conservons %Tempo_Inactif%s.
)

::  Si diffÇrente, On applique la nouvelle valeur
if not "%Tempo_Inactif_TMP%"=="%Tempo_Inactif%" (
    reg add "%WL_VFS%" /v Tempo_Inactif /t REG_SZ /d "%Tempo_Inactif_TMP%" /f >nul
    echo.  Temporisation de l'inactivitÇ modifiÇe de %Tempo_Inactif%s Ö %Tempo_Inactif_TMP%s.
    set "Tempo_Inactif=%Tempo_Inactif_TMP%"
)

timeout /t 3 >nul
goto PARAM4


:COM_AFF
::    Affiche l'intÇgralitÇ des ÇlÇments, ce qui permet de les ProtÇger/LibÇrer
call :COM_ETA %Elements_ID%
:COM_AFF2
cls
echo.
echo.                 Voici la liste dÇtaillÇe des %Elements_Texte_1% dÇsactivables
echo.
for /L %%A in (1,1,%Elements_Nombre%) do (
    rem  echo Arret : *!%%A_Arret!*    Disabled : *!%%A_Disabled!*    Present : *!%%A_Present!*
    if "!%%A_Arret!"=="1"    (set "element_%%A_Etat=S") else (set "element_%%A_Etat=L")
    if "!%%A_Disabled!"=="1" (set "element_%%A_Etat=D")
    if not "!%%A_Present!"=="1" (set "element_%%A_Etat=A")
    if %%A LEQ 9  echo. !element_%%A_SIGN! [!element_%%A_Etat!] 0%%A : !element_%%A_TXT! - !element_%%A_DESC!
    if %%A GEQ 10 echo. !element_%%A_SIGN! [!element_%%A_Etat!] %%A : !element_%%A_TXT! - !element_%%A_DESC!
)

echo.
echo. lÇgende : [A]bsent - [D]ÇsactivÇ - [S]toppÇ - [L]ancÇ
set "Elements_Change="
if "%PowerShell%"=="1" call :TIMEOUT1 Elements_Change " NumÇro des %Elements_Texte_2% Ö rendre modifiables [+] ou protÇgÇs [-]     Par [D]Çfaut ou [0] pour annuler " %Tempo_Inactif% M
if "%PowerShell%"=="0" set /p "Elements_Change=_NumÇro des %Elements_Texte_2% Ö rendre modifiables [+] ou protÇgÇs [-]     Par [D]Çfaut ou [0] pour annuler "

if "%Elements_Change%"=="0"    goto PARAM4
if /i "%Elements_Change%"=="M" call :FIN_INAC && goto COM_AFF
if /i "%Elements_Change%"=="D" goto COM_DEF

::  On sÇcurise un max
if not defined Elements_Change goto COM_AFF2
if "%Elements_Change%"=="" goto COM_AFF2

::  On envoi chaques caractäres 1 par 1
for %%A in (%Elements_Change%) do call :COM_SIG %%A
goto COM_INJ


:COM_SIG
::    Inversion du signe

::  On rÇcupäre le paramätre 1
set "Elements_Change_TMP=%1"

::  On vÇrifie l'unique prÇsence de chiffre
for /f "delims=0123456789" %%V in ("%Elements_Change_TMP%") do goto :EOF

::  On vÇrifie si inclu entre 1 et Elements_Nombre
if %Elements_Change_TMP% GTR %Elements_Nombre% goto :EOF
if %Elements_Change_TMP% LSS 1 goto :EOF

::  On inverse le signe
if "!element_%Elements_Change_TMP%_SIGN!"=="+" (
    set "element_%Elements_Change_TMP%_SIGN=-"
    goto COM_SIG2
)

if not "!element_%Elements_Change_TMP%_SIGN!"=="+" (
    set "element_%Elements_Change_TMP%_SIGN=+"
    goto COM_SIG1
)

::  Code mort, jamais atteint, juste pour marquer visuellement la fin de cette sous-routine
goto :EOF


:COM_SIG1
::   On ajoute dans la variable Ö destination du registre ceux qui sont modifiables
set "Elements_Modifiables=%Elements_Modifiables% %Elements_Change_TMP%"
goto :EOF


:COM_SIG2
::   On enläve, dans la variable Ö destination du registre, ce que l'on vient de rendre non modifiable
set "Elements_Modifiables_TMP="
for %%A in (%Elements_Modifiables%) do (
    if not "%%A"=="%Elements_Change_TMP%" (
        set "Elements_Modifiables_TMP=!Elements_Modifiables_TMP! %%A"
    )
)
set "Elements_Modifiables=%Elements_Modifiables_TMP%"
goto :EOF


:COM_SIG3
::   Mise par dÇfaut en "+"

::  Mise par dÇfaut de element_x_SIGN Ö "-"
for /l %%A in (1,1,%Elements_Nombre%) do (set "element_%%A_SIGN=-")

::  Bascule Ö "+"
if defined Elements_Modifiables (
    for %%A in (%Elements_Modifiables%) do set "element_%%A_SIGN=+"
)

::  Si Signe non dÇfini, Mise par dÇfaut en '+'
for /L %%A in (1,1,%Elements_Nombre%) do (
    if not defined element_%%A_SIGN set "element_%%A_SIGN=+"
)
goto :EOF


:COM_INJ
call :2ESPACE Elements_Modifiables
echo.
::  On rÇinjecte, en Çcrasant, la liste des ÇlÇments modifiables
reg add "%WL_VFS%" /v "%Elements%_Modifiables" /t REG_SZ /d "%Elements_Modifiables% " /f >nul
goto COM_AFF


:COM_DEF
::   Mise par dÇfaut de l'Çtat modifiable
set "Elements_Modifiables="
reg delete "%WL_VFS%" /v "%Elements%_Modifiables" /f >nul 2>&1
goto COM_AFF


:NAM2NUM
::  Convertit une liste de noms [Services ou TÉches] en numÇros
::  %1 = Liste de noms entre guillemets [ex: "MapsBroker CertPropSvc" ou %Liste_a_activer% ]
::  %2 = Variable de sortie qui recevra les numÇros [ex: %Numeros_a_activer% ]
set "Liste_Name_IN=%~1"
set "Liste_Numero_OUT="

for %%N in (%Liste_Name_IN%) do (
    set "NOM_TROUVE=0"
    for /L %%A in (1,1,%Elements_Nombre%) do (
        if "!NOM_TROUVE!"=="0" (
            REM  VÇrification sur le nom systäme complet ou le nom court [xxx_TXT]
            if /i "%%N"=="!element_%%A!" (
                set "Liste_Numero_OUT=!Liste_Numero_OUT! %%A"
                set "NOM_TROUVE=1"
            ) else if /i "%%N"=="!element_%%A_TXT!" (
                set "Liste_Numero_OUT=!Liste_Numero_OUT! %%A"
                set "NOM_TROUVE=1"
            )
        )
    )
)

::  Nettoyage de l'espace initial s'il existe
if defined Liste_Numero_OUT call :2ESPACE Liste_Numero_OUT

set "%~2=%Liste_Numero_OUT%"
goto :EOF


:COM_LIS
if not "%1"=="" set "Elements_ID=%1"
::  Listing dÇtaillÇ des ÇlÇments

::  Mise en variable des ÇlÇments

::  routine spÇciale pour T∂CHES PLANIFIEES
if "%Elements_ID%"=="1" (
    REM   Variables contenant le texte spÇcifique pour les TÉches PlanifiÇes
    set "Elements=Taches"
    set "Elements_Texte_0=Aucune TÉche PlanifiÇe"
    set "Elements_Texte_1=TÉches PlanifiÇes"
    set "Elements_Texte_2=TÉches"
    set "Elements_Texte_3=Taches Planifiees"
    
    REM   Variables contenant le nom systäme des TÉches PlanifiÇes
    set "element_1=\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    set "element_2=\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    set "element_3=\Microsoft\Windows\Application Experience\StartupAppTask"
    set "element_4=\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    set "element_5=\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
    set "element_6=\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    set "Elements_Nombre=6"

    REM   Variables contenant la description des TÉches PlanifiÇes
    set "element_1_DESC=êvalue la compatibilitÇ du PC pour les futures mises Ö jour Windows"
    set "element_2_DESC=Liste les programmes installÇs pour anticiper les conflits de mises Ö jour"
    set "element_3_DESC=Scanne et gäre les applications qui se lancent au dÇmarrage"
    set "element_4_DESC=Envoie Ö Microsoft les donnÇes globales d'utilisation du systäme"
    set "element_5_DESC=Collecte les erreurs et donnÇes de performance du noyau Windows"
    set "element_6_DESC=Analyse le fonctionnement et les bugs de vos pÇriphÇriques USB"

    REM   RÇcupÇration du nom court de la TÉche, prend le dernier ÇlÇment apräs le dernier \
    for /L %%A in (1,1,!Elements_Nombre!) do (
        for %%F in ("!element_%%A!") do (
            set "element_%%A_TXT=%%~nxF"
            REM  On met des _ au lieu des espaces
            set "element_%%A_TXT=!element_%%A_TXT: =_!"
        )
    )
)

::  routine spÇciale pour SERVICES WINDOWS
if "%Elements_ID%"=="2" (
    REM   Variables contenant le texte spÇcifique pour les Services
    set "Elements=Services"
    set "Elements_Texte_0=Aucun Service Windows"
    set "Elements_Texte_1=Services Windows"
    set "Elements_Texte_2=Service"
    set "Elements_Texte_3=Services Windows"

    REM   Variables contenant le nom systäme des Services
    set "element_1=DiagTrack"
    set "element_2=DMwapPushService"
    set "element_3=WerSvc"
    set "element_4=RetailDemo"
    set "element_5=MapsBroker"
    set "element_6=Fax"
    set "element_7=Diagsvc"
    set "element_8=Wecsvc"
    set "element_9=SCardSvr"
    set "element_10=ScDeviceEnum"
    set "element_11=SCPolicySvc"
    set "element_12=SEMgrSvc"
    set "element_13=DusmSvc"
    set "element_14=WpcMonSvc"
    rem  ShellHWDetection est träs utile pour les disques externes
    rem  set "element_15=ShellHWDetection"
    set "element_15=MsKeyboardFilter"
    set "element_16=CertPropSvc"
    set "element_17=WMPNetworkSvc"
    set "element_18=wisvc"
    set "element_19=SysMain"
    set "element_20=RemoteRegistry"
    set "element_21=WbioSrvc"
    set "element_22=fhsvc"
    set "Elements_Nombre=22"
    REM  INFO : Les services DPS et wdiServiceHost servent Ö rÇparer, ils ne sont donc pas Ö dÇsactiver

    REM   Variables contenant la description des Services
    set "element_1_DESC=ExpÇrience des utilisateurs connectÇs et tÇlÇmÇtrie"
    set "element_2_DESC=Service de routage des messages de poussÇe WAP"
    set "element_3_DESC=Service de rapport d'erreurs Windows"
    set "element_4_DESC=Service de dÇmonstration en magasin"
    set "element_5_DESC=Gestionnaire de cartes tÇlÇchargÇes"
    set "element_6_DESC=TÇlÇcopie"
    set "element_7_DESC=Service d'exÇcution de diagnostic"
    set "element_8_DESC=Collecteur d'ÇvÇnements de Windows"
    set "element_9_DESC=Carte Ö puce"
    set "element_10_DESC=Service d'ÇnumÇration de pÇriphÇriques de carte Ö puce"
    set "element_11_DESC=StratÇgie de retrait de la carte Ö puce"
    set "element_12_DESC=Gestionnaires des paiements et des ÇlÇments sÇcurisÇs NFC"
    set "element_13_DESC=Consommation des donnÇes"
    set "element_14_DESC=Contrìle parental"
    rem  set "element_15_DESC=DÇtection matÇriel noyau"
    set "element_15_DESC=Filtre clavier Microsoft"
    set "element_16_DESC=Propagation du certificat"
    set "element_17_DESC=Service Partage rÇseau du Lecteur"
    set "element_18_DESC=Service Windows Insider"
    set "element_19_DESC=Gäre et amÇliore les performances du systäme dans le temps, abime les SSD"
    set "element_20_DESC=Registre Ö distance"
    set "element_21_DESC=Service de biomÇtrie Windows"
    set "element_22_DESC=Historique des fichiers"

    REM  RÇcupÇration du nom du Service qui est Çgal au Service lui-màme, sauf 21
    for /L %%A in (1,1,!Elements_Nombre!) do set "element_%%A_TXT=!element_%%A!"

    REM  DÇfinition de variables si le nom d'un Service est diffÇrent du Service lui-màme
    set "element_21_TXT=BiometrySvc"
)

::   Indexation en mÇmoire Batch avec gestion des chemins complets avec espaces
for /L %%A in (1,1,%Elements_Nombre%) do (
    set "map_!element_%%A_TXT!=%%A"
    set "map_!element_%%A!=%%A"
)

if "%PowerShell%"=="1" (
    REM   CrÇation de la liste des ElÇments pour PowerShell pour les Sercices et les TÉches
    REM      exemple : 'DiagTrack','DMwapPushService','...
    set "Liste_Elements_PowerShell="
    for /L %%A in (1,1,%Elements_Nombre%) do (
        if not defined Liste_Elements_PowerShell (
            set "Liste_Elements_PowerShell='!element_%%A!'"
        ) else (
            set "Liste_Elements_PowerShell=!Liste_Elements_PowerShell!,'!element_%%A!'"
        )
    )
)

::  On rÇcupäre les infos du registre
call :COM_NFO

::  On rÇcupäre les infos nÇcessaires pour le signe
call :COM_SIG3
goto :EOF


:COM_NFO
::   RÇcupÇration des info du registre
set "Elements_Disabled="
set "Elements_Modifiables="
echo.
for /f "tokens=2,*" %%A in ('reg query "%WL_VFS%" /v "%Elements%_Disabled" 2^>nul ^| find "REG_"') do set "Elements_Disabled=%%B"
for /f "tokens=2,*" %%A in ('reg query "%WL_VFS%" /v "%Elements%_Modifiables" 2^>nul ^| find "REG_"') do set "Elements_Modifiables=%%B"
call :2ESPACE Elements_Disabled
call :2ESPACE Elements_Modifiables

::  Si registre vide, on prend tout et on l'injecte
if "%Elements_Modifiables%"=="" (
    for /L %%A in (1,1,%Elements_Nombre%) do (
        if not defined Elements_Modifiables set "Elements_Modifiables=%%A"
        if defined Elements_Modifiables     set "Elements_Modifiables=!Elements_Modifiables! %%A"
    )
    reg add "%WL_VFS%" /v "%Elements%_Modifiables" /t REG_SZ /d "!Elements_Modifiables! " /f >nul
)
goto :EOF

::  :::::::::::::::::::::::::::::::::
::    FIN ROUTINES DE P.PARAMETRES
::  :::::::::::::::::::::::::::::::::


::  :::::::::::::::::::::::::::::::::
::     DEBUT ROUTINES DES ETATS
::  :::::::::::::::::::::::::::::::::

:COM_ETA
if not "%1"=="" set "Elements_ID=%1"
::  Recherche de l'Çtat des ÇlÇments
call :COM_LIS %Elements_ID%

::   Version PowerShell de la recherche de l'Çtat des Services
::  La routine PowerShell est plus lente que la version en CMD pur, Ö revoir Ö partir de 200 TÉches PlanifiÇes

if "%PowerShell%"=="1" (
    if "%Elements_ID%"=="2" (
        REM   Interrogation des SERVICES via PowerShell et affectation des variables
        REM   PowerShell 3.0 minimum
        for /f "tokens=1-4" %%R in ('powershell -NoProfile -Command "$L=@(%Liste_Elements_PowerShell%); $S=Get-Service -Name $L -ErrorAction SilentlyContinue; foreach ($n in $L) { $p=0; $a=0; $d=0; foreach ($item in $S) { if ($item.Name -eq $n) { $p=1; if ($item.Status -eq 'Stopped') {$a=1}; if ($item.StartType -eq 'Disabled') {$d=1}; break } }; $n + ' ' + $p + ' ' + $a + ' ' + $d }"') do (
            set "NUM=!map_%%R!"
            if defined NUM (
                set "!NUM!_Present=%%S"
                set "!NUM!_Arret=%%T"
                set "!NUM!_Disabled=%%U"
            )
        )
    )
)

::    Version CMD de la recherche de l'Çtat des Services et des TÉches

    REM  ROUTINE TACHES PLANIFIEES - ID 1
if "%Elements_ID%"=="1" (
    FOR /L %%A in (1,1,%Elements_Nombre%) do set "%%A_Present=0"

    REM  1. DUMP global de toutes les tÉches en 1 seule commande schtasks
    for /f "tokens=1,2,3 delims=," %%R in ('schtasks /Query /FO CSV /NH 2^>nul') do (
        set "Nom_Trouver=0"
        set "Tache_Nom=%%~R"

        REM  2. Analyse en mÇmoire pure pour nos tÉches
        FOR /L %%A in (1,1,%Elements_Nombre%) do (
            if "!Nom_Trouver!"=="0" (
                if defined Tache_Nom (
                    if "!Tache_Nom!"=="!element_%%A!" (
                        set "%%A_Present=1"
                        set "Nom_Trouver=1"

                        REM  l'Çtat Ö 3 positions 'Pràt' , 'En cours' et 'DÇsactivÇ'
                        set "%%A_Etat=%%~T"
                        REM  Version Franáaise
                        if /i "!%%A_Etat!"=="DÇsactivÇ" (
                            set "%%A_Arret=1"
                            set "%%A_Disabled=1"
                        REM  Version Anglaise
                        ) else if /i "!%%A_Etat!"=="Disabled" (
                            set "%%A_Arret=1"
                            set "%%A_Disabled=1"
                        ) else (
                            set "%%A_Arret=0"
                            set "%%A_Disabled=0"
                        )
                    )
                )
            )
        )
    )
)
    
if "%PowerShell%"=="0" (
    REM  ROUTINE SERVICES - ID 2
    if "%Elements_ID%"=="2" (
        REM   Routine rÇÇcrite venant de la v5.1.0.0
        for /L %%A in (1,1,%Elements_Nombre%) do (
            set "%%A_Present=0"
            rem   On vÇrifie si le Service existe, [0 = existe, 1060 = inexistant]
            sc query "!element_%%A!" >nul 2>&1
            set "ERR_QUERY_1=!ERRORLEVEL!"
            if "!ERR_QUERY_1!"=="0" set "%%A_Present=1"

            if "!%%A_Present!"=="1" (
                set "%%A_Arret=0"
                set "%%A_Disabled=1"
                rem  RÇcupÇration de l'Çtat du service [0 si dÇmarrÇ, 1 si arràtÇ]
                sc query "!element_%%A!" | findstr "RUNNING" >nul 2>&1
                set "ERR_QUERY_2=!ERRORLEVEL!"
                if not "!ERR_QUERY_2!"=="0" set "%%A_Arret=1"

                rem   Analyse de la configuration du service  [1 si dÇsactivÇ, 0 si activÇ]
                sc qc !element_%%A! | findstr "START_TYPE" | findstr "DISABLED" >nul 2>&1
                set "ERR_QUERY_3=!ERRORLEVEL!"
                if "!ERR_QUERY_3!"=="1" set "%%A_Disabled=0"
            )
        )
    )
)

::  CALCUL DES xxxx_LVL
set "%Elements%_LVL=1"
set "%Elements%_LVL_2=0"

FOR /L %%A in (1,1,%Elements_Nombre%) do (
    set "%%A_LVL=0"
    if "!%%A_Present!"=="1" (
        if "!element_%%A_SIGN!"=="+" (
            if "!%%A_Disabled!"=="1" (
                if "!%%A_Arret!"=="1" set "%%A_LVL=1"
            )
        )
        REM   Permet les Options 'RÇactiver les TÉches/Services dÇsactivÇs' du menu :RETABLI
        if "!%Elements%_LVL_2!"=="0" if "!%%A_LVL!"=="1" set "%Elements%_LVL_2=1"

        REM   Si ÇlÇment protÇgÇ, on le considäre comme optimisÇ
        if not "!element_%%A_SIGN!"=="+" set "%%A_LVL=1"
        
        REM  Permet d'activer l'option 'DÇsactiver les TÉches/Services dÇsactivÇs' du menu :OPTIM
        if "!%Elements%_LVL!"=="1" if "!%%A_LVL!"=="0" set "%Elements%_LVL=0"
        
    )
    if not "!%%A_Present!"=="1" (
        REM  Si non prÇsent
        set "%%A_LVL=1"
        set "%%A_Arret=1"
        set "%%A_Disabled=1"
    )
)

::  DÇfinition de l'Çtat des Services de la TÇlÇmÇtrie
if "%Elements%"=="Services" (
    if defined Telemetrie_Services_NUM (
        set "Telemetrie_Services_LVL=1"
        for %%A in (%Telemetrie_Services_NUM%) do (
            if "!%%A_LVL!"=="0" set "Telemetrie_Services_LVL=0"
        )
    )
)

::  CREATION DES LISTES
for %%A in (Actif Inactif Actif_NUM Inactif_NUM Actif_TXT Inactif_TXT) do if defined Liste_%Elements%_%%A set "Liste_%Elements%_%%A="

if "%Mode_Test%"=="2" set "Temps_Liste_1=%time:~3%"
if "%Mode_Test%"=="2" call :TEST_10
if "%Mode_Test%"=="2" set "Temps_Liste_2=%time:~3%"

FOR /L %%A in (1,1,%Elements_Nombre%) do (
    if "!%%A_LVL!"=="0" (
        if "!element_%%A_SIGN!"=="+" if "!%%A_Present!"=="1" (
            if defined Liste_%Elements%_Actif_TXT     set "Liste_%Elements%_Actif_TXT=!Liste_%Elements%_Actif_TXT! . !element_%%A_TXT!"
            if not defined Liste_%Elements%_Actif_TXT set "Liste_%Elements%_Actif_TXT=!element_%%A_TXT!"
                    
            if defined Liste_%Elements%_Actif     set "Liste_%Elements%_Actif=!Liste_%Elements%_Actif! !element_%%A!"
            if not defined Liste_%Elements%_Actif set "Liste_%Elements%_Actif=!element_%%A!"
                    
            if defined Liste_%Elements%_Actif_NUM     set "Liste_%Elements%_Actif_NUM=!Liste_%Elements%_Actif_NUM! %%A"
            if not defined Liste_%Elements%_Actif_NUM set "Liste_%Elements%_Actif_NUM=%%A"
        )
    )
    if "!%%A_LVL!"=="1" (
        if "!element_%%A_SIGN!"=="+" if "!%%A_Present!"=="1" (
            if defined Liste_%Elements%_Inactif_TXT     set "Liste_%Elements%_Inactif_TXT=!Liste_%Elements%_Inactif_TXT! . !element_%%A_TXT!"
            if not defined Liste_%Elements%_Inactif_TXT set "Liste_%Elements%_Inactif_TXT=!element_%%A_TXT!"

            if defined Liste_%Elements%_Inactif     set "Liste_%Elements%_Inactif=!Liste_%Elements%_Inactif! !element_%%A!"
            if not defined Liste_%Elements%_Inactif set "Liste_%Elements%_Inactif=!element_%%A!"

            if defined Liste_%Elements%_Inactif_NUM     set "Liste_%Elements%_Inactif_NUM=!Liste_%Elements%_Inactif_NUM! %%A"
            if not defined Liste_%Elements%_Inactif_NUM set "Liste_%Elements%_Inactif_NUM=%%A"
        )
    )
)
if "%Mode_Test%"=="2" set "Temps_Liste_3=%time:~3%"

::  Modifie la liste Elements_Disabled afin d'enlever ceux protÇgÇs par le signe -
if defined Elements_Disabled (
    set "Elements_Disabled_Sans_Sign_Moins="
    for %%N in (%Elements_Disabled%) do (
        set "NUM=!map_%%N!"
        if defined NUM (
            if "%Mode_Test%"=="1" call :TEST_13
            REM   Ce FOR Çvite l'expansion retardÇe imbriquÇe. Transforme !element_!NUM!_SIGN!  en   !element_%%V_SIGN!
            for %%V in (!NUM!) do (
                if "%Mode_Test%"=="1" echo.  *!element_%%V_SIGN!* : element_V_SIGN
                REM   Ajout l'ÇlÇment, si et seleulement si il a un signe +
                if "!element_%%V_SIGN!"=="+" (
                    if not defined Elements_Disabled_Sans_Sign_Moins (
                        set "Elements_Disabled_Sans_Sign_Moins=%%N"
                    ) else (
                        set "Elements_Disabled_Sans_Sign_Moins=!Elements_Disabled_Sans_Sign_Moins! %%N"
                    )
                )
            )
        )
    )
    if "%Mode_Test%"=="1" call :TEST_14
)
::  Effacement des variables temporaires
for %%A in (NUM ERR_QUERY_3 ERR_QUERY_2 ERR_QUERY_1 ERROREVEL Nom_Trouver Tache_Nom) do if defined %%A set "%%A="

if "%Mode_Test%"=="1" call :TEST_15
goto :EOF


:SAVO_ETA
::  Recherche si l'icìne est visible sur le Bureau de Windows
if %compatible% LSS 10 goto :EOF
set "SAVOIR_LVL=0"
set "WL_Savoir=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
set "TYPE_Savoir={2cc5ca98-6485-489a-920e-b3e88a6ccce3}"

::  On regarde la valeur de TYPE_Savoir
for /f "tokens=3" %%A in ('reg query "%WL_Savoir%" /v %TYPE_Savoir% 2^>nul ^| find "REG_"') do set "SAVOIR_LVL=%%A"

::  SÇcurisation si TYPE_Savoir est vide
if not defined SAVOIR_LVL goto :EOF

::  On enläve 0x de TYPE_Savoir
set "SAVOIR_LVL=%SAVOIR_LVL:0x=%"
goto :EOF


:FILI_ETA
::  Etat du filigrane
set "TESTSIGN_LVL=0"
for /f "tokens=2 delims= " %%A in ('bcdedit ^| findstr /i "testsigning"') do (
    if "%%A"=="No"  set "TESTSIGN_LVL=1"
    if "%%A"=="Yes" set "TESTSIGN_LVL=0"
)
goto :EOF


:TELE_ETA
::   Recherche le niveau de la TÇlÇmÇtrie de Windows
set "Telemetrie_Services_TXT=DiagTrack DMwapPushService"
set "Telemetrie_Services=DiagTrack DMwapPushService"
set "Telemetrie_Services_NUM=1 2"

set "Telemetrie_TXT=maximum"
set "Telemetrie_Windows_LVL=0"
set "Telemetrie_TMP=3"
set "WL_Telemetrie=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
set "TYPE_Telemetrie=AllowTelemetry"

::  On regarde la valeur de TYPE_Telemetrie
for /f "tokens=3" %%A in ('reg query "%WL_Telemetrie%" /v "%TYPE_Telemetrie%" 2^>nul ^| find "REG_"') do set "Telemetrie_TMP=%%A"

::  SÇcurisation si TYPE_Telemetrie est vide
if not defined Telemetrie_TMP goto :EOF

::  Suppression de 0x au dÇbut
set "Telemetrie_TMP=%Telemetrie_TMP:0x=%"

if "%Telemetrie_TMP%"=="3"        set "Telemetrie_TXT=maximum"
if "%Telemetrie_TMP%"=="2"        set "Telemetrie_TXT=intermÇdiaire"
if "%Telemetrie_TMP%"=="1"        set "Telemetrie_TXT=intermÇdiaire"
if "%Telemetrie_TMP%"=="0"        set "Telemetrie_TXT=minimum"
if "%Telemetrie_TMP%"=="%Telemetrie_MINI%" set "Telemetrie_TXT=minimum"
if "%Telemetrie_TXT%"=="minimum"  set "Telemetrie_Windows_LVL=1"
goto :EOF


:NAVI_ETA
::  Etat de la tÇlÇmÇtrie des navigateurs

::    FIREFOX
set "WL_Telemetrie_Firefox=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox"
set "TYPE=DisableTelemetry DisableFirefoxStudies DisableDefaultBrowserAgent DisableFeedbackCommands"
set "COUNT=0"
set "Telemetrie_Firefox_LVL=0"

::  Lecture unique du Registre
for /f "tokens=1,3" %%A in ('reg query "%WL_Telemetrie_Firefox%" 2^>nul ^| findstr /i "%TYPE%"') do if "%%B"=="0x1" set /a "COUNT+=1"

::  DÇfinition de l'Çtat de _LVL
if %COUNT% EQU 4 set "Telemetrie_Firefox_LVL=1"

::    CHROME
set "WL_Telemetrie_Chrome=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome"
set "TYPE=MetricsReportingEnabled UrlKeyedAnonymizedDataCollectionEnabled UserFeedbackAllowed"
set "COUNT=0"
set "Telemetrie_Chrome_LVL=0"

::  Lecture unique du Registre
for /f "tokens=1,3" %%A in ('reg query "%WL_Telemetrie_Chrome%" 2^>nul ^| findstr /i "%TYPE%"') do if "%%B"=="0x0" set /a "COUNT+=1"

::  DÇfinition de l'Çtat de _LVL
if %COUNT% EQU 3 set "Telemetrie_Chrome_LVL=1"

::    DÇfinition de 'Telemetrie_Navigateurs_LVL'
set "COUNT=0"
set "Telemetrie_Navigateurs_LVL=0"
FOR %%A in (Firefox Chrome) do if "!Telemetrie_%%A_LVL!"=="1" set /a "COUNT+=1"
if %COUNT% EQU 2 set "Telemetrie_Navigateurs_LVL=1"
set "COUNT="
set "TYPE="
goto :EOF


:HIBE_ETA
::  Etat de l'hibernation
set "HIBERFIL_LVL=0"
if not exist "%SystemDrive%\hiberfil.sys" set "HIBERFIL_LVL=1"
goto :EOF


:HEUR_ETA
::  Recherche si l'heure rÇelle est activÇe sous Windows
set "HEURE_LVL=0"
set "WL_Heure=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
set "TYPE_Heure=RealTimeIsUniversal"

::  On regarde la valeur de RealTimeIsUniversal
for /f "tokens=3" %%A in ('reg query "%WL_Heure%" /v "%TYPE_Heure%" 2^>nul ^| find "REG_"') do set "HEURE_LVL=%%A"

::  SÇcurisation si RealTimeIsUniversal est vide
if not defined HEURE_LVL goto :EOF

::  On enläve 0x de RealTimeIsUniversal
set "HEURE_LVL=%HEURE_LVL:0x=%"
goto :EOF


:TRIM_ETA
::   Permet de connaitre l'Çtat du TRIM
if %compatible% LSS 10 goto :EOF
set "TRIM_TMP=1"
for /f "tokens=4" %%A in ('fsutil behavior query DisableDeleteNotify ^| findstr /i "NTFS"') do set "TRIM_TMP=%%A"
::  Si TRIM_TMP=0 => TRIM activÇ
::  Si TRIM_TMP=1 => TRIM dÇsactivÇ
if "%TRIM_TMP%"=="1" set "TRIM_LVL=0"
if "%TRIM_TMP%"=="0" set "TRIM_LVL=1"
goto :EOF


:REST_ETA
::  Etat de la restauration Systäme
set "RESTOR_LVL=0"
set "RESTOR_TMP_2=0"
set "RESTOR_USED=0"
set "WL=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
set "TYPE=RPSessionInterval"

::  Dans le Registre, on vÇrifie si la Restauration est activÇe = 0x1
for /f "tokens=3" %%A in ('reg query "%WL%" /v %TYPE% 2^>nul ^| find "REG_"') do set "RESTOR_LVL=%%A"

::  On enläve 0x de RESTOR_LVL
set "RESTOR_LVL=%RESTOR_LVL:0x=%"

::  Si Active, si Windows de 7 Ö 10, on va chercher l'espace octroyÇ
::  En anglais : "Maximum Shadow Copy Storage Space: 284 GB (61%)"
if "%RESTOR_LVL%"=="1" (
    if %compatible% LEQ 10 (
        vssadmin list shadowstorage /for=C: > "%temp%\restore.txt" 2>nul
        REM  On rÇcupäre la ligne "Espace maximal..." et isole la valeur en Go
        for /f "tokens=2 delims=:=" %%A in ('findstr /c:"maxim" "%temp%\restore.txt"') do (
            for /f "tokens=1 delims=,.Gg " %%B in ("%%A") do set "RESTOR_TMP_2=%%B"
        )
    )
)

::  Si Active, si Windows 11, on va chercher l'espace octroyÇ
if "%RESTOR_LVL%"=="1" (
    if "%compatible%"=="11" (
        rem  on rÇcupÇre la valeur en hÇxadÇcimal ex : 0x7800 (dÇcimal 30720)
        for /f "tokens=3" %%A in ('reg query "%WL_Restauration_Win11%" /v MaxGlobalSize_UX 2^>nul ^| find "REG_"') do set "RESTOR_TMP_3=%%A"

        rem  si vide, on le dÇfini au minimum soit 1024 Mo (1 Go)
        if "!RESTOR_TMP_3!"==""    set "RESTOR_TMP_3=1024"
        if !RESTOR_TMP_3! LSS 1024 set "RESTOR_TMP_3=1024"

        rem  RESTOR_TMP_2=0x7800/1024
        rem  set /a converti en dÇcimal grace au 0x qui prÇcäde, puis divise par 1024 pour convertir de Mo en Go
        set /a RESTOR_TMP_2=!RESTOR_TMP_3!/1024
    )
)

::  Si Active, on va chercher l'espace utilisÇ
if "%RESTOR_LVL%"=="1" (
    vssadmin list shadowstorage /for=C: > "%temp%\restore_used.txt" 2>nul
    REM  On rÇcupäre la ligne "Espace du volume de stockage de clichÇ instantanÇ utilisÇ" et isole la valeur en Go
    for /f "tokens=2 delims=:=" %%A in ('findstr /c:"utilis" "%temp%\restore_used.txt"') do (
        for /f "tokens=1 delims=,.Gg " %%B in ("%%A") do set "RESTOR_USED=%%B"
    )
)

::  On rÇcupäre la valeur par dÇfaut dÇfinie dans VFS
call :LIRE_PAR "Restauration_Valeur"

::  Validation si au moins Çgal Ö mini en Go
if %RESTOR_TMP_2% GEQ %Restauration_mini% set "RESTOR_LVL=1"

::  Effacement de variables et des fichiers de travail
del "%temp%\restore.txt" >nul 2>&1
del "%temp%\restore_used.txt" >nul 2>&1
set "RESTOR_TMP_3="
set "TYPE="
set "WL="
goto :EOF


:FLEC_ETA
set "WL_Fleche=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"

:: Initialisation  Cas 1 (Absente) par dÇfaut
set "Fleche_Etat=0"

:: Lecture et analyse en une seule passe
for /f "tokens=1,2,*" %%A in ('reg query "%WL_Fleche%" /v 29 2^>nul') do (
    REM  On isole la ligne contenant la clef 29
    if /i "%%A"=="29" (
        REM  Cas 2 La variable %%C est vide
        if "%%C"=="" set "Fleche_Etat=1"
        REM Cas 3 La variable %%C contient des donnÇes
        if not "%%C"=="" set "Fleche_Etat=2"
    )
)
goto :EOF


:AUTO_ETA
::  Recherche si Auto Logon est actif
set "AUTOLOG_LVL=0"
set "AUTOLOG="
call :AUTO_VAR

::  On regarde la valeur de AutoAdminLogon
for /f "tokens=3" %%A in ('reg query "%WL%" /v %TYPE_ETAT% 2^>nul ^| find "REG_"') do set "AUTOLOG=%%A"

::  SÇcurisation si AutoAdminLogon est vide
if not defined AUTOLOG goto :EOF

if "%AUTOLOG%"=="1" set "AUTOLOG_LVL=1"
goto :EOF

::  :::::::::::::::::::::::::::::::::
::       FIN ROUTINES DES ETATS
::  :::::::::::::::::::::::::::::::::


:ARCHMENU
cls
echo.
echo.                                    ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.                                    ≥       ARCHITECTURE  DES  MENUS  DU  SCRIPT       ≥
echo.                                    ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 1. VÇrifications ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 2. Outils ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.  ≥                                                        ≥     ≥                                                        ≥
echo.  ≥  - CHKDSK          - DISM            - SFC             ≥     ≥  - DNS             - Update          - BOOT            ≥
echo.  ≥  - SIGVERIF        - Antivirus       - Anti-Malware    ≥     ≥  - Pilotes         - Restauration                      ≥
echo.  ≥  - RAM                                                 ≥     ≥                                                        ≥
echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 3. Optimisations ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 4. Automatisations ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.  ≥                                                        ≥     ≥                                                        ≥
echo.  ≥  - Icìne Bureau    - Filigrane      - TÇlÇmÇtrie       ≥     ≥  - AutoLogin       - Installation                      ≥
echo.  ≥  - Hibernation     - Horloge        - TRIM             ≥     ≥                                                        ≥
echo.  ≥  - Restauration    - Fläche link    - Services Windows ≥     ≥                                                        ≥
echo.  ≥  - TÉches PlanifiÇes                - Bloat            ≥     ≥                                                        ≥
echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.  ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 5. Nettoyage ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø     ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 6. Informations ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.  ≥                                                        ≥     ≥                                                        ≥
echo.  ≥  - Temporaire      - Clean MGR       - LOGs CBS        ≥     ≥  - Batterie        - Indice Perf     - SMART           ≥
echo.  ≥  - Cache Store     - Win Update      - Spooler         ≥     ≥  - Rapport         - WiFi            - Erreurs Systäme ≥
echo.  ≥  - DNS             - Winsock         - Protocole IP    ≥     ≥                                                        ≥
echo.  ≥  - Cartes rÇseaux                                      ≥     ≥                                                        ≥
echo.  ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ     ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
echo.
echo.                                      [ Appuyez sur une touche pour revenir au menu ]
timeout /t 360 >nul
goto ACCUEIL


:ENTETE
cls
echo.   ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
echo.   ≥      ∑ propos de VFS   ƒ     VÇrification Fichiers Systäme v%versi%   [build %B% %align%   ƒ   par Dagobert_78      ≥
echo.   √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
goto :EOF


:CREDIT_1
setlocal
if "%SOFT_Channel%"=="RC"         set "align=RC%SOFT_Channel_version%]   "
if "%SOFT_Channel%"=="BETA"       set "align=BETA%SOFT_Channel_version%] "
if "%SOFT_Channel%"=="Finale"     set "align=Finale]"
set "B=%SOFT_build%"
call :ENTETE
echo.   ≥  Qu'est-ce que VFS ?                                                                                                ≥
echo.   ≥                                                                                                                     ≥
echo.   ≥  VFS est un outil de maintenance et de vÇrification systäme pour Windows 10 et 11, entiärement en franáais.         ≥
echo.   ≥  Il regroupe en un seul endroit les opÇrations d'entretien les plus utiles, habituellement dispersÇes dans les      ≥
echo.   ≥  menus Windows ou accessibles uniquement en ligne de commande.                                                      ≥
echo.   ≥  Il s'adresse aux utilisateurs qui veulent garder leur systäme en bonne santÇ sans mÇmoriser des commandes complexes≥
echo.   ≥                                                                                                                     ≥
echo.   √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
echo.   ≥                                                                                                                     ≥
echo.   ≥  Ce que VFS fait :                                  Ce que VFS ne fait pas :                                        ≥
echo.   ≥                                                                                                                     ≥
echo.   ≥  - VÇrification et rÇparation des                   - VFS ne modifie rien sans votre confirmation explicite.        ≥
echo.   ≥    fichiers systäme [SFC, DISM, ...]                - Chaque action est prÇcÇdÇe d'une demande de validation.       ≥
echo.   ≥  - VÇrification des signatures de                   - VFS ne collecte aucune donnÇe, ne se connecte Ö aucun         ≥
echo.   ≥    pilotes et de l'intÇgritÇ du dÇmarrage              serveur tiers et ne transmet aucune information.             ≥
echo.   ≥  - Nettoyage des journaux et fichiers temporaires      La seule connexion rÇseau est la vÇrification de mise        ≥
echo.   ≥  - Gestion de la restauration systäme                  Ö jour vers le dÇpìt GitHub de l'auteur [dÇsactivable].      ≥
echo.   ≥  - Optimisation de la tÇlÇmÇtrie,                   - Aucun exÇcutable tiers n'est inclus ni tÇlÇchargÇ,            ≥
echo.   ≥    veille prolongÇe                                                                          hormis Anti-Bloat      ≥
echo.   ≥  - Analyse de la RAM et du SMART                                                                                    ≥
echo.   ≥  - Gestion des profils WiFi                         - Outils systäme utilisÇs                                       ≥
echo.   ≥  - RÇparation de la pile rÇseau                       SFC  DISM  BCDedit  VSSadmin  PowerShell                      ≥
echo.   ≥  - Mise Ö jour auto [BETA / RC / Finale]              Netsh  MRT  Powercfg  Fsutil  Chkdsk  Reg                     ≥
echo.   ≥  - DÇsactivation de Service Windows et TÉches PlanifiÇes                                                            ≥
echo.   ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
choice /c %OYN% /n /t 360 /d R /m "%NBSP%                                            [S]uivant - [R]etour au menu "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="19" goto CREDIT_2
endlocal
goto ACCUEIL

:CREDIT_2
call :ENTETE
echo.   ≥  CompatibilitÇ :                                                                                                    ≥
echo.   ≥  - Systäme       Windows 10 et Windows 11                                                                           ≥
echo.   ≥  - Langue        Franáais  [certaines fonctions requiärent un systäme en franáais]                                  ≥
echo.   ≥  - Droits        Administrateur requis                                                                              ≥
echo.   ≥                                                                                                                     ≥
echo.   √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
echo.   ≥                                                                                                                     ≥
echo.   ≥  Remerciements :                                                                                                    ≥
echo.   ≥  - PowerBatch de Rabusier, avec qui j'ai commencÇ et travaillÇ - http://www.astase.com/                             ≥
echo.   ≥  - La communautÇ francophone de dÇveloppeurs batch, pour ses rÇponses et ses exemples.                              ≥
echo.   ≥  - Tous les utilisateurs et l'IA Claude qui ont signalÇ des bugs ou suggÇrÇ des amÇliorations.                      ≥
echo.   ≥                                                                                                                     ≥
echo.   √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
echo.   ≥                                                                                                                     ≥
echo.   ≥  Mentions lÇgales :                                                                                                 ≥
echo.   ≥  - VFS est un outil gratuit, dÇveloppÇ et maintenu Ö titre personnel par Dagobert_78. Il est distribuÇ tel quel,    ≥
echo.   ≥    sans garantie d'aucune sorte. L'auteur ne saurait àtre tenu responsable des consÇquences d'une utilisation       ≥
echo.   ≥    incorrecte. Toute redistribution ou publication sous un autre nom est soumise Ö l'accord prÇalable de l'auteur.  ≥
echo.   ≥    Sous license MIT comme le veux la philosophie de partage sur Github.                                                                                                                 ≥
echo.   √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
echo.   ≥                                                                                                                     ≥
echo.   ≥  Contact et mises Ö jour   https://github.com/Dagobert-78/VFS                                                       ≥
echo.   ≥  Historique des versions   Accessible depuis le menu principal via "Quoi de neuf"                                   ≥
echo.   ≥                                                                                                                     ≥
echo.   ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
choice /c %OYN% /n /t 360 /d R /m "%NBSP%                                           [P]rÇcÇdent - [R]etour au menu "
set "CHOIX=%ERRORLEVEL%"
if "%CHOIX%"=="17" goto CREDIT_1
endlocal
goto ACCUEIL


:VAR_SOFT
::  Initialisation des variables de fonctionnement
set "WL_VFS=HKEY_CURRENT_USER\Software\Dagobert\VFS"
set "OYN=OYNRABCDEFGHIJKLPQSTUVWXZ0123456789M"
set "CBS=%windir%\Logs\CBS\CBS.log"
for /f "tokens=1 delims= " %%A in ("%SOFT_taille%") do (set "SOFT_taille_ko=%%A")
set "boot=1"

::  Injection dans le registre
reg add "%WL_VFS%" /v Version /t REG_SZ /d "%SOFT_version%" /f >nul
reg add "%WL_VFS%" /v Version_Build /t REG_SZ /d "%SOFT_build%" /f >nul
reg add "%WL_VFS%" /v Version_Channel /t REG_SZ /d "%SOFT_Channel% %SOFT_Channel_version%" /f >nul

::  Texte Ö afficher Ö l'Çcran d'accueil
if "%SOFT_Channel%"=="Finale" (
    set "SCTV=      "
    set "INFO_RELEASE="
)

if "%SOFT_Channel%"=="RC" (
    set "SCTV=%SOFT_Channel% %SOFT_Channel_version%  "
    set "INFO_RELEASE=Version en test, soyez prudent."
)

if "%SOFT_Channel%"=="BETA" (
    set "SCTV=%SOFT_Channel% %SOFT_Channel_version%"
    set "INFO_RELEASE=Version en cours d'Çcriture, soyez EXTR“MEMENT prudent."
)

set "VERSI=%SOFT_version%"

::   Espace insÇcable non supprimÇ par CHOICE
::   Alt+255
set "NBSP=ˇ"

goto :EOF


:LAST_RUN
::   Initialisation des clefs Last_Run si absentes ou vide dans la Base de Registre
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_0=%time:~3%"

::  Mise en variable de tous les Last_Run_xxxx
set "Script_V=SCRIPT_v5.2"
set "Liste_Last_Run=%Script_V% AUTOLOGIN BATTERIE BSOD CHECK_POINT CHECK_POINT_ACTIF CHKDSK"
set "Liste_Last_Run=%Liste_Last_Run% CLEAN_MGR CLEAN_MGR_SET DEBLOAT DEL_CLEAR_DNS DEL_PROTO_IP DEL_SPOOLER DEL_STORE"
set "Liste_Last_Run=%Liste_Last_Run% DEL_WINSOCK DISM DISM_SCAN DISM_CHECK DISM_RESTORE DISM_CLEANUP DISM_ANALYSE"
set "Liste_Last_Run=%Liste_Last_Run% DISM_RESET DRIVERS DNS INDICE LOG MRT RAM RAZ_CARTE_RESEAU SERVICE_UPDATE"
set "Liste_Last_Run=%Liste_Last_Run% SIGVERIF SMART SFC TEMPORAIRE UPDATE UPDATE_SCRIPT WIFI WIN_DEFENDER"
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_1=%time:~3%"

::  Extraction de toutes les clefs Last_Run en une seule requàte registre
set "REG_DUMP=%temp%\VFS_LastRun.txt"
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_2=%time:~3%"

::  Initialisation par dÇfaut avant lecture
for %%K in (%Liste_Last_Run%) do set "Last_Run_%%K="
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_3=%time:~3%"

::  Extraction du registre
reg query "%WL_VFS%" >"%REG_DUMP%" 2>nul
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_4=%time:~3%"

::  cherche en une seule passe et Çcrase [inconnu] si la valeur existe
for /f "tokens=1,3" %%A in ('findstr /i "Last_Run_" "%REG_DUMP%"') do (
    set "NOM=%%A"
    set "NOM=!NOM:Last_Run_=!"
    set "Last_Run_!NOM!=%%B"
)
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_5=%time:~3%"

::  VÇrification si variable vide ou (inconnu)
for %%K in (%Liste_Last_Run%) do (
    if not defined Last_Run_%%K      reg add "%WL_VFS%" /v Last_Run_%%K /t REG_SZ /d "[inconnu]" /f >nul
    if "!Last_Run_%%K!"=="(inconnu)" reg add "%WL_VFS%" /v Last_Run_%%K /t REG_SZ /d "[inconnu]" /f >nul
)
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_6=%time:~3%"

del "%REG_DUMP%" >nul 2>&1
set "REG_DUMP="
set "Liste_Last_Run="
if "%Mode_Test%"=="2" set "TEMPS_Last_Run_7=%time:~3%"
goto :EOF


:REG_PARA
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_0=%time:~3%"
::  Initialisation des clefs paramätres si absentes dans la Base de Registre
reg query "%WL_VFS%" /v Update_Notify >nul 2>&1 || reg add "%WL_VFS%" /v Update_Notify /t REG_SZ /d "1" /f >nul

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_1=%time:~3%"
::  Initialisation de la valeur de la restauration Systäme si absente ou vide dans la Base de Registre
reg query "%WL_VFS%" /v Restauration_Valeur >nul 2>&1 || reg add "%WL_VFS%" /v Restauration_Valeur /t REG_SZ /d "20" /f >nul

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_2=%time:~3%"
::  Fourchette mini-maxi de la valeur de la Restauration Systäme
set "Restauration_mini=5"
set "Restauration_maxi=50"

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_3=%time:~3%"
::  Sous Windows 11, Si absent ou dÇsactivÇ, activation du nouveau panneau et du rÇglage au maxi
if "%compatible%"=="11" set "WL_Restauration_Win11=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Recovery\PITR\Settings"
if "%compatible%"=="11" (
    set /a CALC_MB=%Restauration_maxi%*1024
    reg add "%WL_Restauration_Win11%" /v Active_UX /t REG_DWORD /d "1" /f >nul
    reg query "%WL_Restauration_Win11%" /v MaxGlobalSize_UX >nul 2>&1 || reg add "%WL_Restauration_Win11%" /v MaxGlobalSize_UX /t REG_DWORD /d "!CALC_MB!" /f >nul
)

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_4=%time:~3%"
::  DÇfinition forcÇe entre mini et maxi
call :REST_ETA

::  si Restauration_Valeur est vide ou hors fourchette, on injecte dans le registre
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_5=%time:~3%"
if not defined Restauration_Valeur reg add "%WL_VFS%" /v Restauration_Valeur /t REG_SZ /d "20" /f >nul
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_6=%time:~3%"
if %Restauration_Valeur% LSS %Restauration_mini% reg add "%WL_VFS%" /v Restauration_Valeur /t REG_SZ /d "%Restauration_mini%" /f >nul
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_7=%time:~3%"
if %Restauration_Valeur% GTR %Restauration_maxi% reg add "%WL_VFS%" /v Restauration_Valeur /t REG_SZ /d "%Restauration_maxi%" /f >nul
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_8=%time:~3%"
set "Restauration_Valeur="

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_9=%time:~3%"
::  Si absente, Mise par dÇfaut Ö 3 pour l'accäs aux mises Ö jour
::  3-Finale    2-RC    1-Bàta
reg query "%WL_VFS%" /v Update_Channel_LVL >nul 2>&1 || reg add "%WL_VFS%" /v Update_Channel_LVL /t REG_SZ /d "3" /f >nul

if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_10=%time:~3%"
::  Si absente, Mise par dÇfaut Ö 120 de la temporisation pour InactivitÇ
reg query "%WL_VFS%" /v Tempo_Inactif >nul 2>&1 || reg add "%WL_VFS%" /v Tempo_Inactif /t REG_SZ /d "120" /f >nul
call :LIRE_PAR "Tempo_Inactif"
if "%Mode_Test%"=="2" set "TEMPS_Reg_Para_11=%time:~3%"

::  Variable qui sert dans la page d'accueil et le menu CrÇdit
set "versi=%SOFT_version%"
goto :EOF


:FOLDERS
::  CrÇation de dossier de travail  
if not exist "%APPDATA%\VFS" MD "%APPDATA%\VFS"

::  Effacement des fichiers prÇcÇdemments crÇÇs
del /s /f /q "%APPDATA%\VFS\*.*" >nul 2>&1
goto :EOF


:WINVER
setlocal
::  DÇfinition de la version de Windows
set "WINVER=Windows Inconnu"
set "compatible=0"

::  Extraire la version brute
for /f "tokens=2 delims=[]" %%A in ('ver') do set "VERSTR=%%A"

::  Suppression du mot 'Version '
::   Pour la version franáaise
set "VERSTR=%VERSTR:version =%"
::   Pour la version Anglaise
set "VERSTR=%VERSTR:Version =%"

::  SÇparation version majeure / mineure
for /f "tokens=1,2,3 delims=." %%A in ("%VERSTR%") do (
    set "MAJOR=%%A"
    set "MINOR=%%B"
    set "MINOR2=%%C"
)

::  --- Famille DOS ---
if "%MAJOR%"=="4" (
    if "%MINOR%"=="0"  set "WINVER=Windows 95"
    if "%MINOR%"=="10" set "WINVER=Windows 98"
    if "%MINOR%"=="90" set "WINVER=Windows ME"
)

::  --- Famille NT ---
if "%MAJOR%"=="5" (
    if "%MINOR%"=="0" set "WINVER=Windows 2000"
    if "%MINOR%"=="1" set "WINVER=Windows XP"
    if "%MINOR%"=="2" set "WINVER=Windows XP Professional x64 Edition"
)

if "%MAJOR%"=="6" (
    if "%MINOR%"=="0"                       set "WINVER=Windows Vista"
    if "%MINOR%"=="0" if "%MINOR2%"=="6001" set "WINVER=Windows Vista SP1"
    if "%MINOR%"=="0" if "%MINOR2%"=="6002" set "WINVER=Windows Vista SP2"
    if "%MINOR%"=="1"                       set "WINVER=Windows 7"
    if "%MINOR%"=="1" if "%MINOR2%"=="7601" set "WINVER=Windows 7 SP1"
    if "%MINOR%"=="2"                       set "WINVER=Windows 8"
    if "%MINOR%"=="3"                       set "WINVER=Windows 8.1"
    if "%MINOR%"=="3" if "%MINOR2%"=="9600" set "WINVER=Windows 8.1 Update 1"
)

::   Differencier Windows 10 / 11
::     ne se fait pas berner si migration Win10 => Win11
set "BUILD=0"

for /f "tokens=2,*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber 2^>nul') do (
    set "BUILD=%%B"
)

if "%MAJOR%"=="10" (
    if %BUILD% GEQ 22000 set "WINVER=Windows 11"
    if %BUILD% LSS 22000 set "WINVER=Windows 10"
)

::  DÇfinit le niveau de compatibilitÇ du script Ö partir de Windows 10
if "%MAJOR%"=="6" if "%MINOR%"=="1"     set "compatible=7"
::  if "%MAJOR%"=="6" if %MINOR% GEQ 2  set "compatible=8"
if "%MAJOR%"=="10" if %BUILD% LSS 22000 set "compatible=10"
if "%MAJOR%"=="10" if %BUILD% GEQ 22000 set "compatible=11"
endlocal & set "compatible=%compatible%" & set "WINVER=%WINVER%"
goto :EOF


:EDITION
::  --- DÇfinition du type de Windows --- 
set "EDITION= "
for /f "tokens=2,*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID 2^>nul') do (
    set "EDITION=%%B"
)
::  On profite de la recherche de l'Çdition pour attribuer le niveau de tÇlÇmÇtrie correspondant
if /i "%EDITION%"=="Core"         set "EDITION=Home" && set "Telemetrie_MINI=1"
if /i "%EDITION%"=="Professional" set "EDITION=Pro" &&  set "Telemetrie_MINI=1"
if /i "%EDITION%"=="Enterprise"                         set "Telemetrie_MINI=0"
if /i "%EDITION%"=="Education"                          set "Telemetrie_MINI=0"
goto :EOF


:ARCH
::  DÇtermination de l'architecture en 32 ou 64 bits 
set "ARCH=32-bit"

if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "ARCH=64-bit"
if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "ARCH=64-bit"

if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (
    if defined PROCESSOR_ARCHITEW6432 set "ARCH=64-bit"
)
goto :EOF


:WIN_LANG
::  VÇrification de la langue du systäme
::  Utile pour : WIFI_AFF, WIFI_SAV, REST_ETA

set "WIN_LANG=FR"

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\VFS_Test_Langue_Inexistant" 2>&1 | findstr /i "Erreur" >nul 2>&1
set "ER_Query=%ERRORLEVEL%"
if "%ER_Query%"=="0" goto :EOF

::  Mot ERREUR absent, systäme certainement autre que franáais
set "WIN_LANG=non FR"

::  Peut àtre dÇpendant d'une modification de la langue apräs installation, Ö vÇrifier
::  for /f "tokens=2 delims=-" %%A in ('bcdedit /enum {current} ^| findstr /i "locale"') do set "WIN_LANG=%%A"

set "ER_Query="
goto :EOF


:POWERSH
::   Recherche de powershell
echo.
echo.   Recherche de PowerShell...
set "powershell=1"
for %%# in (powershell.exe) do @if "%%~$PATH:#"=="" set "powershell=0"
::  Autre possibilitÇ Çvitant un Çventuel soucis avec PATH
::  where powershell.exe >nul 2>&1 && set "powershell=1" || set "powershell=0"
if "%powershell%"=="1" (
    echo.                                               OK
    REM  Recherche de la version de PowerShell
    REM  via le registre
    REM  for /f "tokens=3" %%V in ('reg query "HKLM\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine" /v PowerShellVersion 2^>nul ^| find "PowerShellVersion"') do set "PowerShell_Version=%%V"
    REM  Via PS lui-màme
    REM  for /f "tokens=*" %%V in ('powershell -NoProfile -Command "$PSVersionTable.PSVersion.Major"') do set "PowerShell_Version=%%V"
)
if not "%powershell%"=="1" echo.                                               NON OK
goto :EOF


:INTERNET
setlocal
::  Recherche si Internet est OK
echo.
echo.   Recherche d'Internet...
set "internet=0"

ping 1.1.1.1 -n 1 -w 1000 | find "TTL=" >nul
set "ERROR_1=%ERRORLEVEL%"
if "%ERROR_1%"=="0" (
    set "internet=1"
    goto INT_FIN
)
if not "%ERROR_1%"=="0" echo. Impossible d'atteindre 1.1.1.1, tentative de pings de secours.

ping 8.8.8.8 -n 1 -w 2000 | find "TTL=" >nul
set "ERROR_2=%ERRORLEVEL%"
if "%ERROR_2%"=="0" (
    set "internet=1"
    goto INT_FIN
)
if not "%ERROR_2%"=="0" echo. Impossible d'atteindre 8.8.8.8, tentative de pings de secours.

ping github.com -n 1 -w 2000 | find "TTL=" >nul
set "ERROR_3=%ERRORLEVEL%"
if "%ERROR_3%"=="0" set "internet=1"
if not "%ERROR_3%"=="0" echo. Impossible d'atteindre github.com
:INT_FIN
if "%internet%"=="1" echo.                                               OK
if not "%internet%"=="1" (
    echo. Impossible d'atteindre Internet.           Des fonctions seront dÇsactivÇes
    echo.
    echo.                                               INTERNET : NON OK
    timeout /t 3 > nul
)
endlocal & set "internet=%internet%"
goto :EOF


:WMIC
::  Recherche de wmic
set "wmic=0"
where wmic.exe >nul 2>&1 && set "wmic=1"
goto :EOF


:WINGET
::   VÇrifie si Winget est initialisÇ
set "winget=0"
::  where winget.exe >nul 2>&1 && set "winget=1"
::  where winget --version >nul 2>&1 && set "winget=1"
winget --version >nul 2>&1 && set "winget=1"
goto :EOF


:WD_test
::   Recherche de Windows Defender
set "WD=0"
if exist "%ProgramFiles%\Windows Defender\MpCmdRun.exe" set "WD=1"
goto :EOF


:TEXTES
:: Texte Ö afficher si une commande est absente
if "%winget%"=="0"     set "winget_TXT=Winget absent"
if "%internet%"=="0"   set "internet_TXT=Internet absent"
if "%wmic%"=="0"       set "wmic_TXT=WMIC absent"
if "%powershell%"=="0" set "powershell_TXT=PowerShell absent"
if "%compatible%"=="7" set "Info_Compatibilite_Win7=ATTENTION : Certaines fonctions ne sont pas encore testÇes sous Windows 7"
if defined Mode_Test (
    if "%Mode_Test%"=="1" set "Mode_Test_Texte_1=MODE DEBOGAGE ACTIF"
    if "%Mode_Test%"=="2" set "Mode_Test_Texte_1=MODE TEMPS ACTIF   "
)
if not defined Mode_Test set "Mode_Test_Texte_1=                   "
goto :EOF


:HORODATA
setlocal
::    Mise au format de la date et de l'heure
::     Variables utilisÇes
::  data  = AAAA.MM.DD
::  data2 = DD.MM.AAAA
::  horodata = AAAA.MM.DD_HHhMM.SSs

::  On remplace l'espace des heures Ö 1 chiffre, par un 0
set "mytime=%time: =0%"
set "mytime=%mytime:~0,8%"

::  Remaniement du format de la date
::  On prend les 10 derniers caractäres pour Çliminer un Çventuel "mer. "
for /f "tokens=1,2,3 delims=/" %%A in ("%date:~-10%") do (
    set "data=%%C.%%B.%%A"
    set "data2=%%A.%%B.%%C"
)

::  Remaniement du format de date-heure
for /f "tokens=1,2,3 delims=:" %%A in ("%mytime%") do (
    set "horodata=%data%_%%Ah%%B.%%Cs"
)
endlocal & set "data=%data%" & set "data2=%data2%" & set "horodata=%horodata%"
goto :EOF


:BOOT_MAJ
::   Recherche d'une mise Ö jour au dÇmarrage UNE fois par jour
call :LIRE_PAR "Update_Notify"
call :LIRE_DAT
if "%internet%"=="1" (
    if "%Update_Notify%"=="1" (
        if not "%Last_Run_UPDATE_SCRIPT%"=="%data2%" (
            echo.
            echo.   Recherche d'une mise Ö jour...
            timeout /t 0 >nul
            call :VFS_2
        )
    )
)
goto :EOF


:DESKTOP
::     Permet de dÇterminer l'emplacement du dossier "Bureau" dans la variable %DesktopPath%

::   Cette clÇ est obsoläte depuis Windows 2000
::   n'est pas mise Ö jour lorsque l'utilisateur active la synchronisation du Bureau sur Microsoft OneDrive.
::  ∑ vÇrifier 
::  for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Desktop 2^>nul') do set "DesktopPath=%%B"

for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop 2^>nul') do set "DesktopPath=%%B"

:: Forcer la rÇsolution de la variable d'environnement dynamique %USERPROFILE%
call set "DesktopPath=%DesktopPath%"
goto :EOF


:LIRE_PA1
::   ∑ utiliser si plus de 2 paramätres simultanÇment
::     Charge l'ensemble des valeurs de la clÇ en une seule passe
for /f "tokens=1,3*" %%A in ('reg query "%WL_VFS%" 2^>nul ^| find "REG_"') do (
    set "%%A=%%B"
)
goto :EOF


:LIRE_PAR
::   ∑ utiliser jusqu'Ö 2 paramätres simultanÇment, sinon basculer sur :LIRE_PA1
::     RÇcupäre l'info des Paramätres
for %%K in (%~1) do (
    for /f "tokens=3" %%A in ('reg query "%WL_VFS%" /v %%K 2^>nul ^| find "REG_"') do set "%%K=%%A"
)
goto :EOF


:LIRE_DAT
::   Charge toutes les valeurs Last_Run_ en une seule requàte registre
for /f "tokens=1,3*" %%A in ('reg query "%WL_VFS%" 2^>nul ^| findstr /i "Last_Run_"') do (
    set "%%A=%%B"
)
goto :EOF


:MAJ_DATE
::   Met Ö jour l'info des Last_Run
::  On injecte dans le registre
reg add "%WL_VFS%" /v Last_Run_%~1 /t REG_SZ /d "%data2%" /f >nul
::  On met Ö jour la variable
set "Last_Run_%~1=%data2%"
goto :EOF


:CBS_SAVE
set "CBS_SAVE_Erreur="
setlocal
::  Renommage du CBS.log
cls
if not exist "%CBS%" goto :EOF
echo.
echo.  Tentative de sauvegarde du fichier CBS.log...

call :STOP_SVC TrustedInstaller

if "%ERR_Running_TrustedInstaller%"=="1" (
    call :HORODATA
    ren "%CBS%" "CBS_!horodata!.log" 2>nul
    if not exist "%CBS%" (
        cls
        echo.
        echo. Sauvegarde rÇussie du fichier CBS.log
        endlocal
        goto :EOF
    )
)
cls
echo.
echo. Sauvegarde impossible car le fichier est occupÇ.
endlocal
set "CBS_SAVE_Erreur=1"
goto :EOF


:STOP_SVC
::   Permet d'arràter des Services
::  %1 = nom du service
set "ERR_Present_%1=1"
set "ERR_Running_%1=1"

for /L %%B in (1,1,4) do (
    REM  On vÇrifie si le Service est prÇsent
    sc query "%1" >nul 2>&1
    set "ERR_Present_%1=!ERRORLEVEL!"

    if "!ERR_Present_%1!"=="0" (
        sc query "%1" | findstr "RUNNING" >nul
        set "ERR_Running_%1=!ERRORLEVEL!"
        if "!ERR_Running_%1!"=="1" goto :EOF
        net stop "%1" >nul 2>&1
    )
)
goto :EOF


:STRT_SVC
::   Permet de rÇactiver des Services
::  %1 = nom du service
set "ERR_Present_%1=1"
set "ERR_Running_%1=1"

for /L %%B in (1,1,4) do (
    REM  On vÇrifie si le Service est prÇsent
    sc query "%1" >nul 2>&1
    set "ERR_Present_%1=!ERRORLEVEL!"

    if "!ERR_Present_%1!"=="0" (
        sc query "%1" | findstr "RUNNING" >nul
        set "ERR_Running_%1=!ERRORLEVEL!"
        if not "!ERR_Running_%1!"=="1" goto :EOF
        net start "%1" >nul 2>&1
    )
)
goto :EOF


:2ESPACE
::  Permet d'effacer les doubles espaces
::  On rÇcupÇre le paramätre 1
set "variable_a_nettoyer=!%~1!"
if not defined variable_a_nettoyer goto :EOF

::  Effacement des double-espaces, 3x
set "variable_a_nettoyer=!variable_a_nettoyer:  = !"
set "variable_a_nettoyer=!variable_a_nettoyer:  = !"
set "variable_a_nettoyer=!variable_a_nettoyer:  = !"

::  Effacement du premier caractäre si c'est un espace
::   !variable_a_nettoyer:~0,1!   extrait le tout premier caractäre [index 0, longueur 1]
::   if "!variable_a_nettoyer:~0,1!"==" "   vÇrifie si ce caractäre est un espace
::   set "variable_a_nettoyer=!variable_a_nettoyer:~1!"   rÇassigne la variable en ne gardant que
::        ce qui se trouve Ö partir du deuxiäme caractäre [index 1] jusqu'Ö la fin.
if "!variable_a_nettoyer:~0,1!"==" " set "variable_a_nettoyer=!variable_a_nettoyer:~1!"

::  On rÇinjecte le rÇsultat nettoyÇ dans la variable
set "%~1=%variable_a_nettoyer%"
set "variable_a_nettoyer="
goto :EOF


:TIMEOUT1
setlocal
::   Saisie des variables via des arguments
set "VarName=%~1"
set "PromptText=%~2"
set "TimeoutSec=%~3"
set "DefaultVal=%~4"

::  Nettoyage
if exist "%TEMP%\prompt_out.tmp" del "%TEMP%\prompt_out.tmp" >nul 2>&1

:: êchappement des apostrophes pour PowerShell
set "PromptText_PS=%PromptText:'=''%"

powershell -NoProfile -Command ^
    "$t = %TimeoutSec%; $def = '%DefaultVal%'; " ^
    "Write-Host -NoNewline '%PromptText_PS% : '; " ^
    "$res = $def; $sw = [System.Diagnostics.Stopwatch]::StartNew(); " ^
    "while ($sw.Elapsed.TotalSeconds -lt $t) { " ^
    "    if ([Console]::KeyAvailable) { $res = [Console]::ReadLine(); break } " ^
    "    Start-Sleep -Milliseconds 50 " ^
    "}; " ^
    "if ($res -eq $def) { Write-Host $def }; " ^
    "[System.IO.File]::WriteAllText('%TEMP%\prompt_out.tmp', $res)"

set /p "OutVal="<"%TEMP%\prompt_out.tmp"
del "%TEMP%\prompt_out.tmp" >nul 2>&1

::  Exporte la valeur hors du bloc local vers la variable dynamique
endlocal & set "%VarName%=%OutVal%"
exit /b 0


:DL_ERROR
::   Gestion des erreurs de tÇlÇchargement
set "DL_ERREUR=0"

::  Pour Windows 7
if "%compatible%"=="7" (
    if "%DL_ERR%"=="2097175" goto :EOF
    if "%DL_ERR%"=="2097176" goto :EOF
    if "%DL_ERR%"=="-2147012633" (
        echo.
        echo.  Impossible de contacter le serveur ou fichier de mise Ö jour introuvable.
        set "DL_ERREUR=1"
    )
    if "%DL_ERR%"=="-2146762861" (
        echo.
        echo.  Accäs refusÇ par le serveur [erreur 403].
        set "DL_ERREUR=1"
    )
)

::  Pour Windows 10 et 11
if %compatible% GEQ 10 (
    if "%DL_ERR%"=="22" (
        echo.
        echo.  Impossible de contacter le serveur ou fichier de mise Ö jour introuvable.
        set "DL_ERREUR=1"
    )
)

::  Si erreur, on sort avant de tester une erreur de DL gÇnÇrale
if "%DL_ERREUR%"=="1" (
    timeout /t 4 >nul
    goto :EOF
)
       
::  Pour Windows 7, 10 et 11
if not "%DL_ERR%"=="0" (
    echo.
    echo.  Le tÇlÇchargement de la mise Ö jour a ÇchouÇ.
    echo.  VÇrifiez votre connexion Internet et rÇessayez.
    set "DL_ERREUR=1"
)

if "%DL_ERREUR%"=="1" timeout /t 4 >nul
set "DL_ERR="
goto :EOF


:LOADING
::   Affiche un message pour les menus long Ö charger
echo.
echo.     Chargement en cours ...          Veuillez patienter ...
goto :EOF


:QUOI29
::   Menu contenant tout l'historique des changements
setlocal
set "Num_Page_2=23"
set "Num_Page_1=1"
set "Quoi_Page=22"

:QUOI29_2
::   Calcul dynamique de la sous-routine Page 1 -> :QUOI_22, Page 22 -> :QUOI_1
::   22 - 1 + 1 = QUOI22
set /a "Quoi_Page=Num_Page_2 - Num_Page_1 + 1"

if "%Num_Page_1%"=="%Num_Page_2%" (set "TEXTE_1=") else (set "TEXTE_1= - [S] Suivant")
if "%Num_Page_1%"=="1" (set "TEXTE_2=                ") else (set "TEXTE_2=[P] PrÇcÇdent - ")
cls
echo.                                     Modifications apportÇes  [page %Num_Page_1%/%Num_Page_2%]
echo.
call :QUOI_%Quoi_Page%
echo.
choice /c %OYN% /n /t %Tempo_Inactif% /d 0 /m "%NBSP%                                %TEXTE_2%[R] Retour au menu principal%TEXTE_1%"
set "CHOIX=%ERRORLEVEL%"

::  si ce n'est ni S et ni P
if not "%CHOIX%"=="19" (
    if not "%CHOIX%"=="17" (
        endlocal
        goto ACCUEIL
    )
)
if "%CHOIX%"=="19" if %Num_Page_1% LSS %Num_Page_2% set /a Num_Page_1+=1
if "%CHOIX%"=="17" if %Num_Page_1% GTR 1            set /a Num_Page_1-=1

goto QUOI29_2


:QUOI_23
echo. v5.2.3.0 du 01.11.2026 [build 111 - %SOFT_taille% octets]
echo.  + Ajout de la rÇinitialisation des modems
echo.  * Optimisation du prÇ-chargement des xxx_ETA dans le menu Accueil
echo.  * Nettoyage des variables temporaires Ö la fin de COM_ETA
echo.  # BUG de la b103 v2, Affichait le numÇro rÇactivÇ au lieu du nom des Services/TÉches
echo.  # BUG de la b106, qui appelait inutilement l'Çtat de l'hibernation dans l'Çtat de l'heure rÇelle
echo.
echo. v5.2.2.3 du 28.10.2026 [build 110 - 238 363 octets]
echo.  # BUG de la b106, dans la valeur de la TÇlÇmÇtrie Windows
echo.  # BUG de la b102 v1, dans la dÇsactivation de la TÇlÇmÇtrie Windows
echo.
echo. v5.2.2.2 du 27.10.2026 [build 109 - 238 180 octets]
echo.  i PrÇparation Ö la suppression du DNS QUAD9 le 24 novembre 2026     snif
echo.  + Ajout de la dÇtection des DNS, Orange, Free, Bouygues, Gcore DNS, NextDNS, Control D et DNSforge 
echo.  + Ajout des DNS de Control D et DNSforge
echo.  * Isolation par SETLOCAL de WINVER, RESTART  
echo.  # BUG de b108 v2, corrigÇ, empilement des SETLOCAL si inactif dans le choix du mot de passe
echo.  # BUG de b108 v1, corrigÇ, empilement des SETLOCAL si erreur dans SFC
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_22
echo. v5.2.2.1 du 24.10.2026 [build 108 - 235 688 octets]
echo.  + Si CBS ne peut pas àtre sauvegardÇ, on zappe la dÇtection personnalisÇe d'erreur
echo.  * Isolation par SETLOCAL de Quoi29, Horodata, CBSsave, SFC, DISM, Defender, MRT, DNS  
echo.  * Simplification de la routine HORODATA
echo.  * Refonte compläte du systäme de navigation du menu Quoi de Neuf
echo.  # Vieux BUG de b31 jamais dÇclenchÇ, dans HORODATA, sur certains environnements Windows 
echo.  # BUG de la b107, dans DISM, mini-script scindÇ en 2
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_21
echo. v5.2.2.0 du 18.10.2026 [build 107 - 234 118 octets]
echo.  + PossibilitÇ d'effacer toutes traces sauf les sauvegardes des DNS
echo.  + CrÇation d'une routine pour Fermer/Lancer des services temporairement
echo.  + DISM mis en mini-script autonome
echo.  + PrÇsentation personnalisÇe et plus claire des mises Ö jour disponibles dans Winget
echo.  + Installations regroupÇes via Winget et mis en mini script autonome
echo.  * Fermeture automatique du Scan Defender si tout est OK
echo.  * Logiciel Win11 Anti-Bloat mis en mini script autonome
echo.  * Optimisation du menu Informations
echo.  # BUG de b106, corrigÇ, DISM s'exÇcutait une derniäre fois apräs avoir TOUT fait
echo.  # BUG de b103, critique corrigÇ en sortie de l'affichage des clef WiFi
echo.  # BUG de b101, corrigÇ dans :VFS_7, l'optimisateur des mises Ö jour
echo.  # BUG de b106, corrigÇ dans le choix du DNS si inactif
echo.  # BUG de b100, corrigÇ dans :COM0A avec une accumulation de CALL qui peut faire dÇborder la mÇmoire systäme 
echo.  # Vieux BUG possible de b47, si OneDrive dans l'emplacement du dossier "Bureau"
echo.  # Vieux BUG mineur de b32 corrigÇ, effacement des LOG de SFC et DISM moins restrictif
echo.  # Träs vieux BUG de b17, possible et jamais dÇclenchÇ, corrigÇ dans la dÇtection de la version de Windows
echo.  # BUG corrigÇ dans le CALCUL DES xxxx_LVL qui rendait visible l'option 'RÇactiver les tÉches'
echo.  # BUG corrigÇ si trop de points de restauration ont ÇtÇ faits sur une courte pÇriode
echo.  - Enlävement de la gestion du Service ShellHWDetection, car utile pour les disques externes
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_20
echo. v5.2.1.0 du 11.10.2026 [build 106 - 221 120 octets]
echo.  + PossibilitÇ d'annuler l'extraction des pilotes
echo.  + Ajout de la sauvegarde des DNS avant toutes modifications
echo.  * Optimisation de 0.25s de l'accäs aux menus en prÇchargeant les dates
echo.  * Optimisation des menus Paramätres, Informations, Nettoyage et Automatisations
echo.  * Optimisation des menus VÇrifications, Outils, Optimisations et RÇtablissement
echo.  * Optimisation des Last_Run_xxx en mettant Ö jour le registre et la variable 
echo.  * RÇÇcriture de la routine DISM plus courte, plus simple et plus rapide
echo.  - Suppression de lignes de code obsolätes
echo.
echo. v5.2.0.0 du 08.10.2026 [build 105 - 223 710 octets]     [ page 1/2 ]
echo.  + LibÇration du menu cachÇ permettant de sÇlectionner les Services
echo.  + Ajout de la dÇsactivation des TÉches planifiÇes sÇlectionnÇes
echo.  + Ajout du Last_Run du RÇglage de Clean MGR
echo.  + Ajout de la TÇlÇmÇtrie de Firefox et Chrome et de leur Çtat
echo.  + Ajout d'un espace insÇcable dans les CHOICE
echo.  + Ajout de la version du Bàta/RC de Update2.bat, remise car disparue
echo.  + Ajout de la routine de l'Çtat des Services par PowerShell
echo.  + Ajout d'une confirmation avant de rÇinitialiser les cartes rÇseau
echo.  + Ajout de paramätres Ö l'installation de logiciels
echo.  * Mise en routine de la lecture des paramätres
echo.  * Grande rÇÇcriture des routines xxx_ETA de Services et TÉches pour routine commune
echo.  * Optimisation dans le choix de la carte rÇseau, divisÇe par 7 [10,04s Ö 1,27s] 
echo.  * Optimisation dans l'affichage des DNS, divisÇe par 2 
echo.  * Optimisation dans la rÇcupÇration des dates, divisÇe par 4
echo.  * Ne vÇrifie la prÇsence d'une mise Ö jour que 1 fois par jour
goto :EOF

:QUOI_19
echo. v5.2.0.0 du 08.10.2026 [build 105 - 223 710 octets]     [ page 2/2 ]
echo.  * Et on pousse des routines de dÇbut, Ö la fin du script
echo.  * Effacement de messages temporaires pendant la mise Ö jour
echo.  * Chargement des xxx_ETA et des Last_Run seulement si nÇcessaire
echo.  * Optimisation au dÇmarrage sur la routine :LAST_RUN , divisÇe par 4 [1,06s Ö 0,22s] 
echo.  * AmÇlioration et mise sous routine de la sauvegarde de CBS.log
echo.  # BUG corrigÇ dans le nom du Service 22 [WbioSrvc]
echo.  # BUG CorrigÇ x2 dans les mises Ö jour de Bàta Ö Bàta
echo.  # BUG mineur corrigÇ si inactif dans le menu INACTIF
echo.  # BUG CorrigÇ dans les mises Ö jour de Bàta vers RC
echo.  # BUG CorrigÇ dans l'Çtat du SMART 
echo.  # BUG CorrigÇ dans l'affichage des avertissements
echo.  # BUG mineur corrigÇ dans la non analyse des erreurs DISM
echo.  # BUG corrigÇ si ERRORLEVEL de SFC est vide
echo.  # BUG corrigÇ dans ERRORLEVEL de MRT
echo.  # BUG corrigÇ dans le choix de la carte rÇseau si choix vide
echo.  # BUG corrigÇ dans le choix de la carte rÇseau si prÇsence d'espace
echo.  # BUG corrigÇ dans le nom du dossier de sauvegarde des pilotes si prÇsence d'apostrophe
echo.  # BUG corrigÇ si inactif dans le choix du mot de passe
echo.  # BUG corrigÇ si le mot de passe contient ^^, ^&, ^<, ^> ou ^| 
echo.  # BUG corrigÇ si le nom d'utilisateur contient ^& 
echo.  # BUG corrigÇ dans la tentative d'arràt du Service vital RPCSS 
echo.  # BUG corrigÇ dans le nettoyage des variables du menu 'Erreurs Critiques Systäme'
echo.  # BUG corrigÇ si prÇsence d'une apostrophe dans le PowerShell Timeout
echo.  # BUG corrigÇ dans la mise Ö jour de la date du point de restauration
echo.  # BUG CorrigÇ dans les mises Ö jour de RC vers RC sous canal Finale
goto :EOF

:QUOI_18
echo. v5.1.0.0 du 31.08.2026 [build 96 - 183 202 octets]
echo.  + Affiche clairement la version Bàta ou RC dans la page d'accueil
echo.  + Ajout d'un menu cachÇ pour sÇlectionner les Services Ö couper ou non
echo.  + VÇrification de l'arràt des Services dans toutes les routines
echo.  + Affichage de la liste des Services Windows pris en charge
echo.  + Utilisation de PowerShell pour mettre l'inactivitÇ oó CHOICE est impossible
echo.  + PossibilitÇ de voir ce qu'apporte une mise Ö jour avant de l'appliquer
echo.  + Ajout du Check Somme SHA256 sur la mise Ö jour
echo.  + Ajout du menu pour dÇsactiver/rÇactiver 23 Services Windows
echo.  + PossibilitÇ d'annuler avant la rÇactivation des Services
echo.  + DÇtecte si un Service est prÇsent
echo.  + Fermeture automatique de MRT si pas de menace dÇtectÇe
echo.  * DMwapPushService mis dans la TÇlÇmÇtrie
echo.  * PAUSE changÇes en TIMEOUT afin de gÇrer une inactivitÇ
echo.  * Mise en boucle l'arràt des services du nettoyeur de Spooler
echo.  * Mise en routine du nettoyage des variables
echo.  * Utilisation massive de IF [NOT] DEFINED
echo.  * Usage limitÇ des comparateurs numÇriques EQU et NEQ
echo.  * Simplification de la routine :DISM_0
echo.  * Multiples corrections orthographiques
echo.  * Passage en OEM 850 pour une gestion grave meilleure des accents
echo.  * Gestion grandement amÇliorÇe dans les caractäres spÇciaux et accent pour l'auto-Login
echo.  # Bug corrigÇ dans l'inactivitÇ, dans certaines routines, si retour dans le script
echo.  # Bug corrigÇ dans les ERRORLEVEL Ö rÇpÇtition dans :SPOOLER0, :RESTOR et :VFS_2
echo.  # Bug corrigÇ, Windows 7, dans le choix des commandes DISM
echo.  # 11 autres Bugs corrigÇs un peu partout, sacrÇ taf de dÇbugage
goto :EOF

:QUOI_17
echo. v5.0.3.0 du 18.08.2026 [build 90 - 158 058 octets]
echo.  + Ajout de la dÇsactivation du service DiagTrack [tÇlÇmÇtrie]
echo.
echo. v5.0.2.0 du 18.08.2026 [build 89 - 156 609 octets]
echo.  + Ajout de la suppression de la fläche des raccourcis
echo.  * CrÇation d'un menu de redÇmarrage dÇdiÇ
echo.  # BUG corrigÇ, Windows 11, si le nouveau panneau de la restauration n'est pas actif
echo.
echo. v5.0.1.3 du 15.08.2026 [build 88 - 153 933 octets]
echo.  * Meilleure gestion et information sur la Restauration Systäme 
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_16
echo. v5.0.1.2 du 15.08.2026 [build 87 - 151 463 octets]
echo.  + Ajout d'informations supplÇmentaires dans le SMART
echo.  + Ajout d'un message pour les menus long Ö charger
echo.  # Windows 7, meilleure compatibilitÇ sur la restauration Systäme, le SMART, et l'indice de Perf
echo.  # BUG corrigÇ dans le maintien du rÇglage de la Restauration Systäme sous Windows 11
echo.  # BUG corrigÇ, en prÇvision, sur la gestion des versions en pur numÇrique si plus de 1 chiffre  [ex : 5.10.0.0]
echo.
echo. v5.0.1.1 du 09.08.2026 [build 86 - 147 304 octets]
echo.  * Au dÇmarrage, Temps d'initialisation des Last_Run_xxx divisÇ par 25 [ex : 2,42s Ö 0,09s]
echo.
echo. v5.0.1.0 du 09.08.2026 [build 85 - 146 607 octets]
echo.  + Ajout d'un compteur de scan pour SFC et DISM
echo.  + Ajout de Clean MGR et de son paramÇtrage
echo.  + Ajout du rÇglage du temps de l'inactivitÇ avant fermeture automatique du script
echo.  * Restauration systäme en Go, imposÇ par Windows 11 maxi 50 Go
echo.
echo. v5.0.0.1 du 08.08.2026 [build 84 - 141 281 octets]
echo.  + Ajout du menu CrÇdit
echo.  + Passage au canal Final si update depuis une BÇta ou RC vers une finale
echo.  + Gestion des erreurs de tÇlÇchargements sous Windows 7, 10 et 11 sous routine
echo.  + Affiche si des commandes sont non fonctionnelles
echo.  * DÇplacement des fichiers de travail, mini-script, pour les protÇger du nettoyage
echo.  i Test en cours sous Windows 7 SP1 
echo.  # BUG d'affichage corrigÇ si dÇfaut de tÇlÇchargement
echo.
echo.
goto :EOF

:QUOI_15
echo. v5.0.0.0 du 22.07.2026 [build 83 - 127 842 octets] Finale     [ page 1/3 ]
echo.  + Ajout de la RÇinitialisation du catalogue Winsock
echo.  + Ajout de la RÇinitialisation du protocole IP
echo.  + Ajout de l'analyse des Erreurs Critiques Systäme BSOD
echo.  + Ajout de l'analyse avec Windows Defender
echo.  + Ajout de l'analyse des barrettes de RAM
echo.  + Ajout de l'analyse des Malwares [MRT]
echo.  + RÇinitialisation compläte des cartes rÇseaux
echo.  + Activation et rÇglage possible de la Restauration Systäme
echo.  + Ajout de la crÇation d'un Point de Restauration Systäme
echo.  + Pour tous ces ajouts, un Last_Run leur est attribuÇ
echo.  + Ajout du Last_Run de la vÇrif de mise Ö jour du script
echo.  + Ajout du Last_Run pour chacun des DISM
echo.  + Ajout du canal de mise Ö jour Finale, RC et Bàta
echo.  + Ajout de la taille du script
echo.  + Ajout d'une confirmation avant d'effacer le registre
echo.  + Ajout de la variable OYN pour Çtendre les choix non prioritaires
echo.  + Ajout d'une tempo sur les CHOICE
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_14
echo. v5.0.0.0 du 22.07.2026 [build 83 - 127 842 octets] Finale     [ page 2/3 ]
echo.  + Ajout de l'extraction des clef WiFi avec les Pilotes
echo.  + Confirmation avant dÇsactivation du TRIM et de la restauration systäme
echo.  + Fermeture automatique du script en cas d'inactivitÇ
echo.  + Affiche le nombre ou l'absence de clef Wifi
echo.  + Affiche l'absence de carte rÇseau dans les DNS
echo.  * ReprÇsentation de l'architecture complätement revue
echo.  * AmÇlioration esthÇtique des bordures 
echo.  * Multiples corrections orthographiques
echo.  * Mise Ö jour du fichier de VFS_update.bat qui devient VFS_update2.bat
echo.  * Simplification de la gestion des variables de mise Ö jour
echo.  * Mise en routine de Last_Run
echo.  * Divers amÇliorations esthÇtiques et pratiques mineures
echo.  * Harmonisation de variables xxx_LVL , xxx_TMP et xxx_TXT
echo.  * Mise Ö jour du Last_Run Ö la fin de certains mini script
echo.  * Mises Ö jour tiers, sigverif et RESTART sous mini script
echo.  * Remaniement du code sources pour ordonner les routines
echo.  * Divers modifications mineures un peu partout
echo.  * Demande des droits administrateurs au tout dÇbut, gain de temps au dÇmarrage
echo.  # BUGs Çventuels ÇvitÇs, remplacement de plusieurs CALL par GOTO
echo.  # BUG corrigÇ dans certain CHOICE
echo.  # BUG corrigÇ dans le Battery Report si batterie HS
echo.  # BUG d'affichage furtif corrigÇ au lancement du script
echo.  # BUG Internet peut àtre valide dans certains cas
echo.
echo.
goto :EOF

:QUOI_13
echo. v5.0.0.0 du 22.07.2026 [build 83 - 127 842 octets] Finale     [ page 3/3 ]
echo.  # BUG d'affichage corrigÇ dans le Last_Run du DNS
echo.  # BUG Fatal corrigÇ si pas Internet en cherchant une mise Ö jour
echo.  # BUGs multiples corrigÇs dans les mises Ö jour
echo.  # BUG corrigÇ en dÇtectant la langue systäme et en limitant des fonctions.
echo.  # BUG corrigÇ si Windows n'est pas sur le lecteur C:
echo.  # BUG Fatal corrigÇ dans avec certaines parenthäses textuelles
echo.  # BUG corrigÇ dans :SPOOLER1
echo.  # BUG Fatal corrigÇ si UPDATE2.bat est introuvable
echo.  # BUG corrigÇ dans la mise par dÇfaut de l'Çtat du filigrane
echo.  # BUG corrigÇ en proposant l'optimisation si des Çtats sont inconnus
echo.  # BUG d'affichage corrigÇ dans le menu Optimisations
echo.  # BUG corrigÇ dans l'activation de la restauration systäme si dÇjÖ infÇrieure Ö 25%% 
echo.  # BUG de comportement mineur corrigÇ Ö la fin du nettoyage du Spooler
echo.  # BUG de comportement corrigÇ lors des Mise Ö jour tiers apräs installation si pas Internet
echo.  # BUG corrigÇ dans la crÇation d'un Point Systäme si la restauration est dÇsactivÇe
echo.
echo. v4.8.2.5 du 09.08.2026 [build 68 - 93 267 octets]
echo.  + Ajout d'une confirmation avant d'effacer le registre
echo.  + Affiche le nombre ou l'absence de clef Wifi
echo.  + Affiche l'absence de carte rÇseau dans les DNS
echo.  + Meilleur affichage de l'Çtat de l'initialisation au dÇmarrage du script
echo.  * Demande des droits administrateurs au tout dÇbut, gain de temps au dÇmarrage
echo.  * Mise Ö jour du Last_Run en fin des routines
echo.  # BUG corrigÇ si Last_Run est vide ou sous parenthäses
echo.  # BUG corrigÇ dans l'activation de l'Autologin 
goto :EOF

:QUOI_12
echo. v4.8.2.4 du 09.07.2026 [build 67 - 90 575 octets]
echo.  + Ajout de l'info taille du script dans les mises Ö jour
echo.  # BUG corrigÇ en dÇtectant la langue systäme et en limitant des fonctions
echo.  # BUG corrigÇ si Windows n'est pas sur le lecteur C:
echo.  # BUG Fatal corrigÇ dans avec certaines parenthäses textuelles
echo.  # BUG corrigÇ dans :SPOOLER1
echo.  # BUG corrigÇ dans la mise par dÇfaut de l'Çtat du filigrane
echo.  # BUG corrigÇ en proposant l'optimisation si son Çtat est inconnu
echo.  # BUG corrigÇ dans Tout optimiser
echo.  # BUG corrigÇ dans l'Çtat de l'hibernation
echo.
echo. v4.8.2.3 du 25.06.2026 [build 66 - 89 653 octets]
echo.  + Ajout de la taille du script
echo.  * AmÇlioration esthÇtique des bordures 
echo.  # BUG corrigÇ dans les CHOICE de :SFC_STA1 et :SFC_STA2
echo.  # BUG Fatal corrigÇ si pas Internet en cherchant une mise Ö jour
echo.  # BUG corrigÇ dans le Battery Report si batterie HS
echo.  # BUG Internet peut àtre valide dans certains cas
echo.  # BUG d'affichage corrigÇ dans le Last_Run du DNS
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_11
echo. v4.8.2.2 du 10.06.2026 [build 65 - 88 980 octets]
echo.  * Effacement des fichiers de travail
echo.  # BUG critique corrigÇ si VFS_update.bat n'existe pas sur le serveur
echo.
echo. v4.8.2.1 du 08.06.2026 [build 64 - 88 036 octets]
echo.  + Gestion des erreurs dans CHKDSK
echo.  + Indique le niveau d'importance de la mise Ö jour 
echo.  * Gestion intelligente des Builds lors de la mise Ö jour
echo.  * Meilleure mise en valeur des mises Ö jour
echo.  * Par dÇfaut, n'affiche que la premiäre page du Quoi De Neuf 
echo.
echo. v4.8.2.0 du 07.06.2026 [build 63 - 86 381 octets]
echo.  + PossibilitÇ de forcer la mise Ö jour
echo.  + Gestion des erreurs dans les tÇlÇchargements de la mise Ö jour
echo.  * Fermeture du Store apräs le vidage de son cache
echo.  # BUG corrigÇ dans la Suppression du cache du Store de Windows
echo.  # BUG corrigÇ dans Suppression des fichiers du spooler
echo.  # BUG possible corrigÇ dans :WINGET
echo.  # BUG corrigÇ dans :WIFI_AFF en cas de clef vide
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_10
echo. v4.8.1.0 du 04.06.2026 [build 61 - 85 016 octets]
echo.  + PossibilitÇ de seulement supprimer le cache des DNS, avec son Last_Run
echo.  + DÇtection de la non sÇlection d'une carte rÇseau dans le menu DNS
echo.  * Modification de TrustedInstaller pour limiter les messages d'erreur
echo.  * LÇger Çlargissement de la fenàtre
echo.  * PossibilitÇ de remettre par dÇfaut une carte rÇseau prÇcise
echo.  * Ajout de l'info - Mise Ö jour terminÇe
echo.  * Optimisation des boucles HORO et DATA
echo.  * Utilisation intelligente de LEQ 2
echo.  i Nettoyage de lignes de code obsolätes
echo.
echo. v4.8.0.1 du 03.06.2026 [build 57 - 82 638 octets]
echo.  + Ajout de commentaires
echo.  * Divers remaniements esthÇtiques
echo.  * Mise Ö jour du script sans la vÇrif PowerShell
echo.
echo. v4.8.0.0 du 31.05.2026 [build 56 - 81 343 octets]
echo.  + Ajout du nettoyage du Spooler d'impression
echo.  + Mise en place d'un menu dÇdiÇ au script
echo.  + DÇtection d'une mise Ö jour disponible
echo.  + TÇlÇchargement et Mise Ö jour fonctionnels
echo.
echo. v4.7.1.1 du 25.05.2026 [build 52 - 74 194 octets]
echo.  # BUG corrigÇ dans certains Last_Run si inconnu
echo.
echo.
goto :EOF

:QUOI_9
echo. v4.7.1.0 du 24.05.2026 [build 51 - 73 889 octets]
echo.  + Ajout du Wifi et ses clefs
echo.
echo. v4.7.0.1 du 24.05.2026 [build 50 - 71 150 octets]
echo.  * Divers amÇliorations esthÇtiques
echo.  # BUG d'information corrigÇ dans Tous Optimiser
echo.
echo. v4.7.0.0 du 17.05.2026 [build 49 - 70 412 octets]
echo.  + Mise Ö jour des logiciels Ö la fin du menu Installation
echo.  + Ajout du menu Nettoyage
echo.  + Ajout de l'architecture des Menus
echo.  + Ajout de la date pour l'AutoLogin
echo.  + Suppression du dossier des pilotes si compressÇ
echo.  * Divers optimisations
echo.  * Fermeture du service de CBS avant d'effacer les fichiers
echo.  * PrÇfÇrence de DISM plutìt que Export-Driver
echo.
echo. v4.6.0.0 du 14.05.2026 [build 48 - 65 370 octets]
echo.  + Ajout de la rÇsolution de la fenàtre
echo.  + Ajout de l'extracteur complet des pilotes
echo.  + PossibilitÇ de compresser le dossier des pilotes avec PowerShell
echo.  + Ajout de la dÇtection de WINGET
echo.  + Ajout de la date pour le DNS
echo.  * Besoin de Winget pour utiliser Bloat
echo.  * AmÇlioration esthÇtique de DISM en rafales
echo.
goto :EOF

:QUOI_8
echo. v4.5.1.0 du 14.05.2026 [build 46 - 62 092 octets]
echo.  + Ajout de l'utilisation de PowerShell si WMIC est absent
echo.  * P'tite modif dans la gestion de Last_Run, pratique si on ferme le script sauvagement.
echo.       
echo.
echo. v4.5.0.0 du 06.05.2026 [build 44 - 61 071 octets]
echo.  + Ajout des dates de lancement, premiäre utilisation du registre
echo.  # BUG corrigÇ dans :DISM_0
echo.
echo.
echo. v4.4.4.0 du 24.03.2026 [build 41 - 56 432 octets]
echo.  + Ajout du menu Informations systämes
echo.    + rapport sur la batterie
echo.    + indice de performance [avec PowerShell] 
echo.    + Çtat du SMART 
echo.    + rapport systäme 
echo.    i Çtat du TRIM si inactif
echo.  + possibilitÇ de lancer tous les DISM d'un coup
echo.  + Ajout du TRIM
echo.  * Divers amÇliorations de lecture
echo.  # Commande DISM en doublon 
echo.
echo.
echo.
echo.
echo.
goto :EOF

:QUOI_7
echo. v4.4.2.0 du 14.03.2026 [build 36 - 50 042 octets]
echo.  + Ajout de l'effacement des fichiers temporaires
echo.  + Ajout d'une commande pour DISM
echo.  + Ajout de commandes pour redÇmarrer le PC
echo.
echo.
echo. v4.4.1.1 du 14.03.2026 [build 35 - 48 086 octets]
echo.  + Ajout de la dÇtection des sous versions de Windows
echo.  # BUG corrigÇ dans la dÇtection autre que Windows 10/11
echo.
echo.
echo. v4.4.3.0 du 20.03.2026 [build 40 - 52 261 octets]
echo.  i Utilisation de l'IA Claude Sonnet 4.6 pour Corriger/AmÇliorer
echo.  + Ajout du menu installation de 13 logiciels
echo.  * AmÇlioration en rapiditÇ du test Internet
echo.  * Simplification dans le choix de certaines Çditions de Windows
echo.  * Ajout d'un timeout dans l'activation de la veille prolongÇe
echo.  * LÇgäre simplification du menu du choix du DNS
echo.  * Suppression d'une redondance dans la dÇtection du DNS SFR
echo.  * PossibilitÇ de ne pas faire dÇfiler tout le menu Quoi De neuf 
echo.  * Remaniement du menu Quoi de Neuf
echo.  # BUG corrigÇ dans FILIG
echo.  # BUG corrigÇ dans TELE_INJ sur le nouvel Çtat [mini et maxi] 
echo.  # BUG corrigÇ double utilisation de la variable BUILD
echo.
echo.
goto :EOF

:QUOI_6
echo. v4.4.1.0 du 11.03.2026 [build 34 - 47 492 octets]
echo.  * LÇgäre mise en page des options d'optimisation
echo.  * Divers amÇliorations de lecture dans INTERNET
echo.  * Suppression de Filigrane plutìt que de le mettre en ON
echo.  - On dÇgage la variable 'dispar'
echo.  # BUG corrigÇ dans Filigrane
echo.
echo. v4.4.0.0 du 09.03.2026 [build 33 - 46 678 octets]
echo.  + Ajout d'un menu pour rÇtablir les optimisations
echo.  + Ajout de l'option "Affichage de l'heure rÇelle" sous Windows
echo.  + Choix intelligent des options dans le menu Optimisation
echo.  * Remaniement de l'option sur l'icìne "En savoir plus" du Bureau
echo.  - Suppression du Menu de la Veille prolongÇe, mais option toujours disponible
echo.  - Suppression du Menu du Filigrane, mais option toujours disponible
echo.
echo. v4.3.5.0 du 01.03.2026 [build 32 - 41 084 octets]
echo.  + Ajout d'une dÇtection d'erreur rÇparÇe dans SFC
echo.  + PossibilitÇ d'effacer les LOG de SFC et DISM
echo.
echo. v4.3.4.0 du 09.02.2026 [build 31 - 40 560 octets]
echo.  + Ajout d'un menu DISM
echo.  + Ajout du DISM du magasin de composants
echo.  * Renomme CBS.log en usant de la date et l'heure
echo.  # Nettoyage de CHOIX avant chaque menu
echo.
echo.
goto :EOF

:QUOI_5
echo. v4.3.3.1 du 06.02.2026 [build 30 - 37 740 octets]
echo.  * Nettoyage d'anciennes lignes de codes obsolätes
echo.  # BUG corrigÇ dans SFC sur ERRORLEVEL
echo.
echo. v4.3.3.0 du 03.02.2026 [build 29 - 37 353 octets]
echo.  + PossibilitÇ de simplement dÇsactiver l'auto-LogIn
echo.
echo. v4.3.2.1 du 03.02.2026 [build 28 - 36 355 octets]
echo.  * Corrections de fautes de frappe dans les textes
echo.  # BUG corrigÇ dans la gestion des erreurs de DISM
echo.  # BUG corrigÇ dans l'Çtat de AutoLogIn
echo.
echo. v4.3.2.0 du 03.02.2026 [build 27 - 35 973 octets]
echo.  * Refonte compläte du menu CHKDSK
echo.      + DÇtection des partitions inexistantes
echo.      + Limitation au choix du lecteur  
echo.      + PossibilitÇ de faire un scan approfondi  
echo.      + PossibilitÇ de scanner tous les lecteurs  
echo.  * Divers amÇliorations de lecture
echo.
echo. v4.3.1.1 du 03.02.2026 [build 26 - 33 965 octets]
echo.  + Ajout d'une pause apräs la vÇrification des mises Ö jour dispo
echo.  * Divers amÇliorations de lecture
echo.
echo.
echo.
goto :EOF

:QUOI_4
echo. v4.3.1 du 02.02.2026 [build 25 - 33 512 octets]
echo.  + Ajout du menu Automatisations
echo.  + Ajout de l'auto-LogIn au dÇmarrage du PC
echo.  * Divers amÇliorations de lecture
echo.
echo. v4.3.0 du 31.01.2026 [build 23 - 27 050 octets]
echo.  * Nouvelle faáon de faire les Menus pour Çviter des bugs avec "
echo.
echo. v4.2.0 du 27.01.2026 [build 22 - 26 825 octets]
echo.  * Nouvelle gestion d'erreur dans SFC - Ö tester sur des erreurs
echo.  + Ajout gestion d'erreur dans DISM - Ö tester sur des erreurs
echo.  * Divers amÇliorations de lecture
echo.
echo. v4.1.4 du 23.01.2026 [build 21 - 24 742 octets]
echo.  * Nouvelle gestion d'erreur dans SFC - ne fonctionnait pas tout le temps
echo.  # Bug d'affichage corrigÇ dans le 3e test internet
echo.
echo. v4.1.3 du 21.01.2026 [build 20 - 22 816 octets]
echo.  + Ajout de la gestion d'erreur dans SFC - NE FONCTIONNE PAS
echo.  + Ajout du menu Quoi De Neuf
echo.
echo. v4.1.2 du 17-01-2026 [build 19 - 18 074 octets]
echo.  + Ajout de la vÇrification des Signatures NumÇriques [sigverif]
echo.
echo. v4.1.1 du 17-01-2026 [build 18 - 17 936 octets]
echo.  + Ajout de l'erreur n12
goto :EOF

:QUOI_3
echo. v4.1.0 du 17-01-2026 [build 17 - 17 620 octets]
echo.  + Ajout de la dÇtection de la version de Windows
echo.  * Mise en routine des checks PowerShell, Internet et de la version de Windows
echo.  * Mise en variable de la tÇlÇmÇtrie en fonction de l'Çdition du Windows
echo.  * Anti bug sur TOUS les commentaires
echo.
echo. v4.0.0 du 15-01-2026 [build 16 - 15 183 octets]
echo.  + êclatage des menus en 3 catÇgories
echo.  + Ajout de la gestion d'erreur pour le Filigrane
echo.  * Affiche l'Çtat de PowerShell et de Internet dans les vÇrifications initiales
echo.  * Anti bug sur tous les IF
echo.  * Anti bug sur certains commentaires
echo.  - Enlävement de la barre de progression
echo.
echo. v3.5.2 du 15-01-2026 [build 15 - 13 636 octets]
echo.  * VÇrifie si PowerShell existe avant de proposer Win11Debloat
echo.
echo. v3.5.1 du 15-01-2026 [build 14 - 13 590 octets]
echo.  + Ajout du menu TÇlÇmÇtrie
echo.
echo. v3.5.0 du 15-01-2026 [build 13 - 13 204 octets]
echo.  + VÇrification de la prÇsence d'Internet
echo.  + Ajout du script de Win11Debloat
echo.  * ContinuitÇ dans l'exÇcution des DISM
echo.
echo.
goto :EOF

:QUOI_2
echo. v3.4.1 du 14-01-2026 [build 12 - 12 322 octets]
echo.  + VÇrification de l'existence de PowerShell
echo.
echo. v3.4.0 du 13-01-2026 [build 11 - 11 946 octets]
echo.  + Ajout du menu des mises Ö jour 'winget update'
echo.  + Ajout d'un avertissement dans Filigrane
echo.  + Affiche nativement l'Çtat des DNS dans le menu.
echo.  + Affiche nativement l'Çtat de l'hibernation dans le menu
echo.  + Ajout de commentaires
echo.  * Multiples corrections dans l'utilisation de ECHO
echo.  * Divers amÇliorations de lecture
echo.  * Plus grande gÇnÇralisation de la variable 'dispar'
echo.
echo. v3.3.1 du 13-01-2026 [build 09 - 9 849 octets]
echo.  * GÇnÇralisation de l'utilisation de la variable 'dispar'
echo.
echo. v3.3.0 du 13-01-2026 [build 08 - 9 993 octets]
echo.  + Ajout du menu Filigrane
echo.  + Ajout, proposition d'effacer le cache DNS
echo.  * Version sous variable
echo.  # Bug dans la routine PROGRESS
echo.
echo. v3.2.0 du 08-01-2026 [build 07 - 8 762 octets]
echo.  + Ajout du menu des DNS
echo.  * Simplification de la barre de progression
echo.  # Effacement des confnet avant chaque menu
goto :EOF

:QUOI_1
echo. v3.1.0 du 07-01-2026 [build 06 - 4 438 octets]
echo.  + Ajout de 'En savoir plus sur cette image'
echo.  + Ajout d'une barre de progression
echo.  * Mise en place de timeout plutìt que de PAUSE
echo.  * Divers amÇliorations de lecture
echo.
echo. v3.0.0 du 07-01-2026 [build 05 - 3 138 octets]
echo.  + Mise en place d'un menu
echo.  + Ajout de CHKDSK
echo.
echo. v2.5.0 du 07-01-2026 [build 04 - 2 301 octets]
echo.  + RÇcupÇration automatique des Droits administrateurs
echo.
echo. v2.0.0 du 04-01-2026 [build 03 - 1 778 octets]
echo.  + Ajout de la gestion de la veille ProlongÇe
echo.  * Divers amÇliorations de lecture
echo.
echo. v1.5.0 du 04-01-2026 [build 02 - 867 octets]
echo.  + PossibilitÇ de relancer SFC si erreurs rencontrÇes
echo.
echo. v1.0.0 du 01-01-2026 [build 01]
echo.  * Premiäre version incluant SFC et DISM
echo.
echo.
echo.
echo.
goto :EOF


:ERREUR_A
cls
echo.
echo.
echo.
echo.     ***************   ERREUR n12   ****************
echo.
echo.
echo.      Script non compatible avec %WINVER% [%VERSTR%]
echo.                       
echo.
echo.
timeout /t 6 >nul
goto FIN


:FIN_INAC
setlocal
cls
echo.
for /L %%A in (10,-1,0) do (
    if %%A GEQ 10             set "seconde=secondes ≥"
    if %%A GEQ 2 if %%A LEQ 9 set "seconde=secondes  ≥"
    if %%A LEQ 1              set "seconde=seconde   ≥"
    cls
    echo.
    echo.              ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    echo.              ≥  Fermeture du script pour inactivitÇ dans %%A !seconde!
    echo.              ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
    echo.
    choice /c AB /n /t 1 /d B /m "%NBSP%- Appuyez sur 'A' pour ne pas quitter..."
    set "CHOIX=!ERRORLEVEL!"
    if "!CHOIX!"=="1" (
        endlocal
        goto :EOF
    )
)
endlocal
:FIN
echo.
echo.                                ***************   FIN DU SCRIPT   ****************
echo.                                                                                         Au revoir...
timeout /t 3 >nul
:FIN_2
::  Effacement des fichiers de travail
del /s /f /q "%APPDATA%\VFS\*.*" >nul 2>&1
exit
