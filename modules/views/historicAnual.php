
<div class="container">
    <div class="row">
        <canvas  id="C11" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C12" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C13" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C2" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C3" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C4" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C5" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C6" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C7" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C8" width="2" height="1"></canvas>
    </div>
    <div class="row">
        <canvas  id="C9" width="2" height="1"></canvas>
    </div>


</div>
</body>

<script>
    var colors = ["rgb(230,240,120)","rgb(0,255,127)","rgb(46,139,87)","rgb(175,238,238)","rgb(95,158,160)", "rgb(123,104,238)",
        "rgb(0,250,154)", "rgb(0,255,255)", "rgb(0,191,255)", "rgb(25,25,112)" , "rgb(0,128,0)" , "rgb(173,255,47)" , "rgb(128,0,128)"];
    var ctxC11= document.getElementById("C11").getContext('2d');
    function loadChartC11(resultData) {

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

        var myChart = Chart.Scatter(ctxC11, {
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
                    text: 'Import total segons el recurs',
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

    function ajaxSendC11(callbackFunction) {
        $.ajax({
            url: '../Data/C1.1.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC11(loadChartC11);
</script>
<script>
    var ctxC12= document.getElementById("C12").getContext('2d');
    function loadChartC12(resultData) {

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

        var myChart = Chart.Scatter(ctxC12, {
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
                    text: 'Import total',
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

    function ajaxSendC12(callbackFunction) {
        $.ajax({
            url: '../Data/C1.2.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC12(loadChartC12);
</script>

<script>
    var ctxC13= document.getElementById("C13").getContext('2d');
    function loadChartC13(resultData) {

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

        var myChart = Chart.Scatter(ctxC13, {
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
                    text: 'Usuaris segons el recurs',
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

    function ajaxSendC13(callbackFunction) {
        $.ajax({
            url: '../Data/C1.3.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC13(loadChartC13);
</script>
<script>
    var ctxC2= document.getElementById("C2").getContext('2d');
    function loadChartC2(resultData) {

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

        var myChart = Chart.Scatter(ctxC2, {
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

    function ajaxSendC2(callbackFunction) {
        $.ajax({
            url: '../Data/C2.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC2(loadChartC2);
</script>
<script>
    var ctxC3= document.getElementById("C3").getContext('2d');
    function loadChartC3(resultData) {

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

        var myChart = Chart.Scatter(ctxC3, {
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

    function ajaxSendC3(callbackFunction) {
        $.ajax({
            url: '../Data/C3.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC3(loadChartC3);
</script>
<script>
    var ctxC4= document.getElementById("C4").getContext('2d');
    function loadChartC4(resultData) {

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

        var myChart = Chart.Scatter(ctxC4, {
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

    function ajaxSendC4(callbackFunction) {
        $.ajax({
            url: '../Data/C4.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC4(loadChartC4);
</script>
<script>
    var ctxC5= document.getElementById("C5").getContext('2d');
    function loadChartC5(resultData) {

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

        var myChart = Chart.Scatter(ctxC5, {
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

    function ajaxSendC5(callbackFunction) {
        $.ajax({
            url: '../Data/C5.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC5(loadChartC5);
</script>
<script>
    var ctxC6= document.getElementById("C6").getContext('2d');
    function loadChartC6(resultData) {

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

        var myChart = Chart.Scatter(ctxC6, {
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

    function ajaxSendC6(callbackFunction) {
        $.ajax({
            url: '../Data/C6.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC6(loadChartC6);
</script>
<script>
    var ctxC7= document.getElementById("C7").getContext('2d');
    function loadChartC7(resultData) {

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

        var myChart = Chart.Scatter(ctxC7, {
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

    function ajaxSendC7(callbackFunction) {
        $.ajax({
            url: '../Data/C7.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC7(loadChartC7);
</script>
<script>
    var ctxC8= document.getElementById("C8").getContext('2d');
    function loadChartC8(resultData) {

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

        var myChart = Chart.Scatter(ctxC8, {
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

    function ajaxSendC8(callbackFunction) {
        $.ajax({
            url: '../Data/C8.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC8(loadChartC8);
</script>

<script>
    var ctxC9= document.getElementById("C9").getContext('2d');
    function loadChartC9(resultData) {

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

        var myChart = Chart.Scatter(ctxC9, {
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
                    text: 'Altes per recurs',
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

    function ajaxSendC9(callbackFunction) {
        $.ajax({
            url: '../Data/C9.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
    ajaxSendC9(loadChartC9);
</script>
