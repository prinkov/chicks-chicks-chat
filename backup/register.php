<?php
include("serv.php");

$mysqli = new mysqli(server, login, password, db_name);


$login = $_POST['login'];
$passwd = $_POST['passwd'];
$result = $mysqli->query("SELECT password FROM users WHERE nickname = '".$login."'");
if ($result->num_rows== 0)  {
	$query = "INSERT INTO users(nickname, password) VALUES('".$login."', '".md5($passwd)."')";
	$mysqli->query($query);
	echo 1;
}
else {
	echo -1;
}
$mysqli->close();
?>