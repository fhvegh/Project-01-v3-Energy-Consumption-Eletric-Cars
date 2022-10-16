

# Carregando os dados:
dados <- read_excel('FEV-data-Excel.xlsx')

# Visualizando o dataset:
View(dados)

# Valores NA no dataset?
sum(is.na(dados)) # Há valores NAs presente

str(dados) # Algumas variáveis precisam ser modificadas para tipo fator