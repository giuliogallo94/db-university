-- 1. Selezionare tutti gli studenti nati nel 1990 (160) ✓
SELECT * 
from `students`
WHERE YEAR(`date_of_birth`) = 1990
ORDER BY `date_of_birth` ASC

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479) ✓
SELECT * 
from `courses` 
WHERE `cfu` > 10
ORDER BY `cfu` ASC

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni ✓
SELECT * 
from `students`
WHERE DATEDIFF(CURDATE(),`date_of_birth`) / 365.25 + (1 / 365.25) > 30 
ORDER BY `date_of_birth` DESC

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286) ✓
SELECT * 
from `courses`
WHERE `period` = "I semestre"
AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21) ✓
SELECT * 
from `exams`
WHERE `date` = "2020-06-20"
AND HOUR(`hour`) > 13
ORDER BY `hour` ASC

-- 6. Selezionare tutti i corsi di laurea magistrale (38) ✓
SELECT * 
from `degrees`
WHERE `name` LIKE "Corso di Laurea Magistrale%"

-- 7. Da quanti dipartimenti è composta l'università? (12) ✓
SELECT COUNT(*) as `departments_number`
from `departments`

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50) ✓
SELECT COUNT(*) as `teachers_with_phone_number`
from `teachers`
WHERE `phone` IS NOT NULL


