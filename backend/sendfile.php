<?php
// sleep(2);
$str = md5(generateRandomString(8));
mkdir("./files/".$str, 0777);
$uploaddir = './files/'.$str."/";

$uploadfile = $uploaddir.basename($_FILES['file']['name']);
if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
    echo "http://prinkov.xyz/chat/files/".$str."/".basename($_FILES['file']['name']);
} else {
    echo "-1";
}

function generateRandomString($length = 10) { 	
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

?>
