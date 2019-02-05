# Analiza podatkov s programom R, 2018/19

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/PrelogSasa/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/PrelogSasa/APPR-2018-19/master?urlpath=rstudio) RStudio

## Analiza odlaganja odpadkov v Sloveniji

V svojem projektu si bom ogledala odlaganje odpadkov in ravnanje z njimi skozi leta v Sloveniji. Primerjala bom statistične regije po količini odpadkov na prebivalca in po tem koliko jih ločujejo. Poskusila bom poiskati povezave med starostjo in izobraženostjo prebivalcev ter količino odpadkov, ki jih ločijo. Rada bi našla tudi povezave med vlaganjem regij v varovanje okolja in količino proizvedenih odpadkov, ter količino ločenih odpadkov.

Moj cilj je prikazati, da večja izobraženost in vlaganje v varovanje okolja spreminjajo, kako ravnamo z odpadki.

* vrsta.odpadkov: Nastale količine komunalnih odpadkov glede na vrsto odpadkov: vrsta_odpadkov, leto, tone
* predelava.odpadkov: Količina komunalnih odpadkov glede na način predelave: nacin_predelave, leto, tone
* nastali.odpadki.regije: Količina nastalih odpadkov v tonah po regijah: regije, leto, tone
* loceni.odpadki.regije: Procent  (od nastalih) ločeno zbranih odpadkov po regijah: regije, leto, delez
* investicije.regije: Investicije v boljše ravnanje z odpadki po regijah: regije, leto, 1000_EUR, delez_regionalnega_BDP
* izobrazba.regije: Izobrazba po regijah (iz 2002): regije, stevilo, izobrazba
* starostne.skupine.regije: Starostne skupine po regijah: regije, leto, stevilo, starostna_skupina

Vir podatkov: [SURS](https://pxweb.stat.si/pxweb/Database/Okolje/Okolje.asp)

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
