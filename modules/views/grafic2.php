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
    <!--    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>-->

    <script type="text/javascript" src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <script  src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js" ></script >
    <script  src = "https://cdn.jsdelivr.net/npm/flexio-sdk-js@1.16.2" ></script >
</head>


<body>


    <script>
        function getRandomColor() {
            var letters = '0123456789ABCDEF'.split('');
            var color = '#';
            for (var i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        $.ajax({
            type: 'post',
            url: 'https://www.flex.io/api/v1/pipes/flexio-chart-js-csv-to-json/run?stream=0',

            beforeSend: function(xhr) {
                xhr.setRequestHeader('Authorization', 'Bearer nmgzsqppgwqbvkfhjdjd');
            },
            data: $('form').serialize(),
            dataType: "json",
            success: function(content) {
                // render the JSON result from from the Flex.io pipe --> renderizar el resultado JSON del tubo Flex.io
                $("#flexio-result-data").text(JSON.stringify(content, null, 2))

                var first_item = _.get(content, '[0]', {})

                var column_labels = _.map(_.omit(first_item, ['os']), function(val, key) {
                    if (key != 'os')
                        return key
                })

                // use Lodash to reformat the JSON for use with Chart.js --> use Lodash para reformatear el JSON para usarlo con Chart.js
                var datasets = _.map(content, function(item) {
                    // use the 'os' column as our label   --> use la columna 'os' como nuestra etiqueta
                    var item_label = _.get(item, 'os', 'Not Found')

                    // create an array of number values from each item's JSON object
                    // crea una matriz de valores numéricos del objeto JSON de cada elemento
                    var item_values = _.map(_.omit(item, ['os']), function(val) {
                        return parseFloat(val)
                    })

                    return {
                        label: item_label,
                        data: item_values,
                        backgroundColor: getRandomColor()
                    }
                })


                var chart_data = {
                    labels: column_labels,
                    datasets: datasets
                }

                // render the JSON result after mapping the data with Lodash
                // renderiza el resultado JSON después de mapear los datos con Lodash
                $("#chart-data").text(JSON.stringify(chart_data, null, 2))
                // render the chart using Chart.js
                // renderiza el gráfico usando Chart.js
                var ctx = document.getElementById("canvas1").getContext("2d");

                window.my_chart = new Chart(ctx, {
                    type: 'bar',
                    data: chart_data,
                    options: {
                        responsive: true,
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Use Flex.io to Create a Chart With Chart.js Directly From a CSV File'
                        }
                    }
                });
            }
        });

        for(var b in window) {
            if(window.hasOwnProperty(b)) console.log(b);
        }

    </script>





<!--<div id="chartContainer" style="width:100%; height:300px;"></div>-->

    <div id="Chart">
    <canvas id="canvas1"></canvas>
</div>

</body>



</html>



<!--







<script type="text/javascript">
    window.onload = function() {
        var dataPoints = [];

        function getDataPointsFromCSV(csv) {
            var dataPoints = csvLines = points = [];
            csvLines = csv.split(/[\r?\n|\r|\n]+/);

            for (var i = 0; i < csvLines.length; i++)
                if (csvLines[i].length > 0) {
                    points = csvLines[i].split(",");
                    dataPoints.push({
                        x: parseFloat(points[0]),
                        y: parseFloat(points[1])
                    });
                }
            return dataPoints;
        }

        $.get("dataPoints.csv", function(data) {
            var chart = new CanvasJS.Chart("chartContainer", {
                title: {
                    text: "Chart from CSV",
                },
                data: [{
                    type: "line",
                    dataPoints: getDataPointsFromCSV(data)
                }]
            });

            chart.render();

        });
    }
</script>
-->