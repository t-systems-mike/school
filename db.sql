-- drop database if exists logistic;
-- create database logistic;

USE logistic;

-- Table: users - all registered users of a system
CREATE TABLE IF NOT EXISTS users
(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
removed  INT NOT NULL  default 0
) ENGINE = InnoDB;
-- Insert data
LOCK TABLES users WRITE;
ALTER TABLE users AUTO_INCREMENT = 800;
INSERT INTO users(username,password) VALUES ('admin', '$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG');
INSERT INTO users(username,password) VALUES ('user', '$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG');
UNLOCK TABLES;

-- Table: roles
-- id:1 - for drivers, they don't have rights to create orders
-- id:2 - for authorities of company, who can create orders and start routes
CREATE TABLE IF NOT EXISTS roles
(id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;
-- Insert data
LOCK TABLES roles WRITE;
INSERT INTO roles VALUES (1, 'ROLE_USER');
INSERT INTO roles VALUES (2, 'ROLE_ADMIN');
UNLOCK TABLES;

-- Table for mapping user and roles (ManyToMany)
CREATE TABLE IF NOT EXISTS user_roles (
user_id INT NOT NULL,
role_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users (id),
FOREIGN KEY (role_id) REFERENCES roles (id),
PRIMARY KEY (user_id, role_id)
) ENGINE = InnoDB;
-- Insert data
LOCK TABLES user_roles WRITE;
INSERT INTO user_roles VALUES (800, 2);
INSERT INTO user_roles VALUES (801, 1);
UNLOCK TABLES;

-- Table: trucks - all available cars
-- total_weight - NETTO in kilograms (can be loaded)
-- current_weight - NETTO in kilograms (already is loaded)
CREATE TABLE IF NOT EXISTS `trucks`
(   `id`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `number`  CHAR(7) NOT NULL default 'AA00000',
	`state`   INT UNSIGNED NOT NULL default 0,
    `total_weight`   INT UNSIGNED NOT NULL  default 0,
    `current_weight`   INT UNSIGNED NOT NULL default 0,
    PRIMARY KEY (`id`),
	UNIQUE KEY (`number`)
);
LOCK TABLES `trucks` WRITE;
INSERT INTO `trucks` (`number`,`total_weight`,`current_weight`) VALUES ('BB11111',5,3);
UNLOCK TABLES;

-- Table: cities - list of cities which can be pointed as departure/destination
CREATE TABLE IF NOT EXISTS `cities`
(   `id`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `city`  VARCHAR(24) NOT NULL,
    PRIMARY KEY (`id`)
);
LOCK TABLES `cities` WRITE;
ALTER TABLE cities AUTO_INCREMENT = 200;
INSERT INTO `cities` (`city`) VALUES ('on the way now');
INSERT INTO `cities` (`city`) VALUES ('Leningrad');
INSERT INTO `cities` (`city`) VALUES ('Moscow');
UNLOCK TABLES;

-- Table: drivers
-- list of all registered drivers
-- state -> 0-ready,1-active(on the way),2-relax(on the way or in the city)
USE logistic;
CREATE TABLE IF NOT EXISTS `drivers`
(   `id`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `surname`  VARCHAR(24) NOT NULL,
    `name`   VARCHAR(24) NOT NULL,
    `state`   INT UNSIGNED NOT NULL default 0,
	`current_city`  INT UNSIGNED NOT NULL,
	`user_id`  INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (current_city) REFERENCES cities(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
LOCK TABLES `drivers` WRITE;
ALTER TABLE drivers AUTO_INCREMENT = 10000;
INSERT INTO `drivers` (`surname`,`name`,`state`,`current_city`,`user_id`) VALUES ('Ivanov','Ivan',0,200,801);
UNLOCK TABLES;

-- Table: cargo
-- all registered cargoes
-- state -> 0-not loaded,1-loaded(on the way),2-delivered(can be removed from order)
-- weight in kilograms
CREATE TABLE IF NOT EXISTS `cargo`
(   `id`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`  VARCHAR(24) NOT NULL,
	`state`   INT UNSIGNED NOT NULL default 0,
    `loading_city`  INT UNSIGNED NOT NULL,
    `unloading_city`  INT UNSIGNED NOT NULL,
    `weight`   INT unsigned NOT NULL default 0,
    PRIMARY KEY (`id`),
    FOREIGN KEY (loading_city) REFERENCES cities(id),
    FOREIGN KEY (unloading_city) REFERENCES cities(id)
);
LOCK TABLES `cargo` WRITE;
ALTER TABLE cargo AUTO_INCREMENT = 500;
INSERT INTO `cargo` (`name`,`state`,`loading_city`,`unloading_city`,`weight`) VALUES ('Niles',0,201,202,500);
UNLOCK TABLES;

-- Table: distances
-- all registered lengths of routes between cities
CREATE TABLE IF NOT EXISTS `distances`
(   `city_from`  INT UNSIGNED NOT NULL,
	`city_to`   INT UNSIGNED NOT NULL,
    `distance`   INT UNSIGNED NOT NULL  default 0,
    PRIMARY KEY (`city_from`,`city_to`),
	FOREIGN KEY (city_from) REFERENCES cities(id),
	FOREIGN KEY (city_to) REFERENCES cities(id)
);
LOCK TABLES `distances` WRITE;
INSERT INTO `distances` (`city_from`,`city_to`,`distance`) VALUES (201,202,690);
UNLOCK TABLES;

-- Table: orders - the main table which connects different tables
-- state - 0 - not done, 1 - done, 2 - in service
CREATE TABLE IF NOT EXISTS `orders`
(   `id`   INT UNSIGNED NOT NULL auto_increment,
	`driver_active`   INT UNSIGNED NOT NULL  default 0,
	`driver_passive`   INT UNSIGNED NOT NULL  default 0,
	`driver_add`   INT UNSIGNED NOT NULL  default 0,
	`truck_id`   INT UNSIGNED NOT NULL  default 0,
	`state`   INT UNSIGNED NOT NULL default 0,
    PRIMARY KEY (`id`),
	FOREIGN KEY (driver_active) REFERENCES drivers(id),
	FOREIGN KEY (driver_passive) REFERENCES drivers(id),
	FOREIGN KEY (driver_add) REFERENCES drivers(id),
	FOREIGN KEY (truck_id) REFERENCES trucks(id)
);
LOCK TABLES `orders` WRITE;
ALTER TABLE orders AUTO_INCREMENT = 50000;
INSERT INTO `orders` (`driver_active`,`driver_passive`,`driver_add`,`truck_id`,`state`) VALUES (10000,10000,10000,1,2);
UNLOCK TABLES;

-- Table for mapping order and cargo (ManyToMany)
CREATE TABLE IF NOT EXISTS order_cargo (
    `order_id` INT UNSIGNED NOT NULL,
    `cargo_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`order_id`, `cargo_id`),
    FOREIGN KEY (`order_id`) REFERENCES orders (id),
    FOREIGN KEY (`cargo_id`) REFERENCES cargo (id)
);