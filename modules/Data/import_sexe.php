<?php
function cleanField($field)
{
    $field = str_replace('NA','',$field);
    return $field;
}
$data_box = array();
$num_line = 0;


$f = fopen("../../scripts/graf/estatics/import_sexe.csv", "r");
while (($line = fgetcsv($f)) !== false) {

    if ($num_line == 0)
    {
        //array_shift($line);
        $data_box['headers'][] = $line;
    } else {
        for($i=0; $i<count($line);$i++)
        {
            if ($i < 3)
            {
                $data_box['datasets'][$i][] = cleanField($line[$i]);
            }
        }
    }
    $num_line++;

};
fclose($f);

die(json_encode($data_box));






