###############################
##########   PAKETS    ########
###############################

suppressMessages(library(rowr)) # cbind.fill
suppressMessages(library(readxl))
suppressMessages(library(mondate))
suppressMessages(library(lubridate))
suppressMessages(library(zoo))
suppressMessages(library("forecast"))
suppressMessages(library(plotly))

# Unes funcions inicials ============================================#

LastDayInMonth <- function(dates) {
  dates <- as.POSIXlt(dates)
  dates$mday <- 1
  dates$mon <- dates$mon + 1
  next.year <- dates$mon > 11
  if (any(next.year)) {
    dates$mon[next.year] <- 0
    dates$year[next.year] <- dates$year[next.year] + 1
  }
  dates <- as.Date(dates) - 1
  return(dates)
}
number_of_months <- function(date1,date2){
  a<- (as.yearmon(date2)-
         as.yearmon(date1))*12
  return(a)
}
number_of_day<-function(date1,date2){
  a<-difftime(date2,date1, units="days")
  return(a)
}
LastDayInYear <- function(x) floor_date(x, "year")

###########################################
##########   Càrrega de dades    ##########
###########################################

#carpeta<-"C:/Users/agrenzne/Documents/GestioDeute (DEP)/Escenaris/" # (serà uploads)
# carpeta<-"C:/Users/ccomasga/Documents/ICASS/Gestió/Escenaris"
# path_historic<-"C:/xampp/htdocs/GestioDeute/scripts"
# c_scripts<-paste0(carpeta,"scripts")
carpeta<-"C:/xampp/htdocs/GestioDeute_w10/scripts/escenaris/necesitem"
setwd(carpeta)
quadrament<-as.data.frame(read_excel("quadrament.xlsx", sheet=1, range =cell_cols("L:S"), na="")) # EXCEL en XLSX 
quadrament<-quadrament[quadrament$CATIRC=="PVN",c("GRAU", "IMPORD")]

nous<-as.data.frame(read_excel("24 T 18062018.xls", sheet=1, na=""))
nous$DATEFE<-as.Date(as.character(nous$DATEFE), format="%Y%m%d")
nous$CADTST<-as.Date(as.character(nous$CADTST), format="%Y%m%d")

dades<-nous[nous$PRESTACIO=='PVN',c("CARTE","EXPTI","EXPANY","EXPNUM", "PRESTACIO", "DATEFE", "CADTST", "IMPORD")]
rm(nous)

#setwd(path_historic)
load("historic_anna_w7.Rdata")
TotalVNP<-as.data.frame(TotalP[, "VNP ordinària"]) # Total ordinàries
rownames(TotalVNP)<-rownames(TotalP)
colnames(TotalVNP)<-"Total ord"

baixes<-imports_baixes
rm(imports_baixes)

# usuaris<-historicPVN[34:nrow(historicPVN),c("Grau 3", "Grau 2", "Grau 1", "Any")] # Però què passa mentre hi ha graus i nivells intermitjos ? El nre total d'usuaris no canviarà...
# rownames(usuaris)<-usuaris$Any
# usuaris$Any<-NULL

rm(BAM, comarques, historic, historicPVN, provin, Resum, TotalP, prestllarg, prestcurt, haz.cero.na)

args <- commandArgs(TRUE)
write.table(args,"args.txt")
a<-unlist(strsplit(args, ";"))
N<-as.numeric(a[1])
per<-as.numeric(a[2])

#rel=3
#N= 17


# Sobrecost per un augment de l'import ==============================================#

# 1) Definim els nivells (revisar criteris)
quadrament[quadrament$`G-N`=="3-1" | quadrament$`G-N`=="3-2" | quadrament$`G-N`=="3-9", "GRAU"]<-3
quadrament[quadrament$`G-N`=="2-1" | quadrament$`G-N`=="2-2" | quadrament$`G-N`=="2-9", "GRAU"]<-2
quadrament[quadrament$`G-N`=="1-1" | quadrament$`G-N`=="1-2" | quadrament$`G-N`=="1-9", "GRAU"]<-1
quadrament$`G-N`<-NULL
# Hauríem de calcular l'increment per cadascun dels mesos? ==> SÍ 

##############################################
##########   Posem dades maques ##############
##############################################

# ===================================================================================#
# ====================== FUNCIÓ PER PERÍODES DE CARÈNCIA ============================# 
# ===================================================================================#

# Fem una funció que calcula pressupostos d'altes, noves, baixes per cadascun dels possibles períodes de carència

# Creem noves variables amb les dates que ens interesa
# DATINI_mes  = Data en què ha de començar a cobrar la prestació (Carència=18 mesos)
# avui<- as.mondate(Sys.Date())

avui<-as.mondate("2018-06-18")
lastday_year<-LastDayInYear(as.Date(avui))-1
lastday_year<-as.Date(lastday_year) %m+% years(1)
dies_del_mes<-days_in_month(Sys.Date()) # dies que té el mes (actual)
firstdat_ini<-as.mondate(LastDayInMonth(avui)+1) # primer dia del mes vinent

#N<-18
carencia<-function(N){
  datini<-paste0("DATINI_", N)
  dades[,datini]<-as.mondate(dades$DATEFE) + N
  
  # Dies que s'han de cobrar del primer mes:
  dades[,"dies_mes_ini"]<-number_of_day(dades[,datini], LastDayInMonth(dades[,datini]))
  dades[,"dies_mes_ini_totals"]<-number_of_day(dades[,datini], LastDayInMonth(dades[,datini]))
  
  # Money del mes incial:
  dades[,"money_inimes"]<-(dades[,"dies_mes_ini"])*dades[,"IMPORD"]/days_in_month(as.Date(dades[,datini]))
  ## Mesos fins mes actual/enderreriments:
  # LastDayInMonth(dades$DATINI)+1
  dades[,"mesos_finsavui"]<-number_of_months(as.Date(dades[,datini]),as.Date(avui))
  ## Money fins el dia davui:
  dades[,"money_fins_finalmes"]<-((dades[,"mesos_finsavui"]*dades$IMPORD) + dades$money_inimes) ########?????????
  dades[dades$money_fins_finalmes<0,"money_fins_finalmes"]<-0
  
  # Mesos des d'ara fins acabar l'any
  dades[,"mesos_finalany"]<-number_of_months(as.Date(avui),lastday_year) 

  # Si encara no ha començat a cobrar: els mesos fins final any són els que queden + mesos fins avui (negatiu) 
  dades[dades$mesos_finsavui<0,"mesos_finalany"]<-dades[dades$mesos_finsavui<0,"mesos_finalany"]+dades[dades$mesos_finsavui<0,"mesos_finsavui"] 
  dades[,"money_finalany"]<-dades[,"mesos_finalany"]*dades$IMPORD # pasta total que cobrarà el que queda de l'any actual

  # Si encara no ha començat a cobrar: pasta fins final any + pasta mes inicial (?) 
  dades[dades$mesos_finsavui<0,"money_finalany"]<-dades[dades$mesos_finsavui<0,"money_finalany"]+dades[dades$mesos_finsavui<0,"money_fins_finalmes"]
  dades[dades$money_finalany<0,"money_finalany"]<-0

  ## Money any següent ##
  dades2<-dades[,c("CARTE","EXPTI","EXPANY","EXPNUM","PRESTACIO","DATEFE","CADTST","IMPORD",datini,"money_inimes",
                "money_fins_finalmes","mesos_finalany","money_finalany")]
  dades2[as.yearmon(dades2[,datini])<as.yearmon(avui), "mes0"]<-dades2[as.yearmon(dades2[,datini])<as.yearmon(avui), "IMPORD"] # Si el mes anterior va cobrar pasta
  dades2[as.yearmon(dades2[,datini])==as.yearmon(avui), "mes0"]<-dades2[as.yearmon(dades2[,datini])==as.yearmon(avui),"money_fins_finalmes"] # Si aquest és el primer mes que cobra
  dades2[as.yearmon(dades2[,datini])>as.yearmon(avui), "mes0"]<-0 # Si encara no ha començat a cobrar

  # Relacionar "mes i" amb un mes en yearmon
  # mes0<-as.yearmon(avui)
  # mes1<-as.yearmon(avui+1)
  # mes2<-as.yearmon(avui+2)
  
  for(i in 1:(N-1)){
    dades2[dades2[,paste0("mes", i-1)]!=0, paste0("mes",i)]<-dades2[dades2[,paste0("mes", i-1)]!=0,"IMPORD"]  # Si el mes anterior hi ha import, cobrarà ord.
    dades2[as.yearmon(dades2[,datini])>as.yearmon(avui+i), paste0("mes",i)]<-0 # Si encara no ha de començar a cobrar, import mes_i = 0
    dades2[as.yearmon(dades2[,datini])==as.yearmon(avui+i), paste0("mes",i)]<-dades2[as.yearmon(dades2[,datini])==as.yearmon(avui+i),"money_inimes"] # Si comença a cobrar aquest mes, posem la pasta del mes incial
    dades2[as.yearmon(dades2[,datini])<as.yearmon(avui+i), paste0("mes",i)]<-dades2[as.yearmon(dades2[,datini])<as.yearmon(avui+i),"IMPORD"] # Si ja ha començat a cobrar, a mes_i ha de cobrar l'import ordinari (IMPORD)
  }
  
  # Dades per a guardar (carència = N) ====================================#
  noms<-c(paste0("mes", seq(0, N-1)))
  pressup<-dades2[,noms]
  pressup["TOTAL NOVES",]<-apply(pressup, 2, sum)
  pressup<-as.data.frame(t(pressup["TOTAL NOVES",]))
  mesos<-c()
  for(i in 1:N){
    mesos[i]<-as.character(as.yearmon(avui+i-1))
  }
  rownames(pressup)<-mesos
  
  
  # Previsió fins completar 2 anys =======================================#  (Per ara jo ho deixaria - és més complex que això...)
  # prevN<-as.data.frame(forecast(pressup$`TOTAL NOVES`, h = ifelse(frequency(pressup$`TOTAL NOVES`) > 1, 2 * frequency(pressup$`TOTAL NOVES`), (24-N)),
  #                                level = c(80, 95), fan = FALSE, robust = FALSE, lambda = NULL, biasadj = FALSE, find.frequency = FALSE,
  #                                allow.multiplicative.trend = FALSE, model = NULL))
  # prevN guarda només els valors de la previsió (valors futurs)
  # Podem graficar TOTAL NOVES + previsió fent: 
  # plot(forecast(pressup$`TOTAL NOVES`, h = ifelse(frequency(pressup$`TOTAL NOVES`) > 1, 2 * frequency(pressup$`TOTAL NOVES`), (24-N)),
  #                        level = c(80, 95), fan = FALSE, robust = FALSE, lambda = NULL, biasadj = FALSE, find.frequency = FALSE,
  #                        allow.multiplicative.trend = FALSE, model = NULL))

  # Total actuals -> col. TotalVNP sencera per fer la previsió (Total VNP arriba fins set 2018) però si estem a juny només tindrem dades fins juny...
  plot(forecast(TotalVNP$`Total ord`, h = ifelse(frequency(TotalVNP$`Total ord`) > 1, 2 * frequency(TotalVNP$`Total ord`), N),
                         level = c(80, 95), fan = FALSE, robust = FALSE, lambda = NULL, biasadj = FALSE, find.frequency = FALSE,
                         allow.multiplicative.trend = FALSE, model = NULL))
  
  TotalordN<-as.data.frame(forecast(TotalVNP$`Total ord`, h = ifelse(frequency(TotalVNP$`Total ord`) > 1, 2 * frequency(TotalVNP$`Total ord`), 
                    N),level = c(80, 95), fan = FALSE, robust = FALSE, lambda = NULL, biasadj = FALSE, find.frequency = FALSE,
                    allow.multiplicative.trend = FALSE, model = NULL)) 
  
  # Previsió dels imports de baixes 
  # Baixespred<-as.data.frame(Baixes$`Import baixes`) # No import acumulat, sinó el de cada mes --> si és així es pot treure el càlcul de l'import  acumulat
  # rownames(Baixespred)<-rownames(Baixes)
  BaixesN<-as.data.frame(forecast(baixes$import_baixes, h = ifelse(frequency(baixes$import_baixes) > 1, 2 * frequency(baixes$import_baixes), N), 
                                 level = c(80, 95), fan = FALSE, robust = FALSE, lambda = NULL, biasadj = FALSE, find.frequency = FALSE, 
                                 allow.multiplicative.trend = FALSE, model = NULL)) # és correcte? Em surt una línia recta
  names(BaixesN)<-c("IMPORT BAIXES","Lo 80","Hi 80","Lo 95","Hi 95")

  pressup<-cbind(pressup, BaixesN[,1])
  names(pressup)<-c("TOTAL NOVES","BAIXES")
  pressup1<-cbind(pressup, TotalordN[,1])
  names(pressup1)<-c("NOVES","BAIXES","ORD")
  #names(pressup)<-c("TOTAL NOVES","TOTAL ACTUALS","BAIXES","Lo 80","Hi 80","Lo 95","Hi 95")
  
  # Columna TOTALS
  pressup1[, "PRESSUPOST"]<-pressup1$`NOVES`+pressup1$`ORD`-pressup1$BAIXES

  # Càlcul INTERVALS D'ERROR TOTAL a la manera cutre Anna (pic i pala)
  #pressup$T80<-abs(pressup$BAIXES-pressup$`Lo 80`)
  #pressup$T95<-abs(pressup$BAIXES-pressup$`Lo 95`)
  
  #pressup[,"T_Lo 80"]<-pressup$`PRESSUPOST TOTAL`-pressup$T80
  #pressup[,"T_Hi 80"]<-pressup$`PRESSUPOST TOTAL`+pressup$T80
  #pressup[,"T_Lo 95"]<-pressup$`PRESSUPOST TOTAL`-pressup$T95
  #pressup[,"T_Hi 95"]<-pressup$`PRESSUPOST TOTAL`+pressup$T95
  
  #pressup$T80<-NULL
  #pressup$T95<-NULL
  
  return(pressup1)
}

 N<-17
 per<-3
main<-function(N,per){

  pressup<-carencia(N)
  pressup2<- pressup*(100-per)/100 
  pressupost<-cbind(data.frame(pressup),pressup2)
  pressup2<-pressupost[,c(4,8)]
  names(pressup2)<-c("C_N","C_N_per")

  ara<- carencia(18)
  ara[,2]<-ara[,1]*(100-per)/100 
  ara<-ara[,c(1,2)]
  pol<- cbind.fill(ara, pressup2,fill=NA)
  names(pol)<-c("C18","C18_per","CN","CN_per")
  pressup$Nov_C18<-pol$C18[1:N]
  #rownames(pressup)<- as.Date(rownames(pressup))
  return(list(pressup,pol))
}

rel<-main(N,per) 

##############################################
############## Guardem dades #################
##############################################
carpeta<-"C:/xampp/htdocs/GestioDeute_w10/scripts/escenaris"
setwd(carpeta)
write.csv(as.data.frame(rel[1]),"carencia_N.csv",fileEncoding="utf8")
write.csv(as.data.frame(rel[2]),"rel_N_per.csv",fileEncoding="utf8")



# press<-pressup_18
# press<- pressupost
# 
# press<- main(17,3)
# 
# matplot(press, type = c("l"),pch=1,col = 1:4) #plot
# legend(10,15000000, legend = colnames(press), col=1:4, pch=1) # optional legend
# 
# 
# 









