USE stz

select top 10 * from products (nolock)
where ProductID = '1630219'

select * from categories (nolock)
where CategoryID = '174'

select * from product_categories (nolock)
where ProductID = '1339'

select * from catalog_categories (nolock)
where CategoryID = '174'

select * from category_category_groups (nolock)


select * from product_reviews (nolock)
where email = 'rejanestumpf@yahoo.com.br'

select * from product_review_reactions (nolock)

--case status when 'A' then 'Aprovado' end as Status

select * from customers (nolock)
where email = 'matheusceciliano0911@gmail.com'
select * from product_rating_attributes (nolock)
select * from product_rating_average (nolock)
select * from product_ratings (nolock)

select
case product_reviews.status 
	when 'A' then 'Aprovado'
	when 'R' then 'Reprovado'
	when 'P' then 'Pendente'
	else product_reviews.status
end as Status,
ltrim(rtrim(concat(customers.name,' ', customers.Surname))) as Cliente,
customers.DocumentNumber as CPF,
customers.EMail as EMail,
customers.cellphone as Celular,
Isnull(customers.phone,'') as Telefone,
Isnull(customers.phone2,'') as Telefone2,
products.SKU,
products.Name as Produto,
product_ratings.Average as Nota,
product_reviews.ReviewBody as Avaliacao,
convert(varchar,product_reviews.ReviewDate,103) as Data_Avaliacao
from product_reviews as product_reviews(nolock)
join customers as customers (nolock)
	on product_reviews.CustomerID = customers.CustomerID
join products as products (nolock)
	on product_reviews.ProductID = products.ProductID
join product_ratings as product_ratings (nolock)
	on product_ratings.ProductID = products.ProductID
		and product_ratings.CustomerID = product_reviews.CustomerID
		and product_reviews.ProductRatingID = product_ratings.ProductRatingID
order by product_reviews.ReviewDate asc