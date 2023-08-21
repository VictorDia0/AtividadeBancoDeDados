-- -----------------------------------------------------
-- Questao 01 --
-- -----------------------------------------------------

DELIMITER $$
create function TotalVendas(inicio DATE, fim DATE) 
returns DECIMAL DETERMINISTIC
    begin 
        declare Total_Vendas Decimal(15,2);
        select SUM(p.valor) into Total_Vendas
        from pedido p 
        where p.data between inicio and fim;

        return Total_Vendas;

    end;

    $$

DELIMITER ;

-- -----------------------------------------------------
-- -----------------------------------------------------

select TotalVendas('2009-11-03', '2009-11-30');

-- -----------------------------------------------------
-- Questao 02 --
-- -----------------------------------------------------


DELIMITER $$

CREATE FUNCTION Media(mes INT, ano INT)
RETURNS DECIMAL(15,2) DETERMINISTIC
BEGIN

    DECLARE total DECIMAL(15,2);
    DECLARE dias INT;

        SET dias = DAY(LAST_DAY(CONCAT(ano, '-', mes, '-01')));
    
    SELECT SUM(p.valor) INTO total
        FROM pedido p
        WHERE MONTH(p.data) = mes AND YEAR(p.data) = ano;
    RETURN total / dias;
END;
$$

DELIMITER ;
-- -----------------------------------------------------
-- -----------------------------------------------------

select Media(11,2009);


-- -----------------------------------------------------
-- Questao 03 --
-- -----------------------------------------------------

DELIMITER $$

CREATE FUNCTION maisVendido(ano INT)
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE produto_mais_vendido VARCHAR(100);
    
    SELECT pr.nome INTO produto_mais_vendido
    FROM produto pr
        JOIN item it ON pr.codproduto = it.codproduto
        JOIN pedido p ON it.codpedido = p.codpedido
    WHERE YEAR(p.data) = ano
        GROUP BY pr.codproduto
        ORDER BY SUM(it.quantidade) DESC
    LIMIT 1;

    RETURN produto_mais_vendido;
END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- -----------------------------------------------------

select maisVendido(2009);



-- -----------------------------------------------------
-- Questao 04 --
-- -----------------------------------------------------


DELIMITER $$

CREATE FUNCTION calcular_valor_medio_compra(id_cliente INT)
RETURNS DECIMAL(15,2) DETERMINISTIC
BEGIN
    DECLARE valor_medio DECIMAL;
    
    SELECT AVG(p.valor) INTO valor_medio
    FROM pedido p
    WHERE p.codcliente = id_cliente;

    RETURN valor_medio;
END;
$$

DELIMITER ;



-- -----------------------------------------------------
-- Questao 05 --
-- -----------------------------------------------------
DELIMITER $$

CREATE FUNCTION encontrar_clientes_inativos()
RETURNS TEXT
BEGIN
    DECLARE clientes_inativos TEXT;
    
    SELECT GROUP_CONCAT(codcliente) INTO clientes_inativos
    FROM cliente c
    WHERE NOT EXISTS (
        SELECT 1
        FROM pedido p
        WHERE p.codcliente = c.codcliente AND p.data >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    );

    RETURN clientes_inativos;
END;
$$

DELIMITER ;

-- -----------------------------------------------------
-- Questao 06 --
-- -----------------------------------------------------


DELIMITER $$

CREATE FUNCTION analise_mensal_vendas(mes INT, ano INT)
RETURNS TEXT
BEGIN
    DECLARE total_vendas DECIMAL;
    DECLARE num_clientes INT;
    DECLARE media_por_cliente DECIMAL;
    
    SELECT SUM(p.valor), COUNT(DISTINCT p.codcliente), SUM(p.valor) / COUNT(DISTINCT p.codcliente)
    INTO total_vendas, num_clientes, media_por_cliente
    FROM pedido p
    WHERE MONTH(p.data) = mes AND YEAR(p.data) = ano;

    RETURN CONCAT('Total de Vendas: ', total_vendas,
                  '\nNúmero de Clientes Únicos: ', num_clientes,
                  '\nMédia de Vendas por Cliente: ', media_por_cliente);
END;
$$

DELIMITER ;


-- -----------------------------------------------------
-- Questao 07 --
-- -----------------------------------------------------

DELIMITER $$

CREATE FUNCTION encontrar_maiores_compradores()
RETURNS TEXT
BEGIN
    DECLARE maiores_compradores TEXT;
    
    SELECT GROUP_CONCAT(c.nome) INTO maiores_compradores
    FROM cliente c
    JOIN pedido p ON c.codcliente = p.codcliente
    GROUP BY c.codcliente
    ORDER BY SUM(p.valor) DESC
    LIMIT 3;

    RETURN maiores_compradores;
END;
$$

DELIMITER ;
