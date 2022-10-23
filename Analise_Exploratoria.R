
# Análise Exploratória

# Carregando os dados:
dados <- read.csv("dados.csv")
dados.num <- read.csv("dados.num.csv")
dados.cat <- read.csv("dados.cat.csv")

# ---------------------------------------------------------------------------------------------------------------------------
# EXPLORANDO AS VARIÁVEIS

# Analisando as variáveis categóricas:

# Dados sobre fabricantes:
table(dados.cat$Make) # * maior fabricante de carros elétricos é a Audi e dpois a Kia

# Dados sobre tipos de freio:
table(dados.cat$type_of_breaks) # Existem 3 tipos básicos de freio
table(dados.cat$drive_type) # tração traseira, dianteira e 4x4
table(dados.cat$number_of_seats) # * Maioria são carros com 5 assentos
table(dados.cat$number_of_doors) # Maioria são carros com 5 portas


# Analisando as variáveis Numéricas:
summary(dados.num) # informações gerais sobre as variáveis numéricas

# Estatísticas para a variável target:
hist(dados.num$mean_energy_consumption,col = "blue",main = "Mean of Energy Consumption",
     ylab ="Frequência" ,xlab ="Consumo")

mean(dados.num$mean_energy_consumption)
median(dados.num$mean_energy_consumption) # média e mediana estão próximas
sd(dados.num$mean_energy_consumption)
var(dados.num$mean_energy_consumption)
skewness(dados.num$mean_energy_consumption)
kurtosis(dados.num$mean_energy_consumption)


# Variável target:
range(dados$mean_energy_consumption) # valor mínimo de 13.10 e máximo de 27.55 unidades de energia

# Coluna car_full_name
length(unique(dados$car_full_name)) # 42 modelos de carros

# Quartis do consumo energético
# A maior parte dos modelos de carro elétrico possue um consumo assima dos 17 unidades energética
quantile(dados$mean_energy_consumption)
barplot(quantile(dados$mean_energy_consumption))

# Variação dos consumos energéticos dos carros:
# Percebe-se que o pico fica em 16, 17 na média de consumo 
hist(dados$mean_energy_consumption)

# Quais são os carros com maior e menor velocidade:
speed <- dados[c('Make','Model','maximum_speed')]

range(speed$maximum_speed) # velocidades máximas e mínimas
speed[speed$maximum_speed == 260,] # marca: Porsche, modelo: Taycan Turbo, velocidade máxima = 260km/h
speed[speed$maximum_speed == 130,] # marcas: Skoda, Smart e Citroen

# Carros com maior durabilidade de bateria:
bat <- dados[c("Make","Model","battery_capacity")]
range(bat$battery_capacity)
bat[bat$battery_capacity == 17.6,] # Bateria com menor capacidade - Marca Smart
bat[bat$battery_capacity == 95.0,] # Bateria com maior capacidade - Marca Audi

# Carros mais caros e baratos
car.value <- dados[c("Make","Model","minimal_price_gross")]
range(car.value$minimal_price_gross)
car.value[car.value$minimal_price_gross == 82050,] # Marca Skoda o mais barato
car.value[car.value$minimal_price_gross == 794000,] # Marca Porsche o mais caro!


















