<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Importar</title>

    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link  rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans|Eagle+Lake|Lora|Merriweather+Sans|Open+Sans|PT+Sans|PT+Serif|Playfair+Display|Roboto|Roboto+Condensed|Slabo+27px" rel="stylesheet">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table2excel.js"></script>

    <link href="../../Resources/lib/dropzone/dropzone.min.css" rel="stylesheet">
    <script src="../../Resources/lib/dropzone/dropzone.min.js"></script>
    <link  rel="stylesheet" href="../../Resources/customCss/custom.css">

</head>



<body>
<?php
include 'header.php';
    $myFile = "../../Resources/archivos/ficherofecha.txt";
    $fh = fopen($myFile, 'r');
    $Date = fread($fh, 8);
    $Date2 = fread($fh, 12 );
fclose($fh);
?>


<div class="ui container">
   <div class="row">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">Importació de dades<hr style=" border-top: 1px solid yellowgreen; width:450%"></h4>
    </div>
        <div class="row">
            <div class="col s4">
                <h5>Altes pures 22</h5>
                <form action="../controllers/upload.php" enctype="multipart/form-data" class="dropzone" name="fitxer22" id="fitxer22"> </form>
            </div>


            <div class="col s4">
                    <h5>Altes pures 24</h5>
                    <form action="../controllers/upload.php" enctype="multipart/form-data" class="dropzone" id="fitxer24"></form>
            </div>

            <div class="col s4">
                <h5>Fitxer de Quadrament</h5>
                    <form action="../controllers/upload.php" enctype="multipart/form-data" class="dropzone" id="quadrament"></form>
            </div>
        </div>
        <div class="row">
            <div class="col s6">

                <h5>Endarreriments / DCR</h5>
                <form action="../controllers/upload.php" enctype="multipart/form-data" class="dropzone" id="DCR"> </form>
            </div>

            <div class="col s6">
                <h5>Baixes</h5>
                <form action="../controllers/upload.php" enctype="multipart/form-data" class="dropzone" id="Baixes"></form>
            </div>

        </div>
    <div>
        <form action="../controllers/cargarR.php" method="POST">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Tria la data dels fitxers: </h5>
            <input type="month" name="fecha" style="font-size: 140%; margin-top: 2%"  value="<?php echo date("Y-m");?>"> </input>
                <button  id="actualitzarR" class="btn waves-effect waves-teal" type="submit" value="Actualitzar R" name="submit">Executa</button>
        </form>
    </div>
    <div class="parrafo__box">
        <p>Recorda seguir la mateixa estructura que la plantilla, és important que els noms de les columnes siguin els mateixos.</p>
        <p>Si no has carregat correctament els arxius clica F5; NO EXECUTIS!</p>

        <p>Les últimes dades carregades van ser el dia:  <?php echo $Date2?></p>
        <p>Vas carregar el mes de:  <?php echo $Date?></p>
    </div>


    <div class="row">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">Descarrega el fitxer plantilla: <hr style=" border-top: 1px solid yellowgreen; width:300%"></h4>
    </div>
    <div class="row">
        <table  class="centered striped" id="tab">
            <thead>
            <tr>
                <th >Fitxer</th>
                <th >Acció</th>
                <th >Descarregar Excel</th>
                <th >Tipus de fitxer</th>


            </tr>
            </thead>
            <tbody>
            <tr>
                <th  style=" font-weight: 500;" scope="row">Altes22</th>
                <td><button id="openmodal1" class="waves-effect waves-light btn" style=" background-color: yellowgreen">Veure</button></td>
                <td><button id="excel1" class="waves-effect waves-light btn-flat" onClick="$('#P1').table2excel({
                filename: 'Plantilla_22'});" ><i class="material-icons">system_update_alt</i></button></td>
                <td>.xls</td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row">Altes24</th>
                <td><button id="openmodal2" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
                <td><button id="excel2" class="waves-effect waves-light btn-flat" onClick="$('#P2').table2excel({
                filename: 'Plantilla_24'});" ><i class="material-icons">system_update_alt</i></button></td>
                <td>.xls</td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;" scope="row">Quadrament</th>
                <td><button id="openmodal3" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
                <td><button id="excel3" class="waves-effect waves-light btn-flat" onClick="$('#P3').table2excel({
                    filename: 'Plantilla_Quadrament'});" ><i class="material-icons">system_update_alt</i></button></td>
                <td>.xlsx</td>
            </tr>
            <tr>
                <th style=" font-weight: 500;" scope="row">Endarreriments</th>
                <td><button id="openmodal4" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
                <td><button id="excel4" class="waves-effect waves-light btn-flat" onClick="$('#P4').table2excel({
                    filename: 'Plantilla_endarr'});" ><i class="material-icons">system_update_alt</i></button></td>
                <td>.xls</td>
            </tr>
            <tr>
                <th  style=" font-weight: 500;"scope="row">Baixes</th>
                <td><button id="openmodal5" class="waves-effect waves-light btn" style="background-color: yellowgreen">Veure</button></td>
                <td><button id="excel5" class="waves-effect waves-light btn-flat" onClick="$('#P5').table2excel({
                filename: 'Plantilla_baixes'});" ><i class="material-icons">system_update_alt</i></button></td>
                <td>.xlsx</td>
            </tr>

            </tbody>
        </table>
    </div>



    <div class="row">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">Últimes dades carregades: <hr style=" border-top: 1px solid yellowgreen; width:300%"></h4>
    </div>
    <div class="row">
        <div class="col s6">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Altes22: </h5>
        </div>
        <div class="col s6">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Altes24: </h5>
        </div>

        </div>
    <div class="row">
        <div class="col s6">
            <img src="../../Resources/archivos/altes22.png">
        </div>
        <div class="col s6">
            <img src="../../Resources/archivos/altes24.png">
        </div>
    </div>
    <div class="row">
        <h5 class="left" style="color: yellowgreen;margin-top: 3%">Quadrament: </h5>
    </div>
    <div class="row">
        <img src="../../Resources/archivos/quadrament.png">
    </div>


    <div id="modal1" class="modal" style=" width: 75%; height: 40%">
        <div class="modal-content" style="">
            <div class="scrollspy section left">
                <div style="margin-left: 2%">
                    <h4 class="left" style="color: yellowgreen">Plantilla d'altes pures 22</h4>
                    <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="P1" style=" font-size:10px">
                        <?php
                        $f = fopen("../../scripts/plantilla/Altes pures 22.csv", "r");
                        echo" 
                           <tbody>";
                        $T8=-1;
                        while (($line = fgetcsv($f,5000, ';')) !== false) {
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

                    </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="modal2" class="modal" style=" width: 75%; height: 40%">
        <div class="modal-content" style="">
            <div class="scrollspy section left">
                <div style="margin-left: 2%">
                    <h4 class="left" style="color: yellowgreen">Plantilla de altes pures 24</h4>
                    <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="P2" style=" font-size:10px">
                        <?php
                        $f = fopen("../../scripts/plantilla/Altes pures 24.csv", "r");
                        echo" 
                           <tbody>";
                        $T8=-1;
                        while (($line = fgetcsv($f,5000, ';')) !== false) {
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

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="modal3" class="modal" style=" width: 75%; height: 40%">
        <div class="modal-content" style="">
            <div class="scrollspy section left">
                <div style="margin-left: 2%">
                    <h4 class="left" style="color: yellowgreen">Plantilla de quadrament</h4>
                    <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="P3" style=" font-size:10px">
                        <?php
                        $f = fopen("../../scripts/plantilla/Quadrament conjunt 012018.csv", "r");
                        echo" 
                           <tbody>";
                        $T8=-1;
                        while (($line = fgetcsv($f,5000, ';')) !== false) {
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

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="modal4" class="modal" style=" width: 75%; height: 40%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Plantilla d'endarreriments</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="P4" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/plantilla/DCR generats.csv", "r");
                    echo" 
                           <tbody>";
                    $T8=-1;
                    while (($line = fgetcsv($f,5000, ';')) !== false) {
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

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

    <div id="modal5" class="modal" style=" width: 75%; height: 40%">
    <div class="modal-content" style="">
        <div class="scrollspy section left">
            <div style="margin-left: 2%">
                <h4 class="left" style="color: yellowgreen">Plantilla de baixes</h4>
                <table class="striped" style=" overflow-x: auto; white-space: nowrap;" id="P5" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/plantilla/22-24B.csv", "r");
                    echo" 
                           <tbody>";
                    $T8=-1;
                    while (($line = fgetcsv($f,5000, ';')) !== false) {
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

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>





</div>
<script>

    Dropzone.options.fitxer22 = {
        maxFiles: 1,
        maxFilesize: 50,
        dictDefaultMessage: 'Tria el fitxer de 22´s',
        uploadMultiple:false,
        renameFilename: function (file) {
            return file.renameFilename ="Altes22." + file.split('.').pop();
        }
    };


    Dropzone.options.fitxer24 = {
        maxFiles:1,
        maxFilesize: 50,
        dictDefaultMessage: 'Tria el fitxer de 24´s',
        uploadMultiple:false,
        renameFilename: function (file) {
            return file.renameFilename ="Altes24." + file.split('.').pop();
        }
    };

    Dropzone.options.quadrament = {
        maxFiles:1,
        maxFilesize: 50,
        dictDefaultMessage: 'Tria el fitxer de quadrament',
        uploadMultiple:false,
        renameFilename: function (file) {
            return file.renameFilename ="Quadrament." + file.split('.').pop();
        }
    };
    Dropzone.options.DCR = {
        maxFiles:1,
        maxFilesize: 50,
        dictDefaultMessage: 'Tria el fitxer Endarreriments / DCR',
        uploadMultiple:false,
        renameFilename: function (file) {
            return file.renameFilename ="DCR." + file.split('.').pop();
        }
    };
    Dropzone.options.Baixes = {
        maxFiles:1,
        maxFilesize: 50,
        dictDefaultMessage: 'Tria el fitxer de Baixes',
        uploadMultiple:false,
        renameFilename: function (file) {
            return file.renameFilename ="Baixes." + file.split('.').pop();
        }
    };
</script>
<?php
include 'footer.php'
?>


<script>
    $(document).ready(function() {
        $('#openmodal1').click(function () {
            $('#modal1').modal();
            $('#modal1').modal('open');
        });
    });
    $(document).ready(function() {
        $('#openmodal2').click(function () {
            $('#modal2').modal();
            $('#modal2').modal('open');
        });
    });
    $(document).ready(function() {
        $('#openmodal3').click(function () {
            $('#modal3').modal();
            $('#modal3').modal('open');
        });
    });
    $(document).ready(function() {
        $('#openmodal4').click(function () {
            $('#modal4').modal();
            $('#modal4').modal('open');
        });
    });
    $(document).ready(function() {
        $('#openmodal5').click(function () {
            $('#modal5').modal();
            $('#modal5').modal('open');
        });
    });
</script>




</body>
</html>