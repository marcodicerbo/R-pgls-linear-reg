# regressione lineare
rnorm(40)->x # generiamo distribuzioni normali random 
rnorm(40)->y
hist(x)
hist(y)
plot(x,y)
reg<- lm(y~x) # variabile dipendente contro variabile indipendente, restituisce l'intercetta (q) e il coeff.angolare(mx)
# la significatività dipende da quanto i punti sono vicini alla retta di regressione e dalla pendenza (x è un buon descrittore di y)
# r^2= quanto la regressione spiega la variazione di y, ovvero la distanza dei punti dalla retta, di solito il valore deve essere 
# maggiore di 0.3, anche se quando si hanno tanti punti deve essere più grande
# l'H0 è che la slope (x) è uguale a 0

summary(reg)
abline(reg, col="red", lwd=2)

sep_len<- iris$Sepal.Length
sep_wid <- iris$Sepal.Width
hist(sep_len)
hist(sep_wid)
plot(sep_len,sep_wid)
reg2 <- lm(sep_wid~sep_len)
summary(reg2) # R-squared mi dice che la x non è un buon descrittore di y perché ha un valore basso, e anche il coeff.ang non è signif
              # quindi non è un buon modello anche se l'intercetta è significativa
abline(reg2, col="red", lwd=2) 

# likelihood aic per vedere quale modello è migliore, il valore di aic più basso è quello più verosimile ovvero ci dice il modello 
# migliore, quando abbiamo una differenza di almeno 6-7 tra i valori aic dei modelli utilizzo quallo con aic più basso, quando invece 
# la differenza è bassa va preferito il modello più semplice, ad es con meno variabili
# statistica inferenziale: vedo qual è la probabilità a caso; verosimiglianza invece serve a comparare i modelli, perché non posso 
# utilizzare l'r^2 per compararli

#PGLS
# nella regressione lineare epsilon è derivata mentre nella PGLS epsilon viene presa dalla filogenesi e mx e q sono derivate

library(RRphylo)
library(ape)
DataCetaceans$treecet->tree
plot(tree, no.margin = T, cex = .3)
vv <- vcv(tree) # matrice vcv, sulla diagonale ci sono le distanze delle sp dal root dell'albero, mentre nelle altre celle ci sono 
                # i tempi di coevoluzione
vv[1:2,1:2]
DataCetaceans$masscet->mass
DataCetaceans$brainmasscet->brain
treedataMatch(tree,brain)$tree->tree1 #li matchiamo per fare in modo che siano nello stesso ordine
treedataMatch(tree1, mass)$y->mass1
plot(mass1,brain)
summary(lm(brain~mass1))
summary(PGLS_fossil(brain~mass1, tree = tree1))
