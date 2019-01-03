<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        #myChart
        {
            max-width: 1000px;
        }
    </style>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.js"></script>
    <!--<script src="../../graficspro2/Chart.js/Chart.min.js"></script>-->
    <script src="../../graficspro2/Chart.js"></script>
    <script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js" ></script>
</head>
<body>
<button onclick="ajaxSend(showAjaxData);">Show data from AJAX</button>
<button onclick="ajaxSend(loadChart);">Generate Chart</button>
<div id="div1"></div>
<canvas id="myChart" width="1" height="1"></canvas>
<script>
    /*
    * La funció que utilitzem per agafar les dades de grafic3.php és ajaxSend(callbackFunction)
    * el que li passem a la funció ajaxSend és una altra funció dins de callbackFunction
    *Així un cop acaba l'Ajax i hem carregat les dades que voliam després executa la funció que li hem dit.
    *
    * */
    var colors = ["rgb(230,240,120)","rgb(0,255,127)","rgb(46,139,87)","rgb(175,238,238)","rgb(95,158,160)", "rgb(123,104,238)"]

    var ctx = document.getElementById("myChart").getContext('2d');
    function loadChart(resultData) {
        //El Json que hem carregat el transformem en array perquè l'entengui el plugin de javascript
        var dataGet = $.parseJSON(resultData);
        //Ara dins de dataGet estan tots el valors de l'array_de_coses del fitxer grafic3.php
        //mira el següent console.log
        console.log(dataGet);
        console.log(dataGet.headers[0]);
       console.log(dataGet.headers[0].length);


       var object_datasets  = new Array();
       var $k = 0;
       for (var $i=1;$i<dataGet.headers[0].length;$i++)
       {
            object_datasets[$k] = {
                    label: dataGet.headers[0][$i],
                    backgroundColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                //backgroundColor: '#99cc00',
                    borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[$i],
            }
            $k++;
       }


        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Test'
                },
                scales: {
                    xAxes: [{
                        display: true,
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                    }]
                }
            }
        });
    }
    function showAjaxData(result)
    {
        $("#div1").html(result);
    }
    function ajaxSend(callbackFunction) {
        //Funció que ens fa la consulta AJAX
        $.ajax({
            //Pàgina d'on carrega les dades
            url: '../Data/Ordinaria.php',
            //Métode que utilitza per consultar la pàgina anterior
            type: 'post',
            success: function (result) {
                //Exectuta la funció que li hem dit dins la variable callbackFunction
                //i li envia el resultat "result" que ha obtingut de llegir la pàgina de gràfic3.php
                callbackFunction(result);
            }
        });
    }
</script>
</body>
</html>