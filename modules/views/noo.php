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
    <link rel="stylesheet" href="../../Resources/lib/Jquery/icons.css">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table3excel.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table2excel.js"></script>
    <head>


    </head>
</head>


<?php
include 'header.php';
$myFile = "../../scripts/predic/AP.txt";
$fh = fopen($myFile, 'r');
$DateAP = fread($fh,100);
fclose($fh);

$myFile = "../../scripts/predic/PVS.txt";
$fh = fopen($myFile, 'r');
$DatePVS = fread($fh,100);
fclose($fh);

$myFile = "../../scripts/predic/VNP.txt";
$fh = fopen($myFile, 'r');
$DateVNP = fread($fh,100);
fclose($fh);
?>

<body>
<div class="ui container">

    <div class="col s5" style="margin-left: 2%">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">PREDICCIONS DE LES ORDINÀRIES I ENDARRERIMENTS<hr style=" border-top: 1px solid yellowgreen; width:100%"></h4>


        <table  class="centered striped" id="table1">
            <thead>
            <tr>
                <th >Què predim?</th>
                <th >Definició</th>
                <th >Acció</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Usuaris AP </th>
                <td>Número d'usuaris d'Assistent Personal </td>
                <td><a href="../../scripts/predic/AP prestacions.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Pressupost AP </th>
                <td>Pressupost Assistent Personal </td>
                <td><a href="../../scripts/predic/AP ordinaria.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Endarreriments AP </th>
                <td>Endarreriments Assistent Personal </td>
                <td><a href="../../scripts/predic/AP endarreriments.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Usuaris VNP </th>
                <td>Número d'usuaris de Vetllador no Professional </td>
                <td><a href="../../scripts/predic/VNP prestacions.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Pressupost VNP </th>
                <td>Pressupost de Vetllador no Professional </td>
                <td><a href="../../scripts/predic/VNP ordinaria.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Endarreriments VNP </th>
                <td>Endarreriments Vetllador no Professional </td>
                <td><a href="../../scripts/predic/VNP endarreriments.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Usuaris PVS </th>
                <td>Número d'usuaris de Prestacions Vinculades al Servei </td>
                <td><a href="../../scripts/predic/PVS prestacions.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Pressupost PVS </th>
                <td>Pressupost de Prestacions Vinculades al Servei </td>
                <td><a href="../../scripts/predic/PVS ordinaria.html">Veure</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Endarreriments PVS </th>
                <td>Endarreriments Prestacions Vinculades al Servei </td>
                <td><a href="../../scripts/predic/PVS endarreriments.html">Veure</a></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="col s5" style="margin-left: 2%">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">PREDICCIONS SEGONS LA MITJA DE PAGAMENT ORDINÀRIES<hr style=" border-top: 1px solid yellowgreen; width:100%"></h4>


        <table  class="centered striped" id="table1">
            <thead>
            <tr>
                <th >Què predim?</th>
                <th >Mitjana de pagament per usuari els últims 4 mesos</th>
                <th >Quina mitjana de pagament creus que tindran els usuaris de mitjana els propers mesos?</th>
                <th >Acció</th>
                <th >Veure la última execució</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Assistent Personal </th>
                <td><?php echo $DateAP ?></td>
                <form action="../../modules/controllers/cargarR_AP.php" method="POST">
                <td><input name="fecha" id="icon_telephone" type="tel" class="validate"> </td>
                <td><button  id="actualitzarR_AP" class="btn waves-effect waves-teal" type="submit" value="Actualitzar R" name="submit">Executa</button></td>
                </form>
                <td><a href="../../scripts/predic/Assistent Personal Ordinaria.html">click</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Vetllador No Professional </th>
                <td><?php echo $DateVNP ?></td>
                <form action="../../modules/controllers/cargarR_VNP.php" method="POST">
                    <td><input name="fecha" id="icon_telephone" type="tel" class="validate"> </td>
                    <td><button  id="actualitzarR_VNP" class="btn waves-effect waves-teal" type="submit" value="Actualitzar R" name="submit">Executa</button></td>
                </form>
                <td><a href="../../scripts/predic/Assistent Personal Ordinaria.html">click</a></td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row"> Prestacions Vinculades al Servei </th>
                <td><?php echo $DatePVS ?></td>
                <form action="../../modules/controllers/cargarR_PVS.php" method="POST">
                    <td><input name="fecha" id="icon_telephone" type="tel" class="validate"> </td>
                    <td><button  id="actualitzarR_PVS" class="btn waves-effect waves-teal" type="submit" value="Actualitzar R" name="submit">Executa</button></td>
                </form>
                <td><a href="../../scripts/predic/Assistent Personal Ordinaria.html">click</a></td>
            </tr>

            </tbody>
        </table>
    </div>


</div>
</body>

<?php
include 'footer.php'
?>
