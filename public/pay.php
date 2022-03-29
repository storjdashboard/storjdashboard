<?php 
header('Content-Type: application/json; charset=utf-8');
include("config.php");
echo file_get_contents("http://$ip/api/sno/estimated-payout"); 
?>
