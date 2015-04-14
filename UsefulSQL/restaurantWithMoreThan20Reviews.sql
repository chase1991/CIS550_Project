select distinct bc.category
from Business_Category bc
where bc.category like "%Food"
or bc.category like "Food%"
or bc.category = "Food"
or bc.category like "%Bar%"
or bc.category like "%Bar"
or bc.category = "Bars"
or bc.category = "Bar"
