<?php 
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
//US1
$id="12EayRS2V1kEsWESU9QMRseFhdxYxKicsiFmxrsLZHeLUtdps3S";$us1 = file_get_contents("http://$ip/api/sno/satellite/$id");$array = json_decode($us1,true);$replaced = array("$id" => $array);$us1 = json_encode($replaced,true);
//US2
$id="12tRQrMTWUWwzwGh18i7Fqs67kmdhH9t6aToeiwbo5mfS2rUmo";$us2 = file_get_contents("http://$ip/api/sno/satellite/12tRQrMTWUWwzwGh18i7Fqs67kmdhH9t6aToeiwbo5mfS2rUmo");$array = json_decode($us2,true);$replaced = array("$id" => $array);$us2 = json_encode($replaced,true);
//EU1
$id="12L9ZFwhzVpuEKMUNUqkaTLGzwY9G24tbiigLiXpmZWKwmcNDDs";$eu1 = file_get_contents("http://$ip/api/sno/satellite/12L9ZFwhzVpuEKMUNUqkaTLGzwY9G24tbiigLiXpmZWKwmcNDDs");$array = json_decode($eu1,true);$replaced = array("$id" => $array);$eu1 = json_encode($replaced,true);
//EU-NORTH
$id="12rfG3sh9NCWiX3ivPjq2HtdLmbqCrvHVEzJubnzFzosMuawymB";$eun = file_get_contents("http://$ip/api/sno/satellite/12rfG3sh9NCWiX3ivPjq2HtdLmbqCrvHVEzJubnzFzosMuawymB");$array = json_decode($eun,true);$replaced = array("$id" => $array);$eun = json_encode($replaced,true);
//AP
$id="121RTSDpyNZVcEU84Ticf2L1ntiuUimbWgfATz21tuvgk3vzoA6";$ap1 = file_get_contents("http://$ip/api/sno/satellite/121RTSDpyNZVcEU84Ticf2L1ntiuUimbWgfATz21tuvgk3vzoA6");$array = json_decode($ap1,true);$replaced = array("$id" => $array);$ap1 = json_encode($replaced,true);
//SALTLAKE
$id="1wFTAgs9DP5RSnCqKV1eLf6N9wtk4EAtmN5DpSxcs8EjT69tGE";$sl = file_get_contents("http://$ip/api/sno/satellite/1wFTAgs9DP5RSnCqKV1eLf6N9wtk4EAtmN5DpSxcs8EjT69tGE");$array = json_decode($sl,true);$replaced = array("$id" => $array);$sl = json_encode($replaced,true);
$array = json_encode(array_merge(json_decode($us1, true),json_decode($us2, true),json_decode($eu1, true),json_decode($eun, true),json_decode($ap1, true),json_decode($sl, true)));echo $array;

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
