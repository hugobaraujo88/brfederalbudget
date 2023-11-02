---------------------------------------------------------------------------------------------------
--dashboard.despesa_exec_ac_pib  ------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

truncate table dashboard.despesa_exec_ac_pib

---------------------------------------------------------------------------------------------------
-- Monthly executed value -------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create table #aux_cumulative_despesa_exec
(
	ano int,
	despesa_ac float
);

insert into #aux_cumulative_despesa_exec
	SELECT
			ano,
			SUM(valor) as despesa_ac
		FROM hist.despesa_exec
			group by ano

---------------------------------------------------------------------------------------------------
-- Accumulated executed expense as a % of the previous year's GDP (PIB)  --------------------------
---------------------------------------------------------------------------------------------------

insert into dashboard.despesa_exec_ac_pib
	SELECT

		A.ano,
	   (A.despesa_ac / 1000000) / B.valor_pib AS [Despesa Exec. % PIB]
	FROM
	#aux_cumulative_despesa_exec A
		LEFT JOIN
			hist.pib B ON A.ano = B.ano + 1
	ORDER BY
		A.ano;

drop table #aux_cumulative_despesa_exec
