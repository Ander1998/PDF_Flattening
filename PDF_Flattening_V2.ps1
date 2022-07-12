$fdfs = $HOME
$values = Get-ChildItem -Path $fdfs -Filter *.fdf -File -Name -Recurse

$cont = 0
foreach ($value in $values) {
    $directorio = Split-Path $value
    $directorio = $fdfs + '\' + $directorio
    $ruta = $fdfs + '\' + $values[$cont]
    $text = Get-Content -Path $ruta
    $entrada ='.\Plantillas_PDF\'
    $hora = Get-Date -Format "yyyyMMdd_HHmmss"
    if ($text -match 'bajaINSSA.pdf') {

        $out = $directorio+'\Baja_'+$hora+'_'+$cont+'.pdf'
        $entrada = $entrada + 'bajaINSSa.pdf'
        pdftk $entrada fill_form $ruta output $out flatten

    } elseif ($text -match 'altaINSSa.pdf') {

        $out = $directorio+'\Alta_'+$cont+'.pdf'
        $entrada = $entrada + 'altaINSSa.pdf'
        pdftk $entrada fill_form $ruta output $out flatten

    } elseif ($text -match 'confINSSa.pdf') {

        $out = $directorio+'\Conf_'+$cont+'.pdf'
        $entrada = $entrada + 'confINSSa.pdf'
        pdftk $entrada fill_form $ruta output $out flatten

    }
    Remove-Item $ruta
    $cont++
}