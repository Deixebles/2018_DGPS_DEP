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
    <link rel="stylesheet" href="../../Resources/lib/Jquery/icons.css">
   <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table3excel.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table2excel.js"></script>
  <head>


    </head>
</head>


<?php
include 'header.php'
?>

<body>
<div class="ui container">
    <ul id="tabs-swipe-demo" class="tabs">
        <li class="tab s2"><a class="active" style="color:darkslateblue" href="#test-swipe-1">Veure per prestacions</a></li>
        <li class="tab col s2"><a  style="color:darkslateblue" href="#test-swipe-2">Veure per mesos de l'any</a></li>
    </ul>
    <div id="test-swipe-1" class="col s12 ">
        <?php
        require 'IndPrestacio.php'
        ?>
    </div>
    <div id="test-swipe-2" class="col s12">
        <?php
        require 'IndMes.php'
        ?>
    </div>
</div>



</body>

<?php
include 'footer.php'
?>

<script type="text/javascript">
    $('.toggle').click(function(e) {
        e.preventDefault();

        var $this = $(this);

        if ($this.next().hasClass('show')) {
            $this.next().removeClass('show');
            $this.next().slideUp(350);
        } else {
            $this.parent().parent().find('li .inner').removeClass('show');
            $this.parent().parent().find('li .inner').slideUp(350);
            $this.next().toggleClass('show');
            $this.next().slideToggle(350);
        }
    })
</script>
</html>



