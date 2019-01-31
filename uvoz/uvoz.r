# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=",", grouping_mark=".")


#Funkcija, ki uvozi podatke iz datoteke T1kolicine_locenih_odpadkov.csv
data1 <- read_csv2("podatki/T1kolicine_locenih_odpadkov.csv", n_max=7, skip=5, na="-", 
                  col_names=c("vrsta_odpadkov", 2002:2017),
                    locale=locale(encoding="Windows-1250"))

data1$vrsta_odpadkov <- c("skupaj", "embalaza", "papir", "steklo", "kuhinjski_odpadki", "plastika", "drugo")

vrsta.odpadkov <- melt(data1, id.vars="vrsta_odpadkov", measure.vars=names(data1)[-1],
                       variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T2predelava_odpadkov-tone.csv
data2 <- read_csv2("podatki/T2predelava_odpadkov-tone.csv", skip=5, n_max=9, na=c("-","..."),
                   col_names=c("zbris","nacin_predelave",2002:2017),
                   locale=locale(encoding="Windows-1250"))

data2 <- data2[,c("nacin_predelave",2002:2017)]

predelava.odpadkov <- melt(data2, id.vars="nacin_predelave", measure.vars=names(data2)[-1],
                          variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T3nastali_odpadki_po_regijah-tone.csv
data3 <- read_csv2("podatki/T3nastali_odpadki_po_regijah-tone.csv", skip=5, n_max=15, 
                   col_names=c("regije", 2010:2017),
                   locale=locale(encoding="Windows-1250"))

data3 <- data3[c(1,3:9,12,13,10,14,15,FALSE,FALSE),]

regije <- c("Slovenija", "Pomurska", "Podravska", "Koroska", "Savinjska", "Zasavska", "Posavska", "Jugovzhodna_Slovenija", "Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska", "Goriska", "Obalno-kraska")

data3$regije <- regije

nastali.odpadki.regije <- melt(data3, id.vars="regije", measure.vars=names(data3)[-1],
                               variable.name="leto", value.name="tone", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T4procent_loceno_zbranih_odpadkov_po_regijah.csv
data5 <- read_delim("podatki/T4procent_loceno_zbranih_odpadkov_po_regijah.csv", delim=";", skip=5, n_max=15, 
                   col_names=c("regije", 2002:2017),
                  locale=locale(encoding="Windows-1250",decimal_mark="."))

data5 <- data5[c(1,3:9,12,13,10,14,15,FALSE,FALSE),]
data5$regije <- regije

loceni.odpadki.regije <- melt(data5, id.vars="regije", measure.vars=names(data5)[-1],
                              variable.name="leto", value.name="delez", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T5investicije_po_regijah-1000eur.csv
data6 <- read_csv2("podatki/T5investicije_po_regijah-1000eur.csv", skip=4, n_max=13, 
                   col_names=c("regije", 2001:2016),
                   locale=locale(encoding="Windows-1250"))

data6$regije <- regije

investicije.regije1 <- melt(data6, id.vars="regije", measure.vars=names(data6)[-1],
                          variable.name="leto", value.name="1000_EUR", na.rm=TRUE)


#Funkcija, ki uvozi podatke iz datoteke T5investicije_za_varstvo_okolja_po_regijah-indeksi_regionalnega_bdp.csv
data7 <- read_delim("podatki/T5T5investicije_za_varstvo_okolja_po_regijah-indeksi_regionalnega_bdp.csv", delim=";", skip=5, n_max=13, 
                    col_names=c("regije", 2001:2016),
                    locale=locale(encoding="Windows-1250",decimal_mark="."))

data7[9:11,] <- data7[c(10,11,9),]
data7$regije <- regije

investicije.regije2 <- melt(data7, id.vars="regije", measure.vars=names(data7)[-1],
                            variable.name="leto", value.name="delez_regionalnega_BDP", na.rm=TRUE)

#Funkcija, ki združi podatke o investicijah v eno tabelo
investicije.regije = data.frame(investicije.regije1, investicije.regije2[3])
names(investicije.regije) = c(names(investicije.regije1), "delez_regionalnega_BDP")

#Funkcija, ki uvozi podatke iz datoteke T6srednja_po_regijah.csv
data8 <- read_csv2("podatki/T6srednja_po_regijah.csv", skip=3, n_max=13, 
                   col_names=c("regije", "srednja_izobrazba"),
                   locale=locale(encoding="Windows-1250"))

#Funkcija, ki uvozi podatke iz datoteke T6visja_po_regijah.csv
data9 <- read_csv2("podatki/T6visja_po_regijah.csv", skip=3, n_max=13, 
                   col_names=c("regije", 1:3 ),
                   locale=locale(encoding="Windows-1250"))

data9["visja_izobrazba"] <- apply(data9[-1], 1, sum)


#Funkcija, ki uvozi podatke iz datoteke T6osnovnosolska po regijah.csv
data10 <- read_csv2("podatki/T6osnovnosolska po regijah.csv", skip=3, n_max=13, 
                   col_names=c("regije","osnovnosolska"),
                   locale=locale(encoding="Windows-1250"))

data10$regije <- regije

#Funkcija, ki združi podatke o izobrazbi v eno tabelo
izobrazba.regije <- data.frame(data10, data8[2], data9[5])
names(izobrazba.regije)[c(3,4)] = c(names(data8[2]), names(data9[5]))

#Funkcija, ki uvozi podatke iz datoteke T7otroci.csv
data11 <- read_csv2("podatki/T7otroci.csv", skip=5, n_max=13, 
                    col_names=c("zbris","regije",2002:2017),
                    locale=locale(encoding="Windows-1250"))

data11 <- data11[,c("regije",2002:2017)]
data11$regije <- regije

starostne.skupine.regije1 <- melt(data11, id.vars="regije", measure.vars=names(data11)[-1],
                              variable.name="leto", value.name="0-14", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T7odrasli.csv
data12 <- read_csv2("podatki/T7odrasli.csv", skip=5, n_max=13, 
                    col_names=c("zbris","regije",2002:2017),
                    locale=locale(encoding="Windows-1250"))

data12 <- data12[,c("regije",2002:2017)]
data12$regije <- regije

starostne.skupine.regije2 <- melt(data12, id.vars="regije", measure.vars=names(data12)[-1],
                                  variable.name="leto", value.name="15-64", na.rm=TRUE)

#Funkcija, ki uvozi podatke iz datoteke T7starejsi.csv
data13 <- read_csv2("podatki/T7starejsi.csv", skip=5, n_max=13, 
                    col_names=c("zbris","regije",2002:2017),
                    locale=locale(encoding="Windows-1250"))

data13 <- data13[,c("regije",2002:2017)]
data13$regije <- regije

starostne.skupine.regije3 <- melt(data13, id.vars="regije", measure.vars=names(data13)[-1],
                                  variable.name="leto", value.name="65+", na.rm=TRUE)

#Funkcija, ki zdruzi podatke o starostnih skupinah v eno tabelo
starostne.skupine.regije = data.frame(starostne.skupine.regije1, starostne.skupine.regije2[3], starostne.skupine.regije3[3])
names(starostne.skupine.regije)[3:5] = c(names(starostne.skupine.regije1[3]), names(starostne.skupine.regije2[3]), names(starostne.skupine.regije3[3]))


