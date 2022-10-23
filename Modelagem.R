

# Modelagem:

# Carregando Dados:
dados.flt <- read.csv(dados.flt,"dados.flt.csv")
dados.flt.norm <- read.csv(dados.flt.norm,"dados.flt.norm.csv")

# Dados de treino e teste dos dados originais:
index <- createDataPartition(dados$mean_energy_consumption,p = 0.70,list = FALSE)
train <- dados[index,]
test <- dados[-index,]

### Modelo 1:
# ***  Será feita a modelagem utilizando algoritmo de regressão linear devido o dataset ter pequena quantidade
# de dados.

# modelo com dados originais
modelo1 <- train(mean_energy_consumption ~.,data = train, method = 'lm')

#warnings()
# In predict.lm(modelFit, newdata) :
# prediction from a rank-deficient fit may be misleading

# *** Neste primeiro modelo, ocorre um erro devido algumas variáveis do modelo apresentarem 
# multcolinearidade. O que por sua vez pode implicar em um modelo com overfiting.
# Outro problema no dataset é a quantidade de variáveis preditoras, ou seja, alta dimensionalidade
# Nesta modelagem, decidiu-se remover de forma intuitiva as colunas categóricas consideradas menos importantes.
# Colunas como número de portas, tipo do freio ou ainda marca e modelo, não são interessantes para 
# o modelo matemático

# ------------------------------------------------------------------------------------------------------------------------------

### Modelo 02
# Criando o index a ser utilizado sem normalização ou padronização dos dados:
index.num <- createDataPartition(dados.num$mean_energy_consumption,p = 0.70,list = FALSE)
train.num <- dados.num[index.num,]
test.num <- dados.num[-index.num,]

# Apenas valores numéricos
modelo2 <- lm(formula = train.num$mean_energy_consumption ~ .,data = train.num)
summary(modelo2)

dados.cor <- cor(dados.num)
dados.cor
corrplot(dados.cor,method = "color")

# Aplicando metodo para encontrar multicolinearidade:
imcdiag(modelo2)

# Resultado:
# todas as colunas que apresentam valor de Klein = 0 não são signifante para o modelo:
# minimal_price_gross , engine_power , maximum_torque , wheelbase , height , minimal_empty_weight , 
# permissable_gross_weight , maximum_load_capacity , maximum_dc_charging_power , coefficient(s) 
# are non-significant may be due to multicollinearity
# Necessário novo processamento

# Fazendo previsões:
pred2 <- predict(modelo2,newdata = test.num)
summary(pred2)
# Comparando os valores previstos com dados de teste:
dados.test.2 <- as.numeric(test.num$mean_energy_consumption)

results.2 <- data.frame(dados.test.2,pred2)
results.2

# Valores das estatísticas do modelo 2:
m.2 <- mean(pred2)
s.2 <- sd(pred2)
v.2 <- var(pred2)

# ----------------------------------------------------------------------------------------------------------------------------------

### Modelo 03

# Modelagem com dados filtrados!
# Criando o index a ser utilizado sem normalização:
index.flt <- createDataPartition(dados.flt$mean_energy_consumption, p = 0.70, list = FALSE)
train.flt <- dados.flt[index.flt,]
test.flt <- dados.flt[-index.flt,]

# Modelagem com dados mantida a escala original:
modelo3 <- lm(formula = train.flt$mean_energy_consumption ~ .,data = train.flt)
summary(modelo3)

# Fazendo previsões
pred.3 <- predict(object = modelo3,newdata = test.flt)

# Comparando os valores previstos com dados de teste:
dados.test.3 <- test.flt[,9]
resultado.3 <- data.frame(dados.test.3,pred.3)
resultado.3

# Valores das estatísticas do modelo 3:
m.3 <- mean(pred.3)
s.3 <- sd(pred.3)
v.3 <- var(pred.3)

# Variáveis de importância geradas no modelo são range e battery_capacity
# Aplicando o teste de shapiro-wilk para verificar se temos variáveis com distribuição normal:
shapiro.test(dados.flt$range) # p-value acima de 0.05
shapiro.test(dados.flt$battery_capacity) # p-value abaixo de 0.05

hist(dados.flt$range)
hist(dados.flt$battery_capacity)

# ---------------------------------------------------------------------------------------------------------------------------------

### Modelo 04

# Dados de treino e teste de valores numéricos com ajuste de escala (normalizado)
index.flt.norm <- createDataPartition(dados.flt.norm$mean_energy_consumption,p = 0.70,list = FALSE)
train.flt.norm <- dados.flt.norm[index.flt.norm,]
test.flt.norm <- dados.flt.norm[-index.flt.norm,]

# Aplicando modelagem em dados com escala ajustada (normalizado)
modelo.4 <- lm(train.flt.norm$mean_energy_consumption ~ .,data = train.flt.norm )
summary(modelo.4)

# Testando o modelo:
pred.4 <- predict(object = modelo.4,newdata = test.flt.norm)

# Desnormalizando os dados:
desnormalize <- function(dx,max.x,min.x){
  dvals <- dx * (max.x - min.x) + min.x
  dvals <- round(dvals, digits = 2)
  return(dvals)
}

# Aplicanco a função de desnormalização nos dados de teste e de valores previstos:
test.flt.desnorm.4 <- desnormalize(test.flt.norm[,9],max(test.flt$mean_energy_consumption),min(test.flt$mean_energy_consumption))
test.flt.desnorm.4

pred.desnorm.4 <- desnormalize(pred.4,max(test.flt$mean_energy_consumption),min(test.flt$mean_energy_consumption))
pred.desnorm.4

# Comparando valores de teste e previstos:
resultado.4 <- data.frame(test.flt.desnorm.4,pred.desnorm.4)
resultado.4 

# Estatísticas dos valores previstos:
m.4 <- mean(pred.desnorm.4)
s.4 <- sd(pred.desnorm.4)
v.4 <- var(pred.desnorm.4)

# -------------------------------------------------------------------------------------------------------------------------

# Utilizando outros Algoritmos:

### Modelo 05
# Usando algoritmo svm:
fit.control <- trainControl(method = "repeatedcv",
                            number = 10,
                            repeats = 10,
                            classProbs = TRUE)

modelo.5 <- train(mean_energy_consumption ~ .,data = train.flt, 
                  method = 'svmLinear',
                  trControl = fit.control)
summary(modelo.5)
modelo.5

# ---------------------------------------------------------------------------------------------------------------
### Modelo 06
# Usando algoritmo de bayes:
modelo.6 <- train(mean_energy_consumption ~ .,data = train.flt, method = 'bayesglm')
summary(modelo.6)
modelo.6

# ---------------------------------------------------------------------------------------------------------------

# Modelos 5 e 6 apresentaram baixa performance

# ---------------------------------------------------------------------------------------------------------------

# Conclusão:
# A modelagem 04 foi que apresentou melhor desempenho no valor de r-squared e no valor da variância, o que pode
# ser intermpretado como um modelo com a melhor generalização.
# Outro fator importante é observar que dentre todas as colunas do dataset, batteryc_capacity e range são as de
# maior relevância para obter o valor da previsão. Se você for comprar um carro elétrico, verifique a capacidade
# da bateria e o quanto este veículo consegue rodar.

# Grato!

# fhvegh























