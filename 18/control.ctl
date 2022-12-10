LOAD DATA 
INFILE 'C:\Users\Kate\AppData\Roaming\SQL Developer\import.txt'
DISCARDFILE 'C:\Users\Kate\AppData\Roaming\SQL Developer\import_data.dis'
INTO TABLE orders
FIELDS TERMINATED BY ","
(
id "round(:id, 2)",
text "upper(:text)",
date_value date "DD.MM.YYYY"
)