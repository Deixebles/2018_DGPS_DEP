
<ul  class="collapsible" data-collapsible="expandable">
    <li>
    <div class="collapsible-header colorEveris" style="border-bottom: 1px solid yellowgreen; font-size: 20px; margin-top: 1.5rem">PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI</div>
    <div class="collapsible-body"><span>
    <table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table1" style=" font-size:10px">
            <?php
            $f = fopen("../../scripts/procediment/PVS.csv", "r");
            echo" 
                       <tbody>";

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
                    echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                for ($i = 6; $i < count($line); $i++) {
                    if(is_numeric($line[$i])){
                        $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                    } else{
                        $cell1=$line[$i];
                    }
                    echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                echo "</tr>\n";
            }


            fclose($f);
            ?>
        </table>
        <ul class="accordion">
                    <li>
                        <a style="background:darkslateblue " class="toggle" href="javascript:void(0);">CENTRE DE DIA</a>
                        <ul class="inner">
                            <li><table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table2" style=" font-size:10px">
                    <?php
                    $f = fopen("../../scripts/procediment/CD.csv", "r");
                    echo" 
                               <tbody>";

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
                            echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                        for ($i = 6; $i < count($line); $i++) {
                            if(is_numeric($line[$i])){
                                $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                            } else{
                                $cell1=$line[$i];
                            }
                            echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                        echo "</tr>\n";
                    }
                    fclose($f);
                    ?>
                </table></li>
                </ul>
            </li>
            <li>
                <a style="background:darkslateblue" class="toggle" href="javascript:void(0);">ACOLLIMENT RESIDENCIAL</a>
                <ul class="inner">
                  <li><table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table3" style=" font-size:10px">
                      <?php
                      $f = fopen("../../scripts/procediment/ARP.csv", "r");
                      echo" 
                      <tbody>";
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
                                    echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                                for ($i = 6; $i < count($line); $i++) {
                                    if(is_numeric($line[$i])){
                                        $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                                    } else{
                                        $cell1=$line[$i];
                                    }
                                    echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                                echo "</tr>\n";
                            }
                            fclose($f);
                            ?>
                   </table></li>
                 </ul>
            </li>
            <li>
                <a style="background:darkslateblue" class="toggle" href="javascript:void(0);">SUPORT DOMICILIARI INFERIOR</a>
                <ul class="inner">
                  <li><table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table4" style=" font-size:10px">
                      <?php
                      $f = fopen("../../scripts/procediment/ADI.csv", "r");
                      echo" 
                      <tbody>";
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
                              echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                          for ($i = 6; $i < count($line); $i++) {
                              if(is_numeric($line[$i])){
                                  $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                              } else{
                                  $cell1=$line[$i];
                              }
                              echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                          echo "</tr>\n";
                      }
                      fclose($f);
                      ?>
                   </table></li>
                 </ul>
            </li>
             <li>
                <a style="background:darkslateblue" class="toggle" href="javascript:void(0);">SUPORT DOMICILIARI SUPERIOR</a>
                <ul class="inner">
                  <li><table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table5" style=" font-size:10px">
                      <?php
                      $f = fopen("../../scripts/procediment/ADS.csv", "r");
                      echo" 
                      <tbody>";
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
                              echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                          for ($i = 6; $i < count($line); $i++) {
                              if(is_numeric($line[$i])){
                                  $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                              } else{
                                  $cell1=$line[$i];
                              }
                              echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                          echo "</tr>\n";
                      }
                      fclose($f);
                      ?>
                   </table></li>
                 </ul>
            </li>
        </ul></span>
    </div>
    </li>

    <li>
        <div class="collapsible-header colorEveris" style="border-bottom: 1px solid yellowgreen; font-size: 20px; margin-top: 1.5rem">ASSISTENT PERSONAL</div>
        <div class="collapsible-body"><span>
        <table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table6" style=" font-size:10px">
                <?php
                $f = fopen("../../scripts/procediment/AP.csv", "r");
                echo" 
                           <tbody>";

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
                        echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                    for ($i = 6; $i < count($line); $i++) {
                        if(is_numeric($line[$i])){
                            $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                        } else{
                            $cell1=$line[$i];
                        }
                        echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                    echo "</tr>\n";
                }
                fclose($f);
                ?>
        </table></span></div></li>

    <li>
        <div class="collapsible-header colorEveris" style="border-bottom: 1px solid yellowgreen; font-size: 20px; margin-top: 1.5rem">VETLLADOR NO PROFESSIONAL</div>
        <div class="collapsible-body"><span>
        <table class="striped" style="display: block; overflow-x: auto; white-space: nowrap;" id="table7" style=" font-size:10px">
                <?php
                $f = fopen("../../scripts/procediment/VNP.csv", "r");
                echo" 
                           <tbody>";

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
                        echo "<td style='text-align: right; background-color: lightgray'>" . htmlspecialchars($cell1) . "</td>";                                };
                    for ($i = 6; $i < count($line); $i++) {
                        if(is_numeric($line[$i])){
                            $cell1=number_format($line[$i],(int)$line[$i] == $line[$i] ? 0 : 2,"'",".");
                        } else{
                            $cell1=$line[$i];
                        }
                        echo "<td style='text-align: right'>" . htmlspecialchars($cell1) . "</td>";                                };
                    echo "</tr>\n";
                }
                fclose($f);
                ?>
        </table></span></div></li>

    <h5 class='left' style='color: yellowgreen;margin-top: 3%'>Descarregar: <button id="excel1" class="waves-effect waves-light btn-flat" onClick="tablesToExcel(['table6','table7','table1','table2','table3','table4','table5'],
    ['AP','VNP','PVServei','CDP','ARP','ADI','ADS'], 'Prestacions.xls', 'Excel')" ><i class="material-icons">system_update_alt</i></button></h5>

</ul>


