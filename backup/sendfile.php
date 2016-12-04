<?php
$uploaddir = './files/';
$uploadfile = $uploaddir.basename($_FILES['file']['name']);
if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
    echo "http://localhost/files/".basename($_FILES['file']['name']);
} else {
    echo "-1";
}

?>
