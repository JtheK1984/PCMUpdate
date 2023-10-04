# Projekt: 
  PCMUpdate.exe

# Kurzbeschreibung
  Applikation zum Aktualisieren der Datenbank

# Entwicklungsumgebung:
  DELPHI 11.3 Alexandria

# Entwickler:
  Jens Henske
	
# Abhängigkeiten zu folgenden Units und Formularen:
  - PCM.Functions.pas
  (Dokumentaion:
  [Azure DevOps](https://3e0h2cz1k1ji0ttu.myfritz.net:4443/PCM-DEV/PCMFunctions)
  [GitHub](https://github.com/JtheK1984/PCMFunctions))

# Abhängigkeiten zu folgenden DLL's :
  - 32-Bit 
    - libmysql.dll (DLL für Verbindung zur MySQL-Datenbank)

# Erforderliche Komponenten (DELPHI-IDE)
  - Devexpress
	
# Erforderliche Scripte (nur für die Buildpipelines in Azure DevOps): 
  - PrepareBuild.cmd (Umgebungsvariablen für Delphi anpassen, wird für den Build benötigt)
  - PrepareCopy.cmd (erzeugte Versionen werden in das Inno-Setupverzeichnis abgelgt)

# Stand:
  01.10.2023