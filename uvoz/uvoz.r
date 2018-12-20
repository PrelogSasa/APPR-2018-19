# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi občine iz Wikipedije
#uvozi.obcine <- function() {
#  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
#  stran <- html_session(link) %>% read_html()
#  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
#    .[[1]] %>% html_table(dec=",")
#  for (i in 1:ncol(tabela)) {
#    if (is.character(tabela[[i]])) {
#      Encoding(tabela[[i]]) <- "UTF-8"
#    }
#  }
#  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
#                        "ustanovitev", "pokrajina", "regija", "odcepitev")
#  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#    tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
#  }
#  for (col in c("obcina", "pokrajina", "regija")) {
#    tabela[[col]] <- factor(tabela[[col]])
#  }
#  return(tabela)
#}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#uvozi.druzine <- function(obcine) {
#  data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
#                    locale=locale(encoding="Windows-1250"))
#  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#    strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
#  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
#  data <- data %>% melt(id.vars="obcina", variable.name="velikost.druzine",
#                        value.name="stevilo.druzin")
#  data$velikost.druzine <- parse_number(data$velikost.druzine)
#  data$obcina <- factor(data$obcina, levels=obcine)
#  return(data)
#}

#Funkcija, ki uvozi podatke iz datoteke T1kolicine_locenih_odpadkov.csv
data1 <- read_csv2("podatki/T1kolicine_locenih_odpadkov.csv", n_max=7, skip=5, na="-", 
                  col_names=c("vrsta odpadkov", 2002:2017),
                    locale=locale(encoding="Windows-1250"))

loceni.odpadki <- melt(data1, id.vars="vrsta odpadkov", measure.vars=names(data)[-1],
                       variable.name="leto", value.name="tone")

#Funkcija, ki uvozi podatke iz datoteke T2predelava odpadkov(tone).csv
data2 <- read_csv2("podatki/T2predelava odpadkov(tone).csv", skip=5, n_max=9, na=c("-","..."),
                   col_names=c("zbriš","način predelave",2002:2017),
                   locale=locale(encoding="Windows-1250"))

data2 <- data2 %>% select(-"zbriš")

predelava.odpadkov <- melt(data2, id.vars="način predelave", measure.vars=names(data)[-1],
                          variable.name="leto", value.name="tone")



# Zapišimo podatke v razpredelnico obcine
#obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
