# Quadres anteriors dels municipis  ==========================================================


#===============================================================================================
if("MUNNOM" %in% colnames(quadrament)){
  municipis<-as.data.frame(quadrament[,c("MUNNOM", "IMPORD", "NOPRDB", "CATIRC")])
  levels(municipis$CATIRC)<-prestcurt
  municipis[is.na(municipis$MUNNOM)==TRUE, "MUNNOM"]<-"NA" # Em sortia un error pel fet que hi ha NA's a municipis! :P
  
  #========== NOMS MUNICIPIS ================================================
  #============================================================================================================
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
  
  # ... # muncom, muncomprov,  etc....
  
# Usuaris totals de cada municipi i percentatge que representa aquest municipi respecte el total
munprest2[,"Total_usuaris"]<-apply(munprest2[,2:7],1,sum)
munprest2[,"percentatge_usuaris"]<-round(100*munprest2[,"Total_usuaris"]/sum(munprest2$Total_usuaris), digits=2)

# Al quadre traurem els municipis més rellevants pel nre d'usuaris (>1%)  
majoritaris<-as.data.frame(munprest2[munprest2[,"percentatge_usuaris"]>=1,])
rownames(majoritaris)<-majoritaris$Municipi
majoritaris$Municipi<-NULL

# Els minoritaris els sumem i els presentem com a "altres"
minoritaris<-munprest2[munprest2[,"percentatge_usuaris"]<1,]
rownames(minoritaris)<-minoritaris$Municipi
minoritaris$Municipi<-NULL

majoritaris["ALTRES",]<-apply(minoritaris,2,sum)
majoritaris<-majoritaris[,1:6]
names(majoritaris)<-paste(names(majoritaris), mes[mes_actual], format(as.yearmon(avui), "%Y"), sep = " ")
majoritaris["Any",]<-as.numeric(format(as.yearmon(avui), "%Y"))
majoritaris<-cbind(majoritaris, rownames(majoritaris))
colnames(majoritaris)[ncol(majoritaris)]<-"Municipi"

############## Tenim el quadre de municipis del mes actual! #################################

# Quadre històric (enganxem amb els mesos anteriors)

if(exists("quadre_munic")==FALSE){
  quadre_munic<-majoritaris
}else{
  quadre_munic<-full_join(quadre_munic, majoritaris, by="Municipi") 
  rownames(quadre_munic)<-quadre_munic$Municipi
}
# GUARDEM EL QUADRE PER LA PÀGINA WEB
quadre_munic2<-quadre_munic
quadre_munic2$Municipi<-NULL
quadre_municT<-as.data.frame(t(quadre_munic2))
names(quadre_municT)<-stri_trans_general(names(quadre_municT),"latin-ascii")

##
for(i in 1:ncol(quadre_municT)){
  if(colnames(quadre_municT)[i]!="PRESTACIO"){
    quadre_municT[,i]<-as.numeric(as.character(quadre_municT[,i]))
  }
}
##
anyactual_M<-quadre_municT[quadre_municT[,"Any"]==format(as.yearmon(avui), "%Y"),]
anyactual_M$Any<-NULL
anyactual_M$PRESTACIO<-NULL
#
# Primer hem de crear les files i dp omplir amb zeros

i<-0
while(i<=11){
  if(is.na(anyactual_M[i*6+1,1])){
    anyactual_M[paste(prestcurt, mes[i+1], sep=" "),]<-rep(0,ncol(anyactual_M))
  } 
  i<-i+1
}
anyactual_Mprint<-as.data.frame(t(anyactual_M))# Quadre municipis de l'any actual

# Taula resum de tots els anys (una "fila" per cada any, aquí 6 columnes per cada any)
Gmun<-aggregate(.~Any+PRESTACIO, quadre_municT, sum, na.rm=TRUE,na.action=NULL)
rownames(Gmun)<-paste(Gmun$PRESTACIO, Gmun$Any, sep=" ")

# Completem la taula "Resum dels anys" de municipis amb zeros si fan falta
if(nrow(Gmun)<30){
  i<-0
  while(i<=4){
    if(is.na(Gmun[i*6+1,1])){
      Gmun[paste(prestcurt, as.numeric(format(avui, "%Y"))-i, sep=" "),]<- rep(0,ncol(Gmun))
      Gmun[paste(prestcurt, as.numeric(format(avui, "%Y"))-i, sep=" "),"Any"]<-as.numeric(format(avui, "%Y"))-i
      Gmun[paste(prestcurt, as.numeric(format(avui, "%Y"))-i, sep=" "),"PRESTACIO"]<-prestcurt
    }
    i<-i+1
  }
} else {
  Gmun<-Gmun[Gmun[,"Any"]>=(as.numeric(format(as.yearmon(avui), "%Y")))-4,]
}
Gmun<-Gmun[order(Gmun$PRESTACIO),]
Gmun$PRESTACIO<-NULL
Gmun2<-as.data.frame(t(Gmun)) 
colnames(Gmun2)<-Gmun2["Any",]
Gmun2<-Gmun2[-1,]
# ====================



} else{ # ===== Segona opció: no tenim info de municipis
  u_comarques2<-data.frame()
  u_provin<-data.frame()
  write.csv(u_comarques2,"A5.1p_usuaris_comarca.csv", fileEncoding = "UTF-8")
  write.csv(u_provin,"A5.2p_usuaris_província.csv", fileEncoding = "UTF-8")
  anyactual_Mprint<-data.frame()
  
  if(exists("quadre_munic")){ # (Pot ser que no tinguem info de municipis però que hi hagi una taula guardada a l'històric)
    quadre_munic2<-quadre_munic
    quadre_munic2$Municipi<-NULL
    quadre_municT<-as.data.frame(t(quadre_munic2))
    
    names(quadre_municT)<-stri_trans_general(names(quadre_municT),"latin-ascii")
    Gmun<-aggregate(.~Any+PRESTACIO, quadre_municT, sum, na.rm=TRUE,na.action=NULL)
    rownames(Gmun)<-paste(Gmun$PRESTACIO, Gmun$Any, sep=" ")
    
    if(nrow(Gmun)<30){
      if(mes_actual==1){
        Gmun[paste(prestcurt, as.numeric(format(avui, "%Y")), sep=" "),]<- rep(0,ncol(Gmun))
        Gmun[paste(prestcurt, as.numeric(format(avui, "%Y")), sep=" "),"Any"]<-as.numeric(format(avui, "%Y"))
        Gmun[paste(prestcurt, as.numeric(format(avui, "%Y")), sep=" "),"PRESTACIO"]<-prestcurt
      }
    } else {
      Gmun<-Gmun[Gmun[,"Any"]>=(as.numeric(format(as.yearmon(avui), "%Y")))-4,]
    }
    
    Gmun<-Gmun[order(Gmun$PRESTACIÓ),]
    Gmun$Any<-NULL
    Gmun$PRESTACIÓ<-NULL
    Gmun2<-as.data.frame(t(Gmun))
    
  }else{  
    Gmun2<-data.frame()
  }
}
setwd("C:/xampp/htdocs/GestioDeute/scripts/any")
nomMUN<-paste("Municipis ",format(avui, "%Y"), ".csv", sep="")
write.csv(anyactual_M,"Municipi.csv", fileEncoding="utf8")     
write.csv(anyactual_M,nomMUN, fileEncoding="utf8")  
write.csv(Gmun2,"Gmun.csv", fileEncoding="utf8")






#============================================================================================================