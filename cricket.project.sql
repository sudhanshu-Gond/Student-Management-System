show databases;
use sudhanshu;

create table teams(
team_id int primary key auto_increment,
team_name varchar(40) not null,
Coach_name varchar(50) not null,
Captain_name varchar(40) not null
);

create table player(
player_id int primary key,
player_name varchar(40) not null,
age int,
role varchar(40),
team_id int,
foreign key(team_id) References teams(team_id)
);

create table matches(
match_id int primary key,
team1_id int,
team2_id int,
match_date date,
venue varchar(100),
winner_team_id int,
foreign key(team1_id) references teams(team_id),
foreign key(team2_id) references teams(team_id),
foreign key(winner_team_id) references teams(team_id)
);

CREATE TABLE scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    team_id INT,
    runs INT,
    wickets INT,
    overs DECIMAL(4,1),

    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE player_performance (
    performance_id INT PRIMARY KEY ,
    player_id INT,
    match_id INT,
    runs_scored INT,
    balls_faced INT,
    wickets_taken INT,

    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);

INSERT INTO teams (team_id,team_name, coach_name, captain_name)
VALUES
(101,'India', 'Sudhanshu', 'Mayuresh Kuveshkar'),
(102,'Australia', 'Rajan', 'Anuj Pathak'),
(103,'England', 'Nikhil', 'Sundaram Singh'),
(104,'Pakistan', 'Omkar', 'Rohan');

select * from teams;

insert into player(player_id,player_name,age,role,team_id)
values(1,'Mayuresh kuveshkar',19,'Batsman',101),
(2,'Rohan chougle',21,'Bowler',101),
(3,'Suddu Gond',18,'All Rounder',101),

(4,'Durgesh',21,'Batsman',102),
(5,'Suraj',22,'Bowler',102),
(6,'Raj',23,'All Rounder',102),

(7,'Sagar',23,'Batsman',103),
(8,'Lov',24,'Bowler',103),
(9,'Vivek',21,'All Rounder',103),

(10,'Krish',22,'Betsman',104),
(11,'Akshay',19,'Bowler',104),
(12,'Satyam',21,'All Rounder',104);

select * from player;

insert into matches(match_id,team1_id,team2_id,match_date,venue,winner_team_id)
values(401,101,102,'2026-06-12','Mumbai stadium',101),
(402,103,104,'2026-06-18','Eden garden stadium',104);

select * from matches;

insert into scores(score_id,match_id,team_id,runs,wickets,overs)
values(202,401,101,156,23,20.0),
(203,401,102,178,22,20.0),

(302,402,103,187,20,20.0),
(303,402,104,78,33,20.0);
select * from scores;

insert into player_performance(performance_id,player_id,match_id,runs_scored,balls_faced,wickets_taken)
values(12,1,401,156,87,23),
(19,2,401,178,101,22),
(8,3,402,187,101,20),
(10,4,402,78,50,33);
select * from player_performance;

SELECT 
m.match_id,
t1.team_name AS Team_1,
t2.team_name AS Team_2,
m.match_date,
m.venue
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id;

SELECT
p.player_name,
SUM(pp.runs_scored) AS Total_Runs
FROM player_performance pp
JOIN player p
ON pp.player_id = p.player_id
GROUP BY p.player_name
ORDER BY Total_Runs DESC;

SELECT
p.player_name,
SUM(pp.wickets_taken) AS Total_Wickets
FROM player_performance pp
JOIN player p
ON pp.player_id = p.player_id
GROUP BY p.player_name
ORDER BY Total_Wickets DESC;

SELECT
t.team_name,
SUM(s.runs) AS Total_Runs
FROM scores s
JOIN teams t
ON s.team_id = t.team_id
GROUP BY t.team_name;

SELECT
p.player_name,
p.role,
t.team_name
FROM player p
JOIN teams t
ON p.team_id = t.team_id;

DELIMITER //

CREATE PROCEDURE MatchResult()
BEGIN
    SELECT
    m.match_id,
    t1.team_name AS Team1,
    t2.team_name AS Team2,
    tw.team_name AS Winner
    FROM matches m
    JOIN teams t1 ON m.team1_id = t1.team_id
    JOIN teams t2 ON m.team2_id = t2.team_id
    JOIN teams tw ON m.winner_team_id = tw.team_id;
END //

DELIMITER ;

CALL MatchResult();
