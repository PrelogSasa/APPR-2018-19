# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=",", grouping_mark=".")


#Funkcija, ki uvozi podatke iz datoteke T1kolicine_locenih_odpadkov.csv
data1 <- read_csv2("podatki/T1kolicine_locenih_odpadkov.csv", n_max=7, skip=5, na="-", 
                  col_names=c("vrsta odpadkov", 2002:2017),
                    locale=locale(encoding="Windows-1250"))

loceni.odpadki <- melt(data1, id.vars="vrsta odpadkov", measure.vars=names(data1)[-1],
                       variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T2predelava odpadkov(tone).csv
data2 <- read_csv2("podatki/T2predelava odpadkov(tone).csv", skip=5, n_max=9, na=c("-","..."),
                   col_names=c("zbriš","način predelave",2002:2017),
                   locale=locale(encoding="Windows-1250"))

data2 <- data2 %>% select(-"zbriš")

predelava.odpadkov <- melt(data2, id.vars="način predelave", measure.vars=names(data2)[-1],
                          variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T3nastali odpadki po regijah(tone).csv
data3 <- read_csv2("podatki/T3nastali odpadki po regijah(tone).csv", skip=5, n_max=15, 
                   col_names=c("regije", 2010:2017),
                   locale=locale(encoding="Windows-1250"))

nastali.odpadki.regije1 <- melt(data3, id.vars="regije", measure.vars=names(data3)[-1],
                               variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T3nastali odpadki po regijah(na prebivalca).csv
data4 <- read_csv2("podatki/T3nastali odpadki po regijah(na prebivalca).csv", skip=5, n_max=15, 
                   col_names=c("regije", 2002:2017),
                   locale=locale(encoding="Windows-1250"))

nastali.odpadki.regije2 <- melt(data4, id.vars="regije", measure.vars=names(data4)[-1],
                                variable.name="leto", value.name="kg na prebivalca", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T4procent loceno zbranih odpadkov po regijah.csv
data5 <- read_delim("podatki/T4procent loceno zbranih odpadkov po regijah.csv", delim=";", skip=5, n_max=15, 
                   col_names=c("regije", 2002:2017),
                  locale=locale(encoding="Windows-1250",decimal_mark="."))

loceni.odpadki.regije <- melt(data5, id.vars="regije", measure.vars=names(data5)[-1],
                              variable.name="leto", value.name="delež(%)", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T6dijaki po regijah.csv
data8 <- read_csv2("podatki/T6dijaki po regijah.csv", skip=5, n_max=13, 
                   col_names=c("regije", 2007:2017),
                   locale=locale(encoding="Windows-1250"))

izobraba.regije1 <- melt(data8, id.vars="regije", measure.vars=names(data8)[-1],
                         variable.name="leto", value.name="število", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T6diplomanti po regijah.csv
data9 <- read_csv2("podatki/T6diplomanti po regijah.csv", skip=5, n_max=13, 
                   col_names=c("regije", 1999:2017),
                   locale=locale(encoding="Windows-1250"))

data9 <- data9 %>% select(names(data9)[-(2:9)])

izobrazba.regije2 <- melt(data9, id.vars="regije", measure.vars=names(data9)[-1],
                          variable.name="leto", value.name="število", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T6osnovnosolci po regijah.csv
data10 <- read_csv2("podatki/T6osnovnosolci po regijah.csv", skip=5, n_max=15, 
                   col_names=c("regije", 2005:2014),
                   locale=locale(encoding="Windows-1250")) #drgačna imena regij!!



# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
