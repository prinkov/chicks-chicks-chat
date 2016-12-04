<?php

include("serv.php");


$lastid = $_POST['lastid'];
$date = date('Y-m-d H:i:s');
header('Content-type: text/html; charset=utf-8');
$mysqli = new mysqli(server, login, password, db_name);

if($lastid == -1) {
	$result = $mysqli->query("SELECT max(id) FROM messages");
	$lastid=$result->fetch_array()[0]-10;
}
	

$result = $mysqli->query("SELECT id, author, message, date FROM messages WHERE id > ".$lastid." ORDER BY date ASC");
if($result->field_count == 0)
	echo "-1";
else if ($result) {

    while($row = $result->fetch_assoc()) {
            $myArray[] = $row;
    }
    echo json_encode($myArray);
}

?>