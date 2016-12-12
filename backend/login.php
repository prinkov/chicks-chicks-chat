<?php

include("serv.php");

$login = $_POST['login'];
$passwd = $_POST['passwd'];

$mysqli = new mysqli(server, login, password, db_name);

echo $mysqli->connect_error;

if ($result = $mysqli->query("SELECT password FROM users WHERE nickname = '".$login."'")) {
 	
    $password = $result->fetch_object()->password;

    if(md5($passwd) == $password)
    	echo 1;
   	else 
   		echo -1;
    $result->close();
}

$mysqli->close();

?>