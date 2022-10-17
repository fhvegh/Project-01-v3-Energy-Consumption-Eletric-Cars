
# Projeto 01 v3 - Prevendo Consumo de Energia de Carros Elétricos
# Como vamos criar um modelo de previsão numéria, temos que se trata de um modelo de regressão:
# Projeto do curso de Linguagem R com Azure Machine Learning da Data Science Academy

# Diretório de trabalho:
setwd("C:/My_Development/Projetos/Energy-Consumption-Eletric-Cars/Energy-Consumption-Eletric-Cars")

# Pacotes Necessários:
library(readxl)
library(dplyr)
library(caret)
library(e1071)
library(corrplot)
library(mctest)
library(rmarkdown)

# ---------------------------------------------------------------------------------------------------------

# Carregando os dados:
dados <- read_excel('FEV-data-Excel.xlsx')

# Transformando em dataframe:
dados <- as.data.frame(dados)

# Visualizando o dataset:
View(dados)

# Valores NA no dataset?
sum(is.na(dados)) # Há valores NAs presente

str(dados) # Algumas variáveis precisam ser modificadas para tipo fator

# Modificando o nome de algumas colunas:
colnames(dados)[1] <- "car_full_name"
colnames(dados)[4] <- "minimal_price_gross"
colnames(dados)[5] <- "engine_power"
colnames(dados)[6] <- "maximum_torque"
colnames(dados)[7] <- "type_of_breaks"
colnames(dados)[8] <- "drive_type"
colnames(dados)[9] <- "battery_capacity"
colnames(dados)[10] <- "range"
colnames(dados)[11] <- "wheelbase"
colnames(dados)[12] <- "length"
colnames(dados)[13] <- "width"
colnames(dados)[14] <- "height"
colnames(dados)[15] <- "minimal_empty_weight"
colnames(dados)[16] <- "permissable_gross_weight"
colnames(dados)[17] <- "maximum_load_capacity"
colnames(dados)[18] <- "number_of_seats"
colnames(dados)[19] <- "number_of_doors"
colnames(dados)[20] <- "tire_size"
colnames(dados)[21] <- "maximum_speed"
colnames(dados)[22] <- "boot_capacity"
colnames(dados)[23] <- "acceleration"
colnames(dados)[24] <- "maximum_dc_charging_power"
colnames(dados)[25] <- "mean_energy_consumption"

#-----------------------------------------------------------------------------------------------------------

# Salvando em csv:
dados <- write.csv(dados,file = "dados.csv",sep = ",",fileEncoding = "UTF-8")






























