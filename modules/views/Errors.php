<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Incongruències</title>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link  rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link  rel="stylesheet" href="../../Resources/customCss/custom.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
<!--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">-->
  <!--  <link href="https://fonts.googleapis.com/css?family=Droid+Sans|Eagle+Lake|Lora|Merriweather+Sans|Open+Sans|PT+Sans|PT+Serif|Playfair+Display|Roboto|Roboto+Condensed|Slabo+27px" rel="stylesheet">-->
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table2excel.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table3excel.js"></script>
</head>

<body>

<?php
include 'header.php'
?>



<div id="modal1" class="modal" style=" width: 60%; height: 75%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Assistent personal de grau 1</h4>
                <table class="striped" style="overflow-x: auto; white-space: nowrap;" id="Malos1" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Earp.csv", "r");
                    echo" 
                           <tbody>";
                    $T1=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T1=$T1+1;
                    };
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>


<div id="modal2" class="modal" style=" width: 75%; height: 75%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">DNI's que apareixen a baixes no reflectides entre quadraments</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos2" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/EbaixRep.csv", "r");
                    echo" 
                           <tbody>";
                    $T2=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T2=$T2+1;
                    }
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>


<div id="modal3" class="modal" style=" width: 75%; height: 75%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Procediments que surten al fitxer d'altes i no són nous</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos3" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Ebq.csv", "r");
                    echo" 
                           <tbody>";
                    $T3=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T3=$T3+1;
                    }
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal4" class="modal" style=" width: 60%; height: 60%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Expedients duplicats</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos4" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/EOrdDniRep.csv", "r");
                    echo" 
                           <tbody>";
                    $T4=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T4=$T4+1;
                    }
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal5" class="modal" style=" width: 55%; height: 75%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Expedients retinguts</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos5" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Eret.csv", "r");
                    echo" 
                           <tbody>";
                    $T5=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T5=$T5+1;
                    }
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>


<div id="modal6" class="modal" style=" width: 75%; height: 75%">
    <div class="modal-content">
        <div class="section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Procediments que apareixen nous però no apareixen al fitxer d'altes</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos6" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/E_noves.csv", "r");
                    echo" 
                           <tbody>";
                    $T6=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T6=$T6+1;
                    }
                    fclose($f);
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal7" class="modal" style=" width: 75%; height: 75%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Canvis de recurs que no apareixen a baixes</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos7" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/ErecNb.csv", "r");
                    echo" 
                           <tbody>";
                    $T7=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T7=$T7+1;
                    }
                    fclose($f);
                    ?>
                </table>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<div id="modal8" class="modal" style=" width: 75%; height: 40%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Modificatives que no apareixen a baixes</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos8" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/EmodNb.csv", "r");
                    echo" 
                           <tbody>";
                    $T8=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T8=$T8+1;
                    }
                    fclose($f);
                    ?>
                </table>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal9" class="modal" style=" width: 80%; height: 75%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Any de naixement</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos9" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Enaix.csv", "r");
                    echo" 
                           <tbody>";
                    $T9=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T9=$T9+1;
                    }
                    fclose($f);
                    ?>
                </table>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal10" class="modal" style=" width: 75%; height: 30%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Augment en els endarreriments respecte al mes anterior</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos10" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Eend.csv", "r");
                    echo" 
                           <tbody>";
                    $T10=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";

                            }
                        };
                        $T10=$T10+1;
                    }
                    fclose($f);
                    ?>
                </table>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal11" class="modal" style=" width: 75%; height: 45%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Difunt amb retard d'actualització de l'expedient superior a 3 mesos</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos11" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Edef.csv", "r");
                    echo" 
                           <tbody>";
                    $T11=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            }
                        };
                        $T11=$T11+1;
                    }
                    fclose($f);
                    ?>
                </table>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="modal12" class="modal" style=" width: 75%; height: 45%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Beneficiaris d'edat inferior als 3 anys</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="Malos12" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/errors/Nadons.csv", "r");
                    echo" 
                           <tbody>";
                    $T12=-1;
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500 text-align: right'>";
                        echo "<td>" . htmlspecialchars($line[0]) . "</td>";

                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            } else{
                                $cell1=$line[$i];
                                // echo "<td><a class='tooltipped' data-delay='50' style='color:black' data-tooltip="; echo($a[$i]); echo ">" . htmlspecialchars($cell1) . "</a></td>";
                                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                            }
                        };
                        $T12=$T12+1;
                    }
                    fclose($f);
                    ?>
                </table>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="container">

<div class="col s5" style="margin-left: 2%">
    <h4 class="left" style="color: yellowgreen;margin-top: 3%">INCONGRUÈNCIES<hr style=" border-top: 1px solid yellowgreen; width:440%"></h4>


    <table  class="centered striped" id="table1">
        <thead>
        <tr>
            <th >Observació detectada </th>
            <th >Quantitat de casos trobats</th>
            <th >Acció</th>
            <th >Descarregar Excel</th>

        </tr>
        </thead>
        <tbody>
        <tr>
            <th  style=" font-weight: 500;" scope="row">Assistent personal de grau 1</th>
            <td><?php echo $T1?></td>
            <td><button id="openmodal1" class="waves-effect waves-light btn" style=" background-color: yellowgreen">Veure</button></td>
            <td><button id="excel1" class="waves-effect waves-light btn-flat" onClick="tablesToExcel(['Malos1'],['AP_G1'], 'AP_G1.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
            
        </tr>
        
        <tr>
            <th style=" font-weight: 500;" scope="row">Expedients duplicats</th>
            <td><?php echo $T4?></td>
            <td><button id="openmodal4" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel4" class="waves-effect waves-light btn-flat" onClick="
tablesToExcel(['Malos4'],['EDup'], 'Eduplicats.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        
        <tr>
            <th style="font-weight: 500;" scope="row">Possibles incongruències amb els anys de naixement</th>
            <td><?php echo $T9?></td>
            <td><button id="openmodal9" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel9" class="waves-effect waves-light btn-flat" onClick="tablesToExcel(['Malos9'],['Any_Naix'], 'Any_Naixement.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        </tbody>
    </table>
</div>

<div class="col s5" style="margin-left: 2%">
    <h4 class="left" style="color: yellowgreen;margin-top: 3%">OBSERVACIONS<hr style=" border-top: 1px solid yellowgreen; width:440%"></h4>
    <table  class="centered striped" id="table2">
        <thead>
        <tr>
            <th >Observació detectada </th>
            <th >Quantitat de casos trobats</th>
            <th >Acció</th>
            <th >Descarregar Excel</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th style="font-weight: 500;" scope="row">Difunt amb retard  d'actualització de l'expedient superior a 3 mesos</th>
            <td><?php echo $T11?></td>
            <td><button id="openmodal11" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel11" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos11'],['Retard difunts'], 'Retard difunts.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>

        <tr>
            <th style="font-weight: 500;" scope="row">Augment en els endarreriments respecte al mes anterior (15%)</th>
            <td><?php echo $T10?></td>
            <td><button id="openmodal10" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel10" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos10'],['Augment Endarr'], 'Augment endarreriments.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>

        <tr>
            <th  style=" font-weight: 500;"scope="row">Expedients retinguts</th>
            <td><?php echo $T5?></td>
            <td><button id="openmodal5" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel5" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos5'],['ERet'], 'Eretinguts.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        
        <tr>
            <th style="font-weight: 500;" scope="row">Beneficiaris d'edat inferior als 3 anys</th>
            <td><?php echo $T12?></td>
            <td><button id="openmodal12" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel12" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos12'],['Nens menors 3 anys'], 'Menors 3 anys.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>

        <tr>
            <th  style=" font-weight: 500;" scope="row">DNI's que apareixen a baixes però no estan reflectides entre quadraments</th>
            <td><?php echo $T2?></td>
            <td><button id="openmodal2" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel2" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos2'],['Baixes NoQ'], 'Baixes_NoQ.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        <tr>
            <th  style=" font-weight: 500;" scope="row">Procediments que surten al fitxer d'altes i no són nous</th>
            <td><?php echo $T3?></td>
            <td><button id="openmodal3" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel3" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos3'],['Altes NoQ'], 'Altes_NoQ.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        <tr>
            <th  style=" font-weight: 500;" scope="row">Procediments que apareixen nous però no apareixen al fitxer d'altes</th>
            <td><?php echo $T6?></td>
            <td><button id="openmodal6" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel6" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos6'],['Nous_NoA'], 'Nous_NoA.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        <tr>
            <th style="font-weight: 500;" scope="row">Canvis de recurs que no apareixen a baixes</th>
            <td><?php echo $T7?></td>
            <td><button id="openmodal7" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel7" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos7'],['CR_NoB'], 'CR_NoB.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>

        <tr>
            <th style="font-weight: 500;" scope="row">Modificatives que no apareixen a baixes</th>
            <td><?php echo $T8?></td>
            <td><button id="openmodal8" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
            <td><button id="excel8" class="waves-effect waves-light btn-flat" onClick="
                tablesToExcel(['Malos8'],['Mod_NoB'], 'Mod_NoB.xls', 'Excel');" ><i class="material-icons">system_update_alt</i></button></td>
        </tr>
        
        </tbody>
    </table>  
</div>
    
</div>
</div>
</div>




<script>
        $(document).ready(function() {
           $('#openmodal1').click(function () {
                $('#modal1').modal();
                $('#modal1').modal('open');
           });
        });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal2').click(function () {
            $('#modal2').modal();
            $('#modal2').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal3').click(function () {
            $('#modal3').modal();
            $('#modal3').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal4').click(function () {
            $('#modal4').modal();
            $('#modal4').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal5').click(function () {
            $('#modal5').modal();
            $('#modal5').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal6').click(function () {
            $('#modal6').modal();
            $('#modal6').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal7').click(function () {
            $('#modal7').modal();
            $('#modal7').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal8').click(function () {
            $('#modal8').modal();
            $('#modal8').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal9').click(function () {
            $('#modal9').modal();
            $('#modal9').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal10').click(function () {
            $('#modal10').modal();
            $('#modal10').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal11').click(function () {
            $('#modal11').modal();
            $('#modal11').modal('open');
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#openmodal12').click(function () {
            $('#modal12').modal();
            $('#modal12').modal('open');
        });
    });
</script>
<footer class="page-footer"  style="background: darkgray; margin-top: 3rem">
    <div class="container">
        <div class="row">
            <div class="center">
                <h5 style="font-weight: 200" class="white-text">everis <span style="color:white">BPO</span></h5>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container center">
            <a  style="font-weight:200" class="white-text text-lighten-4 " href="#!">Todos los derechos reservados</a>
        </div>
    </div>
</footer>


</body>

</html>