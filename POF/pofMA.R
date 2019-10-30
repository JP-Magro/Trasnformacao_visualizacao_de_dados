﻿getwd()
setwd('C:/Users/Melquias/Desktop/OMT/POF/') #
library(tidyverse)
library(readxl)
library(dplyr)
library(ggthemes)
library(ggplot2)
library(lme4)
library(plotly)
library(tidyr)

rendimento_total_var_patrim_2017_2018 <- read_xlsx("21MA.xlsx",
                            skip = 9,
                            sheet = 5,
                            col_names = c("origem_rendimento",
                            "total",
                            "ate_1908","Mais_de_1908_a_2862",
                            "Mais_de_2862_a_5_724",
                            "Mais_de_5724_a_9540",
                            "Mais_de_9540_a_14310",
                            "Mais_de_14_310_a_23_850",
                            "Mais_de_23850"),
                            n_max = 22)
rendimento_total_var_patrim_2017_2018<-na.omit(rendimento_total_var_patrim_2017_2018)

rendimento_total_var_patrim_2017_2018[i,] <- gsub('[-]', '0', rendimento_total_var_patrim_2017_2018[i,])

rendimento_total_var_patrim_2017_2018 %>% pivot_longer(
  cols = ate_1908:Mais_de_23850,
  names_to = c("faixa_de_renda"),
  values_to = "valor") ->rendimento_total_var_patrim_2017_2018

rendimento_total_var_patrim_2017_2018 %>%
  ggplot(aes(x = faixa_de_renda, y = valor, fill =origem_rendimento)) +
  geom_bar(stat = "identity", position = "dodge")



Rendimento_do_trabalho<-rendimento_total_var_patrim_2017_2018[15:42,]
ggplot(Rendimento_do_trabalho, aes(x = faixa_de_renda, y = valor, fill = origem_rendimento)) + 
  geom_bar(stat="identity",position = "dodge") + 
  labs(x="", y="Rendimento em R$", title="Rendimento total do trabalho em suas categorias") + 
  theme_economist()



Transferência<-rendimento_total_var_patrim_2017_2018[8:13,]
Transferência<-Transferência %>% arrange(desc(total))


Rendimento_de_aluguel <-rendimento_total_var_patrim_2017_2018[14,]
Rendimento_de_aluguel<-Rendimento_de_aluguel%>% arrange(desc(total))

Outras_rendas<-rendimento_total_var_patrim_2017_2018[15,]
Outras_rendas<-Outras_rendas %>% arrange(desc(total))

Rendimento_não_monetario<-rendimento_total_var_patrim_2017_2018[16,]
Rendimento_não_monetario<-Rendimento_não_monetario %>% arrange(desc(total))

View(rendimento_total_var_patrim_2017_2018)