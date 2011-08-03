<?php

class Setup
{

	//test if we can connect to the database
	function dbTest($dbhost, $dbuser, $dbpass, $dbname, $dbport="3600")
	{
		$status = false;
	
		$conn = mysql_connect($dbhost.":".$dbport, $dbuser, $dbpass);
		
		if($conn)
		{
			if(mysql_select_db($dbname, $conn))
			{
				$status = true;
			}
		}
		
		return $status;
	}
	
	function promptDBinfo()
	{
		
	}
	
	//setup the database
	function dbSetup($dbhost, $dbuser, $dbpass, $dbname, $dbport="3600")
	{
		$conn = mysql_connect($dbhost.":".$dbport, $dbuser, $dbpass) or die("Error connecting to database. ".mysql_error());
		mysql_select_db($dbname, $conn) or die("Error selecting database. ".mysql_error());
		
		//TODO:
		//This needs to be rewritten to SOURCE update files.
		//Files will be located under SQL directory followed by version number and finally, patch date.
		//Example: SQL/01.00.00/2011.08.03
		//Files will be sorted ascending order and will be processed in that fashion
		//Latest version number and date of last update will be stored in database
		mysql_query("SOURCE setup.sql") or die("Error setting up database. ".mysql_error());
	}
	
	//test to check if config is writable
	function writeTest()
	{
		$status = false;
		$fh = fopen("config.php", 'a+');
		
		if($fh)
		{
			$status = true;
		}
		
		return $status;
	}
	
	//save config file
	function writeConfig($dbhost, $dbport, $dbuser, $dbpass, $dbname)
	{
		$config = file_get_contents("config.php");
		
		//write dbName
		$config = preg_replace('/DATABASE_ADDRESS",\s*"[^"]*/', 'DATABASE_ADDRESS", "'.$dbhost, $config);
		
		//write dbPort
		$config = preg_replace('/DATABASE_PORT",\s*"[^"]*/', 'DATABASE_PORT", "'.$dbport, $config);
		
		//write dbUser
		$config = preg_replace('/DATABASE_USER",\s*"[^"]*/', 'DATABASE_USER", "'.$dbuser, $config);
		
		//write dbPass
		$config = preg_replace('/DATABASE_PW",\s*"[^"]*/', 'DATABASE_PW", "'.$dbpass, $config);
		
		//write dbName
		$config = preg_replace('/DATABASE_NAME",\s*"[^"]*/', 'DATABASE_NAME", "'.$dbname, $config);
		
		//save
		file_put_contents("config.php", $config);
	}
	
	
	
}
?>