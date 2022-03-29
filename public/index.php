<?php 
header('Content-Type: application/json; charset=utf-8');
include("config.php");
$content = file_get_contents("http://$ip/api/sno/"); 

$array = json_decode($content, true);$replacements = array("wallet" => "BLANK", "nodeID" => "BLANK");$array = array_replace($array, $replacements);$array = json_encode($array);

echo $array;
?>
