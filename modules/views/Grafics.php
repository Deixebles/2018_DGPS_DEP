<!DOCTYPE html>
<html lang="en">
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
<div class="container">

    <div class="row">
    <h4 class='left' style='color: yellowgreen;margin-top: 4rem; margin-left: 0rem'>Gràfics<hr style='border-top: 1px solid yellowgreen; width:1200%'></h4>
    </div>
    <div class="row" style="margin-top: 5rem">
        <div class="col s6">
            <canvas  id="A31" width="1" height="1"></canvas>
        </div>
        <div class="col s6">
            <canvas  id="A1" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 5rem">
        <div class="col s6">
            <canvas  id="A2" width="1" height="1"></canvas>
        </div>
        <div class="col s6">
            <canvas  id="A12" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6">
            <canvas  id="A30" width="1" height="1"></canvas>
        </div>
        <div class="col s6">
            <canvas  id="A32" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6">
            <canvas  id="A4.1" width="1" height="1"></canvas>
        </div>
        <div class="col s6">
            <canvas  id="A4.2" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6">
            <canvas  id="A6" width="1" height="1"></canvas>
        </div>
        <div class="col s6">
            <canvas  id="A7" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6 center">
            <canvas  id="A9" width="1" height="1"></canvas>
        </div>
        <div class="col s6 center">
            <canvas  id="A8" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6 center">
            <canvas  id="A5" width="1" height="1"></canvas>
        </div>
        <div class="col s6 center">
            <canvas  id="A5.2" width="1" height="1"></canvas>
        </div>
    </div>
    <div class="row" style="margin-top: 3rem">
        <div class="col s6 center">
            <canvas  id="A4.3" width="1" height="1"></canvas>
        </div>
    </div>
</div>
</body>

<script>
    var colors = ["rgb(230,240,120)","rgb(0,255,127)","rgb(46,139,87)","rgb(175,238,238)","rgb(95,158,160)", "rgb(123,104,238)",
        "rgb(0,250,154)", "rgb(0,255,255)", "rgb(0,191,255)", "rgb(25,25,112)" , "rgb(0,128,0)" , "rgb(173,255,47)" , "rgb(128,0,128)"];
    var ctxA31 = document.getElementById("A31").getContext('2d');
    function loadChartA31(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA31, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];

                            return label + ': ' +datasetLabel +'usuaris' + ' ;  ' + datasetLabel1 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Usuaris per sexe",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: true,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true},
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA31(callbackFunction) {
        $.ajax({
            url: '../Data/A3.1p.php', // cridem el php A3.1.php que és el que obre l'script A3.1p_homesdones_ord.csv
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA31(loadChartA31);
</script>

<script>
    var ctxA30 = document.getElementById("A30").getContext('2d');
    function loadChartA30(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA30, {
            type: 'bar',
            
            data: { // if(function_exists('dataGet.datasets[3]')) // no sé com és, però algo per comprovar si existeix un 3r set de dades
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors[0],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                }/*,{  PERÒ COMPTE A VEURE QUÈ PASSA SI NO HI HA 3 SETS DE DADES: S'HA DE TREURE??? 
                        position: 'top',
                        label: dataGet.headers[0][3],
                        backgroundColor: colors[2],
                        //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                        fill: false,
                        data: dataGet.datasets[3],
                        tooltip: true
                }*/
                ]
            },
            options: {

                responsive: true,
                title: {
                    display: true,
                    text: "Usuaris per sexe i recurs",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: true,
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            labelString: 'Usuaris ',
                            display: true
                        }
                    }]
                }
            }
        });

    }
    function ajaxSendA30(callbackFunction) {
        $.ajax({
            url: '../Data/A3.0p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA30(loadChartA30);
</script>

<script>
    var ctxA32 = document.getElementById("A32").getContext('2d');
    function loadChartA32(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA32, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors[0],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                }]
            },
            options: {

                responsive: true,
                title: {
                    display: true,
                    text: "Import mig per sexe i recurs",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: true,
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            labelString: 'Import mig (€/usuari)',
                            display: true
                        }
                    }]
                }
            }
        });

    }
    function ajaxSendA32(callbackFunction) {
        $.ajax({
            url: '../Data/A3.2b.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA32(loadChartA32);
</script>

<script>
    var ctxA2 = document.getElementById("A2").getContext('2d');
    function loadChartA2(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA2, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[3]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];
                            var datasetLabel2 = dataGet.datasets[3][tooltipItem.datasetIndex].label || dataGet.datasets[3][tooltipItem.index];

                            return label + ': ' +datasetLabel +'€' + ' ;  ' + datasetLabel1 +'€/usuari' +'  ;  '+ datasetLabel2 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Import destinat per recurs",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: true,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true},
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA2(callbackFunction) {
        $.ajax({
            url: '../Data/A2p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA2(loadChartA2);
</script>

<script>
    var ctxA41 = document.getElementById("A4.1").getContext('2d');
    function loadChartA41(resultData) {
        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        for (var $i=0;$i<dataGet.datasets[1].length;$i++){
            object_datasets[$k] = {
                x: dataGet.datasets[1][$i],
                y: dataGet.datasets[2][$i],
                z: dataGet.datasets[3][$i]
            };
            $k++;
        }

        var object_datasets1  = new Array();
        var $k1 = 0;
        for (var $i=0;$i<dataGet.datasets[5].length;$i++){
            object_datasets1[$k1] = {
                x: dataGet.datasets[5][$i],
                y: dataGet.datasets[6][$i],
                z: dataGet.datasets[7][$i]
            };
            $k1++;
        }
        var object_datasets2  = new Array();
        var $k2 = 0;
        for (var $i=0;$i<dataGet.datasets[9].length;$i++){
            object_datasets2[$k2] = {
                x: dataGet.datasets[9][$i],
                y: dataGet.datasets[10][$i],
                z: dataGet.datasets[11][$i]
            };
            $k2++;
        }
        var object_datasets3  = new Array();
        var $k3 = 0;
        for (var $i=0;$i<dataGet.datasets[13].length;$i++){
            object_datasets3[$k3] = {
                x: dataGet.datasets[13][$i],
                y: dataGet.datasets[14][$i],
                z: dataGet.datasets[15][$i]
            };
            $k3++;
        }
        var object_datasets4  = new Array();
        var $k4 = 0;
        for (var $i=0;$i<dataGet.datasets[14].length;$i++){
            object_datasets4[$k4] = {
                x: dataGet.datasets[17][$i],
                y: dataGet.datasets[18][$i],
                z: dataGet.datasets[19][$i]
            };
            $k4++;
        }
        var object_datasets5  = new Array();
        var $k5 = 0;
        for (var $i=0;$i<dataGet.datasets[15].length;$i++){
            object_datasets5[$k5] = {
                x: dataGet.datasets[21][$i],
                y: dataGet.datasets[22][$i],
                z: dataGet.datasets[23][$i]
            };
            $k5++;
        }
        var myChart = Chart.Scatter(ctxA41, {
            type: 'scatter',
            data: {
                datasets: [{
                    label: dataGet.datasets[4][1],
                    backgroundColor: colors[0],
                    data: object_datasets,
                    borderColor: colors[0],
                    pointBorderColor: colors[0],
                    pointBackgroundColor: colors[0],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[8][1],
                    backgroundColor: colors[1],
                    data: object_datasets1,
                    borderColor: colors[1],
                    pointBorderColor: colors[1],
                    pointBackgroundColor: colors[1],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[12][1],
                    backgroundColor: colors[2],
                    data: object_datasets2,
                    borderColor: colors[2],
                    pointBorderColor: colors[2],
                    pointBackgroundColor: colors[2],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[16][1],
                    backgroundColor: colors[3],
                    data: object_datasets3,
                    borderColor: colors[3],
                    pointBorderColor: colors[3],
                    pointBackgroundColor: colors[3],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[20][1],
                    backgroundColor: colors[4],
                    data: object_datasets4,
                    borderColor: colors[4],
                    pointBorderColor: colors[4],
                    pointBackgroundColor: colors[4],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[24][1],
                    backgroundColor: colors[5],
                    data: object_datasets5,
                    borderColor: colors[5],
                    pointBorderColor: colors[5],
                    pointBackgroundColor: colors[5],
                    fill: false,
                    showLine: false
                }],
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = data.datasets[tooltipItem.datasetIndex].label || 'Other';
                            var label = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].y;
                            var prest = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].z;

                            return datasetLabel + ': ' + label + '€' +  '    Expedient: ' + prest;
                        }
                    }
                },
                elements: {
                    line: { radius: 0 },
                    area: { radius: 0 } },
                bezierCurve: false,
                pointDot: false,
                datasetFill: true,
                pointDotRadius: 0,
                responsive: true,
                title: {
                    display: true,
                    text: 'Import per edat',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any de naixement'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            displayFormats: {
                                day: 'YYYY-mm-dd'
                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: 'Import (€)',
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA41(callbackFunction) {
        $.ajax({
            url: '../Data/A4.1s.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA41(loadChartA41);
</script>

<script>
    var ctxA42 = document.getElementById("A4.2").getContext('2d');
    function loadChartA42(resultData) {
        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        for (var $i=0;$i<dataGet.datasets[1].length;$i++){
            object_datasets[$k] = {
                x: dataGet.datasets[1][$i],
                y: dataGet.datasets[2][$i],
                z: dataGet.datasets[3][$i]

            };
            $k++;
        }

        var object_datasets1  = new Array();
        var $k1 = 0;
        for (var $i=0;$i<dataGet.datasets[5].length;$i++){
            object_datasets1[$k1] = {
                x: dataGet.datasets[5][$i],
                y: dataGet.datasets[6][$i],
                z: dataGet.datasets[7][$i]

            };
            $k1++;
        }
        var object_datasets2  = new Array();
        var $k2 = 0;
        for (var $i=0;$i<dataGet.datasets[9].length;$i++){
            object_datasets2[$k2] = {
                x: dataGet.datasets[9][$i],
                y: dataGet.datasets[10][$i],
                z: dataGet.datasets[11][$i]

            };
            $k2++;
        }
        var object_datasets3  = new Array();
        var $k3 = 0;
        for (var $i=0;$i<dataGet.datasets[13].length;$i++){
            object_datasets3[$k3] = {
                x: dataGet.datasets[13][$i],
                y: dataGet.datasets[14][$i],
                z: dataGet.datasets[15][$i]

            };
            $k3++;
        }
        var object_datasets4  = new Array();
        var $k4 = 0;
        for (var $i=0;$i<dataGet.datasets[14].length;$i++){
            object_datasets4[$k4] = {
                x: dataGet.datasets[17][$i],
                y: dataGet.datasets[18][$i],
                z: dataGet.datasets[19][$i]
            };
            $k4++;
        }
        var object_datasets5  = new Array();
        var $k5 = 0;
        for (var $i=0;$i<dataGet.datasets[15].length;$i++){
            object_datasets5[$k5] = {
                x: dataGet.datasets[21][$i],
                y: dataGet.datasets[22][$i],
                z: dataGet.datasets[23][$i]
            };
            $k5++;
        }

        var myChart = Chart.Scatter(ctxA42, {
            type: 'scatter',
            data: {
                datasets: [{
                    label: dataGet.datasets[4][1],
                    backgroundColor: colors[0],
                    data: object_datasets,
                    borderColor: colors[0],
                    pointBorderColor: colors[0],
                    pointBackgroundColor: colors[0],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[8][1],
                    backgroundColor: colors[1],
                    data: object_datasets1,
                    borderColor: colors[1],
                    pointBorderColor: colors[1],
                    pointBackgroundColor: colors[1],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[12][1],
                    backgroundColor: colors[2],
                    data: object_datasets2,
                    borderColor: colors[2],
                    pointBorderColor: colors[2],
                    pointBackgroundColor: colors[2],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[16][1],
                    backgroundColor: colors[3],
                    data: object_datasets3,
                    borderColor: colors[3],
                    pointBorderColor: colors[3],
                    pointBackgroundColor: colors[3],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[20][1],
                    backgroundColor: colors[4],
                    data: object_datasets4,
                    borderColor: colors[4],
                    pointBorderColor: colors[4],
                    pointBackgroundColor: colors[4],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[24][1],
                    backgroundColor: colors[5],
                    data: object_datasets5,
                    borderColor: colors[5],
                    pointBorderColor: colors[5],
                    pointBackgroundColor: colors[5],
                    fill: false,
                    showLine: false
                }],
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = data.datasets[tooltipItem.datasetIndex].label || 'Other';
                            var label = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].y;
                            var prest = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].z;

                            return datasetLabel + ': ' + label + '€' +  '    Expedient: ' + prest;
                        }
                    }
                },

                responsive: true,
                title: {
                    display: true,
                    text: 'Endarreriments per edat',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any de naixement',
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            displayFormats: {
                                day: 'YYYY-mm-dd'
                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: 'Import (€)',
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA42(callbackFunction) {
        $.ajax({
            url: '../Data/A4.2s.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA42(loadChartA42);
</script>

<script>
    var ctxA6 = document.getElementById("A6").getContext('2d');
    function loadChartA6(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA6, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors[2],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "Import total per edat i sexe",
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    xAxes: [{
                        display: true,
                        stacked: true
                    }],
                    yAxes: [{
                        display: true,
                        stacked: true,
                        scaleLabel: {
                            labelString: 'Import (€)',
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA6(callbackFunction) {
        $.ajax({
            url: '../Data/A6b.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA6(loadChartA6);
</script>

<script>
    var ctxA1 = document.getElementById("A1").getContext('2d');
    function loadChartA1(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA1, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];

                            return label + ': ' +datasetLabel +'usuaris' + ' ;  ' +  datasetLabel1 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Usuaris per cartera",
                    fontSize: 20

                },
                scales: {
                    xAxes: [{
                        display: true,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true},
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA1(callbackFunction) {
        $.ajax({
            url: '../Data/A1p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA1(loadChartA1);
</script>

<script>
    var ctxA7 = document.getElementById("A7").getContext('2d');
    function loadChartA7(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA7, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    label: 'temps (dies)',
                    position: 'top',
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "Temps de retard de baixes i modificatives",
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    xAxes: [{
                        display: true,
                        stacked: true,
                        ticks: {
                            fontColor: "black", // this here
                            fontSize: 12

                        },
                    }],
                    yAxes: [{
                        display: true,
                        stacked: true,
                        scaleLabel: {
                            labelString: 'Temps de retard (dies)',
                            display: true,
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA7(callbackFunction) {
        $.ajax({
            url: '../Data/A7b.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA7(loadChartA7);
</script>

<script>
    var ctxA12 = document.getElementById("A12").getContext('2d');
    function loadChartA12(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA12, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];

                            return label + ': ' +datasetLabel +'usuaris' + ' ;  ' +  datasetLabel1 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Usuaris per prestació",
                    fontSize: 20

                },
                scales: {
                    xAxes: [{
                        display: true,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true},
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA12(callbackFunction) {
        $.ajax({
            url: '../Data/A1.2p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA12(loadChartA12);
</script>

<script>
    var ctxA5 = document.getElementById("A5").getContext('2d');
    function loadChartA5(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA5, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];

                            return label + ': ' +datasetLabel +'€' + ' ;  ' +  datasetLabel1 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Import per comarca",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: false,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true,
                            fontColor: "transparent"
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA5(callbackFunction) {
        $.ajax({
            url: '../Data/A5p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA5(loadChartA5);
</script>

<script>
    var ctxA8 = document.getElementById("A8").getContext('2d');
    function loadChartA8(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA8, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors[0],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][3],
                    backgroundColor: colors[2],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[3],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][4],
                    backgroundColor: colors[3],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[4],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][5],
                    backgroundColor: colors[4],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[5],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][6],
                    backgroundColor: colors[5],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[6],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][7],
                    backgroundColor: colors[6],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[7],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][8],
                    backgroundColor: colors[7],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[8],
                    tooltip: true
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "Nombre d'usuaris per grau i recurs",
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    xAxes: [{
                        display: true,
                        stacked: true
                    }],
                    yAxes: [{
                        display: true,
                        stacked: true,
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA8(callbackFunction) {
        $.ajax({
            url: '../Data/A8b.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA8(loadChartA8);
</script>

<script>
    var ctxA43 = document.getElementById("A4.3").getContext('2d');
    function loadChartA43(resultData) {
        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        for (var $i=0;$i<dataGet.datasets[1].length;$i++){
            object_datasets[$k] = {
                x: dataGet.datasets[1][$i],
                y: dataGet.datasets[2][$i],
                z: dataGet.datasets[3][$i]

            };
            $k++;
        }

        var object_datasets1  = new Array();
        var $k1 = 0;
        for (var $i=0;$i<dataGet.datasets[5].length;$i++){
            object_datasets1[$k1] = {
                x: dataGet.datasets[5][$i],
                y: dataGet.datasets[6][$i],
                z: dataGet.datasets[7][$i]

            };
            $k1++;
        }
        var object_datasets2  = new Array();
        var $k2 = 0;
        for (var $i=0;$i<dataGet.datasets[9].length;$i++){
            object_datasets2[$k2] = {
                x: dataGet.datasets[9][$i],
                y: dataGet.datasets[10][$i],
                z: dataGet.datasets[11][$i]

            };
            $k2++;
        }
        var object_datasets3  = new Array();
        var $k3 = 0;
        for (var $i=0;$i<dataGet.datasets[13].length;$i++){
            object_datasets3[$k3] = {
                x: dataGet.datasets[13][$i],
                y: dataGet.datasets[14][$i],
                z: dataGet.datasets[15][$i]

            };
            $k3++;
        }
        var object_datasets4  = new Array();
        var $k4 = 0;
        for (var $i=0;$i<dataGet.datasets[14].length;$i++){
            object_datasets4[$k4] = {
                x: dataGet.datasets[17][$i],
                y: dataGet.datasets[18][$i],
                z: dataGet.datasets[19][$i]
            };
            $k4++;
        }
        var object_datasets5  = new Array();
        var $k5 = 0;
        for (var $i=0;$i<dataGet.datasets[15].length;$i++){
            object_datasets5[$k5] = {
                x: dataGet.datasets[21][$i],
                y: dataGet.datasets[22][$i],
                z: dataGet.datasets[23][$i]
            };
            $k5++;
        }

        var myChart = Chart.Scatter(ctxA43, {
            type: 'scatter',
            data: {
                datasets: [{
                    label: dataGet.datasets[4][1],
                    backgroundColor: colors[0],
                    data: object_datasets,
                    borderColor: colors[0],
                    pointBorderColor: colors[0],
                    pointBackgroundColor: colors[0],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[8][1],
                    backgroundColor: colors[1],
                    data: object_datasets1,
                    borderColor: colors[1],
                    pointBorderColor: colors[1],
                    pointBackgroundColor: colors[1],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[12][1],
                    backgroundColor: colors[2],
                    data: object_datasets2,
                    borderColor: colors[2],
                    pointBorderColor: colors[2],
                    pointBackgroundColor: colors[2],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[16][1],
                    backgroundColor: colors[3],
                    data: object_datasets3,
                    borderColor: colors[3],
                    pointBorderColor: colors[3],
                    pointBackgroundColor: colors[3],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[20][1],
                    backgroundColor: colors[4],
                    data: object_datasets4,
                    borderColor: colors[4],
                    pointBorderColor: colors[4],
                    pointBackgroundColor: colors[4],
                    fill: false,
                    showLine: false
                },{
                    label: dataGet.datasets[24][1],
                    backgroundColor: colors[5],
                    data: object_datasets5,
                    borderColor: colors[5],
                    pointBorderColor: colors[5],
                    pointBackgroundColor: colors[5],
                    fill: false,
                    showLine: false
                }],
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = data.datasets[tooltipItem.datasetIndex].label || 'Other';
                            var label = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].y;
                            var prest = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].z;

                            return datasetLabel + ': ' + label + '€' +  '    Expedient: ' + prest;
                        }
                    }
                },

                responsive: true,
                title: {
                    display: true,
                    text: 'Pagaments indeguts per any de naixement',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any de naixement',
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            displayFormats: {
                                day: 'YYYY-mm-dd'
                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: 'Import (€)',
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA43(callbackFunction) {
        $.ajax({
            url: '../Data/A4.3s.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA43(loadChartA43);
</script>

<script>
    var ctxA9 = document.getElementById("A9").getContext('2d');
    function loadChartA9(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA9, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors[1],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1],
                    tooltip: true
                },{
                    position: 'top',
                    label: dataGet.headers[0][2],
                    backgroundColor: colors[2],
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[2],
                    tooltip: true
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "Nombre d'usuaris per sexe i recurs",
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    xAxes: [{
                        display: true,
                        stacked: true
                    }],
                    yAxes: [{
                        display: true,
                        stacked: true,
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });
    }
    function ajaxSendA9(callbackFunction) {
        $.ajax({
            url: '../Data/A9b.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA9(loadChartA9);
</script>

<script>
    var ctxA52 = document.getElementById("A5.2").getContext('2d');
    function loadChartA52(resultData) {
        var dataGet = $.parseJSON(resultData);
        var myChart = new Chart(ctxA52, {
            type: 'pie',
            data: {
                labels: dataGet.datasets[0],
                datasets: [{
                    position: 'top',
                    label: dataGet.headers[0][1],
                    backgroundColor: colors,
                    //  borderColor: 'RGB('+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+','+ Math.floor(Math.random() * 255)+')',
                    fill: false,
                    data: dataGet.datasets[1]
                }]
            },
            options: {
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var datasetLabel = dataGet.datasets[1][tooltipItem.datasetIndex].label || dataGet.datasets[1][tooltipItem.index];
                            var label = dataGet.datasets[0][tooltipItem.index];
                            var datasetLabel1 = dataGet.datasets[2][tooltipItem.datasetIndex].label || dataGet.datasets[2][tooltipItem.index];

                            return label + ': ' +datasetLabel +'€' + ' ;  ' +  datasetLabel1 +'%';
                        }
                    }
                },
                responsive: true,
                title: {
                    display: true,
                    text: "Import per província",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        display: false,
                        ticks: {
                            fontColor: "transparent", // this here
                        },
                    }],
                    yAxes: [{
                        display: true,
                        type: 'logarithmic',
                        ticks: {mirror: true,
                            fontColor: "transparent"
                        },
                    }]
                }
            }
        });

    }
    function ajaxSendA52(callbackFunction) {
        $.ajax({
            url: '../Data/A5.2p.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendA52(loadChartA52);
</script>


<?php
include 'footer.php'
?>

</html>