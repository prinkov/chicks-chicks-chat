<?php

include("serv.php");


$author = $_POST['author'];
$message = $_POST['message'];
$date = date('Y-m-d H:i:s');
header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);

$mysqli->set_charset("utf8");

$result = $mysqli->query("INSERT INTO messages(`author`, `message`, `date`) VALUES('".$author."', '".$message."', '".$date."')");
echo $result;
$mysqli->close();

?>