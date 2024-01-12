WITH last_dollar_currency_rate AS (SELECT id, name, rate_to_usd, updated
                                   FROM (SELECT id,
                                                name,
                                                rate_to_usd,
                                                updated,
                                                row_number() OVER (PARTITION BY id ORDER BY updated DESC) AS row_num
                                         FROM currency) as renked_currencies
                                   WHERE row_num = 1),
     total_balance_in_specific_currency AS (SELECT user_id, type, sum(money) AS total_volume, currency_id
                                            FROM balance
                                            GROUP BY user_id, type, currency_id)

SELECT coalesce(u.name, 'not defined')                         AS name,
       coalesce(lastname, 'not defined')                       AS lastname,
       type,
       total_volume                                            AS volume,
       coalesce(last_dollar_currency_rate.name, 'not defined') AS currency_name,
       coalesce(last_dollar_currency_rate.rate_to_usd, 1)      AS last_rate_to_usd,
       (total_volume * coalesce(rate_to_usd, 1))               AS total_volume_in_usd

FROM last_dollar_currency_rate
         FULL JOIN total_balance_in_specific_currency ON currency_id = id
         FULL JOIN "user" u ON user_id = u.id
ORDER BY name DESC, lastname, type;