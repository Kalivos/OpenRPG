<?php
	require_once("config.php");
	require_once("setup.class.php");
	
	$setup = new Setup();
	$error = "";
	$stage = "";
	
	abstract class Stage
	{
		const DATABASE = 0;
		const ADMIN = 1;
		const GOOGLE = 2;
		const COMPLETE = 3;
		
		function Next($current)
		{
			if($current < COMPLETE)
			{
				$current++;
			}
			
			return $current;
		}
	}
	
	if(!$setup->writeTest())
	{
		$error = "Error opening config file for writting. Please check file permissions.";
	}
	
################# DATABASE SETUP ########################

	$dbhost = DATABASE_ADDRESS;
	$dbuser = DATABASE_USER;
	$dbpass = DATABASE_PW;
	$dbname = DATABASE_NAME;
	$dbport = DATABASE_PORT;
	
	//Database setup
	if($setup->dbTest(DATABASE_ADDRESS, DATABASE_USER, DATABASE_PW, DATABASE_NAME, DATABASE_PORT) == false)
	{
		$stage = Stage::DATABASE;

		//set vars from POST or from config if POST isn't set
		if( $_POST != NULL )
		{
			//sanatize input
			$dbhost = trim(addslashes($_POST['host']));
			$dbuser = trim(addslashes($_POST['user']));
			$dbpass = addslashes($_POST['pass']); //password could end with a space
			$dbname = trim(addslashes($_POST['name']));
			$dbport = trim(addslashes($_POST['port']));
		}
		
		//check if they are submitting data
		if($dbhost != "" && $dbuser != "" && $dbpass != "" && $dbname != "" && $dbport != "" )
		{
			if(!$setup->dbTest($dbhost, $dbuser, $dbpass, $dbname, $dbport))
			{
				$error = "Could not connect to database with provided information.";
			}
			else
			{	
				$setup->writeDBConfig($dbhost, $dbport, $dbuser, $dbpass, $dbname);
				$setup->dbSetup($dbhost, $dbuser, $dbpass, $dbname, $dbport);
				$stage = Stage::Next($stage);
			}
		}
	}
	else
	{
		//run the databse setup
		$setup->dbSetup($dbhost, $dbuser, $dbpass, $dbname, $dbport);
		$stage = Stage::Next($stage);
	}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Installation</title>
		<style type="text/css">
		body {
			background-color: #999999;
			font-size:12px;
			font-family:Verdana, Arial, Helvetica, sans-serif;
		}
		div#outer {
			width: 80%;
			background-color:#FFFFFF;
			margin-top: 50px;
			margin-bottom: 50px;
			margin-left: auto;
			margin-right: auto;
			padding: 0px;
			border: thin solid #000000;
		}
		div#header {
			padding: 15px;
			margin: 0px;
			text-align: center;
		}
		div#nav {
			width: 25%;
			padding: 10px;
			margin-top: 1px;
			float: left;
		}
		div#main {
			margin-left: 30%;
			margin-top: 1px;
			padding: 10px;
		}
		div#error {
			color: red;
		}
		</style>
		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
	</head>
	<body>
	<div id="outer">
		<div id="header">
			<h2>Installation</h2>
		</div>
		<div id="nav">
			<h4>Stages</h4>
			<ul>
				<li>Database</li>
				<li>Admin</li>
				<li>Google</li>
			</ul>
		</div>
		<div id="main">		
			<?php
				echo "<div id='error'>$error</div>";
			
				require_once("forms.class.php");
				$formsClass = new Forms();
				
				switch($stage)
				{
					case Stage::DATABASE:
						$formsClass->displayDatabaseForm($dbhost, $dbuser, $dbpass, $dbname, $dbport);
						break;
					case Stage::ADMIN:
						$formsClass->displayAdminForm();
						break;
					case Stage::GOOGLE:
						$formsClass->displayGoogleForm();
						break;
					case Stage::COMPLETE:
						$formsClass->displayComplete();
						break;
					default:
						echo "There has been an error. The installer lost track of install progress.";					
				}
			?>
		</div>
	</div>
	</body>
</html>