<?php
	require_once("config.php");
	require_once("setup.class.php");
	$setup = new Setup();
	
	if(!$setup->writeTest())
	{
		die("Error opening config file for writting. Please check permissions.");
	}
	
	//Database setup
	if(!$setup->dbTest(DATABASE_ADDRESS, DATABASE_USER, DATABASE_PW, DATABASE_NAME, DATABASE_PORT))
	{
		$setup->promptDBinfo();
	}
	//$setup->writeConfig("OpenRPG.com", "3600", "OpenRPGUser", "OpenRPGPassword", "OpenRPG");
	
?>