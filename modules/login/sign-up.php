
<?php
require_once '../../modules/login/dbconfig.php';

if($user->is_loggedin()!="")
{
    $user->redirect('../../modules/login/home.php');
}

if(isset($_POST['btn-signup']))
{
    $uname = trim($_POST['txt_uname']);
    $umail = trim($_POST['txt_umail']);
    $upass = trim($_POST['txt_upass']);

    if($uname=="") {
        $error[] = "Escriu un nom d'usuari !";
    }
    else if($umail=="") {
        $error[] = "Escriu un mail !";
    }
    else if(!filter_var($umail, FILTER_VALIDATE_EMAIL)) {
        $error[] = 'Sisplau, entra una adressa correcte!';
    }
    else if($upass=="") {
        $error[] = "Escriu una contrasenya !";
    }
    else if(strlen($upass) < 6){
        $error[] = "La contrasenya ha de tenir més de 6 caràcters";
    }
    else
    {
        try
        {
            $stmt = $DB_con->prepare("SELECT user_name,user_email FROM users WHERE user_name=:uname OR user_email=:umail");
            $stmt->execute(array(':uname'=>$uname, ':umail'=>$umail));
            $row=$stmt->fetch(PDO::FETCH_ASSOC);

            if($row['user_name']==$uname) {
                $error[] = "Ho sento, ja hi ha un compte amb aquest usuari !";
            }
            else if($row['user_email']==$umail) {
                $error[] = "Ho sento, ja hi ha un compte amb aquest mail !";
            }
            else
            {
                if($user->register($fname,$lname,$uname,$umail,$upass))
                {
                    $user->redirect('../../modules/login/sign-up.php?joined');
                }
            }
        }
        catch(PDOException $e)
        {
            echo $e->getMessage();
        }
    }
}

?>

<!--

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GEOLOCA LOCA</title>

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

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sign up : cleartuts</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"  />
    <link rel="stylesheet" href="style.css" type="text/css"  />
</head>
<body>
<nav class="nav-extended" style="background: darkslateblue; height: 140px">
    <div class="nav-wrapper">
        <div class="row">
            <div class="col" style="margin-top:2%;margin-left:3rem">
                <img class="right hide-on-med-and-down" src="../../Resources/images/Geologotip.png" width="48px" height="48px"/>
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
<div class="container">
    <div class="form-container">
        <form method="post">
            <h2 style="margin-top: 120px">Registrar-se</h2>
            <?php
            if(isset($error))
            {
                foreach($error as $error)
                {
                    ?>
                    <div class="alert alert-danger">
                        <i class="glyphicon glyphicon-warning-sign"></i> &nbsp; <?php echo $error; ?>
                    </div>
                    <?php
                }
            }
            else if(isset($_GET['joined']))
            {
                ?>
                <div class="alert alert-info">
                    <i class="glyphicon glyphicon-log-in"></i> &nbsp; Registrat perfectament, clica <a href='../../modules/views/index.php'>aquí</a> per iniciar sessió
                </div>
                <?php
            }
            ?>
            <div class="form-group" style="margin-right: 50%">
                <input type="text" class="form-control" name="txt_uname" placeholder="Enter Username" value="<?php if(isset($error)){echo $uname;}?>" />
            </div>
            <div class="form-group" style="margin-right: 50%">
                <input type="text" class="form-control" name="txt_umail" placeholder="Enter E-Mail ID" value="<?php if(isset($error)){echo $umail;}?>" />
            </div>
            <div class="form-group" style="margin-right: 50%">
                <input type="password" class="form-control" name="txt_upass" placeholder="Enter Password" />
            </div>
            <div class="clearfix"></div>
            <div class="form-group">
                <button type="submit" style="background-color:darkslateblue" class="btn btn-block btn-primary" name="btn-signup">
                    <i class="glyphicon glyphicon-open-file"></i>&nbsp; Registre't
                </button>
            </div>

            <label>Si ja ets usuari: <a href="../../modules/views/index.php">Iniciar sessi</a></label>
        </form>
    </div>
</div>

</body>
</html>

-->