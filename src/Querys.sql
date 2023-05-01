
-- Inserto datos en las tablas vacías, tanto para la correcta inserción de los datos de inventario como para "simular" el alquiler de una película

INSERT INTO stores (store_id, address, mall, city, last_update) 
VALUES (1, 'Paseo de la Chopera, 14', 'Gran Plaza', 'Majadahonda', '2023-04-30 19:29:17');

INSERT INTO staff (staff_id, first_name, last_name, DNI,job_position, last_update, stores_idstores) 
VALUES (1, 'Nacho', 'Romero', '43087433T', 'Owner', '2023-04-30 19:29:17',1);

INSERT INTO clients (customer_id, first_name, last_name, DNI,address, last_update) 
VALUES (1, 'Laura', 'Rodriguez', '50557552B', 'Calle Poseidón, 3 - Las Rozas de Madrid', '2023-04-30 20:29:17');

INSERT INTO rental (rental_id, rental_date, return_date, last_update,customer_id, staff_id,inventory_id) 
VALUES (1, '2023-05-01 13:42:17', '2023-05-09 00:00:00','2023-04-30 20:29:17',1,1,20);

-- Query de prueba accediendo desde inventario al lenguaje y a las películas

select i.inventory_id,f.title, l.name
from inventory as i
inner join language as l
on i.language_id = l.language_id
inner join film as f
on i.film_id = f.film_id;


-- Selecciono quien fue el que alquiló una pelicula primero, el título de la pelicula, la dirección de la tienda en la que lo hizo
-- y su fecha de devolución 

select c.first_name as Name, c.last_name as Lastname, f.title as Title, s.address as 'Store Address', r.return_date as 'Return Date'
from rental as r
inner join inventory as i
on r.inventory_id = i.inventory_id
inner join stores as s
on i.store_id = s.store_id
inner join film as f
on i.film_id = f.film_id
inner join clients as c
on r.customer_id = c.customer_id
where r.rental_id = 1;

-- En cuantas películas de horror sale Penelope Guiness

select count(f.title) as 'Number of horror films'
from actor as a
inner join actor_has_film as af
on a.actor_id = af.actor_id
inner join film as f
on af.film_id = f.film_id
inner join category as c
on f.category_id = c.category_id
where a.first_name = 'PENELOPE' and a.last_name = 'GUINESS' and c.name = 'Horror';

-- Cuantas copias tengo  de AIRPORT POLLOCK

select count(i.inventory_id) as 'Number of copies of Airport Pollock' 
from film as f
inner join inventory as i
on f.film_id = i.film_id
where f.title = 'AIRPORT POLLOCK';

-- Las películas con el precio de repuesto más caro

SELECT title,replacement_cost
FROM film
WHERE replacement_cost = (SELECT MAX(replacement_cost) FROM film);

-- Los actores que no participan en ninguna de las películas conocidas

select first_name,last_name
from actor as a
left join actor_has_film as af
on a.actor_id = af.actor_id
where a.actor_id > (SELECT MAX(actor_id) FROM actor_has_film);
