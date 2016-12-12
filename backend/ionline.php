<?php

include("serv.php");

$name = $_POST['name'];
$room = $_POST['room'];
$date = date('Y-m-d H:i:s');
header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);
$mysqli->set_charset("utf8");

if(!$mysqli->query("UPDATE `users` SET `inroom`='".$room."', `lastSeen`='".$date."' WHERE nickname='".$name."'"))
	echo "-1";


