//usuniecie i odzyskanie tabeli
DROP TABLE Regions CASCADE CONSTRAINTS;

FLASHBACK TABLE Regions TO BEFORE DROP;