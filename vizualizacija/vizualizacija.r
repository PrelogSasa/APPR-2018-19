# 3. faza: Vizualizacija podatkov
starostne.skupine.regije$skupaj <- apply(starostne.skupine.regije[,3:5], 1, sum)

#primerjava po regijah
tabela4 <- right_join(nastali.odpadki.regije, starostne.skupine.regije[c(1,2,6)] %>% filter(leto %in% 2010:2017))
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
   aes(x=leto, y=tone, group=vrsta_odpadkov, colour=vrsta_odpadkov) + geom_line()

#graf povezave med izobrazenostjo in locevanjem odpadkov
tabela1 <- right_join(izobrazba.regije, loceni.odpadki.regije %>% filter(leto == 2002))
tabela1$stevilo_prebivalcev <- apply(starostne.skupine.regije[1:13,3:5], 1, sum)
tabela1$delez_osn <- tabela1$osnovnosolska / tabela1$stevilo_prebivalcev
tabela1$delez_sre <- tabela1$srednja_izobrazba / tabela1$stevilo_prebivalcev
tabela1$delez_vis <- tabela1$visja_izobrazba / tabela1$stevilo_prebivalcev

graf.izobazba.in.locevanje <- ggplot() + geom_point(aes(x=tabela1$delez_sre, y=tabela1$delez, color="srednješolska")) + geom_smooth(aes(x=tabela1$delez_sre, y=tabela1$delez, color="srednješolska"), method = "lm") +
  geom_point(aes(x=tabela1$delez_vis, y=tabela1$delez, color="višješolska")) + geom_smooth(aes(x=tabela1$delez_vis, y=tabela1$delez, color="višješolska"), method = "lm") + 
  geom_point(aes(x=tabela1$delez_osn, y=tabela1$delez, color="osnovnošolska")) + geom_smooth(aes(x=tabela1$delez_osn, y=tabela1$delez, color="osnovnošolska"), method = "lm")

#grafi povezanosti starosti in ločevanja odpadkov
tabela2 <- starostne.skupine.regije[,1:2]
tabela2$delez_otr <- starostne.skupine.regije$`0-14` / starostne.skupine.regije$skupaj
tabela2$delez_odr <- starostne.skupine.regije$`15-64` / starostne.skupine.regije$skupaj
tabela2$delez_sta <- starostne.skupine.regije$`65+` / starostne.skupine.regije$skupaj

graf.starost.in.locevanje.starejsi <- ggplot(right_join(tabela2, loceni.odpadki.regije)) + aes(x=delez_sta , y=delez) + geom_point(aes(color=leto)) + geom_smooth()
graf.starost.in.locevanje.odrasli <- ggplot(right_join(tabela2, loceni.odpadki.regije)) + aes(x=delez_odr , y=delez) + geom_point(aes(color=leto)) + geom_smooth()
graf.starost.in.locevanje.2017 <- ggplot(right_join(tabela2, loceni.odpadki.regije) %>% filter(leto == 2017)) + aes(x=delez_sta , y=delez) + geom_point() + geom_smooth()

#graf povezanosti starosti in nastalih odpadkov
graf.starost.in.nastali.odrasli <- ggplot(right_join(tabela2 %>% filter(leto %in% 2010:2017), nastali.odpadki.regije)) + aes(x=delez_odr , y=tone) + geom_point(aes(color = regije)) + geom_smooth()

#grafi povezansti investicij in ločevanja odpadkov
graf.investicije.in.locevanje <- ggplot(right_join(investicije.regije %>% filter(leto %in% 2002:2016), loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije != "Slovenija", delez_regionalnega_BDP < 5)) +
  aes(x=delez_regionalnega_BDP , y=delez) + geom_point(aes(color = regije)) + geom_smooth(method = "lm")

tabela3 <- right_join(investicije.regije %>% filter(leto %in% 2002:2016), starostne.skupine.regije[c("regije", "leto", "skupaj")] %>% filter(leto %in% 2002:2016))
tabela3$eur_na_preb <- tabela3$`1000_EUR` * 1000 / tabela3$skupaj

graf.investicije.in.locevanje.1000 <- ggplot(right_join(tabela3, loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije != "Slovenija", eur_na_preb < 500)) +
  aes(x=eur_na_preb , y=delez) + geom_point(aes(color=regije)) + geom_smooth()

graf.investicije.in.locevanje.posavska <- ggplot(right_join(tabela3, loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije == "Posavska")) +
  aes(x=eur_na_preb , y=delez) + geom_point() + geom_smooth(method = "lm")

graf.investicije.in.locevanje.savinjska <- ggplot(right_join(investicije.regije %>% filter(leto %in% 2002:2016), loceni.odpadki.regije %>% filter(leto %in% 2002:2016)) %>% filter(regije == "Savinjska", delez_regionalnega_BDP < 5)) +
  aes(x=delez_regionalnega_BDP , y=delez, group=1) + geom_point() + geom_path()


# Uvozimo zemljevid.

#zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/gpkg/gadm36_SVN_gpkg.zip",
#                             "gadm36_SVN_gpkg", encoding="Windows-1250") %>% fortify()
