<#
.SYNOPSIS
  Script creado para el flattening de pdfs de la seguridad social
.INPUTS
  None
.OUTPUTS
  $out, pdf autorrellenado
  Log file stored in .\Error_Log.txt
.NOTES
  Version:        3.0
  Author:         Ander Ramos
  Creation Date:  05/08/2022
  Purpose/Change: Mejor control de errores así como ventanas emergentes personalizadas
  
.EXAMPLE
  Ejemplo.fdf
  bajaINSSa.pdf
#>

#----------------------------------------------------------[Declaración de variables]---------------------------------------------

#Primero se guarda en la variable $fdfs la ruta del usuario que está ejecutando el script, y en $values todos los archivos fdf que ha encontrado en el equipo y una
#variable contadora inicializada a 0.
$fdfs = $HOME
$values = Get-ChildItem -Path $fdfs -Filter *.fdf -File -Name -Recurse
#variable contadora para recorrer el array de valores
$cont = 0
#variable para comprobación de errores
$flag = 0
$saltolinea = '------------------------------------------------------------------------------------------------------------------------'
#------------------------------------------------------------------[Programa]------------------------------------------------------

if ($null -eq $values) {
  if($null -eq '.\Error_Log.txt') {
    New-Item '.\Error_Log.txt'
  }
  'No se encuentra ningún archivo fdf en la ruta $HOME' | Out-File -FilePath .\Error_Log.txt -Append
  $horalog | Out-File -FilePath .\Error_Log.txt -Append
  $saltolinea | Out-File -FilePath .\Error_Log.txt -Append
  $flag = 3
} else {
  # Con un foreach se recorre el array de fdfs que se ha encontrado en el equipo
  foreach ($value in $values) {
    # se guarda en $directorio la ruta en la que se encuentra el archivo fdf de esa iteración
    $directorio = Split-Path $value
    # se asigna a la variable la ruta con la parte inicial del usuario (C:\Users\UsuarioEjemplo + \ + Descargas, por ejemplo)
    $directorio = $fdfs + '\' + $directorio
    # y en ruta se guarda la ruta entera del fichero fdf (C:\Users\UsuarioEjemplo + \ + Descargas\Ejemplo_archivo.fdf).
    $ruta = $fdfs + '\' + $value
    # En la variable $text se guarda el contenido del fichero fdf y en $entrada se guarda la ruta del script 
    $text = Get-Content -Path $ruta
    # y se le agrega \Plantillas_PDF\ para que acceda a la subcarpeta en la que se encuentran los pdf plantilla.   
    $entrada = '.\Plantillas_PDF\'
    # En la variable hora se guarda la fecha y hora actual con año, mes, día, hora, minuto y segundo. Esto nos será util para darle nombre a los ficheros de salida.
    $hora = Get-Date -Format "yyyyMMdd_HHmmss"
    $horalog = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    # En caso de que la plantilla exista guarda en la variable $out la ruta en la que se encontraba el fdf + el nombre de la plantilla usada, la variable de hora,la variable
    # contadora y la extensión pdf para darle nombre al archivo. En la variable $entrada guarda la ruta con el fichero plantilla entero y usa las 2 variables de $entrada y
    # $ruta para hacer el pdftk, que es lo que junta el origen de datos con la plantilla y lo saca por $out.
    if ($text -match 'bajaINSSA.pdf') {
      $out = $directorio+'\Baja_'+$hora+'_'+$cont+'.pdf'
      $entrada = $entrada + 'bajaINSSa.pdf'
      pdftk $entrada fill_form $ruta output $out flatten
    } elseif ($text -match 'altaINSSa.pdf') {
      $out = $directorio+'\Alta_'+$hora+'_'+$cont+'.pdf'
      $entrada = $entrada + 'altaINSSa.pdf'
      pdftk $entrada fill_form $ruta output $out flatten
    } elseif ($text -match 'confINSSa.pdf') {
      $out = $directorio+'\Conf_'+$hora+'_'+$cont+'.pdf'
      $entrada = $entrada + 'confINSSa.pdf'
      pdftk $entrada fill_form $ruta output $out flatten
    }
    # Una vez hecho lo anterior el programa comprueba que el fichero fdf contiene el nombre de los pdf plantilla,
    # en caso de que no exista comprueba que exista el log de errores, en caso negativo lo crea y añade una linea con el error.
    if (!([System.IO.File]::Exists($entrada))) {
        if($null -eq '.\Error_Log.txt') {
            New-Item '.\Error_Log.txt'
        }

        #Write-Host $ruta

        $horalog | Out-File -FilePath .\Error_Log.txt -Append
        'Fichero fdf de origen: ' + $ruta | Out-File -FilePath .\Error_Log.txt -Append
        'La plantilla que se quiere usar no existe' | Out-File -FilePath .\Error_Log.txt -Append
        $saltolinea | Out-File -FilePath .\Error_Log.txt -Append
        $flag = 1
    }
    # En caso de que todo haya ido bien y se haya creado el pdf el programa elimina el fdf de origen 
    elseif([System.IO.File]::Exists($out)) {
      Remove-Item $ruta
  } # En caso contrario anota en el error log el problema que ha habido
  else {
      if($null -eq '.\Error_Log.txt') {
          New-Item '.\Error_Log.txt'
      }
      $horalog | Out-File -FilePath .\Error_Log.txt -Append
      $ruta | Out-File -FilePath .\Error_Log.txt -Append
      $Error | Out-File -FilePath .\Error_Log.txt -Append
      $saltolinea | Out-File -FilePath .\Error_Log.txt -Append
      $flag = 2
  } 
    # suma 1 a la variable contadora para en la siguiente iteración poder usarlo a la hora de asignar valor a $ruta.
    $cont++
  }
}

if ($flag -eq 0) {
  # Al terminar saltará un pop up diciendo que se ejecutó el script satisfactoriamente.
  powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Se ha completado el flattening de los fdf','PDF_Flatten')}"
} elseif ($flag -eq 1) {
    # Al no haber plantilla saldrá la siguiente ventana emergente.
    powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('La plantilla que se quiere usar no existe, por favor revisa el log de errores','PDF_Flatten')}"
} elseif ($flag -eq 2) {
    # Al terminar saltará un pop up diciendo que hubo un problema.
    powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Ha habido un error en la ejecucion del programa, por favor revisa el log de errores','PDF_Flatten')}"    
} elseif ($flag -eq 3) {
    # Al no haber ningún archivo fdf saltará un pop up con este mensaje.
    powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('No se encuentra ningun fdf en la ruta $HOME o en sus subdirectorios/carpetas','PDF_Flatten')}"
}