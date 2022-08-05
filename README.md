# PDF_Flattening

## Descripción

El programa sirve para poder autocompletar pdfs de la seguridad social usando plantillas y archivos fdf como origen de los datos.

Busca en C: entero todos los archivos que tengan la extensión fdf, genera los pdf con estos datos y la plantilla y elimina los fdf. En caso de que algo falle lo anota en un log de errores y no elimina el fdf.

## Como usarlo

Se puede usar ejecutando el .ps1 directamente desde la carpeta o crear un acceso directo y poner la linea abajo mostradas en el mismo.
En destino hay que poner esta:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "%userprofile%\Ruta_en_la_que_se_encuentre_el_.ps1"
Al hacer esto se puede hacer doble click sobre el acceso directo y con eso ya se ejecutaría el programa.

## **Atención**

EN CASO DE QUE NO SE PONGA ESA LíNEA EN EL EJECUTABLE EL PROGRAMA VA A DAR ERROR POR LAS VARIABLES DE SISTEMA USADAS EN EL MISMO
