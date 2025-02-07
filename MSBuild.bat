call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"
echo "Build erstellen"
msbuild E:/Projekte/Windows/PCMUpdate/PCMUpdate.dproj /t:Clean;Build;Localize;CompressWin32 /p:config=Release /p:platform=Win32

echo "Kopiere Datei ins Setupverzeichnis 32-Bit"
copy /y /v E:\Projekte\Windows\PCMUpdate\Win32\Release\PCMUpdate.exe "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v E:\Projekte\Windows\PCMUpdate\Win32\Release\PCMUpdate.DE "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v E:\Projekte\Windows\PCMUpdate\Win32\Release\PCMUpdate.EN "e:\Inno\Setupfiles\Programme\PCMUpdate"

echo "Kopiere Doku ins Setupverzeichnis"
copy /y /v E:\Projekte\Windows\PCMUpdate\PCMUpdate.docx "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v E:\Projekte\Windows\PCMUpdate\PCMUpdate.pdf "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v E:\Projekte\Windows\PCMUpdate\PCMUpdate.htm "e:\Inno\Setupfiles\Programme\PCMUpdate"
