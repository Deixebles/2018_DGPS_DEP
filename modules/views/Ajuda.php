<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajuda</title>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link  rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link  rel="stylesheet" href="../../Resources/customCss/custom.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans|Eagle+Lake|Lora|Merriweather+Sans|Open+Sans|PT+Sans|PT+Serif|Playfair+Display|Roboto|Roboto+Condensed|Slabo+27px" rel="stylesheet">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.table2excel.js"></script>
</head>

<body>


<?php
include 'header.php'
?>

<script>
    $(document).ready(function(){
        $('#completa1').click(function(){
            $('#video1')[0].webkitEnterFullScreen();
            $('#video1')[0].play();
        });
        $('#completa2').click(function(){
            $('#video2')[0].webkitEnterFullScreen();
            $('#video2')[0].play();
        });
        $('#completa3').click(function(){
            $('#video3')[0].webkitEnterFullScreen();
            $('#video3')[0].play();
        });
        $('#completa4').click(function(){
            $('#video4')[0].webkitEnterFullScreen();
            $('#video4')[0].play();
        });
    });


$(document).ready(function(){
    $('.carousel.carousel-slider').carousel({fullWidth: true});
});


</script>





<div class="container">
<div class="row">
    <h4 class="left" style="color: yellowgreen;margin-top: 3%">Llegenda<hr style=" border-top: 1px solid yellowgreen; width:900%"></h4>
</div>
    <div class="row">
        <div class="col s2">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Informe: </h5>
        </div>
        <div class="col s8">
            <h6> En aquesta pàgina trobem la quantitat de prestacions i les altes d'aquell
                més tant en persones com en capital destinat per cada grau i cada mes;
                a la segona pestanya trobem el mateix però per cada més trobem les diferentes pensions</h6>
        </div>
    </div>
    <div class="row">
        <div class="col s2">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Resum: </h5>
        </div>
        <div class="col s8">
            <h6> Podem trobar dues taules, una de les quals es el total de quantitat de persones i capital
            (de tots els graus), per cada un dels grups de prestacions.
            A la segona taula trobem un resum del total de prestacions, i de les seves baixes.</h6>
        </div>
    </div>
    <div class="row">
        <div class="col s2">
            <h5 class="left" style="color: yellowgreen;margin-top: 3%">Històric: </h5>
        </div>
        <div class="col s8">
            <h6> Es troben les evolucions del temps de les diferents prestacions.</h6>
        </div>
    </div>
    <!--creem carousel per a combinacio xula de imatges-->

    <div class="col s5" style="margin-left: 2%">
        <h4 class="left" style="color: yellowgreen;margin-top: 3%">IMATGES<hr style=" border-top: 1px solid yellowgreen; width:900%"></h4>


        <div class="row">

        <div class="carousel carousel-slider center black-text"!important data-indicators="true">
            <a class="carousel-item black-text"  href="#one!">
                <img src="../../Resources/images/boton1.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2 style="border:red">CLICK 1: GUARDAR / FOTOGRAFIAR GRÀFIC</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#two!">
                <img src="../../Resources/images/boton2.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 2: ENFOCAR I APROPAR LA ZONA SEL·LECCIONADA</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#tree!">
                <img src="../../Resources/images/boton3.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 3: MOURE'S PER L'INTERIOR DEL GRÀFIC</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#four!">
                <img src="../../Resources/images/boton4.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 4: SELECCIONAR ÀREA</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#five!">
                <img src="../../Resources/images/boton5.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 5: ZOOM DE TOT EL GRÀFIC</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#six!">
                <img src="../../Resources/images/boton6.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 6: RETORNAR AL GRÀFIC AMB LES DIMENSIONS ORIGINALS</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#seven!">
                <img src="../../Resources/images/boton7.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 7: ESPECIFICAR COORDENADES DELS PUNTS</h2></span>
            </a>
            <a class="carousel-item black-text"  href="#seven!">
                <img src="../../Resources/images/boton8.png">
                <span style="position: absolute; color: black; left: 38%; top: 80%;"> <h2>CLICK 8: DOBLE CLICK PER SELECCIONAR UN SOL DEPARTAMENT</h2></span>
            </a>
        </div>
        <h6 class="right" style="0rem">Arrastra amb el ratolí cap a l´esquerra o dreta </h6>
            <img class="right" src="../../Resources/images/info.png">
        </div>
    </div>


        <div  class="col s12" style="margin-left: 2%">
            <div class="row">
                <h4 class="left" style="color: yellowgreen;margin-top: 6%">VIDEOS<hr style="border-top: 1px solid yellowgreen; width:1100%"></h4>
            </div>
            <div class="row"  style="margin-top: 3rem">
                <div class="col s6 center">
                    <h5 style="font-size: 2em" class="center">Visió general</h5>
                    <video id="video1" width="320" height="240" controls>
                        <source src="../../Resources/images/VisioGeneral.webm"  type='video/webm; codecs="vp8, vorbis"'>
                    </video><br />
                    <button style="background: yellowgreen;" id="completa1" class="responsive waves-effect waves-light btn">Pantalla completa</button>
                </div>

                <div class="col s6 center">
                    <h5 style="font-size: 2em" class="center">Seleccionar entitats</h5>
                    <video id="video2" width="320" height="240" controls>
                        <source src="../../Resources/images/Seleccionar.webm"  type='video/webm; codecs="vp8, vorbis"'>
                    </video><br />
                    <button style="background: yellowgreen;" id="completa2" class="responsive waves-effect waves-light btn">Pantalla completa</button>
                </div>
            </div>

            <div class="row"  style="margin-top: 6rem">
                <div class="col s6 center">
                    <h5 style="font-size: 2em" class="center">Anàlisis gràfic</h5>
                    <video id="video3" width="320" height="240" controls>
                        <source src="../../Resources/images/Analisis.webm"  type='video/webm; codecs="vp8, vorbis"'>
                    </video><br />
                    <button style="background: yellowgreen;" id="completa3" class="responsive waves-effect waves-light btn">Pantalla completa</button>

                </div>

                <div class="col s6 center">
                    <h5 style="font-size: 2em" class="center">Guardar el gràfic</h5>
                    <video id="video4" width="320" height="240" controls>
                        <source src="../../Resources/images/GuardarImatge.webm"  type='video/webm; codecs="vp8, vorbis"'>
                    </video><br />
                    <button style="background: yellowgreen;" id="completa4" class="responsive waves-effect waves-light btn">Pantalla completa</button>
                </div>
            </div>

        </div>
</div>

        <footer class="page-footer"  style="background: darkgray; margin-top: 6rem">
            <div class="container">
                <div class="row">
                    <div class="center">
                        <h5 style="font-weight: 200" class="white-text">everis <span style="color:white">BPO</span></h5>
                    </div>
                </div>
            </div>
            <div class="footer-copyright">
                <div class="container center">
                    <a  style="font-weight:200" class="white-text text-lighten-4 " href="#!">Todos los derechos reservados</a>
                </div>
            </div>
        </footer>
</body>




