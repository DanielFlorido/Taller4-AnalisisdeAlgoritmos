@echo off
if not exist archivoObjetos.txt (
    copy %1 archivoObjetos.txt
)

echo %2 > archivoMaleta.txt
type archivoObjetos.txt | find /v /c "" >> archivoMaleta.txt

if exist Taller4.exe (
    Taller4.exe
) else (
    echo "No se encontró Taller4.exe"
)
