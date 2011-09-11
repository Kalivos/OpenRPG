/*Table structure for table `banned` */

CREATE TABLE `banned` (
  `banid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `startban` datetime NOT NULL,
  `until` datetime DEFAULT NULL,
  `reason` text,
  `adminid` int(11) NOT NULL COMMENT 'This is who set the ban',
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`banid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `buff` */

CREATE TABLE `buff` (
  `buffid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `duration` int(6) NOT NULL COMMENT 'expressed in minutes',
  `onbuff` text,
  `onbuff_removal` text,
  PRIMARY KEY (`buffid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `character` */

CREATE TABLE `character` (
  `characterid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `titleid` int(11) NOT NULL,
  `raceid` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  `level` int(2) NOT NULL,
  `xp` int(11) NOT NULL,
  `gender` char(1) NOT NULL COMMENT 'M/F',
  `stamina` int(4) NOT NULL,
  `agility` int(4) NOT NULL,
  `intelligence` int(4) NOT NULL,
  `luck` int(4) NOT NULL,
  `petid` int(11) DEFAULT '0',
  `alignment` int(2) NOT NULL,
  `health` int(11) NOT NULL,
  `energy` int(11) NOT NULL,
  `chat_last_cleared` int(11) NOT NULL DEFAULT '0',
  `chat_last_viewed` int(11) NOT NULL DEFAULT '0',
  `pet` tinyint(1) NOT NULL,
  PRIMARY KEY (`characterid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `character_buff` */

CREATE TABLE `character_buff` (
  `buffid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL,
  `time_buffed` datetime NOT NULL,
  PRIMARY KEY (`buffid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `chat` */

CREATE TABLE `chat` (
  `chatid` int(11) NOT NULL AUTO_INCREMENT,
  `from_character` int(11) NOT NULL DEFAULT '0',
  `to_character` int(11) NOT NULL DEFAULT '0',
  `said` text NOT NULL,
  `chat_time` datetime NOT NULL,
  `chat_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chatid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `chat_type` */

CREATE TABLE `chat_type` (
  `chat_typeid` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(20) NOT NULL,
  `distance` tinyint(3) NOT NULL COMMENT 'distance of 0 should be global',
  `admin` tinyint(1) NOT NULL COMMENT 'Is this an admin only command?',
  `prototype` text NOT NULL COMMENT 'Example: {talker} says to {listener}, "{message}"',
  PRIMARY KEY (`chat_typeid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `class` */

CREATE TABLE `class` (
  `classid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`classid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `enhancement` */

CREATE TABLE `enhancement` (
  `enhancementid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(75) NOT NULL,
  `staminamod` int(4) DEFAULT NULL,
  `strengthmod` int(4) DEFAULT NULL,
  `agilitymod` int(4) DEFAULT NULL,
  `intelligencemod` int(4) DEFAULT NULL,
  `luckmod` int(4) DEFAULT NULL,
  PRIMARY KEY (`enhancementid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `equipment_area` */

CREATE TABLE `equipment_area` (
  `equipment_area` int(11) NOT NULL AUTO_INCREMENT,
  `area` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`equipment_area`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `equipped_items` */

CREATE TABLE `equipped_items` (
  `equippedid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  PRIMARY KEY (`equippedid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `item` */

CREATE TABLE `item` (
  `itemid` int(11) NOT NULL AUTO_INCREMENT,
  `item_skeletonid` int(11) NOT NULL,
  `roomid` int(11) DEFAULT NULL,
  `characterid` int(11) DEFAULT NULL,
  `current_durability` int(3) DEFAULT NULL,
  `shopid` int(11) DEFAULT NULL,
  `enhancementid` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `item_skeleton` */

CREATE TABLE `item_skeleton` (
  `item_skeletonid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `enhancementid` int(11) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `maxdurability` int(3) NOT NULL,
  `equipment_areaid` int(11) NOT NULL,
  PRIMARY KEY (`item_skeletonid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `known_skill` */

CREATE TABLE `known_skill` (
  `characterid` int(11) NOT NULL COMMENT 'FK -> character -> characterid',
  `skillid` int(11) NOT NULL COMMENT 'FK -> skill -> skillid'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `language` */

CREATE TABLE `language` (
  `languageid` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(75) NOT NULL COMMENT 'Name of the language',
  `description` text COMMENT 'A description of the language',
  PRIMARY KEY (`languageid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `language_known` */

CREATE TABLE `language_known` (
  `languageid` int(11) NOT NULL,
  `characterid` int(11) DEFAULT NULL,
  `skeletonid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `lock` */

CREATE TABLE `lock` (
  `lockid` int(11) NOT NULL AUTO_INCREMENT,
  `item_skeletonid` int(11) DEFAULT NULL,
  PRIMARY KEY (`lockid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `login` */

CREATE TABLE `login` (
  `userid` int(11) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `when` datetime NOT NULL,
  `login` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `npc` */

CREATE TABLE `npc` (
  `npcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'Name of a NPC',
  `skeletonid` int(11) NOT NULL COMMENT 'FK -> skeleton -> skeletonid',
  `level` int(2) NOT NULL DEFAULT '1' COMMENT 'The level of the NPC',
  `health` int(11) NOT NULL COMMENT 'Current health of the NPC',
  `energy` int(11) NOT NULL COMMENT 'Current energy of the NPC',
  `shopid` int(11) DEFAULT NULL COMMENT 'The merchant''s shop',
  PRIMARY KEY (`npcid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `npc_actions` */

CREATE TABLE `npc_actions` (
  `npc_chatid` int(11) NOT NULL AUTO_INCREMENT,
  `npcid` int(11) NOT NULL COMMENT 'FK -> npc - npcid',
  `pattern` varchar(75) DEFAULT NULL,
  `action` text COMMENT 'An action that is taken when a pattern is matched. This is intended to be scriptable.',
  PRIMARY KEY (`npc_chatid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `phone_carriers` */

CREATE TABLE `phone_carriers` (
  `carrierid` int(11) NOT NULL AUTO_INCREMENT,
  `carrier` varchar(75) NOT NULL,
  `address` varchar(75) NOT NULL,
  PRIMARY KEY (`carrierid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `playable` */

CREATE TABLE `playable` (
  `playableid` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  PRIMARY KEY (`playableid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `race` */

CREATE TABLE `race` (
  `raceid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`raceid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `room` */

CREATE TABLE `room` (
  `roomid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `x` int(3) NOT NULL,
  `y` int(3) NOT NULL,
  `z` int(3) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `room_type` int(11) NOT NULL,
  `shopid` int(11) DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `action` text,
  `lockid` int(11) DEFAULT NULL,
  PRIMARY KEY (`roomid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `room_type` */

CREATE TABLE `room_type` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(75) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `secure_login` */

CREATE TABLE `secure_login` (
  `userid` int(11) NOT NULL,
  `requested` datetime NOT NULL,
  `code` int(6) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `skeleton` */

CREATE TABLE `skeleton` (
  `skeletonid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'name of the skeleton. Example: Human Guard',
  `stamina` int(4) NOT NULL DEFAULT '1',
  `strength` int(4) NOT NULL DEFAULT '1',
  `agility` int(4) NOT NULL DEFAULT '1',
  `intelligence` int(4) NOT NULL DEFAULT '1',
  `luck` int(4) NOT NULL DEFAULT '1',
  `raceid` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  `gender` char(1) NOT NULL COMMENT 'M/F',
  `favored_room_type` int(11) NOT NULL COMMENT 'FK -> room_type ->typeid NPCs will MOSTLY stay in this type of area',
  PRIMARY KEY (`skeletonid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `skill` */

CREATE TABLE `skill` (
  `skillid` int(11) NOT NULL AUTO_INCREMENT,
  `combat` tinyint(1) NOT NULL COMMENT 'Is this a combat skill?',
  `action` text NOT NULL COMMENT 'Scriptable action',
  PRIMARY KEY (`skillid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `spawn_location` */

CREATE TABLE `spawn_location` (
  `npcid` int(11) NOT NULL COMMENT 'The npcs id that should be spawned',
  `roomid` int(11) NOT NULL COMMENT 'Room id that a creature could spawn in'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `title` */

CREATE TABLE `title` (
  `titleid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `after_name` tinyint(1) NOT NULL COMMENT 'Should this come after the players name rather than before?',
  PRIMARY KEY (`titleid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `titles_earned` */

CREATE TABLE `titles_earned` (
  `titleid` int(11) NOT NULL,
  `characterid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `transportation_route` */

CREATE TABLE `transportation_route` (
  `routeid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(75) NOT NULL,
  `destination` varchar(75) DEFAULT NULL,
  `departure_frequency` int(6) NOT NULL,
  `travel_time` int(6) NOT NULL,
  `quantity_cost` int(7) NOT NULL DEFAULT '1',
  `itemid_cost` int(11) NOT NULL,
  `guide` int(11) DEFAULT NULL,
  `start_roomid` int(11) NOT NULL,
  `destination_roomid` int(11) NOT NULL,
  PRIMARY KEY (`routeid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `user` */

CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `salt` char(6) NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `cell_number` int(10) DEFAULT NULL,
  `carrierid` int(11) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL,
  `secure_login` tinyint(1) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `version` */

CREATE TABLE `version` (
  `versionid` int(11) NOT NULL AUTO_INCREMENT,
  `installed` date NOT NULL COMMENT 'The date of install',
  `major` int(4) NOT NULL DEFAULT '0' COMMENT 'The major version number',
  `minor` int(2) NOT NULL DEFAULT '0' COMMENT 'The minor version number',
  `build` int(2) NOT NULL DEFAULT '0' COMMENT 'The build number',
  PRIMARY KEY (`versionid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
