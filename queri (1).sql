SET SQL_SAFE_UPDATES=0;
#1 (su Python)
UPDATE Passeggero 
SET 
    email = 'a.gibaldi@gmail.com'
WHERE
    ID_pass = '1232932'
;

##2
#trova la categoria di equipaggio che ha svolto più ore nell'ultimo periodo e quante ne ha svolte
SELECT 
    ruolo, SUM(working_hours)
FROM
    Equipaggio
GROUP BY ruolo
HAVING SUM(working_hours) >= ALL (SELECT 
        SUM(working_hours)
    FROM
        Equipaggio
    GROUP BY ruolo)
;

####3
#seleziona nome e cognome dei passeggeri che hanno prenotato almeno una volta per quattro persone
SELECT 
    nome, surname
FROM
    Passeggero
WHERE
    ID_pass IN (SELECT 
            ID_pass
        FROM
            Prenotazione
        WHERE
            n_passengers >= 4)
GROUP BY surname, nome;

####4
#trova nome, cognome e email del passeggero che ha piu punti fedelta
SELECT 
    nome, surname, email
FROM
    Passeggero
WHERE
    ID_pass IN (SELECT 
            ID_pass
        FROM
            Programma_fedelta
        WHERE
			points = (SELECT 
                    points
                FROM
                    Programma_fedelta where points = (select max(points) from Programma_fedelta)))
;

#####5 (su Python)
#Inserisci una prenotazione regalo a chi ha più punti fedeltà facendogli scegliere tra tre viaggi differenti
drop trigger Assegnapunti;
Insert into Prenotazione values ('sedr', (SELECT 
            ID_pass
        FROM
            Programma_fedelta
        WHERE
			points = (SELECT 
                    points
                FROM
                    Programma_fedelta where points = (select max(points) from Programma_fedelta))),Null,'ADM39',1,2,'si','premium')
;

######6
#trova il nome del membro dell'equipaggio che ha viaggiato più volte sulla sua rotta preferita
SELECT 
    ID_dip, COUNT(ID_dip) AS c
FROM
    (SELECT 
        Ciurma.ID_dip, Viaggio.ID_rotta, Equipaggio.fav_route
    FROM
        Ciurma
    INNER JOIN Viaggio ON Ciurma.ID_viaggio = Viaggio.ID_viaggio
    INNER JOIN Equipaggio ON Ciurma.ID_dip = Equipaggio.ID_dip) AS a
WHERE
    fav_route = ID_rotta
GROUP BY ID_dip
ORDER BY c desc
LIMIT 1 OFFSET 0;

#######7 (su Python)
#Modifica la sede di lavoro degli impiegati che rispettano le seguenti caratteristiche
UPDATE Impiegati 
SET 
    office = 'Napoli'
WHERE  type_of_contract = 'a tempo indeterminato'
	AND ID_dip IN (SELECT 
            ID_dip
        FROM
            Dipendenti
        WHERE
            ID_dip like '%1' or ID_dip like '%2'
                or ID_dip like '%3');

########8
#selezionare l'ID del treno passeggeri che ha percorso più volte la rotta in generale più percorsa
SELECT
ID_tp
FROM
    Viaggio
WHERE
    (ID_rotta = (SELECT
            a.ID
        FROM
            (SELECT
                ID_rotta AS ID, COUNT(ID_rotta) AS C
            FROM
                Viaggio
            GROUP BY ID
            ORDER BY C DESC) AS a
        LIMIT 1 OFFSET 0))
GROUP BY ID_tp
ORDER BY COUNT(ID_tp) DESC
LIMIT 1 OFFSET 0;

#########9
#trova l'email dei passeggeri che hanno diritto ad un  risarcimento
SELECT 
    email
FROM
    Passeggero
WHERE
    ID_pass IN (SELECT 
            bc.d
        FROM
            (SELECT 
                Assicurazione.compensation AS a, Prenotazione.ID_pass AS d
            FROM
                Assicurazione
            INNER JOIN Prenotazione ON Prenotazione.ID_pren = Assicurazione.ID_pren
            WHERE
                state = 'da pagare') AS bc);

