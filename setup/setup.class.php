<?php

class Setup
{
	private $configFile = "config.php";
	
	//Returns an array of directories in ascending order
	private function dir_list($dir)
	{
		$list = new array();
		foreach(array_diff(scandir($dir),array('.','..')) as $file)
		{
			if(is_dir($dir.'/'.$file))
			{
				$list[]=$file;
			}
		}
		return $list;
	}

	//test if we can connect to the database
	function dbTest($dbhost, $dbuser, $dbpass, $dbname, $dbport="3306")
	{
		$status = false;
	
		$conn = mysql_connect($dbhost.":".$dbport, $dbuser, $dbpass);
		
		if($conn)
		{
			if(mysql_select_db($dbname, $conn))
			{
				$status = true;
			}
			
			mysql_close($conn);
		}
		
		return $status;
	}
	
	//setup the database
	function dbSetup($dbhost, $dbuser, $dbpass, $dbname, $dbport="3306")
	{
		$db_major = 00;
		$db_minor = 00;
		$db_build = 00;
		$installed = "01/01/2010";
		
		require_once($this->configFile);

		$conn = mysql_connect($dbhost.":".$dbport, $dbuser, $dbpass);
		
		if($conn)
		{
			mysql_select_db($dbname, $conn);
			
			$result = mysql_query("SELECT major, minor, build, installed FROM version ORDER BY installed DESC, LIMIT 1");
			
			while ($row = mysql_fetch_array($result, MYSQL_ASSOC))
			{
				$db_major = $row['major'];
				$db_minor = $row['minor'];
				$db_build = $row['build'];
				$installed = $row['installed'];
			}
			
			mysql_free_result($result);	
		}
		
		//Files will be located under SQL directory followed by version number and finally, patch date.
		//Example: SQL/01.00.00/2011.08.03
		//Files will be sorted ascending order and will be processed in that fashion
		//Latest version number and date of last update will be stored in database
		$db_version = $db_major . $db_minor . $db_build;
		foreach(dir_list("SQL") as $version)
		{				
			if($db_version <= $version)
			{ 
				//get all SQL files with a .sql extension.
				$updates = glob("SQL/".$version. "/*.sql");
				
				foreach($updates as $updateScript)
				{
					if($updateScript > $installed )
					{
						mysql_query("SOURCE SQL/".$version."/".$updateScript) or die("Error setting up database.<br />\nFile: SQL/".$version."/".$updateScript."<br />\n".mysql_error());
					}
				}
			}
			
			//now that the sql file has been sourced, it is the latest version
			$db_version = $version;
		}
		
		list($major, $minor, $build) = explode($db_version);
		mysql_query("INSERT INTO version (installed, major, minor, build) VALUES (CURRENT_DATE(), $major, $minor, $build)");
		
		mysql_close($conn);	
	}
	
	//test to check if config is writable
	function writeTest()
	{
		$status = false;
		$fh = false;
		
		if(file_exists($this->configFile))
		{
			$fh = fopen($this->configFile, 'a');
		}
		else
		{
			die($this->configFile." not found. Try placing ".$this->configFile." into the setup directory.");
		}
		
		if($fh)
		{
			$status = true;
		}
		
		return $status;
	}
	
	//save db config
	function writeDBConfig($dbhost, $dbport, $dbuser, $dbpass, $dbname)
	{
		$config = file_get_contents($this->configFile);
		
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
		file_put_contents($this->configFile, $config);	
		
	}
	
	
	//saves google api key
	function writeGoogleAPI($key)
	{
		$config = file_get_contents($this->configFile);
		
		//write API key
		$config = preg_replace('/GOOGLE_API",\s*"[^"]*/', 'GOOGLE_API", "'.$key, $config);
		
		//save
		file_put_contents($this->configFile, $config);	
	}
	
	
	
}
?>