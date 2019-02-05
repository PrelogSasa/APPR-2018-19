# 4. faza: Analiza podatkov

#tabela za grupiranje
podatki <- right_join(tabela3[c("regije","leto","eur_na_preb","delez_regionalnega_BDP")] %>% filter(leto == 2015), tabela2[c("regije", "leto", "starostna_skupina", "delez_sta")] %>% filter(starostna_skupina == "0-14", leto == 2015))
podatki$starostna_skupina <- NULL
names(podatki)[5] <- "0-14"
podatki <- right_join(podatki, tabela2[c("regije", "leto", "starostna_skupina", "delez_sta")] %>% filter(starostna_skupina == "15-64", leto == 2015))
podatki$starostna_skupina <- NULL
names(podatki)[6] <- "15-64"
podatki <- right_join(podatki, tabela2[c("regije", "leto", "starostna_skupina", "delez_sta")] %>% filter(starostna_skupina == "65+", leto == 2015)) %>% filter(regije != "Slovenija")
podatki$leto <- NULL
podatki$starostna_skupina <- NULL
row.names(podatki) <- podatki$regije
podatki$regije <- NULL
podatki.norm <- podatki %>% scale()

# graf za grupiranje v shiny

graf.zemljevid <- function(st){
  k <- kmeans(podatki.norm, st, nstart=1000)
  skupine <- data.frame(regije=row.names(podatki.norm), skupine=factor(k$cluster))
  ggplot(right_join(zemljevid,skupine, by=c("NAME_1"="regije"))) + geom_polygon() + 
                      aes(x=long, y=lat, group=group, fill=skupine) + xlab("") + ylab("")

}


#graf za shiny za ločevanje
graf.regije <- function(regija){
  ggplot(loceni.odpadki.regije %>% filter(regije %in% regija)) + aes(x=leto, y=delez, group=regije, color=regije) +
    geom_line() + geom_point()+ xlab("Leto") + ylab("Delež ločenih odpadkov (od nastalih) v %") +
    ggtitle("Graf deleža ločenih odpadkov")
}
