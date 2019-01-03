<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GEOANALISI</title>

    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/jquery.maphilight.js"></script>
    <script type="text/javascript" src="../../Resources/lib/Jquery/loader.js"></script>
    <script type="text/javascript" src="../../Resources/lib/materialize/js/materialize.js"></script>
    <link  rel="stylesheet" href="../../Resources/lib/materialize/css/materialize.css">
    <link  rel="stylesheet" href="../../Resources/customCss/custom.css">
    <link rel="stylesheet" href="../../Resources/lib/Jquery/loader.css">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans|Eagle+Lake|Lora|Merriweather+Sans|Open+Sans|PT+Sans|PT+Serif|Playfair+Display|Roboto|Roboto+Condensed|Slabo+27px"
          rel="stylesheet">
    <script type="text/javascript" src="../../Resources/lib/javascripts/plotly-latest.min.js"></script>
</head>
<!--Empieza body!-->
<body>
<nav class="nav-extended" style="background: darkslateblue; height: 140px">
    <div class="nav-wrapper">
        <div class="row">
            <div class="col" style="margin-top:2%;margin-left:3rem ">
                <img class="right hide-on-med-and-down" src="../../Resources/images/Geologotip.png" width="48px" height="48px"/><!-- notice the "circle" class -->
            </div>
            <div class="col" style="margin-top: 2%">
              <span class="brand-logo" style="font-family: 'Open Sans', sans-serif;">
                Geoanàlisi PNC
              </span>
            </div>
            <img class="brand-logo" href="#" style="margin-top:2% ;position:relative: float ; right: 2%" src="../../Resources/images/everis_pq_ntt2.png"></img>

        </div>
    </div>
</nav>

<?php
require_once '../../modules/login/dbconfig.php';

if($user->is_loggedin()!="")
{
    $user->redirect('../../modules/views/index.php');
}

if(isset($_POST['btn-login']))
{
    $uname = $_POST['txt_uname_email'];
    $umail = $_POST['txt_uname_email'];
    $upass = $_POST['txt_password'];

    if($user->login($uname,$umail,$upass))
    {
        $user->redirect('../../modules/views/index.php');
    }
    else
    {
        $error = "Wrong Details !";
    }
}
?>

<div class="container s6">
    <div class="form-container">
        <form method="post">
            <h2 style="margin-top: 150px">Iniciar Sessió</h2>
            <?php
            if(isset($error))
            {
                ?>
                <div class="alert alert-danger">
                    <i class="glyphicon glyphicon-warning-sign"></i> &nbsp; <?php echo $error; ?> !
                </div>
                <?php
            }
            ?>
            <div class="form-group" style="margin-right: 50%">
                <input type="text" class="form-control" name="txt_uname_email" placeholder="Username or E mail ID" required />
            </div>
            <div class="form-group" style="margin-right: 50%">
                <input type="password" class="form-control" name="txt_password" placeholder="Your Password" required />
            </div>
            <div class="clearfix"></div>
            <div class="form-group">
                <button style="background-color:darkslateblue" type="submit" name="btn-login" class="btn btn-block btn-primary">
                    <i class="glyphicon glyphicon-log-in"></i>Iniciar Sessió
                </button>
            </div>

            <!-- <label>Si encara no ets usuari: <a href="sign-up.php">Registrar-se</a></label> -->
        </form>
    </div>
</div>
</body>
</html>



