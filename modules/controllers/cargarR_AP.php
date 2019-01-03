<?php
ini_set('max_execution_time', 5000);
?>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>GEOANALISIS</title>

    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link rel="stylesheet" href="../../Resources/customCss/custom.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans|Eagle+Lake|Lora|Merriweather+Sans|Open+Sans|PT+Sans|PT+Serif|Playfair+Display|Roboto|Roboto+Condensed|Slabo+27px"
          rel="stylesheet">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
</head>
<?php
include '../../modules/views/header.php'
?>

<?php
if(isset($_POST['fecha']))
{
    $N=$_POST['fecha'];

    $command = 'C:\Program Files\R\R-3.3.3\bin\Rscript.exe C:\xampp\htdocs\GestioDeute\scripts\predic\RpredAP.R' . " $N";
//    $oExec = $WshShell->Run("notepad.exe", 7, false);
    $pCom = new COM("WScript.Shell");
    $WshShell = new COM("WScript.Shell");
//$pShell = $WshShell->Run("'C:\Program Files\R\R-3.4.3\bin\Rscript.exe C:\xampp\htdocs\GEOLOCA\paginicial.R'", 7, false);

//$pShell = $pCom->Run($command, 7, false);
    $pShell = $pCom->exec($command);
    $sStdOut = $pShell->StdOut->ReadAll;    # Standard output
    $sStdErr = $pShell->StdErr->ReadAll;    # Error
    $json = json_decode($sStdOut);
    $results = (array)$json;
    // var_dump( $results);
    // echo $sStdOut;
    $variable = 1;
    if($sStdErr)
    {
        echo $sStdErr;
        $res= "Problema en la càrrega de dades";
    } else {
        $res= "Dades carregades correctament";
    }




    $N =date('m-Y',strtotime($N));
    $N2= date("d-m-Y");
    array_map('unlink', glob("C:/xampp/htdocs/GestioDeute/uploads/*"));

    $file=fopen("../../Resources/archivos/ficherofecha.txt","wb");   //fopen intenta abrir el archivo 'fichero.txt' con permisos de lectura y escritura, y con el parametro 'a' si no existe lo crea
    $file2=fopen("../../Resources/archivos/ficherofecha.txt","wb");   //fopen intenta abrir el archivo 'fichero.txt' con permisos de lectura y escritura, y con el parametro 'a' si no existe lo crea
    $newstring = str_replace("oldword", "newword", "$N  $N2" );
    $file = fwrite($file2,$newstring);      //Inserta en el fichero la cadena
    fclose($file2);      //Cierra el fichero*/


} else echo "RAFA ADJUNTA BIEN LOS FICHEROS"  ;

?>
<body>
<div>
    <div class="container">
        <div class="row">
            <h2 class="left" style="color: darkslateblue;margin-top: 3%"><?php echo $res?></h2>
        </div>
        <div class="row">
            <h5 class="left" style="color: darkslateblue;margin-top: 3%">Veure les dades:  <a href="../../scripts/predic/Assistent Personal Ordinaria.html">click</a></h5>

        </div>

    </div>
</div>
</body>

<?php
include '../../modules/views/footer.php'
?>


</html>