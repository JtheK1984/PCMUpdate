echo "Kopiere Datei ins Setupverzeichnis 32-Bit"
copy /y /v Win32\Release\PCMUpdate.exe "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v Win32\Release\PCMUpdate.DE "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v Win32\Release\PCMUpdate.EN "e:\Inno\Setupfiles\Programme\PCMUpdate"

echo "Kopiere Doku ins Setupverzeichnis"
copy /y /v PCMUpdate.docx "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v PCMUpdate.pdf "e:\Inno\Setupfiles\Programme\PCMUpdate"
copy /y /v PCMUpdate.htm "e:\Inno\Setupfiles\Programme\PCMUpdate"
