	<?php 
include("config.php");
$headers = getallheaders();
if($headers['Dash-Auth']==$auth){
header('Content-Type: application/json; charset=utf-8');
echo file_get_contents("http://$ip/api/sno/estimated-payout"); 
	}else{
		if($headers['Dash-Submitted']!=1){
		header('Content-Type: application/json; charset=utf-8');			
echo "Unauthorized
=".$headers['Dash-Auth'];exit;
		}else{
		header('HTTP/1.1 401 Unauthorized', true, 401);exit;
		}
	}
?>
