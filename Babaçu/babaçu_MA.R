﻿getwd()
setwd('C:/Users/Melquias/Desktop/OMT/Babaçu/') # definindo diretorio de trabalho
library(tidyr)
library(ggplot2)
library(dplyr)
library(stringr)
library(geobr) #Forma do mapa(estado subdividio em municipios)
library(maps) #parametros de mapa
library(sf)
library(cartography) #plot do Mapa





rm(list = ls()) #limpando memoria

extra <- read.csv2('Babaçu_municipios.csv',
                     sep =",",
                     skip = 4, 
                     stringsAsFactors = F,
                     encoding = 'UTF-8') # lendo o arquivo
#vamo limpar o nosso dataframe
for(i in 2:ncol(extra)){ #percorrendo em colunas DF
  extra[,i] <- gsub('\\...', '0', extra[,i])  #troca "..." por "0"
   extra[,i] <- gsub('[-]', '0', extra[,i])   #troca " - " por "0"

}
for(i in 1:ncol(extra)){ #percorre em colunas DF
  extra[,i] <- gsub(' [(]MA[)]', '', extra[,i]) # retira "(MA)"  coloca subistitui por espaço
}
View(extra)
##Remover linhas que contém 0
#row_sub = apply(extra, 1, function(row) all(row !=0 ))
##Subset as usual
#extra<-extra[row_sub,]


extra<-extra[2:218,] #delimitando o DF

 for(i in 2:ncol(extra)){ #percorrendo em colunas
  extra[,i] <- as.integer(extra[,i])   # trasnformando em inteiros
} 
nomes_colunas <- c ('Municípios',2014,2015,2016,2017,2018) #criando um array com novos nomes para as colunas
colnames(extra) <- nomes_colunas # aplicando as alteraçoes nos nomes das colunas colunas

#separando nossos dados por Anos
View(extra)
Babaçu_2014<-extra[,1:2]
Babaçu_2015<-extra[,c(1,3)]
Babaçu_2016<-extra[,c(1,4)]
Babaçu_2017<-extra[,c(1,5)]
Babaçu_2018<-extra[,c(1,6)]

#verificando infomrçoes estatisticas sobre  nosso DF
statistic14<-summary(Babaçu_2014)
statistic15<-summary(Babaçu_2015)
statistic16<-summary(Babaçu_2016)
statistic17<-summary(Babaçu_2017)
statistic18<-summary(Babaçu_2018)
View(statistic14)
View(statistic15)
View(statistic16)
View(statistic17)
View(statistic18)


#  Criando o Mapa 2014====================================================================================

shape_mun_pc_2014 <- read_municipality(code_muni = 'MA', year = 2018) # baixando e lendo o formato
Babaçu_2014$Municípios<-str_to_upper(Babaçu_2014$Municípios) #colonado as colunas em caia alta para igualar os dados que serão comparados
shape_mun_pc_2014$name_muni<-str_to_upper(shape_mun_pc_2014$name_muni)#colonado as colunas em caia alta para igualar os dados que serão comparados

shape_mun_pc_2014 <- right_join(shape_mun_pc_2014,Babaçu_2014, by = c('name_muni' = 'Municípios')) # juntando os dados



sizes <- getFigDim(x = shape_mun_pc_2014, width = 1080, height = 1080, mar = c(0,0,1.2,0)) #definindo propriedades das nossas imagens
# exportando o mapa como .PNG
par(mar = c(0,0,1.2,0))
png(filename = "babaçu_2014.png", width = sizes[1], height = sizes[2])
# shape
plot(st_geometry(shape_mun_pc_2014), col = "white", border = "white", bg = "white") #paramentos da imagem
title(main = list("Produção de Babaçu no Maranhão 2014"
                 , cex = 2.5)) #titulo do Mapa
#  tipo de contorno
box()
# mapas coropléticos
choroLayer(
   x = shape_mun_pc_2014, #dados que serão utilizados
   var = "2014", #variavel de daos inserida no mapa
   method = "arith",
   nclass = 5,
   col = carto.pal(pal1 = "red.pal", n1 =5), #parametros de cor
   breaks = c(1, 1000,2000, 3000, 4000, 5500), #intervalos de legenda
   legend.title.txt = "Produção em toneladas", #titulo da legenda
   #parametros de tamanho da legenda
   legend.values.rnd = 2.5, 
   legend.title.cex = 1.8,
   legend.values.cex = 2,
   #posição da legenda
   legend.pos = "topleft",
   legend.nodata = 'sem dados',#definindo padrão para "NA"
   add = TRUE)
   #textos de fonte
text(x = -48.75515, y=  -10.26176, cex = 1.8, adj = 0, font = 3,  labels =
"Fonte: IBGE - Produção da Extração Vegetal e da Silvicultura\nElaboração: OMT-MA")
# norte
#posicionando Rosa dos Ventos
north(pos = "topright")
# escala
#map.scale(x = -43.1000, y = -9.84000, relwidth=0.15, ratio=FALSE)
dev.off()
View(shape_mun_pc_2016)

#  Criando o Mapa 2015====================================================================================

shape_mun_pc_2015 <- read_municipality(code_muni = 'MA', year = 2018) # baixando e lendo o formato
Babaçu_2015$Municípios<-str_to_upper(Babaçu_2015$Municípios) #colonado as colunas em caixa alta para igualar os dados que serão comparados
shape_mun_pc_2015$name_muni<-str_to_upper(shape_mun_pc_2015$name_muni)#colonado as colunas em caixa alta para igualar os dados que serão comparados

shape_mun_pc_2015 <- right_join(shape_mun_pc_2015,Babaçu_2015, by = c('name_muni' = 'Municípios')) # juntando os dados



sizes <- getFigDim(x = shape_mun_pc_2015, width = 1080, height = 1080, mar = c(0,0,1.2,0)) #definindo propriedades das nossas imagens
# exportando o mapa como .PNG
par(mar = c(0,0,1.2,0))
png(filename = "babaçu_2015.png", width = sizes[1], height = sizes[2])
# shape
plot(st_geometry(shape_mun_pc_2015), col = "white", border = "white", bg = "white") #paramentos da imagem
title(main = list("Produção de Babaçu no Maranhão 2015"
                 , cex = 2.5)) #titulo do Mapa
#  tipo de contorno
box()
# mapas coropléticos
choroLayer(
   x = shape_mun_pc_2015, #dados que serão utilizados
   var = "2015", #variavel de daos inserida no mapa
   method = "arith",
   nclass = 5,
   col = carto.pal(pal1 = "red.pal", n1 =5), #parametros de cor
   breaks = c(1, 1000,2000, 3000, 4000, 5500), #intervalos de legenda
   legend.title.txt = "Produção em toneladas", #titulo da legenda
   #parametros de tamanho da legenda
   legend.values.rnd = 2.5, 
   legend.title.cex = 1.8,
   legend.values.cex = 2,
   #posição da legenda
   legend.pos = "topleft",
   legend.nodata = 'sem dados',#definindo padrão para "NA"
   add = TRUE)
   #textos de fonte
text(x = -48.75515, y=  -10.26176, cex = 1.8, adj = 0, font = 3,  labels =
"Fonte: IBGE - Produção da Extração Vegetal e da Silvicultura\nElaboração: OMT-MA")
# norte
#posicionando Rosa dos Ventos
north(pos = "topright")
# escala
#map.scale(x = -43.1000, y = -9.84000, relwidth=0.15, ratio=FALSE)
dev.off()
#  Criando o Mapa 2016====================================================================================

shape_mun_pc_2016 <- read_municipality(code_muni = 'MA', year = 2018) # baixando e lendo o formato
Babaçu_2016$Municípios<-str_to_upper(Babaçu_2016$Municípios) #colonado as colunas em caixa alta para igualar os dados que serão comparados
shape_mun_pc_2016$name_muni<-str_to_upper(shape_mun_pc_2016$name_muni)#colonado as colunas em caixa alta para igualar os dados que serão comparados

shape_mun_pc_2016 <- right_join(shape_mun_pc_2016,Babaçu_2016, by = c('name_muni' = 'Municípios')) # juntando os dados



sizes <- getFigDim(x = shape_mun_pc_2016, width = 1080, height = 1080, mar = c(0,0,1.2,0)) #definindo propriedades das nossas imagens
# exportando o mapa como .PNG
par(mar = c(0,0,1.2,0))
png(filename = "babaçu_2016.png", width = sizes[1], height = sizes[2])
# shape
plot(st_geometry(shape_mun_pc_2016), col = "white", border = "white", bg = "white") #paramentos da imagem
title(main = list("Produção de Babaçu no Maranhão 2016"
                 , cex = 2.5)) #titulo do Mapa
#  tipo de contorno
box()
# mapas coropléticos
choroLayer(
   x = shape_mun_pc_2016, #dados que serão utilizados
   var = "2016", #variavel de daos inserida no mapa
   method = "arith",
   nclass = 5,
   col = carto.pal(pal1 = "red.pal", n1 =5), #parametros de cor
   breaks = c(1, 1000,2000, 3000, 4000, 5500), #intervalos de legenda
   legend.title.txt = "Produção em toneladas", #titulo da legenda
   #parametros de tamanho da legenda
   legend.values.rnd = 2.5, 
   legend.title.cex = 1.8,
   legend.values.cex = 2,
   #posição da legenda
   legend.pos = "topleft",
   legend.nodata = 'sem dados',#definindo padrão para "NA"
   add = TRUE)
   #textos de fonte
text(x = -48.75515, y=  -10.26176, cex = 1.8, adj = 0, font = 3,  labels =
"Fonte: IBGE - Produção da Extração Vegetal e da Silvicultura\nElaboração: OMT-MA")
# norte
#posicionando Rosa dos Ventos
north(pos = "topright")
# escala
#map.scale(x = -43.1000, y = -9.84000, relwidth=0.15, ratio=FALSE)
dev.off()
#  Criando o Mapa 2017====================================================================================

shape_mun_pc_2017 <- read_municipality(code_muni = 'MA', year = 2018) # baixando e lendo o formato
Babaçu_2017$Municípios<-str_to_upper(Babaçu_2017$Municípios) #colonado as colunas em caixa alta para igualar os dados que serão comparados
shape_mun_pc_2017$name_muni<-str_to_upper(shape_mun_pc_2017$name_muni)#colonado as colunas em caixa alta para igualar os dados que serão comparados

shape_mun_pc_2017 <- right_join(shape_mun_pc_2015,Babaçu_2017, by = c('name_muni' = 'Municípios')) # juntando os dados



sizes <- getFigDim(x = shape_mun_pc_2017, width = 1080, height = 1080, mar = c(0,0,1.2,0)) #definindo propriedades das nossas imagens
# exportando o mapa como .PNG
par(mar = c(0,0,1.2,0))
png(filename = "babaçu_2017.png", width = sizes[1], height = sizes[2])
# shape
plot(st_geometry(shape_mun_pc_2015), col = "white", border = "white", bg = "white") #paramentos da imagem
title(main = list("Produção de Babaçu no Maranhão 2017"
                 , cex = 2.5)) #titulo do Mapa
#  tipo de contorno
box()
# mapas coropléticos
choroLayer(
   x = shape_mun_pc_2017, #dados que serão utilizados
   var = "2017", #variavel de daos inserida no mapa
   method = "arith",
   nclass = 5,
   col = carto.pal(pal1 = "red.pal", n1 =5), #parametros de cor
   breaks = c(1, 1000,2000, 3000, 4000, 5500), #intervalos de legenda
   legend.title.txt = "Produção em toneladas", #titulo da legenda
   #parametros de tamanho da legenda
   legend.values.rnd = 2.5, 
   legend.title.cex = 1.8,
   legend.values.cex = 2,
   #posição da legenda
   legend.pos = "topleft",
   legend.nodata = 'sem dados',#definindo padrão para "NA"
   add = TRUE)
   #textos de fonte
text(x = -48.75515, y=  -10.26176, cex = 1.8, adj = 0, font = 3,  labels =
"Fonte: IBGE - Produção da Extração Vegetal e da Silvicultura\nElaboração: OMT-MA")
# norte
#posicionando Rosa dos Ventos
north(pos = "topright")
# escala
#map.scale(x = -43.1000, y = -9.84000, relwidth=0.15, ratio=FALSE)
dev.off()
