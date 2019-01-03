<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HISTORIC</title>

    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link rel="stylesheet" href="../../Resources/customCss/custom.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script src="../../graficspro2/Chart.js/Chart.bundle.min.js"></script>
    <script src="../../graficspro2/Chart.js/Chart.js"></script>
    <script type="text/javascript" src="canvasjs.min.js"></script>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js"></script>



    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!--<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.js"></script>
    <!--<script src="../../graficspro2/Chart.js/Chart.min.js"></script>-->
    <!--   <script src="../../graficspro2/Chart.js"></script>-->
    <!-- <script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js" ></script>-->

</head>


<?php
include 'header.php'
?>

<body>
<div class="ui container">
    <div class="row">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">Històric <hr style=" border-top: 1px solid yellowgreen; width:820%"></h4>
    </div>
    <div class="row">
        <ul id="tabs-swipe-demo" class="tabs">
            <li class="tab col s6"><a class="active" style="color:darkslateblue" href="#test-swipe-1">Veure històric global</a></li>
            <li class="tab col s6"><a  style="color:darkslateblue" href="#test-swipe-2">Veure històric anual</a></li>
        </ul>
    </div>
        <div id="test-swipe-1" class="col s12 ">
            <?php
            require 'historicGlobal.php'
            ?>
        </div>
        <div id="test-swipe-2" class="col s12">
            <?php
            require 'historicAnual.php'
            ?>
        </div>
</div>


<?php
include 'footer.php'
?>

</body>



</html>
