<?php
	require_once('../../modules/login/session.php');
	require_once('../../modules/login/class.user.php');
	$user_logout = new USER();

	if($user_logout->is_loggedin()!="")
	{
		$user_logout->redirect('../../modules/login/home.php');
	}
	if(isset($_GET['logout']) && $_GET['logout']=="true")
	{
#		$user_logout->doLogout();
		session_destroy();
        $user_logout->redirect('../../modules/login/login.php');
	}
