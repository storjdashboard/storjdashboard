<?php 
ini_set('display_errors', 0);
include("config.php");
if (!function_exists('getallheaders')) {
    function getallheaders() {
    $headers = [];
    foreach ($_SERVER as $name => $value) {
        if (substr($name, 0, 5) == 'HTTP_') {
            $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
        }
    }
    return $headers;
    }
}
$headers = getallheaders();
if($headers['Dash-Auth']==$auth){
header('Content-Type: application/json; charset=utf-8');
echo file_get_contents("http://$ip/api/sno/satellites"); 
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
