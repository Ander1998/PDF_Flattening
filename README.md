# PDF_Flattening
El programa sirve para poder autocompletar pdfs de la seguridad social usando plantillas y archivos fdf como base de los datos.
Primero se guarda en la variable $fdfs la ruta del usuario que está ejecutando el script, y en $values todos los archivos fdf que ha encontrado en el equipo y una
variable contadora inicializada a 0.

Con un foreach se recorre el array de fdfs que se ha encontrado en el equipo, se guarda en $directorio la ruta en la que se encuentra el archivo fdf de esa iteración,
se asigna a la variable la ruta con la parte inicial del usuario (C:\Users\UsuarioEjemplo + \ + Descargas, por ejemplo) y en ruta se guarda la ruta entera del fichero fdf
(C:\Users\UsuarioEjemplo + \ + Descargas\Ejemplo_archivo.fdf).
En la variable $text se guarda el contenido del fichero fdf y en $entrada se guarda la ruta del script y se le agrega \Plantillas_PDF\ para que acceda a la subcarpeta
en la que se encuentran los pdf plantilla.
En una variable se guarda la fecha y hora actual con año, mes, día, hora, minuto y segundo. Esto nos será util para darle nombre a los ficheros de salida.

Una vez hecho lo anterior el programa comprueba que el fichero fdf contiene el nombre de los pdf plantilla, en caso de que no exista comprueba que exista el log de
errores, en caso negativo lo crea y añade una linea con el error.

En caso de que la plantilla exista guarda en la variable $out la ruta en la que se encontraba el fdf + el nombre de la plantilla usada, la variable de hora,la variable
contadora y la extensión pdf para darle nombre al archivo. En la variable $entrada guarda la ruta con el fichero plantilla entero y usa las 2 variables de $entrada y
$ruta para hacer el pdftk, que es lo que junta el origen de datos con la plantilla y lo saca por $out.

En caso de que todo haya ido bien y se haya creado el pdf el programa elimina el fdf de origen, en caso contrario anota en el error log el problema que ha habido y suma
1 a la variable contadora para en la siguiente iteración poder usarlo a la hora de asignar valor a $ruta.

#Como usarlo
Se puede usar ejecutando el .ps1 directamente desde la carpeta o crear un acceso directo y poner la linea abajo mostradas en el mismo.
En destino hay que poner esta:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "%userprofile%\Ruta_en_la_que_se_encuentre_el_.ps1"
Al hacer esto se puede hacer doble click sobre el acceso directo y con eso ya se ejecutaría el programa, al terminar saltará un pop up diciendo que se ejecutó el script
satisfactoriamente.

ATENCIóN, EN CASO DE QUE NO SE PONGA ESA LíNEA EN EL EJECUTABLE EL PROGRAMA VA A DAR ERROR POR LAS VARIABLES DE SISTEMA USADAS EN EL MISMO 
