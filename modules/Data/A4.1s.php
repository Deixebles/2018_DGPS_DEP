<?php
ini_set('max_execution_time', 300);
ini_set('memory_limit','1G');
function cleanField($field)
{
    $field = str_replace('NA','',$field);
    return $field;
}
$data_box = array();
$num_line = 0;


$f = fopen("../../scripts/graf/estatics/A4.1s_Import_edat_pensio.csv", "r");
while (($line = fgetcsv($f)) !== false) {

    if ($num_line == 0)
    {
        //array_shift($line);
        $data_box['headers'][] = $line;
    } else {
        for($i=0; $i<count($line);$i++)
        {
            if ($i != 0)
            {
                $data_box['datasets'][$i][] = cleanField($line[$i]);
            }
        }
    }
    $num_line++;

};
fclose($f);

die(json_encode($data_box));


?>