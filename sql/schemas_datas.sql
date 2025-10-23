
CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;

CREATE TABLE filme (
  id_film BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  titlu VARCHAR(100) NOT NULL,
  gen VARCHAR(50) NOT NULL,
  an_lansare YEAR NOT NULL,
  durata_min INT NOT NULL,
  rating DECIMAL(3,1),
  PRIMARY KEY (id_film)
);


CREATE TABLE producatori (
  id_producator BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nume VARCHAR(100) NOT NULL,
  tara_origine VARCHAR(50),
  an_fondare YEAR,
  PRIMARY KEY (id_producator)
);

CREATE TABLE actori (
  id_actor BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_film BIGINT UNSIGNED NOT NULL,
  id_producator BIGINT UNSIGNED NOT NULL,
  nume VARCHAR(100) NOT NULL,
  rol VARCHAR(100),
  PRIMARY KEY (id_actor)
);

ALTER TABLE actori
ADD CONSTRAINT fk_actori_film
FOREIGN KEY (id_film) REFERENCES filme(id_film)
ON DELETE CASCADE;

ALTER TABLE actori
ADD CONSTRAINT fk_actori_producator
FOREIGN KEY (id_producator) REFERENCES producatori(id_producator)
ON DELETE CASCADE;


INSERT INTO filme (titlu, gen, an_lansare, durata_min, rating)
VALUES
('Inception', 'SF', 2010, 148, 8.8),
('The Dark Knight', 'Actiune', 2008, 152, 9.0),
('Interstellar', 'SF', 2014, 169, 8.6),
('Tenet', 'Thriller', 2020, 150, 7.5),
('Dunkirk', 'Razboi', 2017, 106, 7.9);

INSERT INTO producatori (nume, tara_origine, an_fondare)
VALUES
('Warner Bros', 'SUA', 1923),
('Syncopy', 'Marea Britanie', 2001),
('Legendary Pictures', 'SUA', 2000),
('Paramount Pictures', 'SUA', 1912),
('Emma Thomas', 'Marea Britanie', 2000);


INSERT INTO actori (id_film, id_producator, nume, rol)
VALUES
(1, 1, 'Leonardo DiCaprio', 'Cobb'), -- Inception (1), Warner Bros (1)
(1, 2, 'Joseph Gordon-Levitt', 'Arthur'), -- Inception (1), Syncopy (2)
(2, 1, 'Christian Bale', 'Bruce Wayne'), -- The Dark Knight (2), Warner Bros (1)
(2, 3, 'Heath Ledger', 'Joker'), -- The Dark Knight (2), Legendary Pictures (3)
(3, 4, 'Matthew McConaughey', 'Cooper'), -- Interstellar (3), Paramount Pictures (4)
(3, 5, 'Anne Hathaway', 'Brand'), -- Interstellar (3), Emma Thomas (5)
(4, 2, 'John David Washington', 'Protagonist'), -- Tenet (4), Syncopy (2)
(4, 1, 'Robert Pattinson', 'Neil'), -- Tenet (4), Warner Bros (1)
(5, 3, 'Tom Hardy', 'Farrier'), -- Dunkirk (5), Legendary Pictures (3)
(5, 2, 'Cillian Murphy', 'Shivering Soldier'); -- Dunkirk (5), Syncopy (2)