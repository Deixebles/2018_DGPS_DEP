
<div class="container">

    <div class="row">
        <canvas  id="B11" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B12" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B13" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B2" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B3" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B4" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B5" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B6" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B7" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="B8" width="2" height="1"></canvas>
    </div>

</div>
</body>

<script>
    var colors = ["rgb(230,240,120)","rgb(0,255,127)","rgb(46,139,87)","rgb(175,238,238)","rgb(95,158,160)", "rgb(123,104,238)",
        "rgb(0,250,154)", "rgb(0,255,255)", "rgb(0,191,255)", "rgb(25,25,112)" , "rgb(0,128,0)" , "rgb(173,255,47)" , "rgb(128,0,128)"];
    var ctxB11= document.getElementById("B11").getContext('2d');
    function loadChartB11(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB11, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
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
                    text: 'Import total segons el recurs',
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

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

    function ajaxSendB11(callbackFunction) {
        $.ajax({
            url: '../Data/B1.1.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB11(loadChartB11);
</script>

<script>
    var ctxB12= document.getElementById("B12").getContext('2d');
    function loadChartB12(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB12, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
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
                    text: 'Import total',
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

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

    function ajaxSendB12(callbackFunction) {
        $.ajax({
            url: '../Data/B1.2.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB12(loadChartB12);
</script>
<script>
    var ctxB13= document.getElementById("B13").getContext('2d');
    function loadChartB13(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB13, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
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
                    text: 'Usuaris totals per recurs',
                    fontSize: 20
                },
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });

    }

    function ajaxSendB13(callbackFunction) {
        $.ajax({
            url: '../Data/B1.3.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB13(loadChartB13);
</script>
<script>
    var ctxB2= document.getElementById("B2").getContext('2d');
    function loadChartB2(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB2, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Import total segons el tipus de cartera',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

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

    function ajaxSendB2(callbackFunction) {
        $.ajax({
            url: '../Data/B2.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB2(loadChartB2);
</script>
<script>
    var ctxB3= document.getElementById("B3").getContext('2d');
    function loadChartB3(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB3, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: "Usuaris donats d'alta o de baixa (defunció o altres motius)",
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });

    }

    function ajaxSendB3(callbackFunction) {
        $.ajax({
            url: '../Data/B3.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB3(loadChartB3);
</script>
<script>
    var ctxB4= document.getElementById("B4").getContext('2d');
    function loadChartB4(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB4, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Usuaris per diferents motius de baixa',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });

    }

    function ajaxSendB4(callbackFunction) {
        $.ajax({
            url: '../Data/B4.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB4(loadChartB4);
</script>
<script>
    var ctxB5= document.getElementById("B5").getContext('2d');
    function loadChartB5(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB5, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Mitjana de temps de retard pels diferents motius de baixa',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: 'Dies',
                            display: true
                        }
                    }]
                }
            }
        });
    }

    function ajaxSendB5(callbackFunction) {
        $.ajax({
            url: '../Data/B5.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB5(loadChartB5);
</script>
<script>
    var ctxB6= document.getElementById("B6").getContext('2d');
    function loadChartB6(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
          /*  if ($i < 3) {
                object_datasets[$k] = {
                    type: 'bar',
                    data: dataGet.datasets[$i],
                    label: dataGet.headers[0][$i],
                    // backgroundColor: colors[$i],
                    borderColor: colors[$i - 1],
                   // backgroundColor: 'transparent',
                }
            } else{*/
                object_datasets[$k] = {
                    type: 'line',
                    data: dataGet.datasets[$i],
                    label: dataGet.headers[0][$i],
                    // backgroundColor: colors[$i],
                    borderColor: colors[$i - 1],
                    backgroundColor: 'transparent',
                    fill: false,
                }

        //    };
            $k++;
        };

        var myChart = Chart.Scatter(ctxB6, {
            type: 'bar',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Pagaments indeguts',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

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

    function ajaxSendB6(callbackFunction) {
        $.ajax({
            url: '../Data/B6.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB6(loadChartB6);
</script>
<script>
    var ctxB7= document.getElementById("B7").getContext('2d');
    function loadChartB7(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB7, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Endarreriments',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

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

    function ajaxSendB7(callbackFunction) {
        $.ajax({
            url: '../Data/B7.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB7(loadChartB7);
</script>
<script>
    var ctxB8= document.getElementById("B8").getContext('2d');
    function loadChartB8(resultData) {

        var dataGet = $.parseJSON(resultData);
        var object_datasets  = new Array();
        var $k = 0;
        //console.log(dataGet.datasets.length-1);
        //console.log(dataGet.datasets[6]);

        for (var $i=1;$i<(dataGet.datasets.length);$i++){
            object_datasets[$k] = {
                data: dataGet.datasets[$i],
                label: dataGet.headers[0][$i],
                // backgroundColor: colors[$i],
                borderColor: colors[$i-1],
                backgroundColor: 'transparent',
            };
            $k++;
        };
        console.log(dataGet.datasets[0]);

        var myChart = Chart.Scatter(ctxB8, {
            type: 'line',
            data: {
                labels: dataGet.datasets[0],
                datasets: object_datasets,
                fill: false,
                showLine: false,

            },
            options: {
                tooltips: {
                    mode: 'index',
                    intersect: true,
                },
                responsive: true,
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
                    text: 'Usuaris per grau',
                    fontSize: 20
                },
                scales: {
                    xAxes: [{
                        ticks: {
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Any'
                        },
                        type: 'time',
                        position: 'bottom',
                        time: {
                            unit: 'month',
                            displayFormats: {

                            }
                        }
                    }],
                    yAxes: [{
                        type: 'linear',
                        scaleLabel: {
                            labelString: "Número d'usuaris",
                            display: true
                        }
                    }]
                }
            }
        });

    }

    function ajaxSendB8(callbackFunction) {
        $.ajax({
            url: '../Data/B8.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendB8(loadChartB8);
</script>


