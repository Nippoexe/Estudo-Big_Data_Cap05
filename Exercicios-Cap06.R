# Solução Lista de Exercícios - Capítulo 6

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
projeto_path = "D:/FCDados/[06] - Banco de Dados/[03] - Projetos/"
input_path = "D:/FCDados/[06] - Banco de Dados/[01] - InputData/"
output_path = "D:/FCDados/[06] - Banco de Dados/[02] - OutputData/"
setwd(projeto_path)
getwd()

# Exercicio 1 - Instale a carregue os pacotes necessários para trabalhar com SQLite e R
install.packages("RSQLite")
library(RSQLite)
library(dbplyr)
library(dplyr)

# Exercicio 2 - Crie a conexão para o arquivo mamiferos.sqlite em anexo a este script
??RSQlite

setwd(input_path)

drv = dbDriver("SQLite")
con = dbConnect(drv, dbname = "mamiferos.sqlite")


# Exercicio 3 - Qual a versão do SQLite usada no banco de dados?
# Dica: Consulte o help da função src_dbi()
??src_dbi

src_dbi(con, auto_disconnect = FALSE)

# Exercicio 4 - Execute a query abaixo no banco de dados e grave em um objero em R:
# SELECT year, species_id, plot_id FROM surveys
query <- "SELECT year, species_id, plot_id FROM surveys"
rs <- dbSendQuery(con, query)
df_survey <- dbFetch(rs)

?dbSendQuery
# Exercicio 5 - Qual o tipo de objeto criado no item anterior?
class(df_survey)

# Exercicio 6 - Já carregamos a tabela abaixo para você. Selecione as colunas species_id, sex e weight com a seguinte condição:
# Condição: weight < 5
pesquisas <- tbl(con, "surveys")
is.tbl(pesquisas)
pesquisas
class(pesquisas)
a <-  pesquisas %>% select(species_id, sex, weight) %>% filter(weight < 5)
a

query2 <- "SELECT species_id, sex, weight FROM surveys WHERE weight < 5"
rs2 <- dbSendQuery(con, query2)
pesquisa <- dbFetch(rs2)
pesquisa

# Exercicio 7 - Grave o resultado do item anterior em um objeto R. O objeto final deve ser um dataframe
x <- as.data.frame(a)
class(x)


# Exercicio 8 - Liste as tabelas do banco de dados carregado
dbListTables(con)

# Exercicio 9 - A partir do dataframe criado no item 7, crie uma tabela no banco de dados
dbWriteTable(con, "mamiferos", x)

# Exercicio 10 - Imprima os dados da tabela criada no item anterior
dbReadTable(con, "mamiferos")


dbDisconnect(mydb)

