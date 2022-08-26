<?php
ini_set('display_errors', 1);
  // get list
$list  = file_get_contents("https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/file_updater.list");
$page = explode("|", $list);

$p = 0;
$p_max = count($page);

do{ // do start
  
    // Initialize a file URL to the variable
	$ThisPage = $page[$p'];
    $url = "https://raw.githubusercontent.com/storjdashboard/storjdashboard/main/public/$ThisPage";
      
    // Use basename() function to return the base name of file
    $file_name = basename($url);
      
    // Use file_get_contents() function to get the file
    // from url and use file_put_contents() function to
    // save the file by using base name
    if (file_put_contents($file_name, file_get_contents($url)))
    {
        echo "$ThisPage | File downloaded successfully<br>";
    }
    else
    {
        echo "$ThisPage | File downloading failed.<br>";
    }
	
	$p = $p+1;
	} while ($p < $p_max); // end of do 
?>
