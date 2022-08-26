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

  // get list
$list = file_get_contents("https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/file_updater.list"); $list  = preg_replace( "/<br>|\n/", "", $list ); $page = array_filter(explode("|", $list));

$p = 0;
$p_max = count($page);

do{ // do start  
    // Initialize a file URL to the variable
$ThisPage = $page[$p]; $url = "https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/$ThisPage";
      
    // Use basename() function to return the base name of file
    $file_name = basename($url);
      
    // Use file_get_contents() function to get the file
    // from url and use file_put_contents() function to
    // save the file by using base name
    if (file_put_contents($file_name, file_get_contents($url)))
    {   echo "$ThisPage | successful<br>";
    }
    else
    {   echo "$ThisPage | failed.<br>";
    }	
$p = $p+1; } while ($p < $p_max); // end of do 

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
