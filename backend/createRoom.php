<?php

include("serv.php");

$name = $_POST['name'];

header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);
$mysqli->set_charset("utf8");
$query = "
	CREATE TABLE `".$name."` (
	  `id` int(11) NOT NULL  AUTO_INCREMENT,
	  `author` text NOT NULL,
	  `message` text NOT NULL,
	  `date` date NOT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;";
if($mysqli->query($query)) {
	if($mysqli->query("INSERT INTO `rooms`(`table`, `people`) VALUES('".$name."', 0)"))
		echo "1";
}
else 
	echo "-1";