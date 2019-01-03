# INFO COMPLEMETARIA: 
##########################################################################
# estad es l'historic d'aquest mes! --> unir-ho amb historic
# PVNactual es l'historic d'aquest mes! --> unir-ho amb PVNhistoric
# PVN es PVN historic + actual!!
##########################################################################
#
# INDEX: 
##########################################################################
## PAS 1: FER L'ACTUAL
## PAS 2: COMPLETARHO AMB HISTORIC
## PAS 3: EXTREURE DE L'HISTORIC L'ANY ACTUAL!
## PAS 4: CREEM LES TAULES QUE SE'NS DEMANA
## ## A) completar els finals de les taules
## ## C) creem les taules independents per cada mes
## ## B) creem les taules independents per cada prestació; per la resta de mesos coloquem 0!
## ## D) completar LAPAD III
## ## ## a) Baixes
## ## ## b) Modificatives
## ## ## c) Usuaris
## PAS 5: GUARDEM DADES!
## PAS 6: ERRORS
## PAS 7: GRÀFICS
## ACTUALIZEM
##########################################################################

options(warn=-1) # Amaguem els warnings
## LLIBRERIES:
suppressMessages(library(readxl))
suppressMessages(library(dplyr))
suppressMessages(library(sqldf)) #joins?
suppressMessages(library(zoo))  # dates i tal
suppressMessages(library(plyr))  #rbind.fill
suppressMessages(library(ggplot2)) ##per guardar taula en png
suppressMessages(library(gridExtra)) ##per guardar taula en png
suppressMessages(library(rowr)) # cbind.fill
suppressMessages(library(stringi))

#############################################################
##########                                 ##################
##########      CARGUEM DADES              ##################
##########                                 ##################
#############################################################

## PÀGINA WEB! ##
setwd("C:/xampp/htdocs/GestioDeute/uploads/")
altes22<-as.data.frame(read_excel("Altes22.xls", sheet=1, na=""))
altes24<-as.data.frame(read_excel("Altes24.xls", sheet=1, na=""))
quadrament<-as.data.frame(read_excel("Quadrament.xlsx", sheet=1, na=""))
#DCR<-as.data.frame(read_excel("DCR.xls", sheet=1, na=""))
historic_baixes<- as.data.frame(read_excel("Baixes.xlsx", sheet=1, na=""))

#DCR<-as.data.frame(read_excel("C:/Users/ccomasga/Documents/Gestió Deutes/DCR generats.xls", sheet=1, na=""))

#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Gener")
#setwd("C:/Users/ccomasga/Documents/Gestió Deutes/cargar definitius/2017/Febrer 2017")
#altes22<-as.data.frame(read_excel("Altes pures 22.xls", sheet=1, na=""))
#altes24<-as.data.frame(read_excel("Altes pures 24.xls", sheet=1, na=""))
#quadrament<-as.data.frame(read_excel("Febrer.xlsx", sheet=1, na=""))

# ANNA #
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu")
#historic_baixes<-read.csv("22-24B.csv", row.names = NULL, sep = ";")

# CARLA # 
#historic_baixes<-as.data.frame(read_excel("22-24B.xlsx", sheet=1, na=""))
#setwd("C:/Users/ccomasga/Documents/Gestió Deutes")
f <- "C:/xampp/htdocs/GestioDeute/uploads/DCR.xls"
if (file.exists(f)){
  DCR<-as.data.frame(read_excel("DCR.xls", sheet=1, na=""))
} else{
  DCR<-as.data.frame(read_excel("C:/xampp/htdocs/GestioDeute/Resources/archivos/DCRnuls.xls", sheet=1, na=""))
}
#DCR<-as.data.frame(read_excel("DCR generats.xls", sheet=1, na=""))
#DCR<-as.data.frame(read_excel("DCR.xls", sheet=1, na=""))
#if(exists("DCR")==FALSE){
  #DCR<-as.data.frame(read_excel("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/DCR nuls.xlsx",sheet=1, na=""))
#  DCR<-as.data.frame(read_excel("C:/xampp/htdocs/GestioDeute/Resources/archivos/DCRnuls.xls", sheet=1, na=""))
#}

setwd("C:/xampp/htdocs/GestioDeute/scripts")
load("historic.RData")

#############################################################
##########                                 ##################
##########      COMPLETEM EL MES           ##################
##########                                 ##################
#############################################################

#args és el que rebem de PHP: mes actual
args <- commandArgs(TRUE)
N<-as.yearmon(args, "%Y-%m")
mes<-c("Gener","Febrer","Mar","Abril","Maig","Juny","Juliol","Agost","Setembre","Octubre","Novembre","Desembre")
#N<-as.yearmon("02-2018","%m-%Y")
avui<-N
gen2017<-as.yearmon("01-2017","%m-%Y")

#Altes y mod:
if("BENDNI" %in% names(altes22)){altes22<-altes22[,c("EXPTI","EXPANY","EXPNUM","NOPRDB","BENDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")]
}else{
  altes22<-altes22[,c("EXPTI","EXPANY","EXPNUM","NOPRDB","PSNDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")]
  names(altes22)<-c("EXPTI","EXPANY","EXPNUM","NOPRDB","BENDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")
}

if("BENDNI" %in% names(altes24)){altes24<-altes24[,c("EXPTI","EXPANY","EXPNUM","NOPRDB","BENDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")]
}else{
  altes24<-altes24[,c("EXPTI","EXPANY","EXPNUM","NOPRDB","PSNDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")]
  names(altes24)<-c("EXPTI","EXPANY","EXPNUM","NOPRDB","BENDNI","PSNNOM","PSNCOG","CAEXDB","CATIRC","CATIRC01","NOPRDB01")  
}

altesTotes<-rbind(altes22, altes24) 

## MOD
altes22[altes22[,"NOPRDB01"]!=0,"Mod22"]<-"x"
altes24[altes24[,"NOPRDB01"]!=0,"Mod24"]<-"x"

## altes
altes22[altes22[,"NOPRDB01"]==0,"Altes22"]<-"x"
altes24[altes24[,"NOPRDB01"]==0,"Altes24"]<-"x"

#Unim quadrament amb les dues altes 22 i 24:
altes22_2<-altes22[,c("NOPRDB","Altes22","Mod22")]
altes24_2<-altes24[,c("NOPRDB","Altes24","Mod24")]

quadrament<-left_join(quadrament, altes22_2,by=c("NOPRDB"))
quadrament<-left_join(quadrament, altes24_2,by=c("NOPRDB"))

quadrament$CATIRC<-factor(quadrament$CATIRC)
levels(quadrament$CATIRC)<-prestcurt

rm(altes22_2,altes24_2)

## CATIRC
quadrament[quadrament[,"CATIRC"]=="ADI" | quadrament[,"CATIRC"]=="ADS"| quadrament[,"CATIRC"]=="ARP" |
             quadrament[,"CATIRC"]=="CDP","RECURS"]<-"SERVEI"
quadrament[quadrament[,"CATIRC"]=="AP","RECURS"]<-"ASSISTENT"
quadrament[quadrament[,"CATIRC"]=="VNP","RECURS"]<-"CUIDADOR"

## G-N
quadrament[,"GN"]<-paste(quadrament[,"GRAU"],"-",quadrament[,"NIVELL"],sep = "")
DCR[,"GN"]<-paste(DCR[,"RCPPNT"],"-",DCR[,"RCPPNTE"],sep = "")
DCR$GN<-paste0("Grau ",DCR$GN)

## ORD GENERADA 
quadrament[is.na(quadrament[,"IMPORD"])==FALSE,"ORD GENERADA"]<-"X"

## END
b<-c(2007:2022)

for(i in 1:16){
  a<-paste("END",b[i], sep="")
  if(!is.numeric(quadrament[,a])){
    quadrament[,a]<-haz.cero.na(as.numeric(quadrament[,a]))
  }}

quadrament[,"END"]<-quadrament[,"END2007"]+quadrament[,"END2008"]+quadrament[,"END2009"]+quadrament[,"END2010"]+quadrament[,"END2011"]+
  quadrament[,"END2012"]+quadrament[,"END2013"]+quadrament[,"END2014"]+quadrament[,"END2015"]+quadrament[,"END2016"]+quadrament[,"END2017"]+
  quadrament[,"END2018"]+quadrament[,"END2019"]+quadrament[,"END2020"]+quadrament[,"END2021"]+quadrament[,"END2022"]
if("END2025" %in% colnames(quadrament)){
  quadrament[,"END"]<-quadrament[,"END"]+quadrament[,"END2023"]+quadrament[,"END2024"]+quadrament[,"END2025"]
}

## TOTAL
quadrament[,"TOTAL"]<-quadrament[,"END"] + quadrament[,"IMPORD"]
rm(a,b,i)

#############################################################
##########                                 ##################
##########    ABANS DE COMENÇAR            ##################
##########                                 ##################
#############################################################

## Ordenem variables i refactoritzem per fer coincidir amb l'historic
quadrament[quadrament[, "GN"]=="1-9", "GN"]<-"Grau 1"
quadrament[quadrament[, "GN"]=="2-9", "GN"]<-"Grau 2"
quadrament[quadrament[, "GN"]=="3-9", "GN"]<-"Grau 3"

levels(quadrament$CATIRC)<-prestllarg

## Guardem el mes de quadrament en què estem 
nomquadrament<-paste("Quadrament ",avui, ".csv",sep="")
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Quadraments")
setwd("C:/xampp/htdocs/GestioDeute/scripts/quadraments")
write.csv(quadrament,nomquadrament, fileEncoding="utf8")
nomquadrament<-paste("Quadrament ",avui-0.01, ".csv",sep="") 

## Llegim el l'antic quadrament
quadrantic<-read.csv(nomquadrament,fileEncoding = "UTF-8")

## Agafem només les columnes que necessitem:
quadrament01<-quadrantic[,c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")]
quadrament01$BENDNI<-as.character(quadrament01$BENDNI)
quadrament02<-quadrament[,c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")]

ordinaries02<-quadrament02[quadrament02$IMPORD!=0,] # ordinàries gener
ordinaries01<-quadrament01[quadrament01$IMPORD!=0,] # ordinàries desembre
names(ordinaries01)<-c("CARTE01", "NOPRDB", "BENDNI", "CATIRC01", "ALTCAR", "GN01", "IMPORD01", "NOPSAP01", "END")

## Agafem info dos mesos
DosmesosPROC<-full_join(ordinaries01,ordinaries02,by="NOPRDB")
DosmesosDNI<-full_join(ordinaries01,ordinaries02,by="BENDNI")
#NOPRDB.x i BENDNI.x són antics!!!

## Mirem les altes noves i les baixes segons el DNI
Noves<-DosmesosDNI[is.na(DosmesosDNI$NOPRDB.x)==TRUE,]
levels(Noves$CATIRC)<-prestcurt

## Mirem diferències entre els quadraments actual amb el mes anterior
VarienDNI<-DosmesosPROC[DosmesosPROC$BENDNI.x!=DosmesosPROC$BENDNI.y & is.na(DosmesosPROC$BENDNI.y)==FALSE & is.na(DosmesosPROC$BENDNI.x)==FALSE,]
VarienRECURS<-DosmesosDNI[DosmesosDNI$CATIRC01!=DosmesosDNI$CATIRC & DosmesosDNI$NOPRDB.x!=DosmesosDNI$NOPRDB.y & is.na(DosmesosDNI$NOPRDB.x)==FALSE &is.na(DosmesosDNI$NOPRDB.y)==FALSE,]
VarienMod<-DosmesosDNI[DosmesosDNI$CATIRC01==DosmesosDNI$CATIRC & DosmesosDNI$NOPRDB.x!=DosmesosDNI$NOPRDB.y &is.na(DosmesosDNI$NOPRDB.x)==FALSE &is.na(DosmesosDNI$NOPRDB.y)==FALSE,]
levels(VarienRECURS$CATIRC01)<-c("AP","ARP","CDP","ADI","ADS","VNP") 
levels(VarienMod$CATIRC01)<-c("AP","ARP","CDP","ADI","ADS","VNP")

## Abans d'extreure les noves hem de mirar que no siguin antigues modificatives
mod_ells<-altesTotes[altesTotes$NOPRDB01!=0,]
nov_ells<-altesTotes[altesTotes$NOPRDB01==0,]   
Noves<-anti_join(Noves,mod_ells,by="BENDNI") # noves nostres que NO són modificatives ells
names(Noves)[11]<-"NOPRDB"
Noves<-anti_join(Noves,VarienDNI,by="NOPRDB") 
E_noves<-anti_join(Noves,nov_ells,by="BENDNI")   #[err]

## Mirem les baixes definitives en cas  que el DNI desaparegui! 
# S'ha de vigilar que no es doni el cas 'canvi de dni sense canvi de proced'
Baixes<-DosmesosDNI[is.na(DosmesosDNI$NOPRDB.y)==TRUE,]
Baixes<-Baixes[,1:9]
names(Baixes)<-c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")
Baixes<-anti_join(Baixes,VarienDNI,by="NOPRDB")

## Mirem si les baixes que tenim són per defunció o no (altres)
names(historic_baixes)[9]<-"NOPRDB"    
historic_baixes$BENDNI<-as.character(historic_baixes$BENDNI)
Baixes_info<-left_join(Baixes,historic_baixes,by=c("NOPRDB","BENDNI"))
retinguts<-Baixes_info[is.na(Baixes_info$IMPORD.y)==TRUE,] # Retinguts: DNIs que desapareixen però no en tenim info al fitxer de baixes
retinguts<-retinguts[,1:9] 
levels(retinguts$CATIRC)<-c("AP", "ARP", "CDP", "ADI", "ADS", "PVN") 
Baixes_info<-Baixes_info[is.na(Baixes_info$IMPORD.y)==FALSE,] # traiem de baixes info els que estan en situació RETINGUDA
Baixes_info$MOTEST<-as.numeric(Baixes_info$MOTEST)
Baixes_info$DATFI<- as.Date(as.character(Baixes_info$DATFI), format="%Y%m%d")
Baixes_info$CADTST<- as.Date(as.character(Baixes_info$CADTST), format="%Y%m%d")

## PAGAMENTS INDEGUTS BAIXES
Baixes_info$temps_Indegut<-Baixes_info$CADTST- Baixes_info$DATFI
Baixes_info$cobrament_diari<-round(as.numeric(Baixes_info$NOPSAP)/30, digits = 2)                      # Cobrament diari indegut
Baixes_info$cobrament_inde<-round(Baixes_info$cobrament_diari*Baixes_info$temps_Indegut, digits = 2)   # Cobrament total indegut

# Separem per defunció / altres motius:
Baixes_def<-Baixes_info[Baixes_info$MOTEST==5,]
Baixes_def<-(Baixes_def[is.na(Baixes_def[,"NOPRDB"])==FALSE,])
Baixes_altres<-Baixes_info[Baixes_info$MOTEST!=5 | is.na(Baixes_info$MOTEST)==TRUE,]
Baixes_altres<-(Baixes_altres[is.na(Baixes_altres[,"NOPRDB"])==FALSE,])

EOrdUnics<-subset(ordinaries02, duplicated(ordinaries02$NOPRDB)==TRUE)  # [err]
if(nrow(EOrdUnics)!=0){
  rownames(EOrdUnics)<-c(1:nrow(EOrdUnics))
}

## PAGAMENTS INDEGUTS MODIFICATIVES
historic_baixes1<-historic_baixes

names(historic_baixes1)[9]<-"NOPRDB.x"
VarienMod<-left_join(VarienMod,historic_baixes1,by=c("BENDNI","NOPRDB.x"))
VarienMod$DATFI<- as.Date(as.character(VarienMod$DATFI), format="%Y%m%d")
VarienMod$CADTST<- as.Date(as.character(VarienMod$CADTST), format="%Y%m%d")
VarienMod$temps_Indegut<-VarienMod$CADTST- VarienMod$DATFI
VarienMod$cobrament_diari<-round((as.numeric(VarienMod$IMPORD01)-as.numeric(VarienMod$IMPORD.x))/30, digits = 2)    # Cobrament diari indegut
VarienMod$cobrament_inde<-round(VarienMod$cobrament_diari*VarienMod$temps_Indegut, digits = 2)                      # Cobrament total indegut

#Modificatives que no apareixen a baixes
EmodNb<-VarienMod[is.na(VarienMod$DATFI)==TRUE,]  # [err]
levels(EmodNb$CATIRC)<-prestcurt
colnames(EmodNb)[1:17]<-c("CARTE_antiga", "NOPRDB_antic", "BENDNI", "PREST_antiga", "ALTCAR_antic", "GN_antic", "IMPORT_antic", "NOPSAP_antic", 
                          "END_antic", "CARTE_nova", "NOPRDB_nou", "PREST_nova", "ALTCAR_nou", "GN_nou", "IMPORT_nou", "NOPSAP_nou", "END_nou")
EmodNb<-EmodNb[,c(1:17)]

## PAGAMENTS INDEGUTS CANVI RECURS
VarienRECURS<-left_join(VarienRECURS,historic_baixes1,by=c("BENDNI","NOPRDB.x"))
VarienRECURS$DATFI<- as.Date(as.character(VarienRECURS$DATFI), format="%Y%m%d")
VarienRECURS$CADTST<- as.Date(as.character(VarienRECURS$CADTST), format="%Y%m%d")
VarienRECURS$temps_Indegut<-VarienRECURS$CADTST- VarienRECURS$DATFI
VarienRECURS$cobrament_diari<-round((as.numeric(VarienRECURS$IMPORD01)- as.numeric(VarienRECURS$IMPORD.x))/30, digits = 2) # Cobrament diari indegut
VarienRECURS$cobrament_inde<-round(VarienRECURS$cobrament_diari*VarienRECURS$temps_Indegut, digits = 2)   # Cobrament total indegut

#Canvi recurs que no apareixen a baixes
names(VarienRECURS)<-c("CARTE01",         "NOPRDB.x",        "BENDNI",          "CATIRC01",        "ALTCAR01",        "GN01",      "IMPORD01",        "NOPSAP01",       
                       "END01",           "CARTE02",         "NOPRDB.y",        "CATIRC02",        "ALTCAR02",        "GN02",      "IMPORD02",        "NOPSAP02",         
                       "END02",           "CARTE01",         "EXPTI" ,          "EXPANY",          "EXPNUM",          "EXPSIT",    "BENNOM",          "BENCOG",         
                       "PRESTACIO",       "DATEFE",          "DATFI",           "CAVLST",          "CADTST",         "MOTEST" ,    "IMPORD.y",        "GRAU",           
                       "NIVELL",          "temps_Indegut",   "cobrament_diari", "cobrament_inde")


ErecNb<-VarienRECURS[is.na(VarienRECURS$DATFI)==TRUE,]  # [err]
colnames(ErecNb)[1:17]<-c("CARTE_antiga","NOPRDB_antic", "BENDNI", "PREST_antiga", "ALTCAR_antic", "GN_antic", "IMPORT_antic", "NOPSAP_antic", "END_antic",
                          "CARTE_nova", "NOPRDB_nou", "PREST_nova", "ALTCAR_nou", "GN_nou", "IMPORT_nou", "NOPSAP_nou", "END_nou")

#############################################################
##########                                 ##################
########## PAS 1: CREEM TAULES DINÀMIQUES  ##################
##########                                 ##################
#############################################################

## Recol·loquem i calculem valors per tenir la taula historic 
estad<-data.frame()
a<-split(quadrament, quadrament$CATIRC)
for (i in 1:length(a)){
  b<-as.data.frame(a[[i]])
  names(b)<-names(quadrament)
  c<-split(b, b$GN)
  m<-names(a[i])
  for(j in 1:length(c)){
    d<-as.data.frame(c[[j]])
    names(d)<-names(quadrament)
    n<-nrow(estad)
    estad[i,"Prestació"]<-b[1,"CATIRC"]
    if(is.na(d[1,"GN"])){
    }else if(d[1,"GN"]=="Grau 3"){
      estad[i,"Grau 3"]<-length(d[,"IMPORD"])
      estad[i,"3 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G3 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G3 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="3-2"){
      estad[i,"Grau 3-2"]<-length(d[,"IMPORD"])
      estad[i,"3-2 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G3-2 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G3-2 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="3-1"){
      estad[i,"Grau 3-1"]<-length(d[,"IMPORD"])
      estad[i,"3-1 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G3-1 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G3-1 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="Grau 2"){
      estad[i,"Grau 2"]<-length(d[,"IMPORD"])
      estad[i,"2 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G2 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G2 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="2-2"){
      estad[i,"Grau 2-2"]<-length(d[,"IMPORD"])
      estad[i,"2-2 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G2-2 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G2-2 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="2-1"){
      estad[i,"Grau 2-1"]<-length(d[,"IMPORD"])
      estad[i,"2-1 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G2-1 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G2-1 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="1-2"){
      estad[i,"Grau 1-2"]<-length(d[,"IMPORD"])
      estad[i,"1-2 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G1-2 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G1-2 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="Grau 1"){
      estad[i,"Grau 1"]<-length(d[,"IMPORD"])
      estad[i,"1 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G1 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G1 ENDARRERIMENTS"]<-sum(d[,"END"])
    }else if(d[1,"GN"]=="1-1"){
      estad[i,"Grau 1-1"]<-length(d[,"IMPORD"])
      estad[i,"1-1 (ALTES)"]<-nrow(d[is.na(d[,"Altes22"])!=TRUE |is.na(d[,"Altes22"])!=TRUE,])+nrow(d[is.na(d[,"Altes24"])!=TRUE |is.na(d[,"Altes24"])!=TRUE,])
      estad[i,"G1-1 ORDINÀRIA"]<-sum(d[,"IMPORD"])
      estad[i,"G1-1 ENDARRERIMENTS"]<-sum(d[,"END"])
    }
  }     # estad= estadístiques de altes, ordinàries, endarreriments en els diferents graus per cada tipus de prestació
}
rm(a,b,c,d,m,n,i,j)
estad[,"Mes"]<-format(as.yearmon(avui), "%m")
estad[,"Any"]<-as.yearmon(avui)
estad[,"Any"]<-as.yearmon(estad[,"Any"])

## DCRestad son les estadístiques d'aquest mes de VETLLADOR NO PROFESSIONAL;
## DCRenderr son els endarreriments per grau del mes actual (si no ens passen DCR serà tot 0)

DCRestad<-estad[estad$Prestació=="VETLLADOR NO PROFESSIONAL",]
DCRenderr<-aggregate(FCIMTO ~ GN, DCR, sum) # de la taula DCR: aquest aggregate suma tots els FIMTO que tenen el mateix G-N

DCRenderr[DCRenderr[,"GN"]=="Grau 1-2",1]<-"G1-2 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 1-9",1]<-"G1 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 1-1",1]<-"G1-1 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 2-1",1]<-"G2-1 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 2-9",1]<-"G2 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 2-2",1]<-"G2-2 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 3-1",1]<-"G3-1 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 3-2",1]<-"G3-2 ENDARRERIMENTS DCR*"
DCRenderr[DCRenderr[,"GN"]=="Grau 3-9",1]<-"G3 ENDARRERIMENTS DCR*"

## Creem PVNactual pel mes en què estem! PVN es l'històric PVN + l'actual (juntament amb els enderreriments)
DCR<-as.data.frame(t(DCRenderr))
names(DCR)<-DCRenderr[,1]     
DCR<-DCR[-1,]
PVNactual<-cbind(DCRestad, DCR)
PVNactual<-PVNactual[,-1]    
#PVNactual[,(ncol(DCRestad)):(ncol(PVNactual)-2)]<-as.vector(apply(PVNactual[,(ncol(DCRestad)):(ncol(PVNactual)-2)],1,as.numeric)) 

rm(DCRestad, DCRenderr)

#############################################################
##########                                  #################
########## PAS 2: COMPLETAR-HO AMB HISTORIC #################
##########                                  #################
#############################################################

## Ajuntem dades actuals amb el seu històric (excepte PVN):
estad<-estad[estad[,"Prestació"]!="VETLLADOR NO PROFESSIONAL",]
historic$Prestació<-as.factor(historic$Prestació)
historic<-rbind.fill(historic,estad)
historic<-subset(historic,duplicated(cbind(as.Date(historic$Any),historic[,"Prestació"]),fromLast = TRUE)==FALSE)

## Juntem PVN actual amb el seu historic:
historicPVN<-rbind.fill(historicPVN,PVNactual)
historicPVN<-subset(historicPVN,duplicated(as.Date(historicPVN$Any),fromLast = TRUE)==FALSE)
rm(estad)

#############################################################
##########                                 ##################
##########   PAS 3: SEPARAR L'ANY ACTUAL   ##################
##########                                 ##################
#############################################################

## Per poder guardar bé l'any actual fem:
anyactual<-historic[format(historic[,"Any"],"%Y")==  format(as.yearmon(avui), "%Y"),]
anyactual$Any<-NULL
anyactual[,"Mes"]<-as.factor(anyactual[,"Mes"])
levels(anyactual[,"Mes"])<-mes

## VNP de l'any actual
VNP<-historicPVN[format(historicPVN[,"Any"],"%Y")==  as.numeric( format(as.yearmon(avui), "%Y")),]
VNP$Any<-NULL
VNP[,"Mes"]<-as.factor(VNP[,"Mes"])
levels(VNP[,"Mes"])<-mes

## Completem els espais buits amb 0
## Dades prestacions:
anyactual2<-data.frame(sapply(anyactual[,3:ncol(anyactual)],haz.cero.na))
names(anyactual2)<-names(anyactual[,3:ncol(anyactual)])
anyactual2<-round(anyactual2,2) 
anyactual[,3:ncol(anyactual)]<-anyactual2

## Dades PVN:
VNPsinNA<-as.data.frame((sapply(VNP[,1:(ncol(VNP)-1)], haz.cero.na)))
if("Grau 3" %in% names(VNPsinNA)){}else{VNPsinNA<-as.data.frame((t(VNPsinNA)))}
VNP[1:(ncol(VNP)-1)]<-VNPsinNA
VNP[,"Mes"]<-as.factor((VNP[,"Mes"])) 
levels(VNP[,"Mes"])<-mes 

rm(anyactual2,VNPsinNA)

## Ara ja tenim:
# - PVN: PVN de l'any actual
# - anyactual: estad de l'any actual

#############################################################
##########                                 ##################
##########   PAS 4: CREAR TAULES           ##################
##########                                 ##################
#############################################################

#######################################
## A) Calcular el final de la taula  ##
#######################################

## Dades pensions
a<-   anyactual[,"Grau 3"]+ anyactual[,"Grau 2"]+anyactual[,"Grau 1"] 
b<-  if("Grau 3-2" %in% names(anyactual)){anyactual[,"Grau 3-2"]}else{0}
c<-  if("Grau 3-1" %in% names(anyactual)){anyactual[,"Grau 3-1"]}else{0}
d<-  if("Grau 2-2" %in% names(anyactual)){anyactual[,"Grau 2-2"]}else{0}
e<-  if("Grau 2-1" %in% names(anyactual)){anyactual[,"Grau 2-1"]}else{0}
f<-  if("Grau 1-2" %in% names(anyactual)){anyactual[,"Grau 1-2"]}else{0}
g<-  if("Grau 1-1" %in% names(anyactual)){anyactual[,"Grau 1-1"]}else{0}
anyactual[,"Total grau"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a<-   anyactual[,"3 (ALTES)"]+ anyactual[,"2 (ALTES)"]+anyactual[,"1 (ALTES)"] 
b<-  if("3-2 (ALTES)" %in% names(anyactual)){anyactual[,"3-2 (ALTES)"]}else{0}
c<-  if("3-1 (ALTES)" %in% names(anyactual)){anyactual[,"3-1 (ALTES)"]}else{0}
d<-  if("2-2 (ALTES)" %in% names(anyactual)){anyactual[,"2-2 (ALTES)"]}else{0}
e<-  if("2-1 (ALTES)" %in% names(anyactual)){anyactual[,"2-1 (ALTES)"]}else{0}
f<-  if("1-2 (ALTES)" %in% names(anyactual)){anyactual[,"1-2 (ALTES)"]}else{0}
g<-  if("1-1 (ALTES)" %in% names(anyactual)){anyactual[,"1-1 (ALTES)"]}else{0}
anyactual[,"Total (Altes)"]<-a+b+c+d+e+f
rm(a,b,c,d,e,f,g)

a<- anyactual[,"G3 ORDINÀRIA"]+ anyactual[,"G2 ORDINÀRIA"]+ anyactual[,"G1 ORDINÀRIA"]
b<-  if("G3-2 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G3-2 ORDINÀRIA"]}else{0}  
c<-  if("G3-1 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G3-1 ORDINÀRIA"]}else{0} 
d<-  if("G2-2 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G2-2 ORDINÀRIA"]}else{0} 
e<-  if("G2-1 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G2-1 ORDINÀRIA"]}else{0} 
f<-  if("G1-2 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G1-2 ORDINÀRIA"]}else{0}
g<-  if("G1-1 ORDINÀRIA" %in% names(anyactual)){anyactual[,"G1-1 ORDINÀRIA"]}else{0}
anyactual[,"Total Ordinària"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a <-anyactual[,"G3 ENDARRERIMENTS"]+ anyactual[,"G2 ENDARRERIMENTS"]+ anyactual[,"G1 ENDARRERIMENTS"]
b<-  if("G3-2 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G3-2 ENDARRERIMENTS"]}else{0} 
c<-  if("G3-1 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G3-1 ENDARRERIMENTS"]}else{0} 
d<-  if("G2-2 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G2-2 ENDARRERIMENTS"]}else{0} 
e<-  if("G2-1 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G2-1 ENDARRERIMENTS"]}else{0} 
f<-  if("G1-2 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G1-2 ENDARRERIMENTS"]}else{0} 
g<-  if("G1-1 ENDARRERIMENTS" %in% names(anyactual)){anyactual[,"G1-1 ENDARRERIMENTS"]}else{0} 
anyactual[,"Total Endarreriments"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

anyactual[,"TOTAL Import"]<-anyactual[,"Total Ordinària"]+anyactual[,"Total Endarreriments"]

## Dades VNP
a<-   VNP[,"Grau 3"]+ VNP[,"Grau 2"]+VNP[,"Grau 1"] 
b<-  if("Grau 3-2" %in% names(VNP)){VNP[,"Grau 3-2"]}else{0}
c<-  if("Grau 3-1" %in% names(VNP)){VNP[,"Grau 3-1"]}else{0}
d<-  if("Grau 2-2" %in% names(VNP)){VNP[,"Grau 2-2"]}else{0}
e<-  if("Grau 2-1" %in% names(VNP)){VNP[,"Grau 2-1"]}else{0}
f<-  if("Grau 1-2" %in% names(VNP)){VNP[,"Grau 1-2"]}else{0}
g<-  if("Grau 1-1" %in% names(VNP)){VNP[,"Grau 1-1"]}else{0}
VNP[,"Total grau"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a<-   VNP[,"3 (ALTES)"]+ VNP[,"2 (ALTES)"]+VNP[,"1 (ALTES)"] 
b<-  if("3-2 (ALTES)" %in% names(VNP)){VNP[,"3-2 (ALTES)"]}else{0}
c<-  if("3-1 (ALTES)" %in% names(VNP)){VNP[,"3-1 (ALTES)"]}else{0}
d<-  if("2-2 (ALTES)" %in% names(VNP)){VNP[,"2-2 (ALTES)"]}else{0}
e<-  if("2-1 (ALTES)" %in% names(VNP)){VNP[,"2-1 (ALTES)"]}else{0}
f<-  if("1-2 (ALTES)" %in% names(VNP)){VNP[,"1-2 (ALTES)"]}else{0}
g<-  if("1-1 (ALTES)" %in% names(VNP)){VNP[,"1-1 (ALTES)"]}else{0}
VNP[,"Total (Altes)"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a<- VNP[,"G3 ORDINÀRIA"]+ VNP[,"G2 ORDINÀRIA"]+ VNP[,"G1 ORDINÀRIA"]
b<-  if("G3-2 ORDINÀRIA" %in% names(VNP)){VNP[,"G3-2 ORDINÀRIA"]}else{0}  
c<-  if("G3-1 ORDINÀRIA" %in% names(VNP)){VNP[,"G3-1 ORDINÀRIA"]}else{0} 
d<-  if("G2-2 ORDINÀRIA" %in% names(VNP)){VNP[,"G2-2 ORDINÀRIA"]}else{0} 
e<-  if("G2-1 ORDINÀRIA" %in% names(VNP)){VNP[,"G2-1 ORDINÀRIA"]}else{0} 
f<-  if("G1-2 ORDINÀRIA" %in% names(VNP)){VNP[,"G1-2 ORDINÀRIA"]}else{0}
g<-  if("G1-1 ORDINÀRIA" %in% names(VNP)){VNP[,"G1-1 ORDINÀRIA"]}else{0}
VNP[,"Total Ordinària"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a <-VNP[,"G3 ENDARRERIMENTS"]+ VNP[,"G2 ENDARRERIMENTS"]+ VNP[,"G1 ENDARRERIMENTS"]
b<-  if("G3-2 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G3-2 ENDARRERIMENTS"]}else{0} 
c<-  if("G3-1 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G3-1 ENDARRERIMENTS"]}else{0} 
d<-  if("G2-2 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G2-2 ENDARRERIMENTS"]}else{0} 
e<-  if("G2-1 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G2-1 ENDARRERIMENTS"]}else{0} 
f<-  if("G1-2 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G1-2 ENDARRERIMENTS"]}else{0} 
g<-  if("G1-1 ENDARRERIMENTS" %in% names(VNP)){VNP[,"G1-1 ENDARRERIMENTS"]}else{0} 
VNP[,"Total Endarreriments"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

a <-VNP[,"G3 ENDARRERIMENTS DCR*"]+ VNP[,"G2 ENDARRERIMENTS DCR*"]+ VNP[,"G1 ENDARRERIMENTS DCR*"]
b<-  if("G3-2 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G3-2 ENDARRERIMENTS DCR*"]}else{0} 
c<-  if("G3-1 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G3-1 ENDARRERIMENTS DCR*"]}else{0} 
d<-  if("G2-2 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G2-2 ENDARRERIMENTS DCR*"]}else{0} 
e<-  if("G2-1 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G2-1 ENDARRERIMENTS DCR*"]}else{0} 
f<-  if("G1-2 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G1-2 ENDARRERIMENTS DCR*"]}else{0} 
g<-  if("G1-1 ENDARRERIMENTS DCR*" %in% names(VNP)){VNP[,"G1-1 ENDARRERIMENTS DCR*"]}else{0} 
VNP[,"Total Endarreriments DCR*"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

VNP[,"TOTAL Import"]<-VNP[,"Total Ordinària"]+VNP[,"Total Endarreriments"]

## Ordenem les columnes, posant els totals davant:   
anyactual_T<-anyactual[,(ncol(anyactual)-4):ncol(anyactual)]
anyactual_0<-anyactual[,3:(ncol(anyactual)-5)]
anyactual<-cbind(anyactual$Prestació, anyactual$Mes, anyactual_T, anyactual_0)
names(anyactual)[c(1,2)]<-c("Prestació", "Mes")

VNP_T<-VNP[,(ncol(VNP)-5):ncol(VNP)]
VNP_0<-VNP[,1:(ncol(VNP)-6)]
VNP<-cbind(VNP_T, VNP_0)

rm(anyactual_T, anyactual_0, VNP_T, VNP_0)

#############################################################################################
################## SUPRIMIM LES COLUMNES SOBRANTS (ZEROS)           #########################
#############################################################################################

# Faig un vector suma on cada element sigui la suma d'una columna
suma<-c()
for(i in 1:ncol(anyactual)){ # li he de dir que si no són numèrics em posi NA
  if(is.numeric(anyactual[,i])==TRUE){
    suma[i]<-sum(anyactual[,i])
  }else{
    suma[i]<-"NA"
  }
}
suma<-as.data.frame(suma)

# Si 4 elements seguits de suma són zero, elimina'm les columnes corresponents d'anyactual
for(i in 1:(ncol(anyactual)-3)){
  if(suma[i,]==0 && suma[i+1,]==0 && suma[i+2,]==0 && suma[i+3,]==0){
    anyactual<-anyactual[, -c(i:(i+3))]
  }
}

################# El mateix amb VNP ##############################
suma2<-c()
for(i in 1:ncol(VNP)){ # li he de dir que si no són numèrics em posi NA
  if(is.numeric(VNP[,i])==TRUE){
    suma2[i]<-sum(VNP[,i])
  }else{
    suma2[i]<-"NA"
  }
}
suma2<-as.data.frame(suma2)

# Ara han de ser 5 zeros seguits (perquè hi ha endarreriments DCR)
for(i in 1:(ncol(VNP)-4)){
  if(suma2[i,]==0 && suma2[i+1,]==0 && suma2[i+2,]==0 && suma2[i+3,]==0 && suma2[i+4,]==0){
    VNP<-VNP[, -c(i:(i+4))]
  }
}
rm(suma, suma2)
###########################################################################################
###########################################################################################

#######################################
## B) Creem les taules per mesos  #####
#######################################

## Fem totes les prestacions per cada mes
anyactual$Prestació<-as.character(anyactual$Prestació)
VNP[,"Prestació"]<-"VETLLADOR NO PROFESSIONAL"
taula_totes<-full_join(VNP, anyactual,by=names(anyactual))

taula_totes[,ncol(taula_totes)]<-as.factor(taula_totes[,ncol(taula_totes)])
levels(taula_totes[,ncol(taula_totes)])<-c("AP", "ARP", "CD", "ADI", "ADS", "VNP")

aa<-split(taula_totes, taula_totes$Mes)
for(i in 1:length(aa)){         
  bb<-as.data.frame(aa[[i]])
  bb$Mes<-NULL
  rownames(bb)<-bb[,"Prestació"]
  bb$Prestació<-NULL
  assign(names(aa[i]), bb)
}

rownames(VNP)<-VNP[,"Mes"]
VNP$Prestació<-NULL

rm(aa,bb, i, taula_totes)

########################################
## C) Creem les taules per prestació  ##
########################################
mes_actual<-as.numeric(format(as.yearmon(avui), "%m"))

CD<-anyactual[anyactual[,1]=="PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI (CENTRE DE DIA)",]
CD<-CD[match(mes[1:nrow(CD)], CD$Mes),] 
CD<-CD[,-1]

ARP<-anyactual[anyactual[,1]=="PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI (ACOLLIMENT RESIDENCIAL)",]
ARP<-ARP[match(mes[1:nrow(ARP)], ARP$Mes),] 
ARP<-ARP[,-1]

ADI<-anyactual[anyactual[,1]=="PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI (SUPORT DOMICILIARI INFERIOR)",]
ADI<-ADI[match(mes[1:nrow(ADI)], ADI$Mes),] 
ADI<-ADI[,-1]

ADS<-anyactual[anyactual[,1]=="PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI (SUPORT DOMICILIARI SUPERIOR)",]
ADS<-ADS[match(mes[1:nrow(ADS)], ADS$Mes),] 
ADS<-ADS[,-1]

AP<-anyactual[anyactual[,1]=="ASSISTENT PERSONAL",]
AP<-AP[match(mes[1:nrow(AP)], AP$Mes),] 
AP<-AP[,-1]

VNP<-VNP[match(mes[1:nrow(VNP)], VNP$Mes),] 

## Completem el resta de mesos que no hi són per 0
CD[1:12,"Mes"]<-mes
row.names(CD)<-mes
CD[,"Mes"]<-NULL

ARP[1:12,"Mes"]<-mes
row.names(ARP)<-mes
ARP[,"Mes"]<-NULL

ADI[1:12,"Mes"]<-mes
row.names(ADI)<-mes
ADI[,"Mes"]<-NULL

ADS[1:12,"Mes"]<-mes
row.names(ADS)<-mes
ADS[,"Mes"]<-NULL

AP[1:12,"Mes"]<-mes
row.names(AP)<-mes
AP[,"Mes"]<-NULL

VNP[1:12,"Mes"]<-mes
row.names(VNP)<-mes
VNP[,"Mes"]<-NULL 

i<-1
while(i<=12){
  if(is.na(CD[i,1]) & is.na(VNP[i,1]) & is.na(ARP[i,1])){
    CD[mes[i],]<-rep(0, ncol(CD))
    ARP[mes[i],]<-rep(0, ncol(ARP))
    ADI[mes[i],]<-rep(0, ncol(ADI))
    ADS[mes[i],]<-rep(0, ncol(ADS))
    AP[mes[i],]<-rep(0, ncol(AP))
    VNP[mes[i],]<-rep(0, ncol(VNP))
  }
  i<-i+1
}

## Creem el total de PVS
PVS<-CD+ADS+ADI+ARP

#######################################
#### D1) Completar LAPAD III      #####
#######################################

## Es crea TotalP amb els totals globals dels 3 tipus de prestació
avuiC<-as.character(avui) 
TotalP[avuiC,]<-NA
Resum[avuiC,]<-NA
BAM[avuiC,]<-NA
TotalP[avuiC,"Any"]<-avui
Resum[avuiC,"Any"]<-avui
BAM[avuiC,"Any"]<-avui

# AP
TotalP[avuiC,1]<-AP[mes_actual,2]
TotalP[avuiC,2]<-AP[mes_actual,1]
TotalP[avuiC,3:5]<-AP[mes_actual,3:5]

# VNP
TotalP[avuiC, 6]<-VNP[mes_actual, 2]
TotalP[avuiC, 7]<-VNP[mes_actual, 1]
TotalP[avuiC,8:11]<-VNP[mes_actual,3:6]

# PVS
TotalP[avuiC, 12]<-PVS[mes_actual, 2]
TotalP[avuiC, 13]<-PVS[mes_actual, 1]
TotalP[avuiC,14:16]<-PVS[mes_actual,3:5]

#######################################
#### D2) Completar LAPAD III      #####
#######################################
## S'actualitzen les taules de Resum
# A Modif indeguts només volem les que REDUEIXEN L'IMPORT, que són les que generen pagaments indeguts
ModifRedueixen<-VarienMod[VarienMod$cobrament_diari>0,]
ModifAugmenten<-VarienMod[VarienMod$cobrament_diari<0,]
levels(VarienRECURS$CATIRC02)<-prestcurt
RecursRedueixen<-VarienRECURS[VarienRECURS$cobrament_diari>0,]
RecursAugmenten<-VarienRECURS[VarienRECURS$cobrament_diari<0,]

Resum[avuiC,"Prestacions"]<-TotalP[avuiC,2]+TotalP[avuiC,7]+TotalP[avuiC,13]  
Resum[avuiC,"Import"]<-TotalP[avuiC,5]+TotalP[avuiC,11]+TotalP[avuiC,16]         # importAP+importVNP+importPVS
Resum[avuiC,"Mitjana total(e/u)"]<-Resum[avuiC,"Import"]/Resum[avuiC,"Prestacions"]   # Import total entre núm. prestacions
Resum[avuiC,"Endarreriments(e)"]<- TotalP[avuiC,4]+TotalP[avuiC,9]+TotalP[avuiC,15] # + TotalP[avuiC,10] # ??

# Mitjana dels endarreriments total ( = Endarreriments / altes )
Resum[avuiC,"Mitjana endarreriments (end/altes)"]<-ifelse((TotalP[avuiC,4]+TotalP[avuiC,9]+ TotalP[avuiC,10] +
                                                             TotalP[avuiC,15])==0,0,(TotalP[avuiC,4]+TotalP[avuiC,9]+ TotalP[avuiC,10] +TotalP[avuiC,15])/ 
                                                            (TotalP[avuiC,1]+TotalP[avuiC,6]+TotalP[avuiC,12]))
Resum[avuiC,"Noves(u)"]<-nrow(Noves)
Resum[avuiC,"Retinguts(u)"]<-nrow(retinguts)
Resum[avuiC,"Baixes totals(u)"]<-nrow(Baixes_info)
Resum[avuiC,"Baixes defuncions(u)"]<-nrow(Baixes_def)  
Resum[avuiC,"Bdef mitjana temps(dies)"]<-round(mean(Baixes_def[is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"Bdef mitj pagaments(e/u)"]<-mean(Baixes_def[is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
Resum[avuiC,"Bdef pagaments indeguts(e)"]<-sum(Baixes_def[is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
Resum[avuiC,"Baixes altres motius(u)"]<-nrow(Baixes_altres)
Resum[avuiC,"B_altres mitjana temps(dies)"]<-round(mean(Baixes_altres[is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"B_altres mitj pagaments(e/u)"]<-mean(Baixes_altres[is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
Resum[avuiC,"B_altres pagaments indeguts(e)"]<-sum(Baixes_altres[is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])

# Modificatives 
Resum[avuiC,"Modificatives a la baixa(u)"]<-nrow(ModifRedueixen)
Resum[avuiC,"M_b mitj temps (dies)"]<-round(mean(ModifRedueixen[is.na(ModifRedueixen$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"M_b mitj pagaments(e/u)"]<-round(mean(ModifRedueixen[is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)
Resum[avuiC,"M_b pagaments indeguts(e)"]<-round(sum(ModifRedueixen[is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)

Resum[avuiC,"Modificatives a l'alça(u)"]<-nrow(ModifAugmenten)
Resum[avuiC,"M_a mitj temps (dies)"]<-round(mean(ModifAugmenten[is.na(ModifAugmenten$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"M_a mitj pagaments endarr(e/u)"]<-abs(round(mean(ModifAugmenten[is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
Resum[avuiC,"M_a pagaments endarr(e)"]<-abs(round(sum(ModifAugmenten[is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"])  , digits = 2))

# Canvis de recurs 
Resum[avuiC,"Baixes per canvi de recurs a la baixa(u)"]<-nrow(RecursRedueixen)
Resum[avuiC,"R_b mitj temps (dies)"]<-round(mean(RecursRedueixen[is.na(RecursRedueixen$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"R_b mitj pagaments(e/u)"]<-round(mean(RecursRedueixen[is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)
Resum[avuiC,"R_b pagaments indeguts(e)"]<-round(sum(RecursRedueixen[is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)

Resum[avuiC,"Baixes per canvi de recurs a l'alça(u)"]<-nrow(RecursAugmenten)
Resum[avuiC,"R_a mitj temps (dies)"]<-round(mean(RecursAugmenten[is.na(RecursAugmenten$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0)
Resum[avuiC,"R_a mitj pagaments endarr(e/u)"]<-abs(round(mean(RecursAugmenten[is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
Resum[avuiC,"R_a pagaments endarr(e)"]<-abs(round(sum(RecursAugmenten[is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))

# Usuaris
Resum[avuiC,"Usuaris Totals"]<-length(unique(quadrament$BENDNI)) 
Resum[avuiC,"Usuaris DCR"]<-if(is.data.frame(DCR)==FALSE){0}else{nrow(DCR)} 

###################################
#####  BAIXES ALTES I USUARIS  #### 
###################################

levels(ordinaries02$CATIRC)<-prestcurt
levels(Baixes_info$CATIRC)<-c("AP","ARP","CDP","ADI","ADS","VNP")
levels(VarienMod$CATIRC)<-prestcurt

#Mitjana enderreriments
BAM[avuiC,"mitj_end AP"]<-ifelse(AP[mes_actual,2]==0, "NA", round(AP[mes_actual,4]/AP[mes_actual,2], digits = 2))
BAM[avuiC,"mitj_end CDP"]<-ifelse(CD[mes_actual,2]==0, "NA", round(CD[mes_actual,4]/CD[mes_actual,2], digits = 2))
BAM[avuiC,"mitj_end VNP"]<-ifelse(VNP[mes_actual,2]==0, "NA", round((VNP[mes_actual,4]+VNP[mes_actual,5])/VNP[mes_actual,2], digits = 2))
BAM[avuiC,"mitj_end ADI"]<-ifelse(ADI[mes_actual,2]==0, "NA", round(ADI[mes_actual,4]/ADI[mes_actual,2], digits = 2))
BAM[avuiC,"mitj_end ADS"]<-ifelse(ADS[mes_actual,2]==0, "NA", round(ADS[mes_actual,4]/ADS[mes_actual,2], digits = 2))
BAM[avuiC,"mitj_end ARP"]<-ifelse(ARP[mes_actual,2]==0, "NA", round(ARP[mes_actual,4]/ARP[mes_actual,2], digits = 2))

#Noves
BAM[avuiC,"Noves AP"]<- nrow(Noves[Noves$CATIRC=="AP",])
BAM[avuiC,"Noves VNP"]<-nrow(Noves[Noves$CATIRC=="VNP",])
BAM[avuiC,"Noves ADI"]<-nrow(Noves[Noves$CATIRC=="ADI",])
BAM[avuiC,"Noves ADS"]<-nrow(Noves[Noves$CATIRC=="ADS",])
BAM[avuiC,"Noves CDP"]<-nrow(Noves[Noves$CATIRC=="CDP",])
BAM[avuiC,"Noves ARP"]<-nrow(Noves[Noves$CATIRC=="ARP",])

#Retinguts
BAM[avuiC,"Ret AP"]<- nrow(retinguts[retinguts$CATIRC=="AP",])
BAM[avuiC,"Ret VNP"]<-nrow(retinguts[retinguts$CATIRC=="VNP",])
BAM[avuiC,"Ret ARP"]<-nrow(retinguts[retinguts$CATIRC=="ARP",])
BAM[avuiC,"Ret CDP"]<-nrow(retinguts[retinguts$CATIRC=="CDP",])
BAM[avuiC,"Ret ADI"]<-nrow(retinguts[retinguts$CATIRC=="ADI",])
BAM[avuiC,"Ret ADS"]<-nrow(retinguts[retinguts$CATIRC=="ADS",])

#Baixes totals
BAM[avuiC,"Baixes AP"]<- nrow(Baixes_info[Baixes_info$CATIRC=="AP",])
BAM[avuiC,"Baixes VNP"]<-nrow(Baixes_info[Baixes_info$CATIRC=="VNP",])
BAM[avuiC,"Baixes ARP"]<-nrow(Baixes_info[Baixes_info$CATIRC=="ARP",])
BAM[avuiC,"Baixes CDP"]<-nrow(Baixes_info[Baixes_info$CATIRC=="CDP",])
BAM[avuiC,"Baixes ADI"]<-nrow(Baixes_info[Baixes_info$CATIRC=="ADI",])
BAM[avuiC,"Baixes ADS"]<-nrow(Baixes_info[Baixes_info$CATIRC=="ADS",])


### BAIXES DEFUNCIÓ ###

#Baixes per defunció
BAM[avuiC,"B_def AP"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="AP",])
BAM[avuiC,"B_def VNP"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="PVN",])
BAM[avuiC,"B_def ARP"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="ARP",])
BAM[avuiC,"B_def CDP"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="CDP",])
BAM[avuiC,"B_def ADI"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="ADI",])
BAM[avuiC,"B_def ADS"]<-nrow(Baixes_def[Baixes_def$PRESTACIO=="ADS",])

#Mitjana temps baixes
BAM[avuiC,"B_def mitj_t AP"]<-ifelse(BAM[avuiC,"B_def AP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="AP" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_def mitj_t VNP"]<-ifelse(BAM[avuiC,"B_def VNP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="PVN" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_def mitj_t ARP"]<-ifelse(BAM[avuiC,"B_def ARP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ARP" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_def mitj_t CDP"]<-ifelse(BAM[avuiC,"B_def CDP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="CDP" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_def mitj_t ADI"]<-ifelse(BAM[avuiC,"B_def ADI"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ADI" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_def mitj_t ADS"]<-ifelse(BAM[avuiC,"B_def ADS"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ADS" & is.na(Baixes_def$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut
BAM[avuiC,"B_def mitj_p AP"]<- ifelse(BAM[avuiC,"B_def AP"]==0, "NA",  round(mean(Baixes_def[Baixes_def$PRESTACIO=="AP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_def mitj_p CDP"]<-ifelse(BAM[avuiC,"B_def CDP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="CDP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_def mitj_p VNP"]<-ifelse(BAM[avuiC,"B_def VNP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="PVN" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_def mitj_p ADI"]<-ifelse(BAM[avuiC,"B_def ADI"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ADI" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_def mitj_p ADS"]<-ifelse(BAM[avuiC,"B_def ADS"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ADS" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_def mitj_p ARP"]<-ifelse(BAM[avuiC,"B_def ARP"]==0, "NA", round(mean(Baixes_def[Baixes_def$PRESTACIO=="ARP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))

#Total money indegut
BAM[avuiC,"B_def P_ind AP"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="AP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_def P_ind CDP"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="CDP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_def P_ind VNP"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="PVN" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_def P_ind ADI"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="ADI" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_def P_ind ADS"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="ADS" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_def P_ind ARP"]<-sum(Baixes_def[Baixes_def$PRESTACIO=="ARP" & is.na(Baixes_def$cobrament_inde)==FALSE,"cobrament_inde"])

### BAIXES ALTRES MOTIUS ###

#Baixa altres motius
BAM[avuiC,"B_altres AP"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="AP",])
BAM[avuiC,"B_altres VNP"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="PVN",])
BAM[avuiC,"B_altres ARP"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="ARP",])
BAM[avuiC,"B_altres CDP"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="CDP",])
BAM[avuiC,"B_altres ADI"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="ADI",])
BAM[avuiC,"B_altres ADS"]<-nrow(Baixes_altres[Baixes_altres$PRESTACIO=="ADS",])

#Mitjana temps baixes altres
BAM[avuiC,"B_altres mitj_t AP"]<-ifelse(BAM[avuiC,"B_altres AP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="AP" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_altres mitj_t VNP"]<-ifelse(BAM[avuiC,"B_altres VNP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="PVN" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_altres mitj_t ARP"]<-ifelse(BAM[avuiC,"B_altres ARP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ARP" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_altres mitj_t CDP"]<-ifelse(BAM[avuiC,"B_altres CDP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="CDP" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_altres mitj_t ADI"]<-ifelse(BAM[avuiC,"B_altres ADI"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ADI" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"B_altres mitj_t ADS"]<-ifelse(BAM[avuiC,"B_altres ADS"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ADS" & is.na(Baixes_altres$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut
BAM[avuiC,"B_altres mitj_p AP"]<- ifelse(BAM[avuiC,"B_altres AP"]==0, "NA",  round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="AP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_altres mitj_p CDP"]<-ifelse(BAM[avuiC,"B_altres CDP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="CDP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_altres mitj_p VNP"]<-ifelse(BAM[avuiC,"B_altres VNP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="PVN" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_altres mitj_p ADI"]<-ifelse(BAM[avuiC,"B_altres ADI"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ADI" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_altres mitj_p ADS"]<-ifelse(BAM[avuiC,"B_altres ADS"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ADS" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"B_altres mitj_p ARP"]<-ifelse(BAM[avuiC,"B_altres ARP"]==0, "NA", round(mean(Baixes_altres[Baixes_altres$PRESTACIO=="ARP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))

#Total money indegut
BAM[avuiC,"B_altres P_ind AP"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="AP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_altres P_ind CDP"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="CDP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_altres P_ind VNP"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="PVN" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_altres P_ind ADI"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="ADI" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_altres P_ind ADS"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="ADS" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"B_altres P_ind ARP"]<-sum(Baixes_altres[Baixes_altres$PRESTACIO=="ARP" & is.na(Baixes_altres$cobrament_inde)==FALSE,"cobrament_inde"])

### MODIFICATIVES ###
BAM[avuiC,"modif AP"]<-nrow(VarienMod[VarienMod$CATIRC01=="AP",])
BAM[avuiC,"modif VNP"]<-nrow(VarienMod[VarienMod$CATIRC01=="VNP",])
BAM[avuiC,"modif ADI"]<-nrow(VarienMod[VarienMod$CATIRC01=="ADI",])
BAM[avuiC,"modif ADS"]<-nrow(VarienMod[VarienMod$CATIRC01=="ADS",])
BAM[avuiC,"modif CDP"]<-nrow(VarienMod[VarienMod$CATIRC01=="CDP",])
BAM[avuiC,"modif ARP"]<-nrow(VarienMod[VarienMod$CATIRC01=="ARP",])

## Modificatives a la baixa ##
BAM[avuiC,"M_b AP"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="AP",])
BAM[avuiC,"M_b VNP"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="VNP",])
BAM[avuiC,"M_b ADI"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="ADI",])
BAM[avuiC,"M_b ADS"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="ADS",])
BAM[avuiC,"M_b CDP"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="CDP",])
BAM[avuiC,"M_b ARP"]<-nrow(ModifRedueixen[ModifRedueixen$CATIRC01=="ARP",])

#Mitjana temps modificatives
BAM[avuiC,"M_b mitj_t AP"]<-ifelse(BAM[avuiC,"M_b AP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="AP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))                 
BAM[avuiC,"M_b mitj_t VNP"]<-ifelse(BAM[avuiC,"M_b VNP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="VNP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_b mitj_t ARP"]<-ifelse(BAM[avuiC,"M_b ARP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ARP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_b mitj_t CDP"]<-ifelse(BAM[avuiC,"M_b CDP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="CDP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_b mitj_t ADI"]<-ifelse(BAM[avuiC,"M_b ADI"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ADI" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_b mitj_t ADS"]<-ifelse(BAM[avuiC,"M_b ADS"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ADS" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut modificativa
BAM[avuiC,"M_b mitj_p AP"]<-ifelse(BAM[avuiC,"M_b AP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="AP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))                 
BAM[avuiC,"M_b mitj_p VNP"]<-ifelse(BAM[avuiC,"M_b VNP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="VNP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"M_b mitj_p ARP"]<-ifelse(BAM[avuiC,"M_b ARP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ARP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"M_b mitj_p CDP"]<-ifelse(BAM[avuiC,"M_b CDP"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="CDP" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"M_b mitj_p ADI"]<-ifelse(BAM[avuiC,"M_b ADI"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ADI" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"M_b mitj_p ADS"]<-ifelse(BAM[avuiC,"M_b ADS"]==0, "NA", round(mean(ModifRedueixen[ModifRedueixen$CATIRC01=="ADS" & is.na(ModifRedueixen$temps_Indegut)==FALSE & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))

#Total money indegut modificativa
BAM[avuiC,"M_b P_ind AP"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="AP" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"M_b P_ind CDP"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="CDP" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"M_b P_ind VNP"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="VNP" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"M_b P_ind ADI"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="ADI" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"M_b P_ind ADS"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="ADS" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"M_b P_ind ARP"]<-sum(ModifRedueixen[ModifRedueixen$CATIRC01=="ARP" & is.na(ModifRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])


## Modificatives a l'alça ##
BAM[avuiC,"M_a AP"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="AP",])
BAM[avuiC,"M_a VNP"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="VNP",])
BAM[avuiC,"M_a ADI"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="ADI",])
BAM[avuiC,"M_a ADS"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="ADS",])
BAM[avuiC,"M_a CDP"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="CDP",])
BAM[avuiC,"M_a ARP"]<-nrow(ModifAugmenten[ModifAugmenten$CATIRC01=="ARP",])

#Mitjana temps modificatives
BAM[avuiC,"M_a mitj_t AP"]<-ifelse(BAM[avuiC,"M_a AP"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="AP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))                 
BAM[avuiC,"M_a mitj_t VNP"]<-ifelse(BAM[avuiC,"M_a VNP"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="VNP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_a mitj_t ARP"]<-ifelse(BAM[avuiC,"M_a ARP"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ARP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_a mitj_t CDP"]<-ifelse(BAM[avuiC,"M_a CDP"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="CDP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_a mitj_t ADI"]<-ifelse(BAM[avuiC,"M_a ADI"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ADI" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"M_a mitj_t ADS"]<-ifelse(BAM[avuiC,"M_a ADS"]==0, "NA", round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ADS" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut modificativa
BAM[avuiC,"M_a mitj_p AP"]<-ifelse(BAM[avuiC,"M_a AP"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="AP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))                 
BAM[avuiC,"M_a mitj_p VNP"]<-ifelse(BAM[avuiC,"M_a VNP"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="VNP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))
BAM[avuiC,"M_a mitj_p ARP"]<-ifelse(BAM[avuiC,"M_a ARP"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ARP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))
BAM[avuiC,"M_a mitj_p CDP"]<-ifelse(BAM[avuiC,"M_a CDP"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="CDP" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))
BAM[avuiC,"M_a mitj_p ADI"]<-ifelse(BAM[avuiC,"M_a ADI"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ADI" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))
BAM[avuiC,"M_a mitj_p ADS"]<-ifelse(BAM[avuiC,"M_a ADS"]==0, "NA", abs(round(mean(ModifAugmenten[ModifAugmenten$CATIRC01=="ADS" & is.na(ModifAugmenten$temps_Indegut)==FALSE & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))

#Total money indegut modificativa
BAM[avuiC,"M_a P_end AP"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="AP" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"M_a P_end CDP"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="CDP" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"M_a P_end VNP"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="VNP" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"M_a P_end ADI"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="ADI" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"M_a P_end ADS"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="ADS" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"M_a P_end ARP"]<-abs(sum(ModifAugmenten[ModifAugmenten$CATIRC01=="ARP" & is.na(ModifAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))

## BAIXES PER CANVI DE RECURS ##

BAM[avuiC,"B_recurs 22"]<-nrow(VarienRECURS[VarienRECURS$CARTE01=="22" & VarienRECURS$CARTE02=="24",])
BAM[avuiC,"B_recurs 24"]<-nrow(VarienRECURS[VarienRECURS$CARTE01=="24" & VarienRECURS$CARTE02=="22",])

## Baixa recurs a la baixa ##
BAM[avuiC,"B_recurs_b 22"]<-nrow(RecursRedueixen[RecursRedueixen$CARTE01=="22" & RecursRedueixen$CARTE02=="24",])
BAM[avuiC,"B_recurs_b 24"]<-nrow(RecursRedueixen[RecursRedueixen$CARTE01=="24" & RecursRedueixen$CARTE02=="22",])

#Mitjana temps 
BAM[avuiC,"R_b mitj_t 22"]<-ifelse(BAM[avuiC,"B_recurs_b 22"]==0, "NA", round(mean(RecursRedueixen[RecursRedueixen$CARTE01=="22" & RecursRedueixen$CARTE02=="24" & is.na(RecursRedueixen$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"R_b mitj_t 24"]<-ifelse(BAM[avuiC,"B_recurs_b 24"]==0, "NA", round(mean(RecursRedueixen[RecursRedueixen$CARTE01=="24" & RecursRedueixen$CARTE02=="22" & is.na(RecursRedueixen$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut
BAM[avuiC,"R_b mitj_p 22"]<-ifelse(BAM[avuiC,"B_recurs_b 22"]==0, "NA",  round(mean(RecursRedueixen[RecursRedueixen$CARTE01=="22" & RecursRedueixen$CARTE02=="24" & is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))
BAM[avuiC,"R_b mitj_p 24"]<-ifelse(BAM[avuiC,"B_recurs_b 24"]==0, "NA",  round(mean(RecursRedueixen[RecursRedueixen$CARTE01=="24" & RecursRedueixen$CARTE02=="22" & is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2))

#Total money indegut
BAM[avuiC,"R_b P_ind 22"]<-sum(RecursRedueixen[RecursRedueixen$CARTE01=="22" & RecursRedueixen$CARTE02=="24" & is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])
BAM[avuiC,"R_b P_ind 24"]<-sum(RecursRedueixen[RecursRedueixen$CARTE01=="24" & RecursRedueixen$CARTE02=="22" & is.na(RecursRedueixen$cobrament_inde)==FALSE,"cobrament_inde"])


## Baixa recurs a l'alça ##
BAM[avuiC,"B_recurs_a 22"]<-nrow(RecursAugmenten[RecursAugmenten$CARTE01=="22" & RecursAugmenten$CARTE02=="24",])
BAM[avuiC,"B_recurs_a 24"]<-nrow(RecursAugmenten[RecursAugmenten$CARTE01=="24" & RecursAugmenten$CARTE02=="22",])

#Mitjana temps 
BAM[avuiC,"R_a mitj_t 22"]<-ifelse(BAM[avuiC,"B_recurs_a 22"]==0, "NA", round(mean(RecursAugmenten[RecursAugmenten$CARTE01=="22" & RecursAugmenten$CARTE02=="24" & is.na(RecursAugmenten$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))
BAM[avuiC,"R_a mitj_t 24"]<-ifelse(BAM[avuiC,"B_recurs_a 24"]==0, "NA", round(mean(RecursAugmenten[RecursAugmenten$CARTE01=="24" & RecursAugmenten$CARTE02=="22" & is.na(RecursAugmenten$temps_Indegut)==FALSE,"temps_Indegut"]), digits = 0))

#Mitjana money del temps indegut
BAM[avuiC,"R_a mitj_p 22"]<-ifelse(BAM[avuiC,"B_recurs_a 22"]==0, "NA",  abs(round(mean(RecursAugmenten[RecursAugmenten$CARTE01=="22" & RecursAugmenten$CARTE02=="24" & is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))
BAM[avuiC,"R_a mitj_p 24"]<-ifelse(BAM[avuiC,"B_recurs_a 24"]==0, "NA",  abs(round(mean(RecursAugmenten[RecursAugmenten$CARTE01=="24" & RecursAugmenten$CARTE02=="22" & is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]), digits = 2)))

#Total money indegut
BAM[avuiC,"R_a P_end 22"]<-abs(sum(RecursAugmenten[RecursAugmenten$CARTE01=="22" & RecursAugmenten$CARTE02=="24" & is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))
BAM[avuiC,"R_a P_end 24"]<-abs(sum(RecursAugmenten[RecursAugmenten$CARTE01=="24" & RecursAugmenten$CARTE02=="22" & is.na(RecursAugmenten$cobrament_inde)==FALSE,"cobrament_inde"]))

# Usuaris per a cada tipus de prestació: NOMÉS CONSIDEREM ELS QUE REBEN UNA ORDINÀRIA
BAM[avuiC,"Usuaris AP"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="AP","BENDNI"]))
BAM[avuiC,"Usuaris VNP"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="VNP","BENDNI"]))
BAM[avuiC,"Usuaris ADI"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="ADI","BENDNI"]))
BAM[avuiC,"Usuaris ADS"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="ADS","BENDNI"]))
BAM[avuiC,"Usuaris CDP"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="CDP","BENDNI"]))
BAM[avuiC,"Usuaris ARP"]<-length(unique(ordinaries02[ordinaries02$CATIRC=="ARP","BENDNI"]))

###################
##TANCA LAPAD III## 
###################

## Agafem LAPAD III del mes en què estem: Resum,TOTALP BAM 
anyactual_T<-TotalP[format(as.yearmon(avui), "%Y")==format(as.Date(TotalP[,"Any"]),"%Y"),]
anyactual_R<-Resum[format(as.yearmon(avui), "%Y")==format(as.Date(Resum[,"Any"]),"%Y"),]
anyactual_B<-BAM[format(as.yearmon(avui), "%Y")==format(as.Date(BAM[,"Any"]),"%Y"),]

anyactual_T$Any<-format(anyactual_T$Any,"%m")
anyactual_R$Any<-format(anyactual_R$Any,"%m")
anyactual_B$Any<-format(anyactual_B$Any,"%m")

anyactual_T<-anyactual_T[order(anyactual_T$Any),]
anyactual_R<-anyactual_R[order(anyactual_R$Any),]
anyactual_B<-anyactual_B[order(anyactual_B$Any),]

anyactual_T["Total",c(1,3,4,5,6,8,9,10,11,12,14, 15, 16)]<-apply(anyactual_T[,c(1,3,4,5,6,8,9,10,11,12,14, 15, 16)],2,sum)
anyactual_T["Total",c(2,7,13)]<-apply(anyactual_T[,c(2,7,13)], 2, mean, na.rm = TRUE, digits = 2)
anyactual_T["Total", c(2,7,13)]<-round(anyactual_T["Total", c(2,7,13)], digits = 2)

anyactual_R$`Usuaris DCR`<-as.numeric(anyactual_R$`Usuaris DCR`)
anyactual_R["Total",c(3,5,7,8,9,10,13,14,17,18,21,22,25,26,29,30,33,34,35)]<-apply(anyactual_R[,c(3,5,7,8,9,10,13,14,17,18,21,22,25,26,29,30,33,34,35)],2, sum, na.rm=TRUE)
anyactual_R["Total",c(2,4,6,11,12,15,16,19,20,23,24,27,28,31,32)]<-apply(anyactual_R[,c(2,4,6,11,12,15,16,19,20,23,24,27,28,31,32)],2, mean, na.rm=TRUE)

for(i in 2:ncol(anyactual_B)){
  if(!is.numeric(anyactual_B[,i])){
    anyactual_B[,i]<-as.numeric(anyactual_B[,i])
  }
}
anyactual_B["Total",c(8:31,44:55,68:85,98:109,122:131,136:139,144:151)]<-apply(anyactual_B[,c(8:31,44:55,68:85,98:109,122:131,136:139,144:151)],2, sum, na.rm=TRUE, na.action=NULL)
anyactual_B["Total",c(2:7,32:43,56:67,86:97,110:121,132:135,140:143)]<-apply(anyactual_B[,c(2:7,32:43,56:67,86:97,110:121,132:135,140:143)],2, mean, na.rm=TRUE, na.action=NULL)

## Completem els espais buits amb 0! 
## Dades prestacions:
anyactual_T$Any<-as.factor(anyactual_T$Any)
levels(anyactual_T$Any)<-c(mes,"Total")
anyactual_T["Total","Any"]<-"Total"
row.names(anyactual_T)<-anyactual_T$Any

anyactual_R$Any<-as.factor(anyactual_R$Any)
levels(anyactual_R$Any)<-c(mes,"Total")
anyactual_R["Total","Any"]<-"Total"
row.names(anyactual_R)<-anyactual_R$Any

anyactual_B$Any<-as.factor(anyactual_B$Any)
levels(anyactual_B$Any)<-c(mes,"Total")
anyactual_B["Total","Any"]<-"Total"
row.names(anyactual_B)<-anyactual_B$Any

i<-1
while(i<=13){
  if(is.na(anyactual_T[i,1])){
    anyactual_T[mes[i-1],]<-rep(0,ncol(TotalP))
    anyactual_R[mes[i-1],]<-rep(0,ncol(Resum))
    anyactual_B[mes[i-1],]<-rep(0,ncol(BAM))
  } 
  i<-i+1
}
anyactual_T<-anyactual_T[c(mes,"Total"),]
anyactual_R<-anyactual_R[c(mes,"Total"),]
anyactual_B<-anyactual_B[c(mes,"Total"),]

anyactual_T$Any<-NULL
anyactual_R$Any<-NULL
anyactual_B$Any<-NULL

rm(i)

##################################
##Crear la taula total dels anys## 
##################################
GTotalP<-TotalP
GTotalP$Any2<-format(as.Date(GTotalP$Any),"%Y")
GTotalP$Any<-NULL
GTotalP2<-aggregate(.~Any2,GTotalP,sum, na.rm=TRUE,na.action=NULL)

mitjanesAnys<-aggregate(cbind(`AP prestacions`,`VNP prestacions`,`PVS prestacions`)~Any2, GTotalP, mean, na.rm=TRUE)
GTotalP2$`AP prestacions`<-mitjanesAnys$`AP prestacions`
GTotalP2$`VNP prestacions`<-mitjanesAnys$`VNP prestacions`
GTotalP2$`PVS prestacions`<-mitjanesAnys$`PVS prestacions`
rm(mitjanesAnys)
rownames(GTotalP2)<-GTotalP2$Any2
GTotalP2$Any2<-NULL

GResum<-Resum
GResum$Any2<-format(as.Date(GResum$Any),"%Y")
GResum$Any<-NULL
GResum$Prestacions<-NULL
GResum$`Usuaris DCR`<-suppressWarnings(as.numeric(GResum$`Usuaris DCR`))

GResumMEAN<- aggregate(x = GResum[c(2,4,9,10,13,14,17,18,21,22,25,26,29,30)],  by = GResum["Any2"],  FUN = mean, na.rm=TRUE,na.action=NULL)
GResumSUM<- aggregate(x = GResum[c(1,3,5:8,11,12,15,16,19,20,23,24,27,28,31,32,33)],  by = GResum["Any2"],  FUN = sum, na.rm=TRUE,na.action=NULL)
GResumSUM$Any2<-NULL
GResum2<-cbind(GResumSUM,GResumMEAN)
GResum2<-GResum2[,colnames(GResum)]
rownames(GResum2)<-GResum2$Any2
GResum2$Any2<-NULL


GBAM<-BAM
GBAM$Any2<-format(as.Date(GBAM$Any),"%Y")
GBAM$Any<-NULL
for(i in 2:ncol(GBAM)){
  if(!is.numeric(GBAM[,i])){
    GBAM[,i]<-suppressWarnings(as.numeric(GBAM[,i]))
  }
}

GBAMMEAN<- aggregate(x = GBAM[c(1:6,31:42,55:66,85:96,109:120,131:134,139:142)],  by = GBAM["Any2"],  FUN = mean, na.rm=TRUE,na.action=NULL)
GBAMSUM<- aggregate(x = GBAM[c(7:30,43:54,67:84,97:108,121:130,135:138,143:150)],  by = GBAM["Any2"],  FUN = sum, na.rm=TRUE,na.action=NULL)
GBAM2<-cbind(GBAMSUM,GBAMMEAN)
GBAM2<-GBAM2[,names(GBAM)]
rownames(GBAM2)<-GBAM2$Any2
GBAM2$Any2<-NULL


#############################################################
##########                                 ##################
##########     PAS 5: GUARDEM DADES        ##################
##########                                 ##################
#############################################################


## Guardar dades per prestació:
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Procediment")
setwd("C:/xampp/htdocs/GestioDeute/scripts/procediment")

write.csv(historic,"historic.csv")
write.csv(CD,"CD.csv", fileEncoding="utf8")
write.csv(ARP,"ARP.csv", fileEncoding="utf8")
write.csv(ADI,"ADI.csv", fileEncoding="utf8")
write.csv(ADS,"ADS.csv", fileEncoding="utf8")
write.csv(AP,"AP.csv", fileEncoding="utf8")
write.csv(VNP,"VNP.csv", fileEncoding="utf8")
write.csv(PVS,"PVS.csv", fileEncoding="utf8")

#Guardem els Resum, total i BAM a la carpeta any
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/any")
setwd("C:/xampp/htdocs/GestioDeute/scripts/any")
write.csv(anyactual_T,"Total.csv", fileEncoding="utf8")
write.csv(anyactual_R,"Resum.csv", fileEncoding="utf8")
write.csv(anyactual_B,"BAM.csv", fileEncoding="utf8")

write.csv(GTotalP2,"GTotal.csv", fileEncoding="utf8")
write.csv(GResum2,"GResum.csv", fileEncoding="utf8")
write.csv(GBAM2,"GBAM.csv", fileEncoding="utf8")


## Guardar dades per mes:
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Mes")
setwd("C:/xampp/htdocs/GestioDeute/scripts/mes")

write.csv(Gener,"Gener.csv", fileEncoding="utf8")
write.csv(Febrer,"Febrer.csv", fileEncoding="utf8")
write.csv(Mar,"Mar.csv", fileEncoding="utf8")
write.csv(Abril,"Abril.csv", fileEncoding="utf8")
write.csv(Maig,"Maig.csv", fileEncoding="utf8")
write.csv(Juny,"Juny.csv", fileEncoding="utf8")
write.csv(Juliol,"Juliol.csv", fileEncoding="utf8")
write.csv(Agost,"Agost.csv", fileEncoding="utf8")
write.csv(Setembre,"Septembre.csv", fileEncoding="utf8")
write.csv(Octubre,"Octubre.csv", fileEncoding="utf8")
write.csv(Novembre,"Novembre.csv", fileEncoding="utf8")
write.csv(Desembre,"Desembre.csv", fileEncoding="utf8")

## Ordenem les dades per a guardar-les pel mes següent: 
historic<-historic[order(historic$Any),]
historicPVN<-historicPVN[order(historicPVN$Any),]
Resum<-Resum[order(Resum$Any),]
TotalP<-TotalP[order(TotalP$Any),]
BAM<-BAM[order(BAM$Any),]

## Escrivim els noms del que guardarem
nomTOTAL<-paste("TotalP ",format(avui, "%Y"), ".csv",sep="")
nomRESUM<-paste("Resum ",format(avui, "%Y"), ".csv",sep="")
nomBAM<-paste("BAM ",format(avui, "%Y"), ".csv",sep="")

#Guardem els Resum, total i BAM a la carpeta any
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/any")
setwd("C:/xampp/htdocs/GestioDeute/scripts/any")
write.csv(anyactual_T,nomTOTAL, fileEncoding="utf8")
write.csv(anyactual_R,nomRESUM, fileEncoding="utf8")
write.csv(anyactual_B,nomBAM, fileEncoding="utf8")


## Guardem en format imatge els primers expedients per a printar-los al web de les dades que s'han carregat
#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/PNGs")
setwd("C:/xampp/htdocs/GestioDeute/Resources/archivos/")

auxaltes22<-as.data.frame(altes22[1:20,])
suppressMessages(ggsave("aux_altes22.png", tableGrob(auxaltes22), scale =2, dpi=300))

auxaltes24<-as.data.frame(altes24[1:20,])
suppressMessages(ggsave("aux_altes24.png", tableGrob(auxaltes24), scale =2, dpi=300))

auxquadrament<-as.data.frame(quadrament[1:20,1:10])
suppressMessages(ggsave("aux_quadrament.png", tableGrob(auxquadrament), scale =2, dpi=300))

###########################################################################
##############################     ERRORS   ############################### 
###########################################################################

# Fem una taula per cada possible error:
#   1. Procediments que estan a altes (22i24) i no a quadrament --> Ebq
#   2. Expedient tot sencer repetit --> EtotRep
#   3. DNI que estan a baixes i no a quadrament --> EbaixRep
#   4. No hi pot haver ARPs de Grau 1! --> Earp
#   5. Retinguts (a l'espera d'alguna informació o requeriment)
#   6. Noves que tenim nosaltres que  no tenen ells
#   7. Modificatives que  tenim que no apareixen a baixes
#   8. Canvi de recurs que  tenim que no apareixen a baixes
#   9. Dates de naixement a revisar
#  10. Casos que augmenten els endarreriments més d'un 15% entre un mes i el següent
#  11. Casos defunció + pagament indegut elevat
#  12. Nadons <3 anys

#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Errors")
setwd("C:/xampp/htdocs/GestioDeute/scripts/errors")

## 1. PROCEDIMENTS QUE SURTEN A ALTES I NO A QUADRAMENT: Hi ha diversos casos d'usuaris que surten a altes amb més d'un procediment (que hem 
#considerat com a modif. si NOPRDB01 !=0). Tots els usuaris que surten a altes també estan al fitxer de quadrament (en principi), però hi ha 
#procediments que després no surten a quadrament

Ebq<-anti_join(altesTotes, quadrament02, by=c("NOPRDB", "BENDNI")) 
Ebq<-Ebq[,c("NOPRDB","BENDNI","PSNNOM","PSNCOG","CATIRC","CATIRC01")] # CATIRC01 -> precedent?? 
write.csv(Ebq,"Ebq.csv", fileEncoding="utf8")

## 2. EXPEDIENTS SENCERS TOT REPETIT 
## Duplicats DNI ordinàries
EOrdDniRep<-subset(ordinaries02,duplicated(ordinaries02$BENDNI))
if(nrow(EOrdDniRep)!=0){rownames(EOrdDniRep)<-c(1:nrow(EOrdDniRep))}
write.csv(EOrdDniRep,"EOrdDniRep.csv", fileEncoding="utf8")

## 3. DNI que estan a baixes i no a quadrament
historic_baixes$CADTST<-as.Date(as.character(historic_baixes$CADTST), format="%Y%m%d")
Baixes_mes<-historic_baixes[format(historic_baixes$CADTST,"%b %YYYY")==avui,]
EbaixRep<-anti_join(Baixes_mes, Baixes, by="NOPRDB")
EbaixRep<-EbaixRep[,c("NOPRDB","BENDNI","BENNOM","BENCOG","PRESTACIO","CADTST",
                      "MOTEST","DATEFE")]
EbaixRep$DATEFE<-as.Date(as.character(EbaixRep$DATEFE), format="%Y%m%d")
write.csv(EbaixRep,"EbaixRep.csv", fileEncoding="utf8")

## 4. EXPEDIENTS ARP DE GRAU 1 
Earp<- quadrament[(quadrament[,"CATIRC"]=="PRESTACIONS ECONÒMIQUES VINCULADES AL SERVEI (ACOLLIMENT RESIDENCIAL)" | 
                   quadrament[,"CATIRC"]=="ASSISTENT PERSONAL") & (quadrament[,"GN"]=="Grau 1"),] 
Earp<-Earp[,c("CARTE","NOPRDB","BENNOM","BENCOG","BENDNI","IMPORD")] 
if(nrow(Earp)!=0){rownames(Earp)<-c(1:nrow(Earp))}
write.csv(Earp,"Earp.csv", fileEncoding="utf8")

# 5. PAGAMENTS RETINGUTS 
names(retinguts)<-c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORT", "NOPSAP", "END")
retinguts$ALTCAR<-as.Date(as.character(retinguts$ALTCAR), format="%Y%m%d")
if(nrow(retinguts)!=0){rownames(retinguts)<-c(1:nrow(retinguts))}
write.csv(retinguts,"Eret.csv", fileEncoding="utf8")

## 6. Noves que tenim nosaltres que no tenen ells
E_noves<-E_noves[,c("BENDNI", "CARTE", "NOPRDB",   "CATIRC",   "ALTCAR.y", "GN", "IMPORD","NOPSAP", "END.y")]
names(E_noves)<-c("BENDNI", "CARTE", "NOPRDB",   "CATIRC",   "ALTCAR", "GN", "IMPORT","NOPSAP", "END02")
E_noves$ALTCAR<-as.Date(as.character(E_noves$ALTCAR), format="%Y%m%d")
write.csv(E_noves,"E_noves.csv", fileEncoding="utf8")

## 7. Modificatives que tenim que no apareixen a baixes
if(nrow(EmodNb)!=0){rownames(EmodNb)<-c(1:nrow(EmodNb))}
write.csv(EmodNb,"EmodNb.csv", fileEncoding="utf8")

## 8. Canvis de recurs que no apareixen a baixes
ErecNb<-ErecNb[,c(1:17)]
if(nrow(ErecNb)!=0){rownames(ErecNb)<-c(1:nrow(ErecNb))} 
ErecNb2<-ErecNb[,c("CARTE_antiga", "NOPRDB_antic", "BENDNI","PREST_antiga","GN_antic","IMPORT_antic", 
                   "CARTE_nova","NOPRDB_nou","PREST_nova","GN_nou","IMPORT_nou")]
write.csv(ErecNb2,"ErecNb.csv", fileEncoding="utf8")

## 9. Dates de naixement a revisar 
if("PSNDNAI" %in% colnames(quadrament)){
  quadrament$PSNDNAI<-as.Date(as.character(quadrament$PSNDNAI), format="%Y%m%d") ### 
  avuiData<-as.Date(avui, format="%Y%m%d")
  quadrament[,"edat"]<-trunc(as.numeric(avuiData-quadrament[,"PSNDNAI"])/365.25, 0)
  Enaix<-quadrament[quadrament[,"edat"]>=110 | quadrament[,"edat"]<=0,]
  Enaix<-Enaix[,c("NOPRDB", "BENNOM", "BENCOG", "BENDNI", "PSNDNAI", "CATIRC", "edat")]
  Enaix<-Enaix[is.na(Enaix[,"BENDNI"])==FALSE,]
  if(nrow(Enaix)!=0){rownames(Enaix)<-c(1:nrow(Enaix))}
  write.csv(Enaix,"Enaix.csv", fileEncoding="utf8")
}

#  10. Casos que augmenten els endarreriments més d'un 15% entre un mes i el següent

end02<-quadrament[quadrament$IMPORD==0,c("NOPRDB", "BENDNI", "CATIRC", "END")]
levels(end02$CATIRC)<-prestcurt

end01<-quadrantic[quadrantic$IMPORD==0,c("NOPRDB", "BENDNI", "CATIRC", "END")] # data de naixement - no la necessitem
levels(end01$CATIRC)<-prestcurt

ends01<-sum(end01[,"END"], na.rm = TRUE)
ends02<-sum(end02[,"END"], na.rm = TRUE)

persones01<-length(unique(end01$BENDNI))
persones02<-length(unique(end02$BENDNI))

mitjEnd01<-sum(end01[,"END"], na.rm = TRUE)/length(unique(end01$BENDNI))
mitjEnd02<-sum(end02[,"END"], na.rm = TRUE)/length(unique(end02$BENDNI))

augmentEnd= round(100*(abs(mitjEnd01-mitjEnd02))/mitjEnd01, digits = 2)
Eend<-data.frame()

if(mitjEnd01<mitjEnd02){variacio<-"Augment"}else if(mitjEnd01>mitjEnd02){variacio<-"Reducció"}else{variacio<-"Invariància"}
if(augmentEnd>=15){
  Eend[1,1]<-paste(variacio, "dels endarreriments:", sep = " ")
  Eend[1,2]<-paste(augmentEnd, "%", sep=" ")
} else {
  Eend[1,1]<-paste(variacio, "dels endarreriments inferior al 15%", sep = " ")
}
colnames(Eend)[1]<-"Observació"
rownames(Eend)<-" "
write.csv(Eend,"Eend.csv", fileEncoding="utf8")

# 11. Casos defunció + pagament indegut elevat (es triga més de 3 mesos en efectuar la baixa)
Edef<-Baixes_def[Baixes_def$temps_Indegut>=90,]
if(nrow(Edef)!=0){rownames(Edef)<-c(1:nrow(Edef))}
Edef2<-Edef[,c("CARTE.x", "NOPRDB", "BENDNI", "PRESTACIO", "GN", "IMPORD.x", "END","BENNOM","BENCOG", 
               "DATEFE", "DATFI", "CADTST", "temps_Indegut", "cobrament_inde")]
write.csv(Edef2,"Edef.csv", fileEncoding="utf8")

# 12. Menors de 3 anys
if("PSNDNAI" %in% colnames(quadrament)){
  bebitos<-quadrament[quadrament[,"edat"]<3 & quadrament[,"edat"]>=0, ]
  bebitos<-bebitos[,c("NOPRDB", "BENNOM", "BENCOG", "BENDNI", "PSNDNAI", "CATIRC", "edat")]
  bebitos<-bebitos[is.na(bebitos[,"BENDNI"])==FALSE,]
  if(nrow(bebitos)!=0){rownames(bebitos)<-c(1:nrow(bebitos))}
  write.csv(bebitos,"Nadons.csv", fileEncoding="utf8")
}else{
  bebitos<-data.frame()
  write.csv(bebitos,"Nadons.csv", fileEncoding="utf8")
}

rm(ends01, ends02, persones01, persones02, mitjEnd01, mitjEnd02, augmentEnd)
rm(Ebq, EOrdDniRep, EbaixRep, Earp, retinguts, E_noves, EmodNb, ErecNb, ErecNb2, Eend, Edef, Edef2)

############################################################################################################
################################         GRÀFICS !!!            ############################################
############################################################################################################

#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Gràfics")
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/estatics")


############# Farem els següents gràfics:   ################################################################
#                                                                                                          #
# A. GRÀFICS ESTÀTICS                                                                                      #
#p     A1. # NRE USUARIS 
#                  A1.1. PER CARTERA 22/24  ------------------- A1p_u_cartera.csv                          #
#p     A2. # IMPORT TOTAL+MITJÀ PER RECURS  ---------- A2p_import_per_recurs.csv                           #
#      A3. # IMPORT TOTAL PER RECURS I PER SEXE (H/D)                                                      #
#p                                  USUARIS H/D PER RECURS ------  A3.0p_prest_sexe_ord.csv                #
#p                                  USUARIS H/D TOTALS ---------- A3.1p_homesdones_ord.csv                 # 
#b                                  IMPORT MIG ORDINÀRIES ---------- A3.2b_import_sexe_ORDIN.csv           #
#                                   IMPORT MIG TOTAL ------------ A.3.3b_import_mig.csv                    #
#s     A4. # PRESSUPOST PER EDAT I PENSIÓ 
#                       ORDINÀRIES--------------------- A4.1s_Import_edat_pensio.csv                       #
#s                      ENDARRERIMENTS  ---------------------------- A4.2s_End_edat_pensio.csv             #
#s                      INDEGUTS ----------------------------  A4.3s_Indeguts.csv                          #
#P     A5. # USUARIS PER MUNICIPI                                                                          # 
#                       COMARCA --------------------------------- A5.1p_usuaris_comarca.csv                #
#                       PROVÍNCIA ------------------------------- A5.2p_usuaris_provincia.csv              # 
#                       MUNICIPI  ------------------------------- quadre                                   #
#b     A6. # IMPORT PER FRANGES D'EDAT -------------------------- A6b_import_edats.csv                     #
#b     A7. # TEMPS DE RETARD SEGONS LA BAIXA/ MODIF ------------------- A7b_temps_retard.csv               #
#b     A8. # USUARIS PER GRAU I PER PRESTACIÓ ------------------------- A8b_usuaris_grau_prestacio.csv     #
#b     A9. # USUARIS PER SEXE I PER PRESTACIÓ ------------------------- A9_usuaris_prest_sexe.csv          #
#b     A10.# ALTES PER RECURS ----------------------------------------- A10b_altes_recurs.csv              #
#
# B. GRÀFICS GLOBALS     (lines)                                                                           #
#     B1. # PRESSUPOST TOTAL AL LLARG DELS ANYS
#                         PER PRESTACIONS  -------------- B1.1_Import_anys_prest.csv                       #
#                         TOTAL ------------------------- B1.2_Import_anys_tot.csv                         #
#     B2. # PRESSUPOST 22/24----------------------------- B2_Pressupost22_24.csv                           #
#     B3. # USUARIS NOVES I BAIXES ---------------------- B3_altesbaixes.csv                               #
#     B4. # USUARIS MODIFICATIVES I CANVIS DE RECURS ---- B4_modif_recurs.csv                              #
#     B5. # TEMPS MIG DE RETARD ------------------------- B5_temps_mig_retard.csv                          #
#     B6. # PAGAMENTS INDEGUTS -------------------------- B6_pagaments_ind.csv                             #
#     B7. # ENDARRERIMENTS PER PRESTACIÓ  ------------- B7_endarreriments.csv                              #
#     B8. # GRAUS    ---------------------------------- B8_usuaris_graus.csv                               #
#     B9. # ALTES PER RECURS------------------------------- B9_altes_recurs.csv                            #
#
# C. GRÀFICS ANUALS      (lines)                                                                           #
#     C1. # PRESSUPOST TOTAL AL LLARG DELS ANYS
#                         PER PRESTACIONS  -------------- C1.1_Import_anys_prest.csv                       #
#                         TOTAL ------------------------- C1.2_Import_anys_tot.csv                         #
#     C2. # PRESSUPOST 22/24----------------------------- C2_Pressupost22_24.csv                           #
#     C3. # USUARIS NOVES I BAIXES ---------------------- C3_altesbaixes.csv                               #
#     C4. # USUARIS MODIFICATIVES I CANVIS DE RECURS ---- C4_modif_recurs.csv                              #
#     C5. # TEMPS MIG DE RETARD ------------------------- C5_temps_mig_retard.csv                          #
#     C6. # PAGAMENTS INDEGUTS -------------------------- C6_pagaments_ind.csv                             # 
#     C7. # ENDARRERIMENTS ------------------------------ C7_endarreriments.csv                            #
#     C8. # GRAUS  -------------------------------------- C8_usuaris_graus.csv                             #
#     C9. # ALTES PER RECURS------------------------------- C9_altes_recurs.csv                            #
############################################################################################################




############################################################################################################
##############################     (A) GRÀFICS ESTÀTICS         ############################################ 
############################################################################################################

# A1. # NRE USUARIS PER CARTERA 22/24 ####################################################################
u_cart<-data.frame()
u_cart[1,1]<-length(unique(ordinaries02[ordinaries02$CARTE=="22","BENDNI"]))
u_cart[2,1]<-length(unique(ordinaries02[ordinaries02$CARTE=="24","BENDNI"]))
u_cart[1,2]<-round(100*u_cart[1,1]/(u_cart[1,1]+u_cart[2,1]), digits = 2)
u_cart[2,2]<-round(100*u_cart[2,1]/(u_cart[1,1]+u_cart[2,1]), digits = 2)
rownames(u_cart)<-c("22", "24")
colnames(u_cart)<-c("usuaris", "percentatge")
write.csv(u_cart,"A1p_u_cartera.csv",fileEncoding = "UTF-8") # pie


# A2. # IMPORT PER RECURS ##############################################################################

import_recurs<-as.data.frame(levels(ordinaries02$CATIRC))

#Import total per prestació
import_recurs[import_recurs[,1]=="AP",2]<-AP[mes_actual,"TOTAL Import"]
import_recurs[import_recurs[,1]=="VNP",2]<-VNP[mes_actual,"TOTAL Import"]
import_recurs[import_recurs[,1]=="ARP",2]<-ARP[mes_actual,"TOTAL Import"]
import_recurs[import_recurs[,1]=="CDP",2]<-CD[mes_actual,"TOTAL Import"]
import_recurs[import_recurs[,1]=="ADI",2]<-ADI[mes_actual,"TOTAL Import"]
import_recurs[import_recurs[,1]=="ADS",2]<-ADS[mes_actual,"TOTAL Import"]

# Import mig per prestació
import_recurs[import_recurs[,1]=="AP",3]<-AP[mes_actual,"TOTAL Import"]/AP[mes_actual,"Total grau"]
import_recurs[import_recurs[,1]=="VNP",3]<-VNP[mes_actual,"TOTAL Import"]/VNP[mes_actual,"Total grau"]
import_recurs[import_recurs[,1]=="ARP",3]<-ARP[mes_actual,"TOTAL Import"]/ARP[mes_actual,"Total grau"]
import_recurs[import_recurs[,1]=="CDP",3]<-CD[mes_actual,"TOTAL Import"]/CD[mes_actual,"Total grau"]
import_recurs[import_recurs[,1]=="ADI",3]<-ADI[mes_actual,"TOTAL Import"]/ADI[mes_actual,"Total grau"]
import_recurs[import_recurs[,1]=="ADS",3]<-ADS[mes_actual,"TOTAL Import"]/ADS[mes_actual,"Total grau"]

names(import_recurs)<-c("Prestació", "Import_total", "Import_mig")

# Percentatge (import de cada prestació respecte el total)
import_recurs[import_recurs[,1]=="AP",4]<-100*AP[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)
import_recurs[import_recurs[,1]=="VNP",4]<-100*VNP[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)
import_recurs[import_recurs[,1]=="ARP",4]<-100*ARP[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)
import_recurs[import_recurs[,1]=="CDP",4]<-100*CD[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)
import_recurs[import_recurs[,1]=="ADI",4]<-100*ADI[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)
import_recurs[import_recurs[,1]=="ADS",4]<-100*ADS[mes_actual,"TOTAL Import"]/sum(import_recurs$Import_total)

import_recurs[,c(2:4)]<-round(import_recurs[,c(2:4)],2)
rownames(import_recurs)<-import_recurs[,1]
import_recurs[,1]<-NULL
names(import_recurs)[3]<-"percentatge"
write.csv(import_recurs,"A2p_import_per_recurs.csv",fileEncoding = "UTF-8") 

# A3. # IMPORT TOTAL(ORDINÀRIES) PER PRESTACIÓ I PER SEXE (H/D) #################################################

# A3.1. # Quants homes i quantes dones reben cada tipus de prestació

if("PSNSEX" %in% colnames(quadrament)){
  prest_sexe<-as.data.frame(levels(ordinaries02$CATIRC))
  quadr<-quadrament[,c("CARTE", "NOPRDB", "BENDNI", "PSNSEX", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")]
  ords<-quadr[quadr$IMPORD!=0,]
  levels(ords$CATIRC)<-prestcurt
  n=length(unique(ords$PSNSEX))
  for(i in 1:nrow(prest_sexe)){ # Columna 2: núm dones
    prest_sexe[i,2]<-as.numeric(nrow(ords[ords$PSNSEX=="D" & ords$CATIRC==(prest_sexe[i,1]),]))
  }
  for(i in 1:nrow(prest_sexe)){ # Columna 3: núm homes
    prest_sexe[i,3]<-as.numeric(nrow(ords[ords$PSNSEX=="H" & ords$CATIRC==(prest_sexe[i,1]),]))
  }
  if(n==2){
    rownames(prest_sexe)<-prest_sexe[,1]
    prest_sexe[,1]<-NULL
    names(prest_sexe)<-c("prestacions_Dones", "prestacions_Homes")
    prest_sexe["TOTAL", 1]<-sum(prest_sexe[1:6,1])
    prest_sexe["TOTAL", 2]<-sum(prest_sexe[1:6,2])
    write.csv(prest_sexe,"A3.0p_prest_sexe_ord.csv",fileEncoding = "UTF-8")
    
    homesdones<-as.data.frame(c(prest_sexe["TOTAL", "prestacions_Dones"],prest_sexe["TOTAL", "prestacions_Homes"]) )
    homesdones[,"percentatge"]<-round(100*homesdones[,1]/sum(homesdones[,1]), digits = 2)
    names(homesdones)<-c("Prestacions", "percentatge")
    rownames(homesdones)<-c("Dones", "Homes")
  }else{ # NOU
    for(i in 1:nrow(prest_sexe)){ # Columna 4: núm altres
      prest_sexe[i,4]<-as.numeric(nrow(ords[ords$PSNSEX!="H" & ords$PSNSEX!="D" & ords$CATIRC==(prest_sexe[i,1]),]))
    }
    rownames(prest_sexe)<-prest_sexe[,1]
    prest_sexe[,1]<-NULL
    names(prest_sexe)<-c("prestacions_Dones", "prestacions_Homes", "prestacions_altres")
    prest_sexe["TOTAL", 1]<-sum(prest_sexe[1:6,1])
    prest_sexe["TOTAL", 2]<-sum(prest_sexe[1:6,2])
    prest_sexe["TOTAL", 3]<-sum(prest_sexe[1:6,3])
    write.csv(prest_sexe,"A3.0p_prest_sexe_ord.csv",fileEncoding = "UTF-8")
    
    homesdones<-as.data.frame(c(prest_sexe["TOTAL", "prestacions_Dones"],prest_sexe["TOTAL", "prestacions_Homes"], 
                                prest_sexe["TOTAL", "prestacions_altres"]))
    homesdones[,"percentatge"]<-round(100*homesdones[,1]/sum(homesdones[,1]), digits = 5)
    names(homesdones)<-c("Prestacions", "percentatge")
    rownames(homesdones)<-c("Dones", "Homes", "Altres")
  }
  write.csv(homesdones,"A3.1p_homesdones_ord.csv",fileEncoding = "UTF-8")
}else{
  homesdones<-data.frame()
  write.csv(homesdones,"A3.1p_homesdones_ord.csv", fileEncoding = "UTF-8") 
}

# A3.2. # Pressupost mig per sexe  
if("PSNSEX" %in% names(quadrament)){
  import_s_mig<-as.data.frame(aggregate(IMPORD ~ PSNSEX+CATIRC, quadrament, mean))
  HDmig<-split(import_s_mig, import_s_mig$PSNSEX)
  Dmig<-HDmig$D
  Hmig<-HDmig$H
  
  import_sexe<-cbind(Dmig[,-1], Hmig$IMPORD)
  names(import_sexe)<-c("CATIRC", "Dones", "Homes")
  import_sexe[,c(2:3)]<-round(import_sexe[,c(2:3)],2)
  
  levels(import_sexe$CATIRC)<-prestcurt
  rownames(import_sexe)<-import_sexe[,1]
  import_sexe[,1]<-NULL
  write.csv(import_sexe,"A3.2b_import_sexe_ORDIN.csv", fileEncoding = "UTF-8") 
  
  rm(ADI, ADS, ARP, AP, CD, VNP, PVS, import_s_mig, HDmig, Dmig, Hmig) 
}else{
  import_sexe<-data.frame()
  write.csv(import_sexe,"A3.2b_import_sexe_ORDIN.csv", fileEncoding = "UTF-8") 
} 

# A3.3 # Import mig tots (ordinàries)

import_mig<-as.data.frame(aggregate(IMPORD ~ CATIRC, ordinaries02, mean))  # ordinàries
names(import_mig)<-c("CATIRC", "IMPORT ORD.")
levels(import_mig$CATIRC)<-prestcurt
rownames(import_mig)<-import_mig[,1]
import_mig[,1]<-NULL
import_mig[,"IMPORT ORD."]<-apply(import_mig, 2, round, digits = 2)
write.csv(import_mig, "A.3.3b_import_mig.csv", fileEncoding = "UTF-8")


# A4. # PRESSUPOST PER EDAT I PENSIÓ  ########################################################################

# Ordinàries #

if("PSNDNAI" %in% colnames(quadrament)){ 
  import_edats<-quadrament[,c("PSNDNAI", "IMPORD", "EXPTI", "EXPANY", "EXPNUM" ,"CATIRC")] 
  import_edats<-import_edats[is.na(import_edats$PSNDNAI)==FALSE & import_edats$IMPORD!=0,]
  import_edats[,"EXP"]<-paste(import_edats$EXPTI,"/",import_edats$EXPANY,"/", import_edats$EXPNUM )
  levels(import_edats$CATIRC)<-prestcurt
  import_edats<-import_edats[,c("PSNDNAI", "IMPORD", "EXP","CATIRC")] 
  # CANVIEM EL CONTINGUT DE LES TAULES DE PRESTACIÓ #
  a<-split(import_edats, import_edats$CATIRC) # separem import_edats per prestació
  for(i in 1:length(a)){
    b<-as.data.frame(a[[i]])
    b<-b[order(b$PSNDNAI),]   # Ordenem per any
    rownames(b)<-c(1:nrow(b)) # Noms de les files
    assign(names(a[i]), b)
  }
  I_edat_pensio<-cbind.fill(ADI, ADS, AP, ARP, CDP, VNP, fill=NA)
  write.csv(I_edat_pensio,"A4.1s_Import_edat_pensio.csv", fileEncoding = "UTF-8") 
  rm(ADI, ADS, AP, ARP, CDP, VNP)
}else{
  I_edat_pensio<-data.frame()
  write.csv(I_edat_pensio,"A4.1s_Import_edat_pensio.csv", fileEncoding = "UTF-8") 
}

# Endarreriments #

if("PSNDNAI" %in% colnames(quadrament)){ 
  end_edats<-quadrament[,c("PSNDNAI", "IMPORD", "END", "EXPTI", "EXPANY", "EXPNUM", "CATIRC")] 
  end_edats<-end_edats[is.na(end_edats$PSNDNAI)==FALSE & end_edats$IMPORD==0,]
  end_edats[,"EXP"]<-paste(end_edats$EXPTI,"/",end_edats$EXPANY,"/", end_edats$EXPNUM )
  end_edats<-end_edats[,c("PSNDNAI", "END", "EXP","CATIRC")] 
  levels(end_edats$CATIRC)<-prestcurt
  
  a<-split(end_edats, end_edats$CATIRC) # separem end_edats per prestació
  for(i in 1:length(a)){
    b<-as.data.frame(a[[i]])
    b<-b[order(b$PSNDNAI),]   # Ordenem per any
    if(nrow(b)!=0){rownames(b)<-c(1:nrow(b))} # Noms de les files
    assign(names(a[i]), b)
  }
  End_edat_pensio<-cbind.fill(ADI, ADS, AP, ARP, CDP, VNP, fill=NA)
  write.csv(End_edat_pensio,"A4.2s_End_edat_pensio.csv", fileEncoding = "UTF-8")
  rm(ADI, ADS, AP, ARP, CDP, VNP)
}else{
  End_edat_pensio<-data.frame()
  write.csv(End_edat_pensio,"A4.2s_End_edat_pensio.csv", fileEncoding = "UTF-8") 
}

# Indeguts #

if("PSNDNAI" %in% colnames(quadrantic) ){
  indegutsinfo<-Baixes_info[,c("EXPTI", "EXPANY", "EXPNUM", "CATIRC", "cobrament_inde")]
  indeguts0<-quadrantic[,c("EXPTI", "EXPANY", "EXPNUM", "CATIRC", "PSNDNAI")] 
  levels(indeguts0$CATIRC)<-prestcurt
  indeguts<-left_join(indegutsinfo, indeguts0, by=c("EXPTI", "EXPANY", "EXPNUM", "CATIRC"))
  indeguts[,"EXP"]<-paste(indeguts$EXPTI,"/",indeguts$EXPANY,"/", indeguts$EXPNUM )
  indeguts<-indeguts[,c("PSNDNAI", "cobrament_inde", "EXP","CATIRC")]  ####### revisar executant febrer
  
  a<-split(indeguts, indeguts$CATIRC) # separem end_edats per prestació
  for(i in 1:length(a)){
    b<-as.data.frame(a[[i]])
    b<-b[order(b$PSNDNAI),]   # Ordenem per any
    if(nrow(b)!=0){rownames(b)<-c(1:nrow(b))} # Noms de les files
    assign(names(a[i]), b)
  }

  if(length(a)==6){
    Indeguts<-cbind.fill(ADI, ADS, AP, ARP, CDP, VNP, fill=NA)
  } else if(length(a)==5) {
    Indeguts<-cbind.fill(a[[1]], a[[2]],a[[3]], a[[4]],a[[5]], fill=NA)
  } else if(length(a)==4) {
    Indeguts<-cbind.fill(a[[1]], a[[2]],a[[3]], a[[4]], fill=NA)
  } else if(length(a)==3) {
    Indeguts<-cbind.fill(a[[1]], a[[2]],a[[3]], fill=NA)
  } else if(length(a)==2) {
    Indeguts<-cbind.fill(a[[1]], a[[2]], fill=NA)
  } else if(length(a)==1) {
    Indeguts<-a[[1]]
  } else {Indeguts<-data.frame()}
  
  write.csv(Indeguts,"A4.3s_Indeguts.csv", fileEncoding = "UTF-8") 
}else{
  Indeguts<-data.frame()
  write.csv(Indeguts,"A4.3s_Indeguts.csv", fileEncoding = "UTF-8") 
}

# A5. # USUARIS PER MUNICIPI   ###############################################################################

# ===== Primera opció: tenim info de municipis 
if("MUNNOM" %in% colnames(quadrament)){
  municipis<-as.data.frame(quadrament[,c("MUNNOM", "IMPORD", "NOPRDB", "CATIRC")])
  levels(municipis$CATIRC)<-prestcurt
  municipis[is.na(municipis$MUNNOM)==TRUE, "MUNNOM"]<-"NA" # Em sortia un error pel fet que hi ha NA's a municipis! :P
  
  #========== NOMS MUNICIPIS ================================================
  municipis[grep("ALAMÚS", municipis$MUNNOM),"MUNNOM"]<-"ALAMÚS"
  municipis[grep("VANDELLÒS I L'HOSPITALET", municipis$MUNNOM),"MUNNOM"]<-"VANDELLÒS I L'HOSPITALET DE L'INFANT"
  municipis[grep("PALAU DE PLEGAMANS", municipis$MUNNOM),"MUNNOM"]<-"PALAU-SOLITÀ I PLEGAMANS"
  municipis[grep("PRAT DE LLOBREGAT", municipis$MUNNOM),"MUNNOM"]<-"PRAT DE LLOBREGAT"
  municipis[grep("ARBOÇ", municipis$MUNNOM),"MUNNOM"]<-"ARBOÇ"
  municipis[grep("CORNELLA DE LLOBREGAT", municipis$MUNNOM),"MUNNOM"]<-"CORNELLÀ DE LLOBREGAT"
  
  municipis[grep("ALBI", municipis$MUNNOM),"MUNNOM"]<-"ALBI"
  municipis[grep("ALCANAR", municipis$MUNNOM),"MUNNOM"]<-"ALCANAR"
  municipis[grep("ALDEA", municipis$MUNNOM),"MUNNOM"]<-"ALDEA"
  municipis[grep("AMETLLA DE M", municipis$MUNNOM),"MUNNOM"]<-"AMETLLA DE MAR"
  municipis[grep("AMETLLA DEL VALLÈS", municipis$MUNNOM),"MUNNOM"]<-"AMETLLA DEL VALLÈS"
  municipis[grep("AMPOLLA", municipis$MUNNOM),"MUNNOM"]<-"AMPOLLA"
  municipis[grep("ARGENTERA", municipis$MUNNOM),"MUNNOM"]<-"ARGENTERA"
  municipis[grep("ARMENTERA", municipis$MUNNOM),"MUNNOM"]<-"ARMENTERA"
  municipis[grep("AVELLANES", municipis$MUNNOM),"MUNNOM"]<-"AVELLANES I SANTA LINYA"
  municipis[grep("BATLLÒRIA", municipis$MUNNOM),"MUNNOM"]<-"BATLLÒRIA"
  
  municipis[grep("BENAVENT DE SEGR", municipis$MUNNOM),"MUNNOM"]<-"BENAVENT DE SEGRIÀ"
  municipis[grep("BISBAL D'EMPORDÀ", municipis$MUNNOM),"MUNNOM"]<-"BISBAL D'EMPORDÀ"
  municipis[grep("BRUC", municipis$MUNNOM),"MUNNOM"]<-"BRUC"
  municipis[grep("CÀNOVES", municipis$MUNNOM),"MUNNOM"]<-"CÀNOVES I SAMALÚS"
  municipis[grep("CELLERA DE TER", municipis$MUNNOM),"MUNNOM"]<-"CELLERA DE TER"
  municipis[grep("ESCALA", municipis$MUNNOM),"MUNNOM"]<-"ESCALA"
  municipis[grep("ESTARTIT", municipis$MUNNOM),"MUNNOM"]<-"TORROELLA DE MONTGRÍ"
  municipis[grep("FAR D'EMPORDÀ", municipis$MUNNOM),"MUNNOM"]<-"FAR D'EMPORDÀ"
  municipis[grep("FLORESTA", municipis$MUNNOM),"MUNNOM"]<-"FLORESTA"
  municipis[grep("FULIOLA", municipis$MUNNOM),"MUNNOM"]<-"FULIOLA"
  municipis[grep("GALERA", municipis$MUNNOM),"MUNNOM"]<-"GALERA"
  municipis[grep("GIMENELLS", municipis$MUNNOM),"MUNNOM"]<-"GIMENELLS I EL PLA DE LA FONT"
  municipis[grep("GRANADA", municipis$MUNNOM),"MUNNOM"]<-"GRANADA"
  municipis[grep("GRANJA D'ESCARP", municipis$MUNNOM),"MUNNOM"]<-"GRANJA D'ESCARP"
  municipis[grep("HOSPITALET DE L'INFANT", municipis$MUNNOM),"MUNNOM"]<-"VANDELLÒS I L'HOSPITALET DE L'INFANT"
  municipis[grep("HOSPITALET DE LLOBREGAT", municipis$MUNNOM),"MUNNOM"]<-"HOSPITALET DE LLOBREGAT"
  municipis[grep("HOSTALETS DE PIEROLA", municipis$MUNNOM),"MUNNOM"]<-"HOSTALETS DE PIEROLA"
  municipis[grep("JUNCOSA", municipis$MUNNOM),"MUNNOM"]<-"JUNCOSA"
  municipis[grep("LLAGOSTA", municipis$MUNNOM),"MUNNOM"]<-"LLAGOSTA"
  municipis[grep("LLOSSES", municipis$MUNNOM),"MUNNOM"]<-"LLOSSES"
  municipis[grep("MASNOU", municipis$MUNNOM),"MUNNOM"]<-"MASNOU"
  municipis[grep("MONT-ROIG", municipis$MUNNOM),"MUNNOM"]<-"MONT-ROIG DEL CAMP"
  municipis[grep("MONTFERRER", municipis$MUNNOM),"MUNNOM"]<-"MONTFERRER I CASTELLBÒ"
  municipis[grep("MORELL", municipis$MUNNOM),"MUNNOM"]<-"MORELL"
  municipis[grep("OMELLS DE NA GAIA", municipis$MUNNOM),"MUNNOM"]<-"OMELLS DE NA GAIA"
  municipis[grep("PALAU D'ANGLESOLA", municipis$MUNNOM),"MUNNOM"]<-"PALAU D'ANGLESOLA"
  municipis[grep("PALMA DE CERVELLÓ", municipis$MUNNOM),"MUNNOM"]<-"PALMA DE CERVELLÓ"
  municipis[grep("PAPIOL", municipis$MUNNOM),"MUNNOM"]<-"PAPIOL"
  municipis[grep("PINEDA", municipis$MUNNOM),"MUNNOM"]<-"PINEDA DE MAR"
  municipis[grep("PINELL DE BRAI", municipis$MUNNOM),"MUNNOM"]<-"PINELL DE BRAI"
  municipis[grep("POAL", municipis$MUNNOM),"MUNNOM"]<-"POAL"
  municipis[grep("POBLA DE CLARAMUNT", municipis$MUNNOM),"MUNNOM"]<-"POBLA DE CLARAMUNT"
  municipis[grep("POBLA DE LILLET", municipis$MUNNOM),"MUNNOM"]<-"POBLA DE LILLET"
  municipis[grep("POBLA DE MASSALUCA", municipis$MUNNOM),"MUNNOM"]<-"POBLA DE MASSALUCA"
  municipis[grep("PONT DE VILOMARA", municipis$MUNNOM),"MUNNOM"]<-"PONT DE VILOMARA I ROCAFORT"
  municipis[grep("PORTELLA", municipis$MUNNOM),"MUNNOM"]<-"PORTELLA"
  municipis[grep("PRESES", municipis$MUNNOM),"MUNNOM"]<-"PRESES"
  municipis[grep("QUERFORADAT", municipis$MUNNOM),"MUNNOM"]<-"CAVA"
  municipis[grep("ROCA DEL VALLÈS", municipis$MUNNOM),"MUNNOM"]<-"ROCA DEL VALLÈS"
  municipis[grep("ROQUETES", municipis$MUNNOM),"MUNNOM"]<-"ROQUETES"
  municipis[grep("SÉNIA", municipis$MUNNOM),"MUNNOM"]<-"SÉNIA"
  municipis[grep("SEU D'URGELL", municipis$MUNNOM),"MUNNOM"]<-"SEU D'URGELL"
  municipis[grep("TORMS", municipis$MUNNOM),"MUNNOM"]<-"TORMS"
  municipis[municipis["MUNNOM"]=="CRUÏLLES, MONELLS I SANT SADUR", "MUNNOM"]<-"CRUÏLLES, MONELLS I SANT SADURNÍ DE L'HEURA"
  municipis[municipis["MUNNOM"]=="GARRIGA, LA", "MUNNOM"]<-"GARRIGA"
  municipis[municipis["MUNNOM"]=="L´ESQUIROL", "MUNNOM"]<-"ESQUIROL"
  municipis[municipis["MUNNOM"]=="LA CANONJA", "MUNNOM"]<-"CANONJA"
  municipis[municipis["MUNNOM"]=="MONTAGUT", "MUNNOM"]<-"MONTAGUT I OIX"
  municipis[municipis["MUNNOM"]=="VIMBODÍ", "MUNNOM"]<-"VIMBODÍ I POBLET"
  municipis[municipis["MUNNOM"]=="VENDRELL, EL", "MUNNOM"]<-"VENDRELL"
  municipis[municipis["MUNNOM"]=="RODA DE BARÀ", "MUNNOM"]<-"RODA DE BERÀ"
  municipis[municipis["MUNNOM"]=="PASSANANT", "MUNNOM"]<-"PASSANANT I BELLTALL"
  municipis[municipis["MUNNOM"]=="BORGES BLANQUES, LES", "MUNNOM"]<-"BORGES BLANQUES"
  municipis[municipis["MUNNOM"]=="BELLVEÍ", "MUNNOM"]<-"BELLVEI"
  municipis[municipis["MUNNOM"]=="CASTELL D'ARO", "MUNNOM"]<-"CASTELL-PLATJA D'ARO"
  #==========================================================================
  
  muncom<-left_join(municipis, comarques, by="MUNNOM")
  
  muncomprov<-left_join(muncom, provin, by="COMARCA")
  muncomprov$PROVÍNCIA<-as.character(muncomprov$PROVÍNCIA)
  muncomprov[is.na(muncomprov$PROVÍNCIA)==TRUE, "MUNNOM"]<-"NA"
  
  # Hi ha uns quants municipis que cal tractar a part perquè pertanyen a una província diferent que la resta de la comarca!
  muncomprov[muncomprov$MUNNOM=="GÓSOL", "PROVÍNCIA"]<-"LLEIDA"
  muncomprov[muncomprov$MUNNOM=="BELLVER DE CERDANYA" | muncomprov$MUNNOM=="LLES DE CERDANYA" | muncomprov$MUNNOM=="MONTELLÀ I MARTINET"
             | muncomprov$MUNNOM=="PRATS I SANSOR" |muncomprov$MUNNOM=="PRULLANS" | muncomprov$MUNNOM=="RIU DE CERDANYA", "PROVÍNCIA"]<-"LLEIDA"
  muncomprov[muncomprov$MUNNOM=="VILADRAU" | muncomprov$MUNNOM=="ESPINELVES" | muncomprov$MUNNOM=="VIDRÀ","PROVÍNCIA"]<-"GIRONA" # NO VAAAAAAA
  muncomprov[muncomprov$MUNNOM=="FOGARS DE LA SELVA", "PROVÍNCIA"]<-"BARCELONA"
  
  
  # GRÀFIC COMARQUES
  u_comarques<-aggregate(IMPORD~COMARCA, muncom, sum)
  rownames(u_comarques)<-u_comarques$COMARCA
  u_comarques$COMARCA<-NULL
  u_comarques["TOTAL",]<-sum(u_comarques$IMPORD)
  u_comarques["Sense info", "IMPORD"]<-sum(muncom[is.na(muncom$MUNNOM)==TRUE, "IMPORD"])
  u_comarques[,"percentatge"]<-round(100*u_comarques[,"IMPORD"]/u_comarques["TOTAL", "IMPORD"], digits = 2)
  
  u_comarques2<-u_comarques[u_comarques$percentatge>=2,]
  u_comarques2["Altres","IMPORD"]<-sum(u_comarques[u_comarques$percentatge<2, "IMPORD"])
  u_comarques2["Altres","percentatge"]<-round(sum(u_comarques[u_comarques$percentatge<2, "percentatge"]), digits = 2)
  u_comarques2<-u_comarques2[-12,]
  
  
  # GRÀFIC PROVÍNCIES
  u_provin<-aggregate(IMPORD~PROVÍNCIA, muncomprov, sum)
  rownames(u_provin)<-u_provin$PROVÍNCIA
  u_provin$PROVÍNCIA<-NULL
  u_provin["TOTAL",]<-sum(u_provin$IMPORD)
  u_provin["Sense info", "IMPORD"]<-sum(muncomprov[is.na(muncomprov$MUNNOM)==TRUE, "IMPORD"])
  u_provin[,"percentatge"]<-round(100*u_provin[,"IMPORD"]/u_provin["TOTAL", "IMPORD"], digits = 2)
  u_provin<-u_provin[-5,]
  if(u_provin["Sense info", "percentatge"]==0){u_provin<-u_provin[-5,]}
  
  #===========   QUADRE PER MUNICIPIS    ========================================
  
  munprestV2<-aggregate(IMPORD ~ CATIRC+MUNNOM,  municipis, sum)
  munprestV3<-aggregate(IMPORD ~ CATIRC+MUNNOM,  municipis, count)
  names(munprestV2)<-c("CATIRC", "MUNNOM", "IMPORT")
  names(munprestV3)<-c("CATIRC", "MUNNOM", "USUARIS")
  
  #munprestV4<-left_join(munprestV2, munprestV3, by=c("CATIRC", "MUNNOM"))
  munprestV4<-left_join(munprestV3, munprestV2, by=c("CATIRC", "MUNNOM"))
  munprestV4$MUNNOM<-as.factor(munprestV4$MUNNOM)
  
  munprestV<-data.frame(MUNNOM=levels(munprestV4$MUNNOM))
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="ADI",c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="ADS", c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="AP",c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="ARP",c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="CDP",c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  munprestV<-left_join(munprestV, munprestV4[munprestV4$CATIRC=="VNP",c("MUNNOM", "USUARIS","IMPORT")], by="MUNNOM")
  names(munprestV)<-c("Municipi", "Usuaris_ADI","Import_ADI", "Usuaris_ADS","Import_ADS", "Usuaris_AP","Import_AP",  
                      "Usuaris_ARP","Import_ARP", "Usuaris_CDP","Import_CDP", "Usuaris_VNP",  "Import_VNP")
  munprestV_2<-sapply(munprestV[,2:13],  haz.cero.na)
  munprestV[,2:13]<-munprestV_2
  
  rownames(munprestV)<-munprestV$Municipi
  munprestVT<-as.data.frame(t(munprestV)) # munprestVT: TAULA MUNICIPIS MES ACTUAL (versió transposada) 
  munprestVT<-munprestVT[-1,]
  
  rm(munprestV_2, munprestV2, munprestV3, munprestV4, munprestV)
  
  #========== QUADRE PER COMARQUES (mes actual) =================================
  
  comprestV2<-aggregate(IMPORD ~ CATIRC+COMARCA,  muncom, sum)
  comprestV3<-aggregate(IMPORD ~ CATIRC+COMARCA,  muncom, count)
  names(comprestV2)<-c("CATIRC", "COMARCA", "IMPORT")
  names(comprestV3)<-c("CATIRC", "COMARCA", "USUARIS")
  
  comprestV4<-left_join(comprestV2, comprestV3, by=c("CATIRC", "COMARCA"))
  comprestV4$COMARCA<-as.factor(comprestV4$COMARCA)
  
  comprestV<-data.frame(COMARCA=levels(comprestV4$COMARCA))
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="ADI",c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="ADS", c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="AP",c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="ARP",c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="CDP",c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  comprestV<-left_join(comprestV, comprestV4[comprestV4$CATIRC=="VNP",c("COMARCA", "USUARIS","IMPORT")], by="COMARCA")
  names(comprestV)<-c("Comarca", "Usuaris_ADI", "Import_ADI", "Usuaris_ADS","Import_ADS","Usuaris_AP", "Import_AP", 
                      "Usuaris_ARP","Import_ARP", "Usuaris_CDP","Import_CDP", "Usuaris_VNP", "Import_VNP")
  
  comprestV_2<-sapply(comprestV[,2:13],  haz.cero.na)
  comprestV[,2:13]<-comprestV_2
  
  rownames(comprestV)<-comprestV$Comarca
  comprestVT<-as.data.frame(t(comprestV)) 
  comprestVT<-comprestVT[-1,]
  
  rm(comprestV_2, comprestV2, comprestV3, comprestV4, comprestV)
  
  #========== QUADRE PER DEMARCACIONS (mes actual) ==============================
  
  demV2<-muncomprov
  names(demV2)<-c("MUNNOM","IMPORD","NOPRDB","CATIRC","COMARCA","DEMARCACIÓ")
  
  demprestV2<-aggregate(IMPORD ~ CATIRC+DEMARCACIÓ,  demV2, sum)
  demprestV3<-aggregate(IMPORD ~ CATIRC+DEMARCACIÓ,  demV2, count)
  names(demprestV2)<-c("CATIRC", "DEMARCACIÓ", "IMPORT")
  names(demprestV3)<-c("CATIRC", "DEMARCACIÓ", "USUARIS")
  
  demprestV4<-left_join(demprestV2, demprestV3, by=c("CATIRC", "DEMARCACIÓ"))
  demV2$DEMARCACIÓ<-as.factor(demV2$DEMARCACIÓ)
  
  demprestV<-data.frame(DEMARCACIÓ=levels(demV2$DEMARCACIÓ))
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="ADI",c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="ADS", c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="AP",c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="ARP",c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="CDP",c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  demprestV<-left_join(demprestV, demprestV4[demprestV4$CATIRC=="VNP",c("DEMARCACIÓ", "USUARIS","IMPORT")], by="DEMARCACIÓ")
  names(demprestV)<-c("Demarcació", "Usuaris_ADI", "Import_ADI", "Usuaris_ADS","Import_ADS", "Usuaris_AP", "Import_AP", 
                      "Usuaris_ARP","Import_ARP", "Usuaris_CDP", "Import_CDP", "Usuaris_VNP", "Import_VNP")
  
  demprestV_2<-sapply(demprestV[,2:13], haz.cero.na)
  demprestV[,2:13]<-demprestV_2
  
  rownames(demprestV)<-demprestV$Demarcació
  demprestVT<-as.data.frame(t(demprestV)) # demprestV: TAULA demarcacions MES ACTUAL 
  demprestVT<-demprestVT[-1,]
  
  rm(demprestV_2, demprestV2, demprestV3, demprestV4, demprestV)
  
  # ====================
  
} else{ # ===== Segona opció: no tenim info de municipis
  u_comarques2<-data.frame()
  u_provin<-data.frame()
  munprestVT<-data.frame()
  comprestVT<-data.frame()
  demprestVT<-data.frame()
}
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/estatics")
write.csv(u_comarques2,"A5.1p_usuaris_comarca.csv", fileEncoding = "UTF-8")
write.csv(u_provin,"A5.2p_usuaris_provincia.csv", fileEncoding = "UTF-8")

setwd("C:/xampp/htdocs/GestioDeute/scripts/mes")
nom_muni<-paste0("municipis ", mes[mes_actual], ".csv")
write.csv(munprestVT, nom_muni, fileEncoding = "UTF-8")

nom_com<-paste0("comarques ", mes[mes_actual], ".csv")
write.csv(comprestVT, nom_com, fileEncoding = "UTF-8")

nom_dem<-paste0("demarcacions ", mes[mes_actual], ".csv")
write.csv(demprestVT, nom_dem, fileEncoding = "UTF-8")



setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/estatics")


# A6. # IMPORT PER FRANGES D'EDAT   ##########################################################################

import_franges_edat<-data.frame()
import_franges_edat["0-24 anys",1]<-sum(quadrament[quadrament$edat<25 & quadrament$PSNSEX=="D", "IMPORD"], na.rm = TRUE)
import_franges_edat["25-39 anys",1]<-sum(quadrament[quadrament$edat>=25 & quadrament$edat<40 & quadrament$PSNSEX=="D", "IMPORD"], na.rm = TRUE)
import_franges_edat["40-64 anys",1]<-sum(quadrament[quadrament$edat>=40 & quadrament$edat<65 & quadrament$PSNSEX=="D", "IMPORD"], na.rm = TRUE)
import_franges_edat[">65 anys",1]<-sum(quadrament[quadrament$edat>=64 & quadrament$PSNSEX=="D", "IMPORD"], na.rm = TRUE)

import_franges_edat["0-24 anys",2]<-sum(quadrament[quadrament$edat<25 & quadrament$PSNSEX=="H", "IMPORD"], na.rm = TRUE)
import_franges_edat["25-39 anys",2]<-sum(quadrament[quadrament$edat>=25 & quadrament$edat<40 & quadrament$PSNSEX=="H", "IMPORD"], na.rm = TRUE)
import_franges_edat["40-64 anys",2]<-sum(quadrament[quadrament$edat>=40 & quadrament$edat<65 & quadrament$PSNSEX=="H", "IMPORD"], na.rm = TRUE)
import_franges_edat[">65 anys",2]<-sum(quadrament[quadrament$edat>=64 & quadrament$PSNSEX=="H", "IMPORD"], na.rm = TRUE)

names(import_franges_edat)<-c("Dones", "Homes")
write.csv(import_franges_edat,"A6b_import_edats.csv", fileEncoding = "UTF-8") 

# A7. # TEMPS DE RETARD SEGONS LA BAIXA/ MODIF ###############################################################

temps_retard<-as.data.frame(c("Baixes defunció", "Baixes altres motius", "Baixes recurs a la baixa", 
                              "Baixes recurs a l'alça", "Modificatives a la baixa", "Modificatives a l'alça"))
temps_retard[1,2]<-Resum[avuiC, "Bdef mitjana temps(dies)"]
temps_retard[2,2]<-Resum[avuiC, "B_altres mitjana temps(dies)"]
temps_retard[3,2]<-Resum[avuiC, "R_b mitj temps (dies)"]
temps_retard[4,2]<-Resum[avuiC, "R_a mitj temps (dies)"]
temps_retard[5,2]<-Resum[avuiC, "M_b mitj temps (dies)"]
temps_retard[6,2]<-Resum[avuiC, "M_a mitj temps (dies)"]
rownames(temps_retard)<-temps_retard[,1]
temps_retard[,1]<-NULL
names(temps_retard)<-"temps mig retard (dies)"
write.csv(temps_retard,"A7b_temps_retard.csv", fileEncoding = "UTF-8") 


# A8. # USUARIS PER GRAUS I PER PRESTACIÓ  ###################################################################

auxgraus<-historic[,c("Prestació", "Any", "Grau 3", "Grau 3-2", "Grau 3-1","Grau 2", "Grau 2-2", "Grau 2-1", "Grau 1-2", "Grau 1")]
levels(auxgraus$Prestació)<-c("AP", "ARP","CDP", "ADI", "ADS", "VNP")
auxgrausVNP<-historicPVN[,c("Any", "Grau 3", "Grau 3-2", "Grau 3-1", "Grau 2","Grau 2-2", "Grau 2-1", "Grau 1-2", "Grau 1", "Grau 1-1")]
auxgrausVNP[,"Prestació"]<-"VNP"
auxtot<-rbind.fill(auxgraus,auxgrausVNP)
graus_estatic<-auxtot[auxtot[,"Any"]==avuiC,]
graus_estatic[,"Any"]<-NULL
rownames(graus_estatic)<-graus_estatic[,"Prestació"]
graus_estatic[,"Prestació"]<-NULL
write.csv(graus_estatic,"A8b_usuaris_grau_prestacio.csv", fileEncoding="utf8")

# A9. # USUARIS PER SEXE I PER RECURS  ###################################################################

if("CATIRC" %in% colnames(quadrament) &"PSNSEX" %in% colnames(quadrament)){
  a<-aggregate(x=quadrament[,"PSNSEX"],by=quadrament[c("CATIRC","PSNSEX")],count)
  a$CATIRC<-as.factor(a$CATIRC)
  levels(a$CATIRC)<-prestcurt
  b<-data.frame(Dones=a[a$PSNSEX=="D","x"], Prestacio=levels(a$CATIRC),Homes=a[a$PSNSEX=="H","x"])
  rownames(b)<-b$Prestacio
  b$Prestacio<-NULL
  write.csv(b,"A9_usuaris_prest_sexe.csv", fileEncoding = "UTF-8")
}else{
  b<-data.frame()
  write.csv(b,"A9_usuaris_prest_sexe.csv", fileEncoding = "UTF-8")
}

# A10. # ALTES PER RECURS #################### (Altes segons fitxers altes ELLS)  ########################

altesNM<-quadrament[is.na(quadrament$Altes22)!=TRUE | is.na(quadrament$Altes24)!=TRUE,]
altes_recurs<-as.data.frame(aggregate(BENDNI ~ CATIRC, altesNM, count))
levels(altes_recurs$CATIRC)<-prestcurt

altes_recurs2<-as.data.frame(prestcurt)
names(altes_recurs2)<-"CATIRC"
altes_recurs2$CATIRC<-as.character(altes_recurs2$CATIRC)
altes_recurs$CATIRC<-as.character(altes_recurs$CATIRC)

altes_recurs<-left_join(altes_recurs2, altes_recurs, by="CATIRC")
names(altes_recurs)<-c("CATIRC","ALTES")
altes_recurs[,"ALTES"]<-sapply(altes_recurs[,"ALTES"], haz.cero.na)

rownames(altes_recurs)<-altes_recurs[,"CATIRC"]
altes_recurs[,"CATIRC"]<-NULL

rm(altes_recurs2)
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/estatics")
write.csv(altes_recurs, "A10b_altes_recurs.csv", fileEncoding = "UTF-8")

##############################################################################################################
##############################     (B) GRÀFICS GLOBALS            ############################################
##############################################################################################################

#setwd("C:/Users/agrenzne/Documents/Gestió deute/Quasi definitiu/Gràfics/Global i anual")
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/global")


# B1. # PRESSUPOST TOTAL AL LLARG DELS ANYS  #################################################################

#############################################
##  Càlcul d'imports totals - històric ###### 
#############################################

############ Històric normal ################

histo<-historic
# Posem els mesos amb lletres
histo$Any<-as.Date(histo$Any)

#histo[,"Mes"]<-as.factor(histo[,"Mes"])
#levels(histo[,"Mes"])<-mes
# Posem la columna "any" al final
columna_mes_any<-as.data.frame(histo$Any)
histo$Any<-NULL

# Posem zeros 
histo_2<-data.frame(sapply(histo[,3:(ncol(histo)-1)],haz.cero.na))
histo_2<-round(histo_2,2) 
histo[,3:(ncol(histo)-1)]<-histo_2
rm(histo_2)
histo$Any<-columna_mes_any
rm(columna_mes_any)

## Imports totals ordinàries
a<- histo[,"G3 ORDINÀRIA"]+ histo[,"G2 ORDINÀRIA"]+ histo[,"G1 ORDINÀRIA"]
b<-  if("G3-2 ORDINÀRIA" %in% names(histo)){histo[,"G3-2 ORDINÀRIA"]}else{0}  
c<-  if("G3-1 ORDINÀRIA" %in% names(histo)){histo[,"G3-1 ORDINÀRIA"]}else{0} 
d<-  if("G2-2 ORDINÀRIA" %in% names(histo)){histo[,"G2-2 ORDINÀRIA"]}else{0} 
e<-  if("G2-1 ORDINÀRIA" %in% names(histo)){histo[,"G2-1 ORDINÀRIA"]}else{0} 
f<-  if("G1-2 ORDINÀRIA" %in% names(histo)){histo[,"G1-2 ORDINÀRIA"]}else{0}
g<-  if("G1-1 ORDINÀRIA" %in% names(histo)){histo[,"G1-1 ORDINÀRIA"]}else{0}
histo[,"Total Ordinària"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)
## USUARIS
a<- histo[,"Grau 3"]+ histo[,"Grau 2"]+ histo[,"Grau 1"]
b<-  if("Grau 3-2" %in% names(histo)){histo[,"Grau 3-2"]}else{0}  
c<-  if("Grau 3-1" %in% names(histo)){histo[,"Grau 3-1"]}else{0} 
d<-  if("Grau 2-2" %in% names(histo)){histo[,"Grau 2-2"]}else{0} 
e<-  if("Grau 2-1" %in% names(histo)){histo[,"Grau 2-1"]}else{0} 
f<-  if("Grau 1-2" %in% names(histo)){histo[,"Grau 1-2"]}else{0}
g<-  if("Grau 1-1" %in% names(histo)){histo[,"Grau 1-1"]}else{0}
histo[,"Total usuaris"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

histo$Prestació<-as.factor(histo$Prestació)
levels(histo$Prestació)<-c("AP","ARP","CDP","ADI","ADS","VNP")
aa<-split(histo, histo$Prestació)
for(i in 1:length(aa)){         
  bb<-as.data.frame(aa[[i]])
  t<-bb[,c("Any", "Total Ordinària","Total usuaris")]
  t<-t[order(t$Any),]
  assign(names(aa)[i], t)
}

############ Històric PVN ###################

histoPVN<-historicPVN
histoPVN[,"Mes"]<-as.factor(histoPVN[,"Mes"]) 
levels(histoPVN[,"Mes"])<-mes
histoPVN2<-data.frame(sapply(histoPVN[,1:(ncol(histoPVN)-3)],haz.cero.na)) # Posem zeros
histoPVN2<-round(histoPVN2,2) # arrodoneix a 2 decimals

names(histoPVN2)<-names(histoPVN[,1:(ncol(histoPVN)-3)])
histoPVN<-cbind(histoPVN2, histoPVN[,(ncol(histoPVN)-2):(ncol(histoPVN))])
rm(histoPVN2)

## Imports totals ordinàries (PVN)

a<- histoPVN[,"G3 ORDINÀRIA"]+ histoPVN[,"G2 ORDINÀRIA"]+ histoPVN[,"G1 ORDINÀRIA"]
b<-  if("G3-2 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G3-2 ORDINÀRIA"]}else{0}  
c<-  if("G3-1 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G3-1 ORDINÀRIA"]}else{0} 
d<-  if("G2-2 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G2-2 ORDINÀRIA"]}else{0} 
e<-  if("G2-1 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G2-1 ORDINÀRIA"]}else{0} 
f<-  if("G1-2 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G1-2 ORDINÀRIA"]}else{0}
g<-  if("G1-1 ORDINÀRIA" %in% names(histoPVN)){histoPVN[,"G1-1 ORDINÀRIA"]}else{0}
histoPVN[,"Total Ordinària"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

VNP<-histoPVN[,c("Any", "Total Ordinària")]
VNP<-VNP[order(VNP$Any),]

Import_anys<-cbind(VNP, AP$`Total Ordinària`, ARP$`Total Ordinària`, CDP$`Total Ordinària`, 
                   ADI$`Total Ordinària`, ADS$`Total Ordinària`)

Import_anys<-cbind(ADI$`Total Ordinària`,ADS$`Total Ordinària`,AP$`Total Ordinària`,ARP$`Total Ordinària`,CDP$`Total Ordinària`,VNP)
rownames(Import_anys)<-as.Date(Import_anys$Any)
Import_anysC<-Import_anys
Import_anys[,6]<-NULL
names(Import_anys)<-c("ADI", "ADS", "AP", "ARP", "CDP", "VNP")
names(Import_anysC)<-c("ADI", "ADS", "AP", "ARP", "CDP", "Any", "VNP")
write.csv(Import_anys,"B1.1_Import_anys_prest.csv", fileEncoding="utf8")

## B1.3 Usuaris 
a<- histoPVN[,"Grau 3"]+ histoPVN[,"Grau 2"]+ histoPVN[,"Grau 1"]
b<-  if("Grau 3-2" %in% names(histoPVN)){histoPVN[,"Grau 3-2"]}else{0}  
c<-  if("Grau 3-1" %in% names(histoPVN)){histoPVN[,"Grau 3-1"]}else{0} 
d<-  if("Grau 2-2" %in% names(histoPVN)){histoPVN[,"Grau 2-2"]}else{0} 
e<-  if("Grau 2-1" %in% names(histoPVN)){histoPVN[,"Grau 2-1"]}else{0} 
f<-  if("Grau 1-2" %in% names(histoPVN)){histoPVN[,"Grau 1-2"]}else{0}
g<-  if("Grau 1-1" %in% names(histoPVN)){histoPVN[,"Grau 1-1"]}else{0}
histoPVN[,"Total usuaris"]<-a+b+c+d+e+f+g
rm(a,b,c,d,e,f,g)

VNP<-histoPVN[,c("Any", "Total usuaris")]
VNP<-VNP[order(VNP$Any),]

Import_anys2<-cbind(VNP, AP$`Total usuaris`, ARP$`Total usuaris`, CDP$`Total usuaris`, 
                    ADI$`Total usuaris`, ADS$`Total usuaris`)

Import_anys2<-cbind(ADI$`Total usuaris`,ADS$`Total usuaris`,AP$`Total usuaris`,ARP$`Total usuaris`,CDP$`Total usuaris`,VNP)
rownames(Import_anys2)<-as.Date(Import_anys2$Any)
Import_anysC2<-Import_anys2
Import_anys2[,6]<-NULL
names(Import_anys2)<-c("ADI", "ADS", "AP", "ARP", "CDP", "VNP")
names(Import_anysC2)<-c("ADI", "ADS", "AP", "ARP", "CDP", "Any", "VNP")
write.csv(Import_anys2,"B1.3_usuaris_anys_prest.csv", fileEncoding="utf8")


# B1.2. Import total 
Import_tot_anys<-as.data.frame(Resum[,c("Any", "Import")])
rownames(Import_tot_anys)<-as.Date(Import_tot_anys$Any)
Import_tot_anysC<-Import_tot_anys
Import_tot_anys$Any<-NULL
Import_tot_anys[,"Import"]<-round(Import_tot_anys[,"Import"], digits = 2)
write.csv(Import_tot_anys,"B1.2_Import_anys_tot.csv", fileEncoding="utf8")



# B2. # PRESSUPOST 22/24 #####################################################################################
Import22_24<-as.data.frame(TotalP[,c("Any", "PVS Total")])
Import22_24[,"Import 24"]<-TotalP[,"AP Total"]+TotalP[,"VNP Total"]
rownames(Import22_24)<-as.Date(Import22_24$Any)
Import22_24C<-Import22_24
Import22_24$Any<-NULL
names(Import22_24)<-c("Import 22", "Import 24")
names(Import22_24C)<-c("Any", "Cartera 22", "Cartera 24")
write.csv(Import22_24,"B2_Pressupost22_24.csv", fileEncoding="utf8")

# B3. # USUARIS NOVES I BAIXES ###############################################################################
altesbaixes<-Resum[,c("Any", "Noves(u)", "Baixes totals(u)")]
altesbaixes<-altesbaixes[altesbaixes$Any>=gen2017,]
rownames(altesbaixes)<-as.Date(altesbaixes$Any)
altesbaixesC<-altesbaixes
altesbaixes[,1]<-NULL
write.csv(altesbaixes,"B3_altesbaixes.csv", fileEncoding="utf8")

# B4. # USUARIS MODIFICATIVES I CANVIS DE RECURS #############################################################
modrecurs<-Resum[,c("Any", "Baixes defuncions(u)", "Baixes altres motius(u)", "Modificatives a la baixa(u)", "Modificatives a l'alça(u)", 
                    "Baixes per canvi de recurs a la baixa(u)", "Baixes per canvi de recurs a l'alça(u)","Retinguts(u)")]

modrecurs[,"Modif"]<-modrecurs[,"Modificatives a la baixa(u)"]+modrecurs[,"Modificatives a l'alça(u)"]
modrecurs[,"Canvis recurs"]<-modrecurs[,"Baixes per canvi de recurs a la baixa(u)"]+modrecurs[,"Baixes per canvi de recurs a l'alça(u)"]
modrecurs<-modrecurs[,-c(4:7)]
modrecurs<-modrecurs[modrecurs$Any>=gen2017,]
rownames(modrecurs)<-as.Date(modrecurs$Any)
modrecursC<-modrecurs
modrecurs[,1]<-NULL
write.csv(modrecurs,"B4_modif_recurs.csv", fileEncoding="utf8")

# B5. # TEMPS MIG DE RETARD ##################################################################################
temps_mig<-Resum[,c("Any", "Bdef mitjana temps(dies)", "B_altres mitjana temps(dies)", "M_b mitj temps (dies)", "M_a mitj temps (dies)", 
                    "R_b mitj temps (dies)", "R_a mitj temps (dies)")]
names(temps_mig)<-c("Any", "Baixes defunció(dies)", "Baixes altres motius(dies)", "Modif_baixa", "Modif_alça", 
                    "Canvis_recurs_baixa", "Canvis_recurs_alça")
temps_mig<-temps_mig[temps_mig$Any>=gen2017,]
rownames(temps_mig)<-as.Date(temps_mig$Any)
temps_migC<-temps_mig
temps_mig[,1]<-NULL
write.csv(temps_mig,"B5_temps_mig_retard.csv", fileEncoding="utf8")

# B6. # PAGAMENTS INDEGUTS ###################################################################################
pagaments_ind<-Resum[,c("Any", "Bdef pagaments indeguts(e)", "B_altres pagaments indeguts(e)", "M_b pagaments indeguts(e)", "R_b pagaments indeguts(e)")]
names(pagaments_ind)<-c("Any", "Baixes defunció", "Baixes altres motius", "Modif_baixa","Canvis_recurs_baixa")
pagaments_ind<-pagaments_ind[pagaments_ind$Any>=gen2017,]
rownames(pagaments_ind)<-as.Date(pagaments_ind$Any)
pagaments_indC<-pagaments_ind
pagaments_ind[,1]<-NULL
write.csv(pagaments_ind,"B6_pagaments_ind.csv", fileEncoding="utf8")


# B7. # ENDARRERIMENTS PER PRESTACIÓ        #################################################################
Endarreriments<-TotalP[,c("Any", "AP endarreriments", "VNP endarreriments", "PVS endarreriments")]
EndarrerimentsC<-Endarreriments
rownames(Endarreriments)<-as.Date(Endarreriments$Any)
rownames(EndarrerimentsC)<-as.Date(EndarrerimentsC$Any)
Endarreriments$Any<-NULL
write.csv(Endarreriments,"B7_endarreriments.csv", fileEncoding="utf8")

# B8. # GRAUS  ###############################################################################################

graus_global<-auxtot[,-1]
graus_global2<-data.frame(sapply(graus_global[,2:(ncol(graus_global))],haz.cero.na))
graus_global[,2:ncol(graus_global)]<-graus_global2
rm(graus_global2)

graus<-aggregate(cbind(`Grau 3`, `Grau 3-2`, `Grau 3-1`, `Grau 2`,`Grau 2-2`, `Grau 2-1`, `Grau 1-2`, `Grau 1`, `Grau 1-1`) ~ Any,graus_global,sum)
rownames(graus)<-as.Date(graus$Any)
grausC<-graus
graus[,"Any"]<-NULL 
write.csv(graus,"B8_usuaris_graus.csv", fileEncoding="utf8")

# B9. # ALTES RECURS #########################################################################################

# Històric prestacions
historicB<-historic
historicB<-cbind(historicB, historicB$Any)
historicB$Any<-NULL
colnames(historicB)[ncol(historicB)]<-"Any"

historicB2<-data.frame(sapply(historicB[,3:(ncol(historicB)-1)],haz.cero.na))
names(historicB2)<-names(historicB[,3:(ncol(historicB)-1)])
historicB2<-round(historicB2,2) 
historicB[,3:(ncol(historicB)-1)]<-historicB2
rm(historicB2)

a<-   historicB[,"3 (ALTES)"]+ historicB[,"2 (ALTES)"]+historicB[,"1 (ALTES)"] 
b<-  if("3-2 (ALTES)" %in% names(historicB)){historicB[,"3-2 (ALTES)"]}else{0}
c<-  if("3-1 (ALTES)" %in% names(historicB)){historicB[,"3-1 (ALTES)"]}else{0}
d<-  if("2-2 (ALTES)" %in% names(historicB)){historicB[,"2-2 (ALTES)"]}else{0}
e<-  if("2-1 (ALTES)" %in% names(historicB)){historicB[,"2-1 (ALTES)"]}else{0}
f<-  if("1-2 (ALTES)" %in% names(historicB)){historicB[,"1-2 (ALTES)"]}else{0}
g<-  if("1-1 (ALTES)" %in% names(historicB)){historicB[,"1-1 (ALTES)"]}else{0}
historicB[,"Total (Altes)"]<-a+b+c+d+e+f
rm(a,b,c,d,e,f,g)
levels(historicB$Prestació)<-c("AP", "ARP", "CDP", "ADI", "ADS", "VNP")
historicB<-historicB[,c("Any","Prestació", "Total (Altes)")]

# Històric VNP
historicPVNB<-historicPVN
historicPVNB<-cbind(historicPVNB, historicPVNB$Any)
historicPVNB$Any<-NULL
colnames(historicPVNB)[ncol(historicPVNB)]<-"Any"

historicPVNB2<-data.frame(sapply(historicPVNB[,1:(ncol(historicPVNB)-3)],haz.cero.na))
names(historicPVNB2)<-names(historicPVNB[,1:(ncol(historicPVNB)-3)])
historicPVNB2<-round(historicPVNB2,2) 
historicPVNB[,1:(ncol(historicPVNB)-3)]<-historicPVNB2
rm(historicPVNB2)

a<-   historicPVNB[,"3 (ALTES)"]+ historicPVNB[,"2 (ALTES)"]+historicPVNB[,"1 (ALTES)"] 
b<-  if("3-2 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"3-2 (ALTES)"]}else{0}
c<-  if("3-1 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"3-1 (ALTES)"]}else{0}
d<-  if("2-2 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"2-2 (ALTES)"]}else{0}
e<-  if("2-1 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"2-1 (ALTES)"]}else{0}
f<-  if("1-2 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"1-2 (ALTES)"]}else{0}
g<-  if("1-1 (ALTES)" %in% names(historicPVNB)){historicPVNB[,"1-1 (ALTES)"]}else{0}
historicPVNB[,"Total (Altes)"]<-a+b+c+d+e+f
rm(a,b,c,d,e,f,g)
historicPVNB<-historicPVNB[,c("Any","Total (Altes)")]
historicPVNB<-historicPVNB[order(historicPVNB$Any),] # en principi està ordenat

aaa<-split(historicB, historicB$Prestació) # com puc saber si sempre ho separarà en el mateix ordre/si el vnp serà sempre el 6?? 
# --> suposem que sí (que ho separa per nivells)

historic_altes<-as.data.frame(cbind(aaa[[1]]$Any, aaa[[1]]$`Total (Altes)`, aaa[[2]]$`Total (Altes)`, aaa[[3]]$`Total (Altes)`, 
                                    aaa[[4]]$`Total (Altes)`,  aaa[[5]]$`Total (Altes)`, # aaa[[6]]$`Total (Altes)`, 
                                    historicPVNB$`Total (Altes)`))

names(historic_altes)<-c("Any", "AP", "ARP", "CDP", "ADI", "ADS", "VNP")

historic_altes$Any<-as.yearmon(historic_altes[,"Any"],"%Y%m%d")
rownames(historic_altes)<-as.Date(historic_altes$Any)
historic_altesC<-historic_altes
historic_altes$Any<-NULL
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/global")
write.csv(historic_altes, "B9_altes_recurs.csv", fileEncoding = "UTF-8")

##############################################################################################################
##############################     (C) GRÀFICS ANUALS             ############################################
##############################################################################################################
setwd("C:/xampp/htdocs/GestioDeute/scripts/graf/anual")

#  C1. # PRESSUPOST TOTAL AL LLARG DELS ANYS 

#  C1.1. PER PRESTACIONS  
Import_anual<-Import_anysC[Import_anysC$Any>(avui-1),]
Import_anual$Any<-NULL
write.csv(Import_anual,"C1.1_Import_anys_prest.csv", fileEncoding="utf8")

#  C1.2. TOTAL
Import_tot_anual<-Import_tot_anysC[Import_tot_anysC$Any>(avui-1),]
Import_tot_anual$Any<-NULL
write.csv(Import_tot_anual,"C1.2_Import_anys_tot.csv", fileEncoding="utf8")

#  C1.3. USUARIS
Import_anual2<-Import_anysC2[Import_anysC2$Any>(avui-1),]
Import_anual2$Any<-NULL
write.csv(Import_anual2,"C1.3_usuaris_anys_prest.csv", fileEncoding="utf8")


#  C2. # PRESSUPOST 22/24                           
Import22_24anual<-Import22_24C[Import22_24C$Any>(avui-1),]
Import22_24anual$Any<-NULL
write.csv(Import22_24anual,"C2_Pressupost22_24.csv", fileEncoding="utf8")

#  C3. # USUARIS NOVES I BAIXES                           
Altesbaixes_anual<-altesbaixesC[altesbaixesC$Any>(avui-1),]
Altesbaixes_anual$Any<-NULL
write.csv(Altesbaixes_anual,"C3_altesbaixes.csv", fileEncoding="utf8")

#     C4. # USUARIS MODIFICATIVES I CANVIS DE RECURS                               
Modrec_anual<-modrecursC[modrecursC$Any>(avui-1),]
Modrec_anual$Any<-NULL
write.csv(Modrec_anual,"C4_modif_recurs.csv", fileEncoding="utf8")

#     C5. # TEMPS MIG DE RETARD                       
tempsmig_anual<-temps_migC[temps_migC$Any>(avui-1),]
tempsmig_anual$Any<-NULL
write.csv(tempsmig_anual,"C5_temps_mig_retard.csv", fileEncoding="utf8")

#     C6. # PAGAMENTS INDEGUTS                              
pagamentsind_anual<-pagaments_indC[pagaments_indC$Any>(avui-1),]
pagamentsind_anual$Any<-NULL
write.csv(pagamentsind_anual,"C6_pagaments_ind.csv", fileEncoding="utf8")


#     C7. # ENDARRERIMENTS                              
End_anual<-EndarrerimentsC[EndarrerimentsC$Any>(avui-1),]
End_anual$Any<-NULL
write.csv(End_anual,"C7_endarreriments.csv", fileEncoding="utf8")

#     C8. # GRAUS                              
Graus_anual<-grausC[grausC$Any>(avui-1),]
Graus_anual$Any<-NULL
write.csv(Graus_anual,"C8_usuaris_graus.csv", fileEncoding="utf8")

#     C9. # ALTES RECURS                              
altes_anual<-historic_altesC[historic_altesC$Any>(avui-1),]
altes_anual$Any<-NULL
write.csv(altes_anual,"C9_altes_recurs.csv", fileEncoding="utf8")

rm(Import_anysC, Import_tot_anysC, Import22_24C, altesbaixesC, modrecursC, temps_migC, pagaments_indC, EndarrerimentsC, grausC, historic_altesC)

###########################################################################
###########     ACTUALITZAR I NETEJAR DADES   #############################
###########################################################################

## Eliminem el que no volem i guardem l'històric
rm(list=setdiff(ls(), c("historic","historicPVN","BAM","Resum","TotalP","haz.cero.na","prestcurt","prestllarg","comarques", 
                        "provin")))


## Ara falta actualitzarl'historic:
setwd("C:/xampp/htdocs/GestioDeute/scripts/")
save.image("historic.RData")
