---------------------------------------------------------------------------------------------------
--dashboard.receita_arrec_ac_pib -------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

truncate table dashboard.receita_arrec_ac_pib

---------------------------------------------------------------------------------------------------
--Monthly Executed Value -------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create table #aux_cumulative_receita_arrec
(
	ano int,
	receita_ac float
);

insert into #aux_cumulative_receita_arrec
	SELECT
			ano,
			SUM(valor_receita_real) as receita_ac
		FROM hist.receitas_real
			group by ano

---------------------------------------------------------------------------------------------------
--Accumulated collected revenue as a % of the previous year's GDP ------------------------------------
---------------------------------------------------------------------------------------------------

insert into dashboard.receita_arrec_ac_pib
    SELECT

		A.ano,
	   (A.receita_ac / 1000000) / B.valor_pib AS [Despesa Exec. % PIB]
	FROM
	#aux_cumulative_receita_arrec A
		LEFT JOIN
			hist.pib B ON A.ano = B.ano + 1
	ORDER BY
		A.ano;

drop table #aux_cumulative_receita_arrec
