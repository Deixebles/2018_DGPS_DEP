
# --------------------------------------------------------------------------------------------------#
# ------------------------------ SCRIPT IMPORT BAIXES ----------------------------------------------#
# --------------------------------------------------------------------------------------------------#

# Aquest script serveix per calcular "imports_baixes" 
# --> Es tracta d'una taula que conté info del nre de baixes de cada mes i l'import total d'ordinàries associat
#     (import que es pagava ordinàriament a aquests usuaris que s'han donat de baixa)
# --> Aquesta taula s'anirà completant amb la mateixa execució de l'R gestió.
#     Però que com que volem iniciar-la des que tenim info (feb 2017), amb aquest script ho podrem fer sense tornar a executar tot el programa
#     per tots els mesos ja carregats a l'històric (anem per setembre 2018)
# --> La informació que necessitem: el quadrament, el quadrament del mes anterior guardat a "scripts", 
#     l'històric de baixes actualitzat en el mes de l'execució

# LIBRERIES ----------------------------------------------------------------------------------------#

suppressMessages(library(dplyr))
suppressMessages(library(sqldf)) #joins?


# Per cadascun dels mesos (des que tinguem info baixes + 1 mes):
avui<-as.yearmon("09-2018","%m-%Y")

# CÀRREGA DE DADES  ===================================================#
setwd("C:/xampp/htdocs/GestioDeute/uploads/")
historic_baixes<- as.data.frame(read_excel("Baixes.xlsx", sheet=1, na="")) # llegir sempre mateix fitxers de baixes no funciona

setwd("C:/xampp/htdocs/GestioDeute/scripts")
load("importsbaixes.RData")

# LLegim quadraments mes actual i mes anterior ===============================================#

setwd("C:/xampp/htdocs/GestioDeute/scripts/quadraments")
quadrantic<-read.csv(paste("Quadrament ",avui-0.01, ".csv",sep=""),fileEncoding = "UTF-8")
quadrament<-read.csv(paste("Quadrament ",avui, ".csv",sep=""),fileEncoding = "UTF-8")

## Agafem només les columnes que necessitem:
quadrament01<-quadrantic[,c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")]
quadrament01$BENDNI<-as.character(quadrament01$BENDNI)
quadrament02<-quadrament[,c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")]
quadrament02$BENDNI<-as.character(quadrament02$BENDNI)

ordinaries02<-quadrament02[quadrament02$IMPORD!=0,] # ordinàries gener
ordinaries01<-quadrament01[quadrament01$IMPORD!=0,] # ordinàries desembre
names(ordinaries01)<-c("CARTE01", "NOPRDB", "BENDNI", "CATIRC01", "ALTCAR", "GN01", "IMPORD01", "NOPSAP01", "END")

DosmesosPROC<-full_join(ordinaries01,ordinaries02,by="NOPRDB")
DosmesosDNI<-full_join(ordinaries01,ordinaries02,by="BENDNI")
VarienDNI<-DosmesosPROC[DosmesosPROC$BENDNI.x!=DosmesosPROC$BENDNI.y & is.na(DosmesosPROC$BENDNI.y)==FALSE & is.na(DosmesosPROC$BENDNI.x)==FALSE,]

Baixes<-DosmesosDNI[is.na(DosmesosDNI$NOPRDB.y)==TRUE,]
Baixes<-Baixes[,1:9]
names(Baixes)<-c("CARTE", "NOPRDB", "BENDNI", "CATIRC", "ALTCAR", "GN", "IMPORD", "NOPSAP", "END")
Baixes<-anti_join(Baixes,VarienDNI,by="NOPRDB")

# Prenem històric_baixes
names(historic_baixes)[9]<-"NOPRDB"    
historic_baixes$BENDNI<-as.character(historic_baixes$BENDNI)
Baixes_info<-left_join(Baixes,historic_baixes,by=c("NOPRDB","BENDNI"))
retinguts<-Baixes_info[is.na(Baixes_info$IMPORD.y)==TRUE,] # Retinguts: DNIs que desapareixen però no en tenim info al fitxer de baixes
# retinguts<-retinguts[,1:9] 
# levels(retinguts$CATIRC)<-c("AP", "ARP", "CDP", "ADI", "ADS", "PVN") 

Baixes_info<-Baixes_info[is.na(Baixes_info$IMPORD.y)==FALSE,] # traiem de baixes info els que estan en situació RETINGUDA
Baixes_info$MOTEST<-as.numeric(Baixes_info$MOTEST)
Baixes_info$DATFI<-as.Date(as.character(Baixes_info$DATFI), format="%Y%m%d")
Baixes_info$CADTST<-as.Date(as.character(Baixes_info$CADTST), format="%Y%m%d")

# ============================================================================#
# FITXER BAIXES AMB ELS IMPORTS ORDINARIS ASSOCIATS A LES BAIXES =============#
# ============================================================================#

# --------------------------------------------------------------------------------------------------#

if(exists("imports_baixes")==FALSE){
  imports_baixes<-data.frame(nombre_baixes=numeric(0), import_baixes=numeric(0))  
}
imports_baixes[as.character(avui),"nombre_baixes"]<-nrow(Baixes_info[Baixes_info$CATIRC=="VETLLADOR NO PROFESSIONAL",])
imports_baixes[as.character(avui),"import_baixes"]<-sum(Baixes_info[Baixes_info$CATIRC=="VETLLADOR NO PROFESSIONAL","IMPORD.x"])

# --------------------------------------------------------------------------------------------------#


# ============================================================================#
# NETEJAR I GUARDAR DADES D'IMPORT_BAIXES EN UN WORKSPACE  ===================#
# ============================================================================#

rm(list=setdiff(ls(), "imports_baixes"))
setwd("C:/xampp/htdocs/GestioDeute/scripts/")
save.image("importsbaixes.RData")
