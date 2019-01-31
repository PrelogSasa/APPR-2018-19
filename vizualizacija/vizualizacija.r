# 3. faza: Vizualizacija podatkov

graf.odpadki.regije.2010 <- ggplot(nastali.odpadki.regije %>% filter(regije != 'SLOVENIJA', leto == 2010)) + 
  aes(x=regije, y=tone) + geom_col() + 
  xlab("Statistične regije") + ylab("Nastali odpadki (tone)") +
  ggtitle("Stolpični diagram nastalh odpadkov v letu 2010 za statistične regije Slovenije") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))

graf.odpadki.regije.2017 <- ggplot(nastali.odpadki.regije %>% filter(regije != 'SLOVENIJA', leto == 2017)) + 
                                      aes(x=regije, y=tone) + geom_col() + 
                                      xlab("Statistične regije") + ylab("Nastali odpadki (tone)") + 
                                      ggtitle("Stolpični diagram nastalh odpadkov v letu 2017 za statistične regije Slovenije") +  
                                      theme(axis.text.x = element_text(angle = 90, vjust = 0.3, hjust=1))

graf.locevanje.skozi.leta <- ggplot(vrsta.odpadkov %>% filter(vrsta_odpadkov %in% c("1501 EMBALAŽA VKLJUCNO Z LOCENO ZBRANO EMB.", "200101 Papir ter karton in lepenka", "200139 Plastika"))) +
   aes(x=leto, y=tone, group=vrsta_odpadkov, colour=vrsta_odpadkov) + geom_line()

# Uvozimo zemljevid.

zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/gpkg/gadm36_SVN_gpkg.zip",
                             "gadm36_SVN_gpkg", encoding="Windows-1250") %>% fortify()
