<?php

include("serv.php");

$firstid= $_POST['firstid'];
$table = $_POST['room'];

$date = date('Y-m-d H:i:s');
header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);
$mysqli->set_charset("utf8");

$result = $mysqli->query("SELECT `table` FROM rooms WHERE `id` = ".$table);
$table = $result->fetch_object()->table;
	

$result = $mysqli->query("SELECT id, author, message, date FROM `".$table."` WHERE id < ".$firstid." AND id > ".($firstid-10)." ORDER BY date ASC");
if($result->field_count == 0)
	echo "-1";
else if ($result) {

    while($row = $result->fetch_assoc()) {
            $myArray[] = $row;
    }
    echo json_encode($myArray);
}

?>