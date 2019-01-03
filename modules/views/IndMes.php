


<?php
$myFile = "../../Resources/archivos/ficherofecha.txt";
$fh = fopen($myFile, 'r');
$Date = fread($fh, 2);
fclose($fh);
?>

<?php
/*$myFile = "../../Resources/graf/estatics/import_sexe.csv";
$fh = fopen($myFile, 'r');
var_dump ($fh);
fclose($fh);*/
?>


<ul  class="collapsible" data-collapsible="expandable">

<?php
//Print tables


 $monthBox = array('Gener','Febrer','Mar','Abril','Maig','Juny','Juliol','Agost','Setembre','Octubre','Novembre','Desembre');

 for ($nm=0;$nm<count($monthBox);$nm++)
 {

    if($Date>=($nm+1)){ 
     
    echo "
    <li>
        <div class='collapsible-header colorEveris' style='border-bottom: 1px solid yellowgreen; font-size: 20px; margin-top: 1.5rem'>".changeName($monthBox[$nm])."
            <button class=\"waves-effect waves-light btn-flat\" onClick=\"tablesToExcel(['".$monthBox[$nm]."', 'mun".$monthBox[$nm]."', 'com".$monthBox[$nm]."', 'dem".$monthBox[$nm]."'],['Informe ".changeName($monthBox[$nm])."', 'Municipis', 'Comarques', 'Demarcacions'], '".changeName($monthBox[$nm]).".xls', 'Excel')\" >
                <i class=\"material-icons\">system_update_alt</i>
            </button>
        </div>";
    echo "<div class='collapsible-body'>";
    ?>
    <span>
        <table class='striped' style='display: block; overflow-x: auto; white-space: nowrap;' id='<?=$monthBox[$nm]?>' style='font-size:10px'>
            <tbody>
                <?php
                     $f = fopen("../../scripts/mes/".$monthBox[$nm].".csv", "r");
                      while (($line = fgetcsv($f)) !== false) {
            echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
            echo "<td class='headcol'>" . htmlspecialchars($line[0]) . "</td>";
            //              echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
            for ($i = 1; $i < 6; $i++) {
                if(is_numeric($line[$i])){
                    $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                } else{
                    $cell1=$line[$i];
                }
                echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";     
            }
            for ($i = 6; $i < count($line); $i++)
            {
                if(is_numeric($line[$i])){
                    $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                } else{
                    $cell1=$line[$i];
                }

                echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
            }
            echo "</tr>\n";
        }
            fclose($f);
                ?>
            </tbody>
        </table>
        <ul class='accordion'>
        <li>
            <a style="background:darkslateblue" class="toggle" href="javascript:void(0);">Usuaris i imports per municipi</a>
            <ul class="inner">
                <li>
                    <table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="mun<?=$monthBox[$nm]?>" style="font-size:10px">
                        <tbody>
                            <?php
                            $f = fopen("../../scripts/mes/municipis ".$monthBox[$nm].".csv", "r");
                            while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        echo "<td class='headcol'>" . htmlspecialchars($line[0]) . "</td>";
                        //              echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        for ($i = 1;$i < count($line); $i++) {
                        if(is_numeric($line[$i])){
                            $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                        } else{
                            $cell1=$line[$i];
                        }
                        echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                        };
                        echo "</tr>\n";
                    }
                    fclose($f);
                            ?>
                        </tbody>
                    </table>
                </li>
            </ul>
        </li>

        <li>
                        <a style="background:darkslateblue" class="toggle" href="javascript:void(0);">Usuaris i imports per comarca</a>
                        <ul class="inner">
                        <li><table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="com<?=$monthBox[$nm]?>" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/mes/comarques ".$monthBox[$nm].".csv", "r");
                    echo" 
                      <tbody>";
                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        echo "<td class='headcol'>" . htmlspecialchars($line[0]) . "</td>";
                                //              echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        for ($i = 1;$i < count($line); $i++) {
                        if(is_numeric($line[$i])){
                            $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                        } else{
                            $cell1=$line[$i];
                        }
                        echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                        };
                        echo "</tr>\n";
                    }
                    fclose($f);
                    ?>
                   </table></li>
                 </ul>
                </li>

                <li>
                        <a style="background:darkslateblue " class="toggle" href="javascript:void(0);">Usuaris i imports per demarcació</a>
                        <ul class="inner">
                            <li><table class="striped" style="overflow-x: auto; white-space: nowrap;" id="dem<?=$monthBox[$nm]?>" style=" font-size:10px">
                    <?php

                    $f = fopen("../../scripts/mes/demarcacions ".$monthBox[$nm].".csv", "r");
                    echo" 
                               <tbody>";

                    while (($line = fgetcsv($f)) !== false) {
                        echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        echo "<td >" . htmlspecialchars($line[0]) . "</td>";
                        //              echo "<tr style='font-weight: bold text-decoration: underline border-left:2px black font-weight: 500'>";
                        for ($i = 1;$i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                            } else{
                                $cell1=$line[$i];
                            }
                            echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";
                        };
                        echo "</tr>\n";
                    }
                    fclose($f);
                    
                    ?>
                        </table></li>
                    </ul>
                </li>           

    </ul>
    </span>
</div>

    <?php
    echo '</li>';

    }

} //End for print tables
?>
</ul>



<?php
    function changeName($str)
    {
        switch(trim($str))
        {
            case "Mar":
                $str .= 'ç';
                break;
            default:
        }
        return $str;
    }
?>

