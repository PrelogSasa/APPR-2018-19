# 4. faza: Analiza podatkov

#tabela za grupiranje
podatki <- right_join(tabela3[c(1,2,4,6)] %>% filter(leto == 2016), tabela1[c(1,8,9,10)])
podatki <- right_join(podatki, tabela2 %>% filter(leto == 2016)) %>% filter(regije != "Slovenija")
podatki$leto <- NULL
row.names(podatki) <- podatki$regije
podatki$regije <- NULL
podatki.norm <- podatki %>% scale()

# graf za grupiranje v shiny

graf.zemljevid <- function(st){
  k <- kmeans(podatki.norm, st, nstart=1000)
  skupina <- data.frame(regije=row.names(podatki.norm), skupina=factor(k$cluster))
  #ggplot(right_join(zemljevid,skupina, by=c(""="regije"))) + geom_polygon() + 
  #                    aes(x=long, y=lat, group=group, fill=skupina) + xlab("") + ylab("")
  #fejk graf ker zemljevid ni uvozen
  ggplot(right_join(tabela2, loceni.odpadki.regije)) + aes(x=delez_sta , y=delez) + geom_point()
}


#graf za shiny za ločevanje
graf.regije <- function(regija){
  ggplot(loceni.odpadki.regije %>% filter(regije %in% regija)) + aes(x=leto, y=delez, group=regije, color=regije) +
    geom_line() + geom_point()+ xlab("Leto") + ylab("Delež ločenih odpadkov (od nastalih) v %") +
    ggtitle("Graf deleža ločenih odpadkov")
}
