
# Pré-processamento dos dados:

# Carregando os dados:
dados <- read.csv("dados.csv")

# Removendo valores NA:
dados <- na.omit(dados)
sum(is.na(dados))

View(dados)

# As variáveis com valores únicos serão removidas, pois elas podem interferir no resultado da modelagem.
dados$car_full_name <- NULL
dados$Model <- NULL

# Separando as variáveis categóricas das numéricas:

# Variáveis categóricas:
dados$Make <- as.factor(dados$Make)
dados$type_of_breaks <- as.factor(dados$type_of_breaks)
dados$drive_type <- as.factor(dados$drive_type)
dados$number_of_seats <- as.factor(dados$number_of_seats)
dados$number_of_doors <- as.factor(dados$number_of_doors)

dados.cat <- dados[c("Make","type_of_breaks","drive_type","number_of_seats","number_of_doors")]

# Variáveis numéricas:
dados.num <- dados[c("minimal_price_gross","engine_power","maximum_torque","battery_capacity","wheelbase","width",
                     "range","length","height","minimal_empty_weight","permissable_gross_weight","maximum_load_capacity",
                     "tire_size","maximum_speed","boot_capacity","acceleration","maximum_dc_charging_power",
                     "mean_energy_consumption")]

dados.num <- write.csv(dados.num,"dados.num.csv")
dados.cat <- write.csv(dados.cat,"dados.cat.csv")

# -------------------------------------------------------------------------------------------------------------------------------

# Aplicação do teste de normalidade shapiro-wilk à variável target:
shapiro.test(dados.num$mean_energy_consumption)

# valor p muito baixo que indica que há significância estatística, ou seja, REJEITAMOS H0
# Os valores da variável target NÃO seguem uma distribuição normal
# Portanto, será aplicado técnicas para a padronizar os dados

# -------------------------------------------------------------------------------------------------------------------------------

# Devemos remover as seguintes colunas devido apresentarem multicolinearidade obtido pela função imcdiag()
# aplicado ao modelo 2.
remover.colunas <- dados.num[c("minimal_price_gross","engine_power","maximum_torque","wheelbase" , 
                               "height","minimal_empty_weight","permissable_gross_weight","maximum_load_capacity",
                               "maximum_dc_charging_power")]

# Novos dados já com as colunas filtradas:
dados.flt <- dados.num[c("range","tire_size","boot_capacity","battery_capacity","width","length","maximum_speed",
                         "acceleration","mean_energy_consumption")]

# Função para ajustar a escala dos dados
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# Dados na mesma escala (normalizados)
dados.flt.norm <- lapply(dados.flt, normalize)
dados.flt.norm <- as.data.frame(dados.flt.norm)
View(dados.flt)
View(dados.flt.norm)

# --------------------------------------------------------------------------------------------------------------
# Salvando em disco:
dados.flt <- write.csv(dados.flt,"dados.flt.csv")
dados.flt.norm <- write.csv(dados.flt.norm,"dados.flt.norm.csv")

















