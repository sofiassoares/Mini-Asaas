-- 1 Select de cobranças (payment) com valor maior que R$ 1.000,00 
SELECT * FROM payment
WHERE value > 1000;

-- 2 Soma dos valores de cobranças recebidas com a data de criação maior que 2020, agrupadas por tipo de cobrança (billing_type)
SELECT billing_type, SUM(value) AS valor_recebido_cobrancas FROM payment
WHERE status = 'RECEIVED' AND YEAR(date_created) > 2020
GROUP BY billing_type;

-- 3 Lista de 20 pagadores (customer_account) com valores recebidos maiores que R$ 1.000,00
SELECT customer_account_id, SUM(value) AS total_recebido FROM payment
WHERE status = 'RECEIVED' 
GROUP BY customer_account_id
HAVING total_recebido > 1000.00
ORDER BY total_recebido DESC
LIMIT 20;

-- 4 Primeiro nome dos clientes (customer) com análise geral aprovada (customer_regiter_status), ordenado por data de aprovação
SELECT SUBSTRING_INDEX(c.name, ' ', 1) AS primeiro_nome,crs.last_general_status_change AS data_aprovacao
FROM customer c
INNER JOIN customer_register_status crs ON c.id = crs.customer_id
WHERE crs.general_approval = 'APPROVED'
ORDER BY crs.last_general_status_change DESC; 
