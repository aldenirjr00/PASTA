-- !preview conn=DBI::dbConnect(RSQLite::SQLite())



#1. Valor total das vendas e dos fretes por produto e ordem de venda
SELECT
    Data,                                   #acessando o produto e a data (ordem)
    ProdutoID,                              #somando as vendas e frete
    SUM(Venda) AS ValorTotalVendas,
    SUM(ValorFrete) AS ValorTotalFretes
FROM
    Vendas 
JOIN
    Fretes ON  DataVenda = DataFrete
GROUP BY                                    agrupando o total das vendas e fretes por ordem de data e por poduto
    Data, ProdutoID;
    
    
    
#2. Valor de venda por tipo de produto
SELECT
    CategoriaID,                         #selecionando a categoria do produto e realizando uma soma das vendas por categoria
    SUM(Venda) AS ValorTotalVendas
FROM
    Vendas                                 #agrupando por categoria de produto
GROUP BY
    CategoriaID;
    

#3. Quantidade e valor das vendas por dia, mês, ano
# VENDAS POR DIA
SELECT
    Data,
    SUM(Quantidade) AS QuantidadeTotal,
    SUM(ValorVenda) AS ValorTotalVendas
FROM
    Vendas
GROUP BY
    Data;

#VENDAS POR MÊS
SELECT
    EXTRACT(YEAR_MONTH FROM Data) AS AnoMes,
    SUM(Quantidade) AS QuantidadeTotal,
    SUM(ValorVenda) AS ValorTotalVendas
FROM
    Vendas
GROUP BY
    AnoMes;

#VENDAS POR ANO
SELECT
    EXTRACT(YEAR FROM Data) AS Ano,
    SUM(Quantidade) AS QuantidadeTotal,
    SUM(ValorVenda) AS ValorTotalVendas
FROM
    Vendas
GROUP BY
    Ano;
    
    
#4.Lucro dos meses;
SELECT                                           #extraindo o mês e calculando o lucro
    EXTRACT(YEAR_MONTH FROM Data) AS AnoMes,
    SUM(Valor - Custo) AS Lucro
FROM
    Vendas
JOIN
    Custo ON Data = DataCusto
GROUP BY
    AnoMes;
    

#5. Venda por produto
#venda (dinheiro)
dados2 %>% group_by(ProdutoID) %>% summarise(produtos_vendidos = sum(vendas)) %>% arrange(-produtos_vendidos) %>% print(n = ) #venda (dinheiro)
#acessando o conj de dados (dados2), e fazendo uma soma das vendas por produto. o Arrange diz se sera em ordem crescente ou não

#venda por quantidade
dados2 %>% group_by(ProdutoID) %>% summarise(produtos_vendidos = sum(Quantidade)) %>% arrange(-produtos_vendidos) %>% print(n = ) #venda por quantidade
#Acessando o conjunto de dados (dados2), fazendo uma soma da quantidade de produtos vendidos. O print n : especifica quantas produtos aparecerão (como deixei vazio ele que é para printar todos os produtos)
sum(dados2[dados2$ProdutoID == 75,8]) #confirmação do prod 75  


#6. Venda por cliente, cidade do cliente e estado
SELECT
    ClienteID,                  #selecionando estas colunas e fazendo uma soma de vendas
    NomeCliente,
    Cidade,
    Estado,
    SUM(Venda) AS ValorTotalVendas
FROM
    Clientes                        #colunas acessadas da tabela cliente
JOIN
    Vendas  ON ClienteID = ClienteID    #join entre clientes e vendas
GROUP BY
    ClienteID, NomeCliente, Cidade, Estado;      #agrupando por cliente, sua respectiva cidade e seu estado
    
  
#7. Média de produtos vendidos
dados2 %>% group_by(ProdutoID) %>% summarise(media_produtos = mean(vendas)) %>% arrange(-media_produtos) %>% print(n = )
#Acessando o conjunto de dados (dados2), fazendo uma média de vendas dos produtos e ordenando do prod mais vendido para o menos vendido


#8. Média de compras que um cliente faz.
SELECT
    ClienteID,                               #selecionndo a coluna ClienteID
    AVG(Venda) AS MediaCompras               #fazendo a média de vendas
FROM
    Clientes                                 #da tabela Clientes
JOIN
    Vendas ON ClienteID                   #join entre cliente e vendas
GROUP BY
    ClienteID;                              #agrupando por cliente