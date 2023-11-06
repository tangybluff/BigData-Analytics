--I want to see what operators I have available.
select * FROM operators;

--I want to see what weapons I have available.
SELECT * FROM weapons;

--My operators have multiple primary and secondary weapons and gadgets availble, how do I make a table to get an operator with their primary weapon, type, damage, and ROF?
--Because I have multiple primary and secondary weapons, I will associate Primary1 to a single operator. 
WITH PrimaryWeapons AS (
    SELECT o.Name AS Operator, w.Name AS PrimaryWeapon, w.Type, w.Damage, w.ROF
    FROM operators o
    JOIN weapons w ON o.Primary1 = w.Name
)
SELECT * FROM PrimaryWeapons;
--Understand SQL logic first, cry later.