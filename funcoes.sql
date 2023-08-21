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
