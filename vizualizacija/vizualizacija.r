# 3. faza: Vizualizacija podatkov
starostne.skupine.regije <- right_join(starostne.skupine.regije, starostne.skupine.regije %>% group_by(regije, leto) %>% summarise(skupaj=sum(stevilo)))

#primerjava po regijah
tabela4 <- right_join(nastali.odpadki.regije, starostne.skupine.regije[c(1,2,5)] %>% filter(leto %in% 2010:2017))
tabela4$kg_na_pre <- tabela4$tone * 1000 / tabela4$skupaj

graf.nastali.regije <- ggplot(tabela4 %>% filter(regije != "Slovenija")) + aes(x=leto, y=kg_na_pre, group=regije, color=regije) + geom_line()
graf.loceni.regije <- ggplot(loceni.odpadki.regije %>% filter(regije != "Slovenija")) + aes(x=leto, y=delez, group=regije, color=regije) + geom_line()

graf.odpadki.regije.2010 <- ggplot(tabela4%>% filter(regije != 'Slovenija', leto == 2010)) + 
  aes(x=regije, y=kg_na_pre) + geom_col() + xlab("Statistične regije") + ylab("Nastali odpadki (kg na prebivalca)") +
  ggtitle("Stolpični diagram nastalh odpadkov v letu 2010 za statistične regije Slovenije") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))

graf.odpadki.regije.2017 <- ggplot(tabela4 %>% filter(regije != 'Slovenija', leto == 2017)) + 
                                      aes(x=regije, y=kg_na_pre) + geom_col() + 
                                      xlab("Statistične regije") + ylab("Nastali odpadki (kg na prebivalca)") + 
                                      ggtitle("Stolpični diagram nastalh odpadkov v letu 2017 za statistične regije Slovenije") +  
                                      theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))

graf.loceni.odpadki.regije.2002 <- ggplot(loceni.odpadki.regije %>% filter(regije != 'Slovenija', leto == 2002)) + 
  aes(x=regije, y=delez) + geom_col() + theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))
graf.loceni.odpadki.regije.2017 <- ggplot(loceni.odpadki.regije %>% filter(regije != 'Slovenija', leto == 2010)) + 
  aes(x=regije, y=delez) + geom_col() + theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))

#graf prikazuje kako se je povečalo ločevanje odpadkov za specifične vrste odpadkov 
graf.locevanje.skozi.leta <- ggplot(vrsta.odpadkov %>% filter(vrsta_odpadkov %in% c("drugo", "embalaza", "papir", "steklo"))) +
   aes(x=leto, y=tone/1000, group=vrsta_odpadkov, colour=vrsta_odpadkov) + geom_line()

#graf povezave med izobrazenostjo in locevanjem odpadkov
tabela1 <- right_join(izobrazba.regije, loceni.odpadki.regije %>% filter(leto == 2002))
tabela1 <- right_join(tabela1, starostne.skupine.regije[c(1,2,5)]%>%filter(leto==2002))
tabela1$delez_izobr <- tabela1$stevilo / tabela1$skupaj

graf.izobazba.in.locevanje <- ggplot(tabela1) + geom_point(aes(x=delez_izobr, y=delez, color=izobrazba))

#grafi povezanosti starosti in ločevanja odpadkov
tabela2 <- starostne.skupine.regije %>% mutate(delez_sta = stevilo / skupaj)

graf.starost.in.locevanje.starejsi <- ggplot(right_join(tabela2, loceni.odpadki.regije)%>%filter(starostna_skupina=="65+")) + aes(x=delez_sta , y=delez) + geom_point(aes(color=leto)) + geom_smooth()
graf.starost.in.locevanje.odrasli <- ggplot(right_join(tabela2, loceni.odpadki.regije)%>%filter(starostna_skupina=="15-64")) + aes(x=delez_sta , y=delez) + geom_point(aes(color=leto)) + geom_smooth()
graf.starost.in.locevanje.2017 <- ggplot(right_join(tabela2, loceni.odpadki.regije) %>% filter(starostna_skupina=="65+", leto == 2017)) + aes(x=delez_sta , y=delez) + geom_point() + geom_smooth()

#graf povezanosti starosti in nastalih odpadkov
graf.starost.in.nastali.odrasli <- ggplot(right_join(tabela2 %>% filter(leto %in% 2010:2017), nastali.odpadki.regije)) + aes(x=delez_odr , y=tone) + geom_point(aes(color = regije)) + geom_smooth()

#grafi povezansti investicij in ločevanja odpadkov
graf.investicije.in.locevanje <- ggplot(right_join(investicije.regije %>% filter(leto %in% 2002:2016), loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije != "Slovenija", delez_regionalnega_BDP < 5)) +
  aes(x=delez_regionalnega_BDP , y=delez) + geom_point(aes(color = regije)) + geom_smooth(method = "lm")

tabela3 <- right_join(investicije.regije %>% filter(leto %in% 2002:2016), starostne.skupine.regije[c("regije", "leto","starostna_skupina", "skupaj")] %>% filter(leto %in% 2002:2016, starostna_skupina == "0-14"))
tabela3 <- tabela3 %>% mutate(eur_na_preb = `1000_EUR` * 1000 / skupaj, starostna_skupina = NULL)

graf.investicije.in.locevanje.1000 <- ggplot(right_join(tabela3, loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije != "Slovenija", eur_na_preb < 500)) +
  aes(x=eur_na_preb , y=delez) + geom_point(aes(color=regije)) + geom_smooth()

graf.investicije.in.locevanje.posavska <- ggplot(right_join(tabela3, loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije == "Posavska")) +
  aes(x=eur_na_preb , y=delez) + geom_point() + geom_smooth(method = "lm")

graf.investicije.in.locevanje.savinjska <- ggplot(right_join(investicije.regije %>% filter(leto %in% 2002:2016), loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije == "Savinjska", delez_regionalnega_BDP < 5)) +
  aes(x=delez_regionalnega_BDP , y=delez, group=1) + geom_point() + geom_path() + annotate("label", x=c(0.5, 2, 3.25, 0.4), y=c(15, 25, 50, 65), label=c("2002", "2009", "2012", "2016"))


# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", mapa = "zemljevid_Slovenije", encoding = "UTF-8")
zemljevid$NAME_1 <- c("Gorenjska", "Goriska","Jugovzhodna_Slovenija", "Koroska", "Primorsko-notranjska", "Obalno-kraska", "Osrednjeslovenska", "Podravska", "Pomurska", "Savinjska", "Posavska", "Zasavska")

zemljevid <- fortify(zemljevid)         
