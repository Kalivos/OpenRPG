<?php

class Forms
{
	function displayDatabaseForm($dbhost, $dbuser, $dbpass, $dbname, $dbport)
	{
		print "<form method='POST'>\n"
				."<table>\n"
					."<tr><td>Host</td><td><input type='text' name='host' value='".$dbhost."'></td></tr>\n"
					."<tr><td>Username</td><td><input type='text' name='user' value='".$dbuser."'></td></tr>\n"
					."<tr><td>Password</td><td><input type='password' name='pass' value='".$dbpass."'></td></tr>\n"
					."<tr><td>Database</td><td><input type='text' name='name' value='".$dbname."'></td></tr>\n"
					."<tr><td>Port</td><td><input type='text' name='port' value='".$dbport."'></td></tr>\n"
					."<tr><td colspan='2'><input type='submit' value='Submit' /></td></tr>\n"
				."</table>\n"
			."</form>";
	}
	
	function displayAdminForm()
	{
	
	}
	
	function displayGoogleForm()
	{
	
	}
	
	function displayComplete()
	{
		echo "The installation has completed!";
	}
}