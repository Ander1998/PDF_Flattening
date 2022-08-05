$fdfs = $HOME
$values = Get-ChildItem -Path $fdfs -Filter *.fdf -File -Name -Recurse
$cont = 0

foreach ($value in $values) {
    $directorio = Split-Path $value
    $directorio = $fdfs + '\' + $directorio
    $ruta = $fdfs + '\' + $values[$cont]
    $text = Get-Content -Path $ruta
    $entrada =$PSScriptRoot+'\Plantillas_PDF\'
    $hora = Get-Date -Format "yyyyMMdd_HHmmss"
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
    if (!([System.IO.File]::Exists($entrada))) {
        if($null -eq $PSScriptRoot+'\Error_Log.txt') {
            New-Item $PSScriptRoot+'\Error_Log.txt'
        }
        $plantilla = $(Split-Path $entrada -leaf)
        'La plantilla ' + $plantilla + ' que se quiere usar no existe' | Out-File -FilePath .\Error_Log.txt -Append
    }
    if([System.IO.File]::Exists($out)) {
        Remove-Item $ruta
    } else {
        if($null -eq $PSScriptRoot+'\Error_Log.txt') {
            New-Item $PSScriptRoot+'\Error_Log.txt'
        }
        $Error | Out-File -FilePath .\Error_Log.txt -Append    
    }
    $cont++
}
powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('Se ha completado el flattening de los pdf','PDF_Flatten')}"
