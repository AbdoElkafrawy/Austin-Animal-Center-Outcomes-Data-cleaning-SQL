/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *

  FROM [Pet Shelter Analysis].[dbo].[Austin_Animal_Center_Outcomes$]

  ---to Identify the Duplicates in the Animal Id column , we used  A CTE to collect the data so it's easier to delete the Duplicates. we use the partition by 
  -- show how many duplicates each value has , the row number function must have an over caluse with order by so we have to use order by , a CTE can't be excuted on its own
  -- it needs a select statment at the end to run with it , after deleting it ,u can check that there are no more duplicates using the where statment 

  With [Austin_Animal_Center_Outcomes$-CTE]as 
  (
  select [Animal ID], ROW_NUMBER() over (partition by  [Animal ID] order by [Animal ID] )   as DuplicatesID
  from [dbo].[Austin_Animal_Center_Outcomes$]
  )
  select*
  from [Austin_Animal_Center_Outcomes$-CTE]
  --where DuplicatesID >1

  delete DuplicatesID from [Austin_Animal_Center_Outcomes$-CTE]
  where DuplicatesID >1

  select *
  from Austin_Animal_Center_Outcomes$

  --Removing the Time stamp from the DateTime & date of birth columns
  Alter table Austin_Animal_Center_Outcomes$
  add intakedate date;
  alter table Austin_Animal_Center_Outcomes$
  add DOB date;

  update Austin_Animal_Center_Outcomes$
  set intakedate= CONVERT(date,DateTime)

  update Austin_Animal_Center_Outcomes$
  set DOB= convert (DATE, [Date of Birth])

  Alter table Austin_Animal_Center_Outcomes$
  drop column [DateTime], [Date of Birth] 

Alter table Austin_Animal_Center_Outcomes$
  drop column [Outcome Subtype]
 
   select *
  from Austin_Animal_Center_Outcomes$
  where [Outcome Type] = 'Adoption'
  order by 8
  