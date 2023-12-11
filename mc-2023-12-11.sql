DROP PROCEDURE IF EXISTS available_cars_in_price_range; 
DELIMITER //
CREATE PROCEDURE available_cars_in_price_range(IN min_value INT, IN max_value INT)
BEGIN
SELECT `id`, `rental_charge`, `brand`, `model`, `vehicle_type`, `vin`, `year_of_production`, `mileage`, `seats`, `department_id`, `insurance_id`
FROM `vehicles_(pojazdy)` 
WHERE `availability` = "AVAILABLE" AND `rental_charge` >= min_value AND `rental_charge` <= max_value
ORDER BY `rental_charge`;
END //