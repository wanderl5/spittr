-- 数据库初始化脚本
CREATE DATABASE spittr;
USE spittr;

CREATE TABLE spitter (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'spitter id',
  `name` VARCHAR(120) NOT NULL UNIQUE COMMENT 'username',
  `password` VARCHAR(32) NOT NULL COMMENT 'password',
  `avatar` TEXT COMMENT 'avatar',
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT 'create time',
  `enabled` BOOL NOT NULL DEFAULT TRUE COMMENT 'if spitter is enabled',
  PRIMARY KEY (id),
  KEY idx_name(name)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8 COMMENT = 'spitter table';

CREATE TABLE spittle(
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'spittle id',
  `username` VARCHAR(120) NOT NULL COMMENT 'username',
  `text` TEXT COMMENT 'text text',
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT 'create time',
  `enabled` BOOL NOT NULL DEFAULT TRUE COMMENT 'if spittle is enabled',
  `attachment` TEXT DEFAULT NULL comment 'attachments',
  PRIMARY KEY (id),
  FOREIGN KEY (username) REFERENCES spitter (name) ON DELETE CASCADE ON UPDATE CASCADE,
  KEY idx_username(username)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8 COMMENT = 'spittle table';

CREATE TABLE comment(
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'comment id',
  `username` VARCHAR(120) NOT NULL COMMENT 'username',
  `spittle_id` BIGINT NOT NULL COMMENT 'spittle id',
  `commented_id` BIGINT COMMENT 'commented_id',
  `text` TEXT NOT NULL COMMENT 'text text',
  `create_time` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT 'create time',
  `enabled` BOOL NOT NULL DEFAULT TRUE COMMENT 'enabled',
  `attachment` TEXT DEFAULT NULL comment 'attachments',
  PRIMARY KEY (id),
  FOREIGN KEY (spittle_id) REFERENCES spittle (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (username) REFERENCES spitter (name) ON DELETE CASCADE ON UPDATE CASCADE,
  KEY idx_username(username)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8 COMMENT = 'comment table';

