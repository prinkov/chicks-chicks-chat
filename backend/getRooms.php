<?php

include("serv.php");

$date = new DateTime();
$date->sub(new DateInterval('P0Y0M0DT0H3M0S'));

$str = $date->format('Y-m-d H:i:s');

$mysqli = new mysqli(server, login, password, db_name);
$mysqli->set_charset("utf8");

$mysqli->query("UPDATE rooms SET people = (SELECT count(id) FROM users WHERE rooms.id = users.inroom AND users.lastSeen > '".$str."')");

$result = $mysqli->query("SELECT * FROM rooms ORDER BY id ASC");
if($result->field_count == 0)
	echo "-1";
else {
	while($row = $result->fetch_assoc()) {
	            $myArray[] = $row;
	    }
	echo json_encode($myArray);
}