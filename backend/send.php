<?php

include("serv.php");

$author = $_POST['author'];
$message = $_POST['message'];
$table = $_POST['room'];
$message = str_replace("'", "\'", $message);

$date = date('Y-m-d H:i:s');
header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);

$mysqli->set_charset("utf8");
$result = $mysqli->query("SELECT `table` FROM rooms WHERE `id` = ".$table);
$table = $result->fetch_object()->table;
$result = $mysqli->query("INSERT INTO `".$table."`(`author`, `message`, `date`) VALUES('".$author."', '".$message."', '".$date."')");

$mysqli->close();

?>