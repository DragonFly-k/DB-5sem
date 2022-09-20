CREATE TABLE Persons (
P_Id int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);

CREATE VIEW London_view 
AS SELECT * FROM Persons
WHERE City = 'London';

--drop table Persons;
--drop view London_view;
