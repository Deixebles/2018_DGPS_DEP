<!DOCTYPE HTML>
<html>
<head>
    <script>
        window.onload = function () {

            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                title:{
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
                        { x: new Date(2017, 6, 3),  y: [4, 6, 8, 9, 7] },
                        { x: new Date(2017, 6, 4),  y: [5, 6, 7, 8, 6.5] },
                        { x: new Date(2017, 6, 5),  y: [4, 5, 7, 8, 6.5] },
                        { x: new Date(2017, 6, 6),  y: [3, 5, 6, 9, 5.5] },
                        { x: new Date(2017, 6, 7),  y: [6, 8, 10, 11, 8.5] },
                        { x: new Date(2017, 6, 8),  y: [5, 7, 9, 12, 7.5] },
                        { x: new Date(2017, 6, 9),  y: [4, 6, 8, 9, 7] }
                    ]
                }]
            });
            chart.render();

        }
    </script>
</head>
<body>
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>