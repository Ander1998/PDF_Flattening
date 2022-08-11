# PDF_Flattening

## Requisitos

-Windows versión 7 o posterior.

-PDFTK Server

```bash
https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-win-setup.exe
```

-Powershell

```bash
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.2#zip
```

## Descripción

El programa sirve para poder autocompletar pdfs de la seguridad social usando plantillas y archivos fdf (los datos de la red de la seguridad social) como origen de los datos.

Busca en ```C:\Users\'Usuario que ejecuta el script'``` entero todos los archivos que tengan la extensión fdf, genera los pdf con estos datos y la plantilla y elimina los fdf. En caso de que algo falle lo anota en un log de errores y no elimina el fdf.

## Como usarlo

Ejecutar el .exe haciendo doble click sobre este.


<div align="center">
    <img src="/Resources/ejecutar.png" width="650px"</img> 
</div>

 La carpeta del PDF_Flattening puede ser almacenada en cualquier destino dentro del PC y se puede ejecutar accediendo a esa ruta y haciendo doble click sobre el .exe o crear un acceso directo del mismo y tenerlo así más acesible dejando el acceso directo donde se quiera, en el escritorio por ejemplo.

<div align="center">
    <img src="/Resources/accesodirecto.png" width="650px"</img> 
</div>

**ATENCIÓN**

**Una vez dejado la carpeta de PDF_Flattening en un directorio y creado el acceso directo, en caso de mover dicha carpeta de lugar el acceso directo dejará de funcionar. En ese caso bastaría con volver a crear el acceso directo.**
