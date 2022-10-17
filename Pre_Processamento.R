
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




















