-- Query to execute

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
-- other solution
SELECT *
FROM `students`
WHERE `date_of_birth` <= CURDATE() - INTERVAL 30 YEAR;
-- other solution
SELECT *
FROM `students`
WHERE YEAR(NOW()) - YEAR(`date_of_birth`) > 30;

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

-- Query with JOIN to execute

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT *
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `courses`.* 
FROM `courses` 
INNER JOIN `degrees`
ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`level` = "magistrale"
AND `departments`.`name` = "Dipartimento di Neuroscienze"

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.* 
FROM `courses` 
INNER JOIN `course_teacher`
ON  `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`name` = "Fulvio"
AND `teachers`.`surname` = "Amato"

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`, `departments`.`name`
FROM `students`
JOIN `degrees` 
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`,  `students`.`name` ASC 

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT  `courses`.`name`, `degrees`.`name`, `teachers`.`surname`, `teachers`.`name`
FROM `courses`
JOIN `degrees` 
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` 
ON `teachers`.`id` = `course_teacher`.`teacher_id`  
ORDER BY `teachers`.`surname` DESC

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.*
FROM `teachers`
JOIN `course_teacher`
ON `course_teacher`. `teacher_id` = `teachers`.`id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`. `course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments` 
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Matematica"

-- Query with GROUP BY to execute

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`) as `year`, COUNT(*) as `total_enrolment`
FROM `students`
GROUP BY YEAR(`enrolment_date`)

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `office_address` as `address`, COUNT(*) as `number_of_teachers`
FROM `teachers`
GROUP BY `office_address`

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` as `exam_session`, AVG(`vote`) as `avg_vote` 
FROM `exam_student`
GROUP BY `exam_id`  
ORDER BY `exam_student`.`exam_id` ASC

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT  `departments`.`name` as `department`, COUNT(*) as `number_of_degrees`
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
GROUP BY `department_id`