<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
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
    <script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js"></script>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

</head>
<body>
<button onclick="ajaxSend(showAjaxData);">Show data from AJAX</button>
<button onclick="ajaxSend(loadChart);">Generate Chart</button>
<div id="div1"></div>
<canvas id="myChart" width="1" height="1"></canvas>
<script>
    var colors = ["rgb(230,240,120)","rgb(0,255,127)","rgb(46,139,87)","rgb(175,238,238)","rgb(95,158,160)", "rgb(123,104,238)"]
    var ctx = document.getElementById("myChart").getContext('2d');
    function loadChart(resultData) {
        var dataGet = $.parseJSON(resultData);
        var object_datasets = new Array();
        var $k = 0;
        console.log(dataGet.headers[0][1]);
        console.log(dataGet.datasets.length);
        console.log(dataGet.datasets[1]);
    }
    window.onload = function () {
        ajaxSend(loadChart);
        var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true,
            title: {
                text: "Daily Sleep Statistics of Age Group 12 - 20"
            },
            axisX: {
                valueFormatString: "DDD"
            },
            axisY: {
                title: "Sleep Time (in Hours)"
            },
            data: [{
                type: "boxAndWhisker",
                xValueFormatString: "DDDD",
                yValueFormatString: "#0.0 Hours",
                dataPoints: [
                    {x: new Date(2017, 6, 3), y: dataGet.datasets[1]},
                    {x: new Date(2017, 6, 4), y: [5, 6, 7, 8, 6.5]},
                    {x: new Date(2017, 6, 5), y: [4, 5, 7, 8, 6.5]},
                    {x: new Date(2017, 6, 6), y: [3, 5, 6, 9, 5.5]},
                    {x: new Date(2017, 6, 7), y: [6, 8, 10, 11, 8.5]},
                    {x: new Date(2017, 6, 8), y: [5, 7, 9, 12, 7.5]},
                    {x: new Date(2017, 6, 9), y: [4, 6, 8, 9, 7]}
                ]
            }]
        });
        chart.render();
    }
    function showAjaxData(result) {
        $("#div1").html(result);
    }
    function ajaxSend(callbackFunction) {
        $.ajax({
            url: '../Data/boxplot.php',
            type: 'post',
            success: function (result) {
                callbackFunction(result);
            }
        });
    }
</script>

<div id="chartContainer" style="height: 300px; width: 100%;"></div>

</body>
</html>
</html>