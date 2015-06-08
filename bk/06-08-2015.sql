/*
SQLyog Enterprise - MySQL GUI v7.15 
MySQL - 5.6.20 : Database - freepost
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`freepost` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `mc`;

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hashId` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `dateCreated` date NOT NULL,
  `read` tinyint(1) NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `vote` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `parentUserId` int(11) DEFAULT NULL,
  `postId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashId` (`hashId`),
  KEY `IDX_9474526C10EE4CEE` (`parentId`),
  KEY `IDX_9474526C251330C5` (`parentUserId`),
  KEY `IDX_9474526CE094D20D` (`postId`),
  KEY `IDX_9474526C64B64DCC` (`userId`),
  KEY `created` (`created`),
  KEY `dateCreated` (`dateCreated`),
  KEY `isRead` (`read`),
  KEY `vote` (`vote`),
  CONSTRAINT `FK_9474526C10EE4CEE` FOREIGN KEY (`parentId`) REFERENCES `comment` (`id`),
  CONSTRAINT `FK_9474526C251330C5` FOREIGN KEY (`parentUserId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_9474526C64B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_9474526CE094D20D` FOREIGN KEY (`postId`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `comment` */

/*Table structure for table `community` */

DROP TABLE IF EXISTS `community`;

CREATE TABLE `community` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hashId` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashId` (`hashId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `community` */

insert  into `community`(`id`,`hashId`,`name`,`description`,`created`) values (1,'1','واحد نرم افزار','Salam','0000-00-00 00:00:00'),(2,'9tpvejk9','واحد عمومی','','2015-06-08 11:31:44');

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hashId` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `dateCreated` date NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `vote` int(11) NOT NULL,
  `commentsCount` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `communityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashId` (`hashId`),
  KEY `IDX_5A8A6C8D64B64DCC` (`userId`),
  KEY `IDX_5A8A6C8DA80A7C32` (`communityId`),
  KEY `created` (`created`),
  KEY `dateCreated` (`dateCreated`),
  KEY `vote` (`vote`),
  CONSTRAINT `FK_5A8A6C8D64B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_5A8A6C8DA80A7C32` FOREIGN KEY (`communityId`) REFERENCES `community` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `post` */

insert  into `post`(`id`,`hashId`,`created`,`dateCreated`,`title`,`text`,`vote`,`commentsCount`,`userId`,`communityId`) values (1,'ryi1k7q8','2015-06-08 11:27:16','2015-06-08','test','<p>test</p>',1,0,1,1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hashId` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `registered` datetime NOT NULL,
  `resetPasswordSecretToken` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashId` (`hashId`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`hashId`,`email`,`username`,`password`,`salt`,`registered`,`resetPasswordSecretToken`,`isActive`) values (1,'f0ga4az0',NULL,'مهمان','3627909a29c31381a071ec27f7c9ca97726182aed29a7ddd2e54353322cfb30abb9e3a6df2ac2c20fe23436311d678564d0c8d305930575f60e2d3d048184d79','','2015-06-08 11:25:00','',1);

/*Table structure for table `users_communities` */

DROP TABLE IF EXISTS `users_communities`;

CREATE TABLE `users_communities` (
  `userId` int(11) NOT NULL,
  `communityId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`communityId`),
  KEY `IDX_F97B0DD964B64DCC` (`userId`),
  KEY `IDX_F97B0DD9A80A7C32` (`communityId`),
  CONSTRAINT `FK_F97B0DD964B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_F97B0DD9A80A7C32` FOREIGN KEY (`communityId`) REFERENCES `community` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users_communities` */

insert  into `users_communities`(`userId`,`communityId`) values (1,1),(1,2);

/*Table structure for table `vote_comment` */

DROP TABLE IF EXISTS `vote_comment`;

CREATE TABLE `vote_comment` (
  `vote` smallint(6) NOT NULL,
  `datetime` datetime NOT NULL,
  `commentId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`commentId`,`userId`),
  KEY `IDX_1FC60DF46690C3F5` (`commentId`),
  KEY `IDX_1FC60DF464B64DCC` (`userId`),
  CONSTRAINT `FK_1FC60DF464B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_1FC60DF46690C3F5` FOREIGN KEY (`commentId`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `vote_comment` */

/*Table structure for table `vote_post` */

DROP TABLE IF EXISTS `vote_post`;

CREATE TABLE `vote_post` (
  `vote` smallint(6) NOT NULL,
  `datetime` datetime NOT NULL,
  `postId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`postId`,`userId`),
  KEY `IDX_EDE89DBCE094D20D` (`postId`),
  KEY `IDX_EDE89DBC64B64DCC` (`userId`),
  CONSTRAINT `FK_EDE89DBC64B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_EDE89DBCE094D20D` FOREIGN KEY (`postId`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `vote_post` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
