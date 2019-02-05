# 4. faza: Analiza podatkov

#tabela za grupiranje
podatki <- right_join(tabela3[c(1,2,4,6)] %>% filter(leto == 2015), tabela2 %>% filter(leto == 2015)) %>% filter(regije != "Slovenija")
podatki$leto <- NULL
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
