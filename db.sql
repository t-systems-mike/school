drop database if exists logistic;
create database logistic;

use logistic;

CREATE TABLE IF NOT EXISTS `roles`
(   `id`   INT unsigned NOT NULL,
    `description`  VARCHAR(24) NOT NULL,
    PRIMARY KEY (`id`)
);
LOCK TABLES `roles` WRITE;
INSERT INTO `roles` (`id`,`description`) VALUES (1,'registrator');
INSERT INTO `roles` (`id`,`description`) VALUES (2,'driver');
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `users`
(   `id`   INT unsigned NOT NULL auto_increment,
    `login`  VARCHAR(24) NOT NULL,
	`password`  VARCHAR(255) NOT NULL,
    `removed`   INT unsigned NOT NULL  default 0,
	`role_id`   INT unsigned NOT NULL,
    PRIMARY KEY (`id`),
	UNIQUE KEY (`login`),
	FOREIGN KEY (role_id) REFERENCES roles(id)
);
LOCK TABLES `users` WRITE;
ALTER TABLE users AUTO_INCREMENT = 800;
INSERT INTO `users` (`login`,`password`,`removed`,`role_id`) VALUES ('admin',5,1,1);
INSERT INTO `users` (`login`,`password`,`removed`,`role_id`) VALUES ('user',5,1,2);
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `trucks`
(   `id`   INT unsigned NOT NULL auto_increment,
    `number`  CHAR(7) NOT NULL default 'AA00000',
	`state`   INT unsigned NOT NULL default 0,
    `total_weight`   INT unsigned NOT NULL  default 0,
    `current_weight`   INT unsigned NOT NULL default 0,
    PRIMARY KEY (`id`),
	UNIQUE KEY (`number`)
);
LOCK TABLES `trucks` WRITE;
INSERT INTO `trucks` (`number`,`total_weight`,`current_weight`) VALUES ('BB11111',5,3);
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `cities`
(   `id`   INT unsigned NOT NULL auto_increment,
    `city`  VARCHAR(24) NOT NULL,
    PRIMARY KEY (`id`)
);
LOCK TABLES `cities` WRITE;
ALTER TABLE cities AUTO_INCREMENT = 200;
INSERT INTO `cities` (`city`) VALUES ('Leningrad');
INSERT INTO `cities` (`city`) VALUES ('Moscow');
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `drivers`
(   `id`   INT unsigned NOT NULL auto_increment,
    `surname`  VARCHAR(24) NOT NULL,
    `name`   VARCHAR(24) NOT NULL,
    `state`   INT unsigned NOT NULL default 0,
	`current_city`  INT unsigned NOT NULL,
	`user_id`  INT unsigned NOT NULL,
    PRIMARY KEY (`id`),
	FOREIGN KEY (current_city) REFERENCES cities(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);
LOCK TABLES `drivers` WRITE;
ALTER TABLE drivers AUTO_INCREMENT = 10000;
INSERT INTO `drivers` (`surname`,`name`,`state`,`current_city`,`user_id`) VALUES ('Ivanov','Ivan',0,200,800);
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `cargo`
(   `id`   INT unsigned NOT NULL auto_increment,
    `name`  VARCHAR(24) NOT NULL,
	`state`   INT unsigned NOT NULL default 0,
    `weight`   INT unsigned NOT NULL  default 0,
    PRIMARY KEY (`id`)
);
LOCK TABLES `cargo` WRITE;
ALTER TABLE cargo AUTO_INCREMENT = 500;
INSERT INTO `cargo` (`name`,`state`,`weight`) VALUES ('Niles',2,200);
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `distances`
(   `city_from`  INT unsigned NOT NULL,
	`city_to`   INT unsigned NOT NULL,
    `distance`   INT unsigned NOT NULL  default 0,
    PRIMARY KEY (`city_from`,`city_to`),
	FOREIGN KEY (city_from) REFERENCES cities(id),
	FOREIGN KEY (city_to) REFERENCES cities(id)
);
LOCK TABLES `distances` WRITE;
INSERT INTO `distances` (`city_from`,`city_to`,`distance`) VALUES (200,201,690);
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `orders`
(   `id`   INT unsigned NOT NULL auto_increment,
    `city_from`  INT unsigned NOT NULL,
    `city_to`  INT unsigned NOT NULL,
    `cargo`   INT unsigned NOT NULL,
	`driver_active`   INT unsigned NOT NULL  default 0,
	`driver_passive`   INT unsigned NOT NULL  default 0,
	`driver_add`   INT unsigned NOT NULL  default 0,
	`truck`   INT unsigned NOT NULL  default 0,
	`state`   INT unsigned NOT NULL default 0,
    PRIMARY KEY (`id`),
	FOREIGN KEY (driver_active) REFERENCES drivers(id),
	FOREIGN KEY (driver_passive) REFERENCES drivers(id),
	FOREIGN KEY (driver_add) REFERENCES drivers(id),
	FOREIGN KEY (truck) REFERENCES trucks(id),
	FOREIGN KEY (cargo) REFERENCES cargo(id),
	FOREIGN KEY (city_from) REFERENCES cities(id),
	FOREIGN KEY (city_to) REFERENCES cities(id)
);
LOCK TABLES `orders` WRITE;
ALTER TABLE orders AUTO_INCREMENT = 50000;
INSERT INTO `orders` (`city_from`,`city_to`,`cargo`,`driver_active`,`driver_passive`,`driver_add`,`truck`,`state`) VALUES (200,201,500,10000,10000,10000,1,3);
UNLOCK TABLES;