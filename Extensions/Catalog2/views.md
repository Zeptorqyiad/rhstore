# normal

```sql
create or replace view v_product_discounted_price as
select `p`.`product_id`      AS `product_id`,
       `p`.`name`            AS `name`,
       `p`.`price`           AS `original_price`,
       coalesce((select min((`p`.`price` - ((`p`.`price` * `s`.`discount`) / 100.0)))
                 from (`catalog_sale_product` `sp` join `catalog_sale` `s`
                       on ((`sp`.`sale_id` = `s`.`sale_id`)))
                 where ((`sp`.`product_id` = `p`.`product_id`) and (`s`.`is_active` = 1) and (`s`.`is_running` = 1))),
                (select min((`p`.`price` - ((`p`.`price` * `csc`.`discount`) / 100.0)))
                 from (`catalog_p2c` `p2c` join (with recursive `parent_categories`
                                                                                as (select `catalog_category`.`category_id` AS `category_id`,
                                                                                           `catalog_category`.`category_id` AS `parent_category_id`
                                                                                    from `catalog_category`
                                                                                    union all
                                                                                    select `pc`.`category_id` AS `category_id`,
                                                                                           `cc`.`pid`         AS `parent_category_id`
                                                                                    from (`catalog_category` `cc` join `parent_categories` `pc`
                                                                                          on ((`cc`.`category_id` = `pc`.`parent_category_id`))))
                                                             select `pc`.`category_id` AS `category_id`,
                                                                    `sc`.`sale_id`     AS `sale_id`,
                                                                    `s`.`discount`     AS `discount`
                                                             from ((`parent_categories` `pc` join `catalog_sale_category` `sc`
                                                                    on ((`pc`.`parent_category_id` = `sc`.`category_id`))) join `catalog_sale` `s`
                                                                   on (((`sc`.`sale_id` = `s`.`sale_id`) and
                                                                        (`s`.`is_active` = 1) and
                                                                        (`s`.`is_running` = 1))))) `csc`
                       on ((`p2c`.`category_id` = `csc`.`category_id`)))
                 where (`p2c`.`product_id` = `p`.`product_id`)),
                (select min((`p`.`price` - ((`p`.`price` * `s`.`discount`) / 100.0)))
                 from `catalog_sale` `s`
                 where ((`s`.`is_active` = 1) and (`s`.`is_running` = 1) and exists(select 1
                                                                                    from `catalog_sale_category`
                                                                                    where (`catalog_sale_category`.`sale_id` = `s`.`sale_id`)) is false and
                        exists(select 1
                               from `catalog_sale_product`
                               where (`catalog_sale_product`.`sale_id` = `s`.`sale_id`)) is false)),
                `p`.`price`) AS `discounted_price`
from `catalog_product` `p`
group by `p`.`product_id`, `p`.`name`, `p`.`price`;
```

# multiprice

```sql
create or replace view v_product_discounted_multi_price as
SELECT
    p.product_id AS product_id,
    p.name AS name,
    cp.level_id AS level_id,
    cp.price AS original_price,
    COALESCE(
            (SELECT MIN(cp.price - (cp.price * s.discount / 100.0))
             FROM catalog_sale_product sp
                      JOIN catalog_sale s ON sp.sale_id = s.sale_id
             WHERE sp.product_id = p.product_id AND s.is_active = 1 AND s.is_running = 1),
            (SELECT MIN(cp.price - (cp.price * csc.discount / 100.0))
             FROM catalog_p2c p2c
                      JOIN (
                 WITH RECURSIVE parent_categories AS (
                     SELECT cc.category_id, cc.category_id AS parent_category_id
                     FROM catalog_category cc
                     UNION ALL
                     SELECT pc.category_id, cc.pid AS parent_category_id
                     FROM catalog_category cc
                              JOIN parent_categories pc ON cc.category_id = pc.parent_category_id
                 )
                 SELECT pc.category_id, sc.sale_id, s.discount
                 FROM parent_categories pc
                          JOIN catalog_sale_category sc ON pc.parent_category_id = sc.category_id
                          JOIN catalog_sale s ON sc.sale_id = s.sale_id
                 WHERE s.is_active = 1 AND s.is_running = 1
             ) csc ON p2c.category_id = csc.category_id
             WHERE p2c.product_id = p.product_id),
            (SELECT MIN(cp.price - (cp.price * s.discount / 100.0))
             FROM catalog_sale s
             WHERE s.is_active = 1 AND s.is_running = 1
               AND NOT EXISTS (SELECT 1 FROM catalog_sale_category WHERE catalog_sale_category.sale_id = s.sale_id)
               AND NOT EXISTS (SELECT 1 FROM catalog_sale_product WHERE catalog_sale_product.sale_id = s.sale_id)),
            cp.price
    ) AS discounted_price
FROM catalog_product p
         JOIN catalog_price cp ON p.product_id = cp.product_id
GROUP BY p.product_id, p.name, cp.level_id, cp.price;
```