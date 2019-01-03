<?php
ini_set('max_execution_time', 300);
function cleanField($field)
{
    $field = str_replace('NA','',$field);
    return $field;
}
$data_box = array();
$num_line = 0;


$f = fopen("../../scripts/graf/estatics/A8b_usuaris_grau_prestacio.csv", "r");
while (($line = fgetcsv($f)) !== false) {

    if ($num_line == 0)
    {
        //array_shift($line);
        $data_box['headers'][] = $line;
    } else {
        for($i=0; $i<count($line);$i++)
        {
            if ($i != 10)
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