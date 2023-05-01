INSERT INTO stores (store_id, address, mall, city, last_update) 
VALUES (1, 'Paseo de la Chopera, 14', 'Gran Plaza', 'Majadahonda', '2023-04-30 19:29:17');

INSERT INTO staff (staff_id, first_name, last_name, DNI,job_position, last_update, stores_idstores) 
VALUES (1, 'Nacho', 'Romero', '43087433T', 'Owner', '2023-04-30 19:29:17',1);

INSERT INTO clients (customer_id, first_name, last_name, DNI,address, last_update) 
VALUES (1, 'Laura', 'Rodriguez', '50557552B', 'Calle Poseidón, 3 - Las Rozas de Madrid', '2023-04-30 20:29:17');

select i.inventory_id,f.title, l.name
from inventory as i
inner join language as l
on i.language_id = l.language_id
inner join film as f
on i.film_id = f.film_id;