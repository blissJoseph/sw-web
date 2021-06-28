CREATE DATABASE IF NOT EXISTS db;

USE db;

CREATE TABLE IF NOT EXISTS `model` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `equipment_company` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equipment_model` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `model_drawing` (
  `model_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`model_name`,`image_url`),
  CONSTRAINT `model_drawing_FK` FOREIGN KEY (`model_name`) REFERENCES `model` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `element` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `model_element` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `element_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`,`element_name`),
  KEY `model_element_FK_1` (`element_name`),
  CONSTRAINT `model_element_FK` FOREIGN KEY (`name`) REFERENCES `model` (`name`),
  CONSTRAINT `model_element_FK_1` FOREIGN KEY (`element_name`) REFERENCES `element` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tool` (
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `model_tool` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tool_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tool_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`,`tool_type`,`tool_name`),
  KEY `model_tool_FK_1` (`tool_type`,`tool_name`),
  CONSTRAINT `model_tool_FK` FOREIGN KEY (`name`) REFERENCES `model` (`name`),
  CONSTRAINT `model_tool_FK_1` FOREIGN KEY (`tool_type`, `tool_name`) REFERENCES `tool` (`type`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `processing` (
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `model_processing` (
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processing_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processing_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`,`processing_type`,`processing_name`),
  KEY `model_processing_FK_1` (`processing_type`,`processing_name`),
  CONSTRAINT `model_processing_FK` FOREIGN KEY (`name`) REFERENCES `model` (`name`),
  CONSTRAINT `model_processing_FK_1` FOREIGN KEY (`processing_type`, `processing_name`) REFERENCES `processing` (`type`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `result` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `spindle` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedrate` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;