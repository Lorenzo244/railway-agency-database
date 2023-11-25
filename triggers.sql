CREATE 
    TRIGGER  Assegnapunti
 AFTER INSERT ON Prenotazione FOR EACH ROW 
    UPDATE Programma_fedelta SET points = points + 5 WHERE
        Programma_fedelta.ID_pass = new.ID_pass
;
       
CREATE 
    TRIGGER  Licenziamento_equipaggio
 AFTER DELETE ON Dipendenti FOR EACH ROW 
    DELETE FROM Equipaggio WHERE
        ID_dip = old.ID_dip;
       
CREATE 
    TRIGGER  Licenziamento_impiegati
 AFTER DELETE ON Dipendenti FOR EACH ROW 
    DELETE FROM Impiegati WHERE
        ID_dip = old.ID_dip;
        
        
