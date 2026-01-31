select * 
from internships_demo; 

select*,
row_number() over(partition by Company,'Job Title' , Location, 'Job Type' , Experience,'Skill 1','Skill 2','Skill 3','Skill 4','Skill 5',
'Skill 6','Perk 1','Perk 2','Perk 3')
as row_num
from internships_demo;

with duplicate_cte as 
(
select*,
row_number() over(partition by Company,'Job Title' , Location, 'Job Type' , Experience,'Skill 1','Skill 2','Skill 3','Skill 4','Skill 5',
'Skill 6','Perk 1','Perk 2','Perk 3')
as row_num
from internships_demo
)
select * 
from duplicate_cte
where row_num > 1;

CREATE TABLE `internships_demo2` (
  `Company` text,
  `Job Title` text,
  `Location` text,
  `Job Type` text,
  `Experience` text,
  `Skill 1` text,
  `Skill 2` text,
  `Skill 3` text,
  `Skill 4` text,
  `Skill 5` text,
  `Skill 6` text,
  `Perk 1` text,
  `Perk 2` text,
  `Perk 3` text,
  `Perk 4` text,
  `Perk 5` text,
  `Perk 6` text,
  `row_num` INT
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from internships_demo2
where row_num > 1;

insert into  internships_demo2
select*,
row_number() over(partition by Company,'Job Title' , Location, 'Job Type' , Experience,'Skill 1','Skill 2','Skill 3','Skill 4','Skill 5',
'Skill 6','Perk 1','Perk 2','Perk 3')
as row_num
from internships_demo;

delete
from internships_demo2
where row_num > 1;

select * 
from internships_demo2
;


alter table internships_demo2
drop column `Perk 4`,
drop column `Perk 5`,
drop column `Perk 6`,
drop column row_num;



UPDATE internships_demo2
SET 
    `Skill 2` = IFNULL(`Skill 2`, 'Not Specified'),
    `Skill 3` = IFNULL(`Skill 3`, 'Not Specified'),
    `Skill 4` = IFNULL(`Skill 4`, 'Not Specified'),
    `Skill 5` = IFNULL(`Skill 5`, 'Not Specified'),
    `Skill 6` = IFNULL(`Skill 6`, 'Not Specified');


UPDATE internships_demo2 
SET 
    `Perk 1` = IFNULL(`Perk 1`, 'Not Specified'),
    `Perk 2` = IFNULL(`Perk 2`, 'Not Specified'),
    `Perk 3` = IFNULL(`Perk 3`, 'Not Specified');

-- 4. Verify that no NULLs remain in these columns
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN `Skill 2` = 'Not Specified' THEN 1 ELSE 0 END) AS fixed_skill2_rows
FROM internships_demo2;

select * 
from internships_demo2;

USE internships_demo2;

SELECT 
    'Preprocessing Summary' AS Report_Type,
    COUNT(*) AS Total_Records,
    SUM(CASE WHEN `Skill 2` = 'Not Specified' THEN 1 ELSE 0 END) AS Skill2_Filled,
    SUM(CASE WHEN `Skill 6` = 'Not Specified' THEN 1 ELSE 0 END) AS Skill6_Filled,
    SUM(CASE WHEN `Perk 1` = 'Not Specified' THEN 1 ELSE 0 END) AS Perk1_Filled,
    (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'internships' AND table_schema = 'internships_demo2') AS Remaining_Columns
FROM internships_demo2;

select *
from internships_demo2;