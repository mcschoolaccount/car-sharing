DROP PROCEDURE cars_in_department;
DELIMITER //
CREATE PROCEDURE cars_in_department(in dep_id INT)
BEGIN
SELECT * 
FROM `vehicles_(pojazdy)` 
WHERE department_id = dep_id;
END //
DELIMITER ;
CALL cars_in_department(1);
