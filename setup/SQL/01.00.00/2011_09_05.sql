alter table `version` 
   change `major` `major` int(2) ZEROFILL default '0' NOT NULL comment 'The major version number', 
   change `minor` `minor` int(2) ZEROFILL default '0' NOT NULL comment 'The minor version number', 
   change `build` `build` int(2) ZEROFILL default '0' NOT NULL comment 'The build number'