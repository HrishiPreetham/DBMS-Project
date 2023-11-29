create database csdbms;
use csdbms;
create table Country(CountryID INT NOT NULL AUTO_INCREMENT,CountryName VARCHAR(255) NOT NULL,PRIMARY KEY(CountryID));

create table League(LeagueID INT NOT NULL AUTO_INCREMENT,LeagueName VARCHAR(255) NOT NULL,HostID INT NOT NULL,FOREIGN KEY(HostID) references Country(CountryID),PRIMARY KEY(LeagueID));

create table Franchise(FranchiseID INT NOT NULL AUTO_INCREMENT,FranchiseName VARCHAR(255) NOT NULL,Trophies INT NOT NULL DEFAULT 0,TeamPoints INT NOT NULL,LeagueID INT NOT NULL,FOREIGN KEY(LeagueID) references League(LeagueID),PRIMARY KEY(FranchiseID));

create table Selectors(SelectorID INT NOT NULL AUTO_INCREMENT,SelectorName VARCHAR(255) NOT NULL,Role VARCHAR(255) NOT NULL,FranchiseID INT NOT NULL, FOREIGN KEY(FranchiseID) references Franchise(FranchiseID),PRIMARY KEY(SelectorID));

create table Coach(CoachID INT NOT NULL AUTO_INCREMENT,CoachName VARCHAR(255) NOT NULL,Specialist VARCHAR(255) NOT NULL,FranchiseID INT NOT NULL,FOREIGN KEY(FranchiseID) references Franchise(FranchiseID),PRIMARY KEY(CoachID));

create table Player(PlayerID INT NOT NULL AUTO_INCREMENT,PlayerName VARCHAR(255) NOT NULL,Matches INT NOT NULL,Specialist VARCHAR(255) NOT NULL,CountryID INT NOT NULL,FranchiseID INT NOT NULL,FOREIGN KEY(CountryID) references Country(CountryID),FOREIGN KEY(FranchiseID) references Franchise(FranchiseID),PRIMARY KEY(PlayerID));

create table OverallBattingStats(Runs INT NOT NULL DEFAULT 0,StrikeRate DECIMAL(10,2) NOT NULL DEFAULT 0.0,BattingAverage DECIMAL(10,2) NOT NULL DEFAULT 0.0,NumberOf100s INT NOT NULL DEFAULT 0,NumberOF50s INT NOT NULL DEFAULT 0,PlayerID INT NOT NULL,FOREIGN KEY(PlayerID) references Player(PlayerID),PRIMARY KEY(PlayerID));

create table OverallBowlingStats(Wickets INT NOT NULL DEFAULT 0, BowlingAverage DECIMAL(10,2) NOT NULL DEFAULT 0.0,ECONOMY DECIMAL(10,2) NOT NULL DEFAULT 0.0,FiveWicketHauls INT NOT NULL DEFAULT 0,PlayerID INT NOT NULL, FOREIGN KEY(PlayerID) references Player(PlayerID),PRIMARY KEY(PlayerID));

create table RecentPerformance(Wickets INT NOT NULL DEFAULT 0,Runs INT NOT NULL DEFAULT 0,Economy DECIMAL(10,2) NOT NULL DEFAULT 0.0,StrikeRate DECIMAL(10,2) NOT NULL DEFAULT 0.0,PlayerID INT NOT NULL,FOREIGN KEY(PlayerID) references Player(PlayerID),PRIMARY KEY(PlayerID));

alter table selectors drop role;


insert into country values(1,'Australia');
insert into country values(2,'Afganistan');
insert into country values(3,'Bangladesh');
insert into country values(4,'England');
insert into country values(5,'India');
insert into country values(6,'Pakistan');
insert into country values(7,'New Zealand');
insert into country values(8,'South Africa');
insert into country values(9,'Sri Lanka');
insert into country values(10,'West Indies');


insert into league values(1,'Indian Premier League',5);
insert into league values(2,'Big Bash League',1);
insert into league values(3,'Carribean Premier League',10);
insert into league values(5,'Bangladesh Premier League',3);
insert into league values(6,'Lanka Premier League',9);
insert into league values(7,'SA20',8);
insert into league values(8,'The 100',4);

insert into franchise values(1,'Mumbai Indians',5,14,1);
insert into franchise values(2,'Chennai Super Kings',5,16,1);
insert into franchise values(3,'Lucknow Super Giants',0,15,1);
insert into franchise values(4,'Gujarat Titans',1,18,1);
insert into franchise values(5,'Rajastan Royals',1,14,1);
insert into franchise values(6,'Royal Challengers Bangalore',0,14,1);
insert into franchise values(7,'Kolkata Knight Riders',2,12,1);
insert into franchise values(8,'Punjab Kings',0,10,1);
insert into franchise values(9,'Delhi Capitals',0,8,1);
insert into franchise values(10,'Sunrisers Hyderabad',1,8,1);
insert into franchise values(11,'Perth Scorchers',5,22,2);
insert into franchise values(12,'Sydney Sixers',3,21,2);
insert into franchise values(13,'Melbourne Renegades',1,14,2);
insert into franchise values(14,'Sydney Thunders',1,14,2);
insert into franchise values(15,'Brisbane Heats',1,13,2);
insert into franchise values(16,'Hobart Hurricanes',0,12,2);
insert into franchise values(17,'Adelaide Strikers',1,10,2);
insert into franchise values(18,'Melbourne Stars',0,6,2);
insert into franchise values(19,'Guyana Amazon Warriors',1,17,3);
insert into franchise values(20,'Trinbago Knight Riders',4,13,3);
insert into franchise values(21,'Saint Lucia Kings',0,10,3);
insert into franchise values(22,'Jamaica Tallawahs',3,9,3);
insert into franchise values(23,'Barbados Royals',2,7,3);
insert into franchise values(24,'St.Kitts and Nevis Patriots',1,4,3);
insert into franchise values(25,'Lahore Qalandars',2,14,4);
insert into franchise values(26,'Multan Sultans',1,12,4);
insert into franchise values(27,'Islamabad United',2,12,4);
insert into franchise values(28,'Peshawar Zalmi',1,10,4);
insert into franchise values(29,'Karachi Kings',1,6,4);
insert into franchise values(30,'Quetta Gladiators',1,6,4);
insert into franchise values(31,'Pretoria Capitals',0,32,7);
insert into franchise values(32,'Johannesburg Super Kings',0,27,7);
insert into franchise values(33,'Sunrisers Eastern Cape',1,19,7);
insert into franchise values(34,'Pretoria Royals',4,19,7);
insert into franchise values(35,'Durban Super Giants',0,19,7);
insert into franchise values(36,'MI Cape Town',0,13,7);
insert into franchise values(37,'Oval Invincibles',1,13,8);
insert into franchise values(38,'Manchester Originals',0,9,8);
insert into franchise values(39,'Southern Brave',1,9,8);
insert into franchise values(40,'Welsh Fire',0,9,8);
insert into franchise values(41,'Trent Rockets',1,7,8);
insert into franchise values(42,'Birmingham Phoenix',0,6,8);
insert into franchise values(43,'London Spirit',0,6,8);
insert into franchise values(44,'Northern Superchargers',0,5,8);
insert into franchise values(45,'Comilla Victorians',4,18,5);
insert into franchise values(46,'Dhaka Gladiators',3,6,5);
insert into franchise values(47,'Rangpur Riders',3,16,5);
insert into franchise values(48,'B-Love Kandy',1,8,6);
insert into franchise values(49,'Jaffna Kings',3,6,6);
insert into franchise values(50,'Galle Titans',0,8,6);
insert into franchise values(51,'Canterbury',3,24,9);
insert into franchise values(52,'Otago',0,24,9);
insert into franchise values(53,'Wellington',1,16,9);

insert into coach values(12,'Greg Shipperd','Head',12);
insert into coach values(13,'David Saker','Batting',13);
insert into coach values(14,'Trevor Bayliss','Head',14);
insert into coach values(15,'Wade Seccombe','Bowling',15);
insert into coach values(16,'Adam Griffith','Batting',16);
insert into coach values(17,'Jason Gillespie','Bowling',17);
insert into coach values(18,'Peter Moores','Head',18);
insert into coach values(19,'Rayon Griffith','Head',19);
insert into coach values(20,'Phil Simmons','Batting',20);
insert into coach values(21,'Daren Sammy','Batting',21);
insert into coach values(22,'Shivnarine Chanderpaul','Batting',22);
insert into coach values(23,'Trevor Penny','Head',23);
insert into coach values(24,'Malolan Rangarajan','Head',24);
insert into coach values(25,'Aaqib Javed','Bowling',25);
insert into coach values(26,'Abdul Rehman','Bowling',26);
insert into coach values(27,'Azhar Mahmood','Head',27);
insert into coach values(28,'James Foster','Bowling',28);
insert into coach values(29,'Johan Botha','Bowling',29);
insert into coach values(30,'Moin Khan','Head',30);
insert into coach values(31,'Graham Ford','Head',31);
insert into coach values(32,'Albie Morkel','Batting',32);
insert into coach values(33,'Adrian Birell','Head',33);
insert into coach values(34,'Brad Haddin','Batting',34);
insert into coach values(35,'Jason Douglas','Head',35);
insert into coach values(36,'Robin Peterson','Bowling',36);
insert into coach values(37,'Tom Moody','Batting',37);
insert into coach values(38,'Simon Katich','Batting',38);
insert into coach values(39,'Charlotte Edwards','Batting',39);
insert into coach values(40,'Micheal Hussey','Batting',40);
insert into coach values(41,'Jon Lewis','Head',41);
insert into coach values(42,'Daniel Vettori','Bowling',42);
insert into coach values(43,'Ashley Noffke','Head',43);
insert into coach values(44,'James Foster','Head',44);
insert into coach values(45,'Mohammad Salahuddin','Head',45);
insert into coach values(46,'Ian Pont','Bowling',46);
insert into coach values(47,'Shane Jurgensen','Head',47);
insert into coach values(48,'Mushtaq Ahmed','Bowling',48);
insert into coach values(49,'Thilina Kandamby','Head',49);
insert into coach values(50,'Chamara Kapugedera','Head',50);
insert into coach values(51,'Cameron Ciraldo','Head',51);
insert into coach values(52,'Dion Ebrahim','Head',52);
insert into coach values(53,'Shane Jurgensen','Batting',53);


insert into selectors values(1,'Julia Preston',1);
insert into selectors values(2,'Vincenzo Frost',2);
insert into selectors values(3,'Paula Collier',3);
insert into selectors values(4,'Edison Warner',4);
insert into selectors values(5,'Wynter Hail',5);
insert into selectors values(6,'Hector Roberson',6);
insert into selectors values(7,'Sasha Pham',7);
insert into selectors values(8,'Russell Allen',8);
insert into selectors values(9,'Riley Reeves',9);
insert into selectors values(10,'Clark Johns',10);
insert into selectors values(11,'Giovanna Wright',11);
insert into selectors values(12,'Grayson Peck',12);
insert into selectors values(13,'Crystal Enriquez',13);
insert into selectors values(14,'Elisha Hayden',14);
insert into selectors values(15,'Avayah Vazquez',15);
insert into selectors values(16,'Jesse Bernal',16);
insert into selectors values(17,'Emmeline Preston',17);
insert into selectors values(18,'Vincenzo Osborne',18);
insert into selectors values(19,'Shelby Graves',19);
insert into selectors values(20,'Cesar Hansen',20);
insert into selectors values(21,'Hope Hampton',21);
insert into selectors values(22,'Hank Reid',22);
insert into selectors values(23,'Charlee Kline',23);
insert into selectors values(24,'Ramon Cline',24);
insert into selectors values(25,'Lina Novak',25);
insert into selectors values(26,'Bishop Sosa',26);
insert into selectors values(27,'Cassandra Hebert',27);
insert into selectors values(28,'Guillermo Rhodes',28);
insert into selectors values(29,'Tatum Rivers',29);
insert into selectors values(30,'Bear Reese',30);
insert into selectors values(31,'Rosemary Baxter',31);
insert into selectors values(32,'Tomas Donaldson',32);
insert into selectors values(33,'Natasha Gutierrez',33);
insert into selectors values(34,'Luca Tate',34);
insert into selectors values(35,'Skye Caldwell',35);
insert into selectors values(36,'Rylan Kirk',36);
insert into selectors values(37,'Ellis Ortega',37);
insert into selectors values(38,'Kobe Horton',38);
insert into selectors values(39,'Aitana Price',39);
insert into selectors values(40,'Brooks Kent',40);
insert into selectors values(41,'Jazmine Arnold',41);
insert into selectors values(42,'Abraham Kaur',42);
insert into selectors values(43,'Holland Clayton',43);
insert into selectors values(44,'Boston Mosley',44);
insert into selectors values(45,'Zaniyah Skinner',45);
insert into selectors values(46,'Ridge Wilkinson',46);
insert into selectors values(47,'Siena Maxwell',47);
insert into selectors values(48,'Eden Curtis',48);
insert into selectors values(49,'Alexis Vu',49);
insert into selectors values(50,'Kamdyn Rodriguez',50);
insert into selectors values(51,'Evelyn Suarez',51);
insert into selectors values(52,'Soren Reeves',52);
insert into selectors values(53,'Lana McKenzie',53);


insert into player values(1,'Rohit Sharma',148,'Batsman',5,1);
insert into player values(2,'Suryakumar Yadav',139,'Batsman',5,1);
insert into player values(3,'Cameron Green',8,'All rounder',1,1);
insert into player values(4,'Ruturaj Gaikwad',52,'Batsman',5,2);
insert into player values(5,'Ravindra Jadeja',226,'All rounder',5,2);
insert into player values(6,'Dwayne Pretorius',30,'Bowler',8,2);
insert into player values(7,'K L Rahul',72,'Batsman',5,3);
insert into player values(8,'Kyle Mayers',29,'Batsman',10,3);
insert into player values(9,'Krishnappa Gautham',35,'All rounder',5,3);
insert into player values(10,'Shubhman Gill',11,'Batsman',5,4);
insert into player values(11,'Hardik Pandya',92,'All rounder',5,4);
insert into player values(12,'Rashid Khan',82,'All rounder',2,4);
insert into player values(13,'Sanju Samson',24,'Batsman',5,5);
insert into player values(14,'Devdutt Padikkal',57,'Batsman',5,5);
insert into player values(15,'Joe Root',32,'Batsman',4,5);
insert into player values(16,'Virat Kohli',115,'Batsman',5,6);
insert into player values(17,'Glenn Maxwell',98,'All rounder',1,6);
insert into player values(18,'Mohammed Siraj',79,'Bowler',5,6);
insert into player values(19,'Shreyas Iyer',49,'Batsman',5,7);
insert into player values(20,'Rinku Singh',31,'Batsman',5,7);
insert into player values(21,'Jason Roy',64,'Batsman',4,7);
insert into player values(22,'Prabhsimran SIngh',20,'Batsman',5,8);
insert into player values(23,'Sam Curran',41,'All rounder',4,8);
insert into player values(24,'Arshdeep Singh','Bowler',36,5,8);
insert into player values(25,'Yash Dhull',4,'Batsman',5,9);
insert into player values(26,'Axar Patel',45,'All rounder',5,9);
insert into player values(27,'Philip Salt',16,'Batsman',8,9);
insert into player values(28,'Mayank Agarwal',123,'Batsman',5,10);
insert into player values(29,'Aiden Markram',37,'All rounder',8,10);
insert into player values(30,'Umran Malik',25,'Bowler',5,10);
insert into player values(31,'Ashton Turner', 77, 'All rounder',1, 11);
insert into player values(32,'Cameron Bancroft', 69, 'All rounder',1, 11);
insert into player values(33,'Faf du Plessis', 63, 'Batsman',8, 11);
insert into player values(34,'Moises Henriques','Batsman', 125, 1, 12);
insert into player values(35,'Jordan Silk', 113, 'Batsman',1, 12);
insert into player values(36,'Josh Philippe', 78,'Batsman', 1, 12);
insert into player values(37,'Aaron Finch', 92, 'Batsman',1, 13);
insert into player values(38,'Nic Maddinson', 83, 'Batsman',1, 13);
insert into player values(39,'Andre Russell', 67, 'Batsman',10, 13);
insert into player values(40,'Matthew Gilkes', 69, 'Batsman',1, 14);
insert into player values(41,'Alex Hales', 61,'All rounder', 4, 14);
insert into player values(42,'Daniel Sams', 55,'Batsman', 1, 14);
insert into player values(43,'Usman Khawaja', 77,'Batsman', 1, 15);
insert into player values(44,'Marnus Labuschagne', 69,'Batsman', 1, 15);
insert into player values(45,'Jimmy Neesham', 63,'Batsman', 7, 15);
insert into player values(46,'Matthew Wade', 85,'Batsman', 1, 16);
insert into player values(47,'D Arcy Short', 79,'Batsman', 1, 16);
insert into player values(48,'Ben McDermott', 66,'Batsman', 1, 16);
insert into player values(49,'Travis Head', 91,'Batsman', 1, 17);
insert into player values(50,'Alex Carey', 87, 'All rounder',1, 17);
insert into player values(51,'Colin Ingram', 67, 'All rounder',8, 17);
insert into player values(52,'Marcus Stoinis', 99, 'All rounder',1, 18);
insert into player values(53,'Adam Zampa', 91, 'All rounder',1, 18);
insert into player values(54,'Andre Russell', 67, 'All rounder',10, 18);
insert into player values(55,'Shimron Hetmyer', 65,'Batsman',10, 19);
insert into player values(56,'Nicholas Pooran', 59, 'Batsman',10, 19);
insert into player values(57,'Romario Shepherd', 57,'All rounder',10, 19);
insert into player values(58,'Kieron Pollard', 71,'All rounder', 10, 20);
insert into player values(59,'Colin Munro', 69, 'All rounder',7, 20);
insert into player values(60,'Dwayne Bravo', 65,'All rounder', 10, 20);
insert into player values(61,'Roshon Primus', 59, 'All rounder',8, 21);
insert into player values(62,'Roston Chase', 56, 'Batsman',10, 21);
insert into player values(63,'Alzarri Joseph', 51, 'All rounder',10, 21);
insert into player values(64,'Andre Russell', 67, 'All rounder',10, 22);
insert into player values(65,'Brandon King', 65, 'All rounder',10, 22);
insert into player values(66,'Rovman Powell', 59, 'All rounder',10, 22);
insert into player values(67,'Obed McCoy', 107,'All rounder', 10, 23);
insert into player values(68,'Jason Holder', 85, 'All rounder', 10, 23);
insert into player values(69,'Rahkeem Cornwall', 64,'All rounder', 10, 23);
insert into player values(70,'Evin Lewis', 83,'All rounder', 10, 24);
insert into player values(71,'Sherfane Rutherford', 62, 'All rounder',10, 24);
insert into player values(72,'Devon Thomas', 59, 'All rounder',10, 24);
insert into player values(73,'Shaheen Afridi', 53, 'Bowler', 6, 25);
insert into player values(74,'David Wiese', 59, 'All rounder',8, 25);
insert into player values(75,'Fakhar Zaman', 67, 'Batsman',6, 25);
insert into player values(76,'Mohammed Rizwan',97,'Batsman',6,26);
insert into player values(77,'Rilee Rossouw',62,'Batsman',8,26);
insert into player values(78,'Khushdil Shah',92,'All rounder',6,26);
insert into player values(79,'Colin Munro', 62,'All rounder', 7, 27);
insert into player values(80,'Asif Ali', 99,'All rounder', 6, 27);
insert into player values(81,'Faheem Ashraf', 76,'All rounder', 6, 27);


insert into overallbattingstats values(3853,139,31,4,29,1);
insert into overallbattingstats values(1841,173,46,3,15,2);
insert into overallbattingstats values(139,174,17,0,2,3);
insert into overallbattingstats values(1797,39,136,1,14,4);
insert into overallbattingstats values(2692,129,26,0,2,5);
insert into overallbattingstats values(44,157.14,11,0,0,6);
insert into overallbattingstats values(2265,139.13,38,2,22,7);
insert into overallbattingstats values(379,144.11,29.15,0,4,8);
insert into overallbattingstats values(247, 166.89, 13.72, 0, 1,9);
insert into overallbattingstats values(2790,134.07,37.70,3,18,10);
insert into overallbattingstats values(2275,133.33,32.25,2,12,11);
insert into overallbattingstats values(1225, 153.91, 25.63, 2, 6,12);
insert into overallbattingstats values(2317, 139.41, 29.56, 2, 14,13);
insert into overallbattingstats values(1681, 134.62, 28.41, 2, 9,14);
insert into overallbattingstats values(1263, 122.42, 32.42, 2, 7,15);
insert into overallbattingstats values(7263, 131.33, 37.25, 7, 50,16);
insert into overallbattingstats values(2723, 153.33, 30.50, 5, 18,17);
insert into overallbattingstats values(97,87.39,12.12,0,0,18);
insert into overallbattingstats values(2776,125.38,31.55,0,19,19);
insert into overallbattingstats values(725, 149.52, 59.25, 0, 2,20);
insert into overallbattingstats values(614, 138.60, 32.32, 0, 4,21);
insert into overallbattingstats values(422, 127.27, 21.10, 1, 1,22);
insert into overallbattingstats values(613, 135.96, 24.52, 0, 3,23);
insert into overallbattingstats values(72, 100.00, 18.00, 0, 0,24);
insert into overallbattingstats values(13, 69.56, 5.33, 0, 0,25);
insert into overallbattingstats values(1418, 130.81, 20.55, 0, 1,26);
insert into overallbattingstats values(188, 138.88, 37.60, 1, 2,27);
insert into overallbattingstats values(1188, 139.09, 34.52, 3, 6,28);
insert into overallbattingstats values(1376, 144.60, 35.02, 3, 6,29);
insert into overallbattingstats values(2, 12.50, 2.00, 0, 0,30);
insert into overallbattingstats values(2107, 133.43, 40.51, 1, 14,31);
insert into overallbattingstats values(1617, 124.09, 33.68, 0, 12,32);
insert into overallbattingstats values(1509, 142.76, 29.01, 0, 13,33);
insert into overallbattingstats values(2732, 132.30, 29.06, 0, 15,34);
insert into overallbattingstats values(2017, 124.66, 31.51, 0, 6,35);
insert into overallbattingstats values(1994, 139.24, 29.76, 0, 16,36);
insert into overallbattingstats values(2988, 125.36, 43.00, 2, 23,37);
insert into overallbattingstats values(1853, 125.16, 35.47, 0, 11,38);
insert into overallbattingstats values(2354, 152.00, 33.60, 0, 12,39);
insert into overallbattingstats values(2345, 124.10, 40.40, 1, 16, 40);
insert into overallbattingstats values(1827, 121.50, 34.10, 0, 13, 41);
insert into overallbattingstats values(1615, 130.10, 32.30, 0, 12, 42);
insert into overallbattingstats values(2493, 132.30, 32.76, 1, 16, 43);
insert into overallbattingstats values(2185, 128.00, 34.45, 0, 14, 44);
insert into overallbattingstats values(1867, 135.00, 29.50, 0, 13, 45);
insert into overallbattingstats values(2654, 132.30, 34.40, 1, 17, 46);
insert into overallbattingstats values(2236, 127.00, 35.60, 0, 15, 47);
insert into overallbattingstats values(2078, 137.00, 32.80, 0, 14, 48);
insert into overallbattingstats values(2897, 132.30, 37.40, 1, 18, 49);
insert into overallbattingstats values(2753, 129.00, 38.60, 0, 16, 50);
insert into overallbattingstats values(1965, 128.10, 35.60, 1, 14, 51);
insert into overallbattingstats values(3107, 132.30, 35.40, 1, 19, 52);
insert into overallbattingstats values(1234, 120.00, 25.00, 0, 8, 53);
insert into overallbattingstats values(2354, 152.00, 33.60, 0, 12, 54);
insert into overallbattingstats values(2178, 125.10, 34.40, 1, 14, 55);
insert into overallbattingstats values(1789, 122.50, 31.70, 0, 12, 56);
insert into overallbattingstats values(1698, 135.10, 29.90, 0, 11, 57);
insert into overallbattingstats values(2498, 125.10, 35.40, 1, 16, 58);
insert into overallbattingstats values(1987, 122.50, 33.70, 0, 14, 59);
insert into overallbattingstats values(1898, 135.10, 26.90, 0, 11, 60);
insert into overallbattingstats values(2098, 124.10, 39.40, 1, 15, 61);
insert into overallbattingstats values(1827, 125.50, 34.10, 0, 13, 62);
insert into overallbattingstats values(1287, 130.10, 27.70, 0, 10, 63);
insert into overallbattingstats values(2354, 152.00, 33.60, 0, 12, 64);
insert into overallbattingstats values(2107, 132.30, 35.40, 1, 19, 65);
insert into overallbattingstats values(1898, 135.10, 29.90, 0, 11, 66);
insert into overallbattingstats values(1698, 130.10, 29.90, 0, 11, 67);
insert into overallbattingstats values(1950, 130.10, 32.50, 1, 14, 68);
insert into overallbattingstats values(1827, 125.00, 34.10, 0, 13, 69);
insert into overallbattingstats values(2321, 135.10, 33.60, 1, 12, 70);
insert into overallbattingstats values(1876, 132.30, 35.40, 1, 19, 71);
insert into overallbattingstats values(1698, 130.10, 29.90, 0, 11, 72);
insert into overallbattingstats values(1287, 130.10, 27.70, 5, 15, 73);
insert into overallbattingstats values(2098, 124.10, 39.40, 1, 15, 74);
insert into overallbattingstats values(2354, 152.00, 33.60, 0, 12, 75);
insert into overallbattingstats values(3358, 134.50, 36.80, 1, 25, 76);
insert into overallbattingstats values(1965, 128.10, 35.60, 1, 14, 77);
insert into overallbattingstats values(1927, 135.10, 33.60, 0, 12, 78);
insert into overallbattingstats values(2098, 124.10, 39.40, 1, 15, 79);
insert into overallbattingstats values(2354, 152.00, 33.60, 0, 12, 80);
insert into overallbattingstats values(1950, 130.10, 32.50, 1, 14, 81);


insert into overallbowlingstats values(1,113,10,0,1);
insert into overallbowlingstats values(0,0,0,0,2);
insert into overallbowlingstats values(5,36,9,0,3);
insert into overallbowlingstats values(0,0,0,0,4);
insert into overallbowlingstats values(152,30,7.6,1,5);
insert into overallbowlingstats values(6,40,9.5,1,6);
insert into overallbowlingstats values(0,0,0,0,7);
insert into overallbowlingstats values(21, 37.10, 8.11, 0,8);
insert into overallbowlingstats values(21, 37.10, 8.11, 0,9);
insert into overallbowlingstats values(0,0,0,0,10);
insert into overallbowlingstats values(42,28.55,7.81,0,11);
insert into overallbowlingstats values(104, 20.13, 6.45, 3,12);
insert into overallbowlingstats values(0,0,0,0,13);
insert into overallbowlingstats values(0, 0, 0, 0,14);
insert into overallbowlingstats values(0,0,0,0,15);
insert into overallbowlingstats values(4, 42.50, 8.50, 0,16);
insert into overallbowlingstats values(21, 37.10, 8.11, 0,17);
insert into overallbowlingstats values(78, 29.83, 8.54, 2,18);
insert into overallbowlingstats values(0,0,0,0,19);
insert into overallbowlingstats values(0,0,0,0,20);
insert into overallbowlingstats values(0,0,0,0,21);
insert into overallbowlingstats values(0,0,0,0,22);
insert into overallbowlingstats values(42, 35.33, 8.19, 1,23);
insert into overallbowlingstats values(57, 27.14, 8.74, 0,24);
insert into overallbowlingstats values(0,0,0,0,25);
insert into overallbowlingstats values(171, 17.16, 7.18, 0,26);
insert into overallbowlingstats values(0,0,0,0,27);
insert into overallbowlingstats values(0,0,0,0,28);
insert into overallbowlingstats values(24, 28.75, 8.46, 0,29);
insert into overallbowlingstats values(22, 20.00, 8.36, 0,30);
insert into overallbowlingstats values(101, 26.15, 8.26, 4,31);
insert into overallbowlingstats values(95, 25.82, 8.34, 3,32);
insert into overallbowlingstats values(68, 25.21, 8.39, 2,33);
insert into overallbowlingstats values(433, 10.56, 114.55, 0,34);
insert into overallbowlingstats values(423, 17.62, 136.45, 0,35);
insert into overallbowlingstats values(310, 12.56, 112.30, 0,36);
insert into overallbowlingstats values(190, 26.35, 8.74, 4, 37);
insert into overallbowlingstats values(133, 29.05, 9.06, 1, 38);
insert into overallbowlingstats values(432, 24.70, 8.60, 17, 39);
insert into overallbowlingstats values(152, 25.10, 8.50, 3, 40);
insert into overallbowlingstats values(131, 26.50, 8.70, 2, 41);
insert into overallbowlingstats values(120, 27.10, 8.90, 1,42);
insert into overallbowlingstats values(101, 25.20, 8.70, 4,43);
insert into overallbowlingstats values(95, 26.50, 8.90, 3,44);
insert into overallbowlingstats values(81, 27.10, 9.10, 2,45);
insert into overallbowlingstats values(109, 25.10, 8.60, 4,46);
insert into overallbowlingstats values(99, 26.50, 8.80, 3,47);
insert into overallbowlingstats values(85, 27.10, 9.00, 2,48);
insert into overallbowlingstats values(127, 25.10, 8.50, 4,49);
insert into overallbowlingstats values(117, 26.50, 8.70, 3,50);
insert into overallbowlingstats values(95, 27.10, 8.90, 2,51);
insert into overallbowlingstats values(133, 25.10, 8.40, 4,52);
insert into overallbowlingstats values(121, 23.00, 7.50, 5,53);
insert into overallbowlingstats values(432, 24.70, 8.60, 17,54);
insert into overallbowlingstats values(78, 27.10, 8.50, 2,55);
insert into overallbowlingstats values(59, 27.50, 8.70, 1,56);
insert into overallbowlingstats values(57, 28.10, 8.90, 0,57);
insert into overallbowlingstats values(103, 27.10, 8.50, 2,58);
insert into overallbowlingstats values(89, 27.50, 8.70, 1,59);
insert into overallbowlingstats values(87, 28.10, 8.90, 0,60);
insert into overallbowlingstats values(88, 26.10, 8.50, 2,61);
insert into overallbowlingstats values(79, 26.50, 8.70, 1,62);
insert into overallbowlingstats values(67, 27.10, 8.90, 0,63);
insert into overallbowlingstats values(432, 24.70, 8.60, 17,64);
insert into overallbowlingstats values(133, 25.10, 8.40, 4,65);
insert into overallbowlingstats values(107, 26.50, 8.80, 3,66);
insert into overallbowlingstats values(87, 27.10, 8.90, 0,67);
insert into overallbowlingstats values(103, 26.10, 8.50, 2,68);
insert into overallbowlingstats values(88, 26.50, 8.70, 1,69);
insert into overallbowlingstats values(432, 24.70, 8.60, 17,70);
insert into overallbowlingstats values(133, 25.10, 8.40, 4,71);
insert into overallbowlingstats values(87, 27.10, 8.90, 0,72);
insert into overallbowlingstats values(107, 26.50, 8.80, 3,73);
insert into overallbowlingstats values(88, 26.10, 8.50, 2,74);
insert into overallbowlingstats values(432, 24.70, 8.60, 17,75);
insert into overallbowlingstats values(3, 27.10, 8.90, 0,76);
insert into overallbowlingstats values(43, 26.50, 8.80, 1,77);
insert into overallbowlingstats values(59, 24.70, 8.60, 2,78);
insert into overallbowlingstats values(1234, 120.00, 25.00, 0,79);
insert into overallbowlingstats values(95, 27.10, 8.90, 2,80);
insert into overallbowlingstats values(432, 24.70, 8.60, 17,81);


DELIMITER //
CREATE TRIGGER check_franchise
BEFORE INSERT ON player
FOR EACH ROW
BEGIN
    DECLARE franchise_count INT;
    SELECT COUNT(*) INTO franchise_count
    FROM franchise
    WHERE FranchiseID = NEW.FranchiseID;
    IF franchise_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: FranchiseID does not exist in the franchise table';
    END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetBestAllRounders(IN limit_count INT)
BEGIN
    -- Temporary table to store the result
    CREATE TEMPORARY TABLE IF NOT EXISTS result_table (
        PlayerName VARCHAR(255),
        BattingAverage DECIMAL(10,2),
        BowlingAverage DECIMAL(10,2),
        Difference DECIMAL(10,2),
        FranchiseName VARCHAR(255)
    );

    -- Insert data into the temporary table, considering only players with non-zero bowling average
    INSERT INTO result_table
    SELECT
        player.PlayerName,
        overallbattingstats.BattingAverage,
        overallbowlingstats.BowlingAverage,
        overallbattingstats.BattingAverage - overallbowlingstats.BowlingAverage AS Difference,
        franchise.FranchiseName
    FROM player
    JOIN overallbattingstats ON player.PlayerID = overallbattingstats.PlayerID
    JOIN overallbowlingstats ON player.PlayerID = overallbowlingstats.PlayerID
    JOIN franchise ON player.FranchiseID = franchise.FranchiseID
    WHERE overallbowlingstats.BowlingAverage > 0 -- Only consider players with non-zero bowling average
    ORDER BY Difference DESC
    LIMIT limit_count;

    -- Display the result within the stored procedure
    SELECT * FROM result_table;

    -- Drop the temporary table if it's no longer needed
    DROP TEMPORARY TABLE IF EXISTS result_table;
END //

DELIMITER ;






SELECT f.FranchiseName, SUM(op.Wickets) AS TotalWickets FROM franchise f JOIN player p ON f.FranchiseID = p.FranchiseID JOIN overallbowlingstats op ON p.PlayerID = op.PlayerID GROUP BY f.FranchiseID ORDER BY TotalWickets DESC;

SELECT f.FranchiseName, SUM(op.Runs) AS TotalRuns FROM franchise f JOIN player p ON f.FranchiseID = p.FranchiseID JOIN overallbattingstats op ON p.PlayerID = op.PlayerID GROUP BY f.FranchiseID ORDER BY TotalRuns DESC;

SELECT player.PlayerName,overallbattingstats.strikeRate,overallbattingstats.runs from player join overallbattingstats on player.playerid=overallbattingstats.playerid where overallbattingstats.runs>'{selected_runs}' and overallbattingstats.strikerate>'{selected_sr}' order by runs desc,strikerate desc;

SELECT
      player.PlayerName,
            overallbattingstats.BattingAverage,
            overallbowlingstats.BowlingAverage,
            overallbattingstats.BattingAverage - overallbowlingstats.BowlingAverage AS Difference,
            franchise.FranchiseName
      FROM player
      JOIN overallbattingstats ON player.PlayerID = overallbattingstats.PlayerID
      JOIN overallbowlingstats ON player.PlayerID = overallbowlingstats.PlayerID
      JOIN franchise ON player.FranchiseID = franchise.FranchiseID
      WHERE overallbowlingstats.BowlingAverage > 0 -- Only consider players with non-zero bowling average
      ORDER BY Difference DESC
      LIMIT 10;