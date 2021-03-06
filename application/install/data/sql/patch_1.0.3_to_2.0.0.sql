ALTER TABLE `prefix_subscribe` ADD `user_id` INT( 11 ) UNSIGNED NULL DEFAULT NULL AFTER `target_id` ,
ADD INDEX ( `user_id` ) ;


CREATE TABLE IF NOT EXISTS `prefix_blog_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `url` varchar(100) NOT NULL,
  `url_full` varchar(200) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  `count_blogs` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `count_blogs` (`count_blogs`),
  KEY `title` (`title`),
  KEY `url` (`url`),
  KEY `url_full` (`url_full`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


ALTER TABLE `prefix_blog_category`
  ADD CONSTRAINT `prefix_blog_category_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `prefix_blog_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `prefix_blog` ADD `category_id` INT NULL DEFAULT NULL AFTER `user_owner_id` ,
ADD INDEX ( `category_id` ) ;

ALTER TABLE `prefix_blog` ADD FOREIGN KEY ( `category_id` ) REFERENCES `prefix_blog_category` (
`id`
) ON DELETE CASCADE ON UPDATE CASCADE ;



-- 01-10-2013

--
-- Структура таблицы `prefix_property`
--

CREATE TABLE IF NOT EXISTS `prefix_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(50) NOT NULL,
  `type` enum('int','float','varchar','text','checkbox','select','tags','video_link') NOT NULL DEFAULT 'text',
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `sort` int(11) NOT NULL,
  `validate_rules` varchar(500) DEFAULT NULL,
  `params` text,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `code` (`code`),
  KEY `type` (`type`),
  KEY `date_create` (`date_create`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `property_type` varchar(30) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `value_int` int(11) DEFAULT NULL,
  `value_float` float(11,2) DEFAULT NULL,
  `value_varchar` varchar(250) DEFAULT NULL,
  `value_text` text,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `value_int` (`value_int`),
  KEY `property_type` (`property_type`),
  KEY `value_float` (`value_float`),
  KEY `value_varchar` (`value_varchar`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_tag`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `text` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `text` (`text`),
  KEY `property_id` (`property_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 29-10-2013

--
-- Структура таблицы `prefix_property_select`
--

CREATE TABLE IF NOT EXISTS `prefix_property_select` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `target_type` (`target_type`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_select`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value_select` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `select_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `property_id` (`property_id`),
  KEY `select_id` (`select_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `prefix_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `file_size` (`file_size`),
  KEY `width` (`width`),
  KEY `height` (`height`),
  KEY `date_add` (`date_add`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_media_target`
--

CREATE TABLE IF NOT EXISTS `prefix_media_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_tmp` varchar(50) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `media_id` (`media_id`),
  KEY `target_id` (`target_id`),
  KEY `target_type` (`target_type`),
  KEY `target_tmp` (`target_tmp`),
  KEY `date_add` (`date_add`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prefix_media_target`
--
ALTER TABLE `prefix_media_target`
  ADD CONSTRAINT `prefix_media_target_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `prefix_media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- 10-01-2014
ALTER TABLE `prefix_topic` CHANGE `topic_type` `topic_type` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'topic';

-- 11-01-2014
CREATE TABLE IF NOT EXISTS `prefix_topic_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `name_many` varchar(250) NOT NULL,
  `code` varchar(50) NOT NULL,
  `allow_remove` tinyint(1) NOT NULL DEFAULT '0',
  `date_create` datetime NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `params` text,
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `state` (`state`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 12.01.2014
ALTER TABLE `prefix_topic_type` ADD `sort` INT NOT NULL DEFAULT '0' AFTER `state` ,
ADD INDEX ( `sort` ) ;

-- 12.01.2014
ALTER TABLE `prefix_property` ADD `description` VARCHAR( 500 ) NOT NULL AFTER `title` ;

-- 23.01.2014
--
-- Структура таблицы `prefix_property_target`
--

CREATE TABLE IF NOT EXISTS `prefix_property_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `date_create` (`date_create`),
  KEY `date_update` (`date_update`),
  KEY `state` (`state`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 25.01.2014
--
-- Структура таблицы `prefix_user_complaint`
--

CREATE TABLE IF NOT EXISTS `prefix_user_complaint` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`target_user_id` int(11) unsigned NOT NULL,
	`user_id` int(11) unsigned NOT NULL,
	`type` varchar(50) NOT NULL,
	`text` text NOT NULL,
	`date_add` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `user_id` (`user_id`),
	KEY `target_user_id` (`target_user_id`),
	KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prefix_user_complaint`
--
ALTER TABLE `prefix_user_complaint`
ADD CONSTRAINT `prefix_user_complaint_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `prefix_user_complaint_ibfk_1` FOREIGN KEY (`target_user_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- 27.01.2014
--
-- Структура таблицы `prefix_rbac_permission`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `msg_error` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `date_create` (`date_create`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `state` (`state`),
  KEY `date_create` (`date_create`),
  KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role_permission`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  KEY `date_create` (`date_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_user_role`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  KEY `date_create` (`date_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prefix_rbac_role_permission`
--
ALTER TABLE `prefix_rbac_role_permission`
  ADD CONSTRAINT `prefix_rbac_role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `prefix_rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `prefix_rbac_user_role`
--
ALTER TABLE `prefix_rbac_user_role`
  ADD CONSTRAINT `prefix_rbac_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prefix_rbac_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `prefix_rbac_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- 28.01.2014
ALTER TABLE `prefix_user_complaint` ADD `state` TINYINT NOT NULL DEFAULT '1',
ADD INDEX ( `state` ) ;


-- 31.01.2014
--
-- Структура таблицы `prefix_storage`
--

CREATE TABLE IF NOT EXISTS `prefix_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `value` mediumtext NOT NULL,
  `instance` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_instance` (`key`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_property_target`
--

INSERT INTO `prefix_property_target` ( `type`, `date_create`, `date_update`, `state`, `params`) VALUES
('topic_topic', '2014-01-31 12:01:34', NULL, 1, 'a:2:{s:6:"entity";s:23:"ModuleTopic_EntityTopic";s:4:"name";s:35:"Топик - Стандартный";}');


-- 04.02.2014
--
-- Структура таблицы `prefix_poll`
--

CREATE TABLE IF NOT EXISTS `prefix_poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_tmp` varchar(50) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `count_answer_max` tinyint(4) NOT NULL DEFAULT '1',
  `count_vote` int(11) NOT NULL DEFAULT '0',
  `count_abstain` int(11) NOT NULL DEFAULT '0',
  `date_create` datetime NOT NULL,
  `date_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `target_type_target_id` (`target_type`,`target_id`),
  KEY `target_tmp` (`target_tmp`),
  KEY `count_vote` (`count_vote`),
  KEY `count_abstain` (`count_abstain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_poll_answer`
--

CREATE TABLE IF NOT EXISTS `prefix_poll_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `title` varchar(500) CHARACTER SET utf8 NOT NULL,
  `count_vote` int(11) NOT NULL DEFAULT '0',
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `poll_id` (`poll_id`),
  KEY `count_vote` (`count_vote`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_poll_vote`
--

CREATE TABLE IF NOT EXISTS `prefix_poll_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `poll_id` (`poll_id`),
  KEY `answer_id` (`answer_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prefix_poll_answer`
--
ALTER TABLE `prefix_poll_answer`
  ADD CONSTRAINT `prefix_poll_answer_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `prefix_poll` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `prefix_poll_vote`
--
ALTER TABLE `prefix_poll_vote`
  ADD CONSTRAINT `prefix_poll_vote_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `prefix_poll` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prefix_poll_vote_ibfk_2` FOREIGN KEY (`answer_id`) REFERENCES `prefix_poll_answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- 05.02.2014
ALTER TABLE `prefix_poll_vote` DROP FOREIGN KEY `prefix_poll_vote_ibfk_2` ;
ALTER TABLE `prefix_poll_vote` DROP `answer_id` ;
ALTER TABLE `prefix_poll_vote` ADD `answers` VARCHAR( 500 ) NOT NULL AFTER `user_id` ;


-- 11.02.2014
ALTER TABLE `prefix_property` CHANGE `type` `type` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'text';
ALTER TABLE `prefix_property_value` ADD `value_date` DATETIME NULL DEFAULT NULL AFTER `value_varchar` ,
ADD INDEX ( `value_date` ) ;


-- 17.02.2014
ALTER TABLE `prefix_media` ADD `target_type` VARCHAR( 50 ) NOT NULL AFTER `type` ,
ADD INDEX ( `target_type` ) ;


-- 21.03.2014
ALTER TABLE `prefix_media_target` ADD `is_preview` TINYINT( 1 ) NOT NULL DEFAULT '0',
ADD INDEX ( `is_preview` ) ;
ALTER TABLE `prefix_media_target` ADD `data` TEXT NOT NULL ;


-- 24.04.2014
ALTER TABLE `prefix_comment` ADD `comment_text_source` TEXT NOT NULL AFTER `comment_text` ;
ALTER TABLE `prefix_comment` ADD `comment_date_edit` DATETIME NULL DEFAULT NULL AFTER `comment_date` ,
ADD INDEX ( `comment_date_edit` ) ;
ALTER TABLE `prefix_comment` ADD `comment_count_edit` INT NOT NULL DEFAULT '0' AFTER `comment_count_favourite` ,
ADD INDEX ( `comment_count_edit` ) ;


-- 29.05.2014
UPDATE `prefix_stream_user_type` set `event_type`='vote_comment_topic' WHERE `event_type`='vote_comment';
UPDATE `prefix_stream_event` set `event_type`='vote_comment_topic' WHERE `event_type`='vote_comment';


-- 26.05.2014
--
-- Структура таблицы `prefix_category`
--

CREATE TABLE IF NOT EXISTS `prefix_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(250) NOT NULL,
  `url_full` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `order` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `title` (`title`),
  KEY `order` (`order`),
  KEY `state` (`state`),
  KEY `url` (`url`),
  KEY `url_full` (`url_full`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_target`
--

CREATE TABLE IF NOT EXISTS `prefix_category_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `category_id` (`category_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_type`
--

CREATE TABLE IF NOT EXISTS `prefix_category_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `state` (`state`),
  KEY `target_type` (`target_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 10.07.2014
ALTER TABLE `prefix_category` ADD `data` VARCHAR( 500 ) NOT NULL ;
ALTER TABLE `prefix_category` ADD `count_target` INT NOT NULL DEFAULT '0' AFTER `state` ,
ADD INDEX ( `count_target` ) ;
ALTER TABLE `prefix_blog_category` DROP FOREIGN KEY `prefix_blog_category_ibfk_1` ;
ALTER TABLE `prefix_blog` DROP FOREIGN KEY `prefix_blog_ibfk_1` ;
ALTER TABLE `prefix_blog` DROP `category_id` ;
DROP TABLE `prefix_blog_category`;

INSERT INTO `prefix_category_type` (
`id` ,
`target_type` ,
`title` ,
`state` ,
`date_create` ,
`date_update` ,
`params`
)
VALUES (
NULL , 'blog', 'Блоги', '1', '2014-07-14 00:00:00', NULL , ''
);


-- 22.07.2014
ALTER TABLE `prefix_topic` ADD `topic_date_edit_content` DATETIME NULL DEFAULT NULL AFTER `topic_date_edit` ,
ADD INDEX ( `topic_date_edit_content` ) ;


-- 23.07.2014
CREATE TABLE IF NOT EXISTS `prefix_cron_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `method` varchar(500) NOT NULL,
  `plugin` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `count_run` int(11) NOT NULL DEFAULT '0',
  `period_run` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_run_last` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `count_run` (`count_run`),
  KEY `state` (`state`),
  KEY `plugin` (`plugin`),
  KEY `method` (`method`(255)),
  KEY `period_run` (`period_run`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 17.08.2014
INSERT INTO `prefix_cron_task` (`id`, `title`, `method`, `plugin`, `state`, `count_run`, `period_run`, `date_create`, `date_run_last`) VALUES (NULL, 'Отложенная отправка емайлов', 'Tools_SystemTaskNotify', '', '1', '0', '2', '2014-08-17 00:00:00', NULL);
INSERT INTO `prefix_cron_task` (`id`, `title`, `method`, `plugin`, `state`, `count_run`, `period_run`, `date_create`, `date_run_last`) VALUES (NULL, 'Удаление старого кеша данных', 'Cache_ClearOldCache', '', '1', '0', '1500', '2014-08-17 00:00:00', NULL);

-- 19.08.2014
ALTER TABLE `prefix_rbac_permission` ADD `plugin` VARCHAR( 50 ) NOT NULL AFTER `code` ,
ADD INDEX ( `plugin` );

CREATE TABLE IF NOT EXISTS `prefix_rbac_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `prefix_rbac_role_permission` DROP FOREIGN KEY `prefix_rbac_role_permission_ibfk_1` ;
ALTER TABLE `prefix_rbac_user_role` DROP FOREIGN KEY `prefix_rbac_user_role_ibfk_2` ;
ALTER TABLE `prefix_rbac_user_role` DROP FOREIGN KEY `prefix_rbac_user_role_ibfk_1` ;

ALTER TABLE `prefix_rbac_permission` ADD `group_id` INT NULL DEFAULT NULL AFTER `id` ,
ADD INDEX ( `group_id` );
ALTER TABLE `prefix_rbac_group` ADD `date_create` DATETIME NOT NULL ;
RENAME TABLE `prefix_rbac_user_role` TO `prefix_rbac_role_user`;


-- 14.09.2014

CREATE TABLE IF NOT EXISTS `prefix_plugin_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `file` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file` (`file`(255)),
  KEY `code` (`code`),
  KEY `version` (`version`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `prefix_plugin_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `version` (`version`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 07.12.2014

--
-- Дамп данных таблицы `prefix_rbac_group`
--

INSERT INTO `prefix_rbac_group` (`id`, `code`, `title`, `date_create`) VALUES
(1, 'topic', 'Топики', '2014-12-07 07:51:14'),
(2, 'blog', 'Блоги', '2014-12-07 07:51:41'),
(3, 'comment', 'Комментарии', '2014-12-07 07:52:01'),
(4, 'user', 'Пользователи', '2014-12-07 07:52:18');

--
-- Дамп данных таблицы `prefix_rbac_permission`
--

INSERT INTO `prefix_rbac_permission` (`id`, `group_id`, `code`, `plugin`, `title`, `msg_error`, `date_create`, `state`) VALUES
(1, 1, 'create_topic', '', 'rbac.permission.create_topic.title', 'rbac.permission.create_topic.error', '2014-08-31 07:59:56', 1),
(2, 2, 'create_blog', '', 'rbac.permission.create_blog.title', 'rbac.permission.create_blog.error', '2014-10-02 16:08:54', 1),
(3, 1, 'create_topic_comment', '', 'rbac.permission.create_topic_comment.title', 'rbac.permission.create_topic_comment.error', '2014-10-05 11:02:31', 1),
(4, 4, 'create_talk', '', 'rbac.permission.create_talk.title', 'rbac.permission.create_talk.error', '2014-10-05 11:54:22', 1),
(5, 4, 'create_talk_comment', '', 'rbac.permission.create_talk_comment.title', 'rbac.permission.create_talk_comment.error', '2014-10-05 14:08:15', 1),
(6, 3, 'vote_comment', '', 'rbac.permission.vote_comment.title', 'rbac.permission.vote_comment.error', '2014-10-05 14:31:29', 1),
(7, 2, 'vote_blog', '', 'rbac.permission.vote_blog.title', 'rbac.permission.vote_blog.error', '2014-10-05 16:51:53', 1),
(8, 1, 'vote_topic', '', 'rbac.permission.vote_topic.title', 'rbac.permission.vote_topic.error', '2014-10-05 17:22:56', 1),
(9, 4, 'vote_user', '', 'rbac.permission.vote_user.title', 'rbac.permission.vote_user.error', '2014-10-05 17:27:19', 1),
(10, 4, 'create_invite', '', 'rbac.permission.create_invite.title', 'rbac.permission.create_invite.error', '2014-10-05 17:28:46', 1),
(11, 3, 'create_comment_favourite', '', 'rbac.permission.create_comment_favourite.title', 'rbac.permission.create_comment_favourite.error', '2014-10-05 17:56:23', 1),
(12, 1, 'remove_topic', '', 'rbac.permission.remove_topic.title', 'rbac.permission.remove_topic.error', '2014-10-05 18:06:09', 1);

--
-- Дамп данных таблицы `prefix_rbac_role`
--

INSERT INTO `prefix_rbac_role` (`id`, `pid`, `code`, `title`, `date_create`, `state`) VALUES
(1, NULL, 'guest', 'Гость', '2014-08-22 00:00:00', 1),
(2, NULL, 'user', 'Пользователь', '2014-08-22 00:00:00', 1);

--
-- Дамп данных таблицы `prefix_rbac_role_permission`
--

INSERT INTO `prefix_rbac_role_permission` (`id`, `role_id`, `permission_id`, `date_create`) VALUES
(1, 2, 2, '2014-12-07 08:03:38'),
(2, 2, 7, '2014-12-07 08:03:44'),
(3, 2, 11, '2014-12-07 08:03:47'),
(4, 2, 6, '2014-12-07 08:03:49'),
(5, 2, 10, '2014-12-07 08:03:52'),
(6, 2, 4, '2014-12-07 08:03:55'),
(7, 2, 5, '2014-12-07 08:03:59'),
(8, 2, 9, '2014-12-07 08:04:02'),
(9, 2, 1, '2014-12-07 08:04:09'),
(10, 2, 3, '2014-12-07 08:04:11'),
(11, 2, 12, '2014-12-07 08:04:15'),
(12, 2, 8, '2014-12-07 08:04:17');

--
-- Дамп данных таблицы `prefix_rbac_role_user`
--

INSERT INTO `prefix_rbac_role_user` (`id`, `user_id`, `role_id`, `date_create`) VALUES
(1, 1, 2, '2014-12-07 08:06:11');


--
-- Дамп данных таблицы `prefix_topic_type`
--

INSERT INTO `prefix_topic_type` (`id`, `name`, `name_many`, `code`, `allow_remove`, `date_create`, `state`, `sort`, `params`) VALUES
(1, 'Топик', 'Топики', 'topic', 0, '2014-01-11 00:00:00', 1, 0, 'a:3:{s:10:"allow_poll";b:1;s:10:"allow_text";b:1;s:10:"allow_tags";b:1;}');


-- 17.12.2014
ALTER TABLE `prefix_user` CHANGE `user_settings_timezone` `user_settings_timezone` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
ALTER TABLE `prefix_user` ADD `user_admin` TINYINT(1) NOT NULL DEFAULT '0' AFTER `user_mail`, ADD INDEX (`user_admin`) ;


-- 27.12.2014
ALTER TABLE `prefix_session` DROP FOREIGN KEY `prefix_session_fk`;
ALTER TABLE `prefix_session` DROP INDEX user_id;
ALTER TABLE `prefix_session` ADD INDEX(`user_id`);
ALTER TABLE `prefix_session` ADD `session_date_close` DATETIME NULL DEFAULT NULL , ADD INDEX (`session_date_close`) ;

-- 28.12.2014
ALTER TABLE `prefix_blog` CHANGE `blog_type` `blog_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'personal';
ALTER TABLE `prefix_comment` CHANGE `target_type` `target_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'topic';
ALTER TABLE `prefix_comment_online` CHANGE `target_type` `target_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'topic';
ALTER TABLE `prefix_favourite` CHANGE `target_type` `target_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'topic';
ALTER TABLE `prefix_favourite_tag` CHANGE `target_type` `target_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_user` CHANGE `user_profile_sex` `user_profile_sex` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'other';
ALTER TABLE `prefix_vote` CHANGE `target_type` `target_type` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'topic';

ALTER TABLE `prefix_blog` DROP FOREIGN KEY `prefix_blog_fk`;
ALTER TABLE `prefix_blog_user` DROP FOREIGN KEY `prefix_blog_user_fk`;
ALTER TABLE `prefix_blog_user` DROP FOREIGN KEY `prefix_blog_user_fk1`;
ALTER TABLE `prefix_comment` DROP FOREIGN KEY `prefix_topic_comment_fk`;
ALTER TABLE `prefix_comment` DROP FOREIGN KEY `topic_comment_fk1`;
ALTER TABLE `prefix_comment_online` DROP FOREIGN KEY `prefix_topic_comment_online_fk1`;
ALTER TABLE `prefix_favourite` DROP FOREIGN KEY `prefix_favourite_target_fk`;
ALTER TABLE `prefix_favourite_tag` DROP FOREIGN KEY `prefix_favourite_tag_ibfk_1`;
ALTER TABLE `prefix_friend` DROP FOREIGN KEY `prefix_friend_from_fk`;
ALTER TABLE `prefix_friend` DROP FOREIGN KEY `prefix_friend_to_fk`;
ALTER TABLE `prefix_geo_city` DROP FOREIGN KEY `prefix_geo_city_ibfk_1`;
ALTER TABLE `prefix_geo_city` DROP FOREIGN KEY `prefix_geo_city_ibfk_2`;
ALTER TABLE `prefix_geo_region` DROP FOREIGN KEY `prefix_geo_region_ibfk_1`;
ALTER TABLE `prefix_geo_target` DROP FOREIGN KEY `prefix_geo_target_ibfk_1`;
ALTER TABLE `prefix_geo_target` DROP FOREIGN KEY `prefix_geo_target_ibfk_2`;
ALTER TABLE `prefix_geo_target` DROP FOREIGN KEY `prefix_geo_target_ibfk_3`;
ALTER TABLE `prefix_invite` DROP FOREIGN KEY `prefix_invite_fk`;
ALTER TABLE `prefix_invite` DROP FOREIGN KEY `prefix_invite_fk1`;
ALTER TABLE `prefix_media_target` DROP FOREIGN KEY `prefix_media_target_ibfk_1`;
ALTER TABLE `prefix_poll_answer` DROP FOREIGN KEY `prefix_poll_answer_ibfk_1`;
ALTER TABLE `prefix_poll_vote` DROP FOREIGN KEY `prefix_poll_vote_ibfk_1`;
ALTER TABLE `prefix_reminder` DROP FOREIGN KEY `prefix_reminder_fk`;
ALTER TABLE `prefix_stream_event` DROP FOREIGN KEY `prefix_stream_event_ibfk_1`;
ALTER TABLE `prefix_stream_subscribe` DROP FOREIGN KEY `prefix_stream_subscribe_ibfk_1`;
ALTER TABLE `prefix_stream_user_type` DROP FOREIGN KEY `prefix_stream_user_type_ibfk_1`;
ALTER TABLE `prefix_talk` DROP FOREIGN KEY `prefix_talk_fk`;
ALTER TABLE `prefix_talk_blacklist` DROP FOREIGN KEY `prefix_talk_blacklist_fk_user`;
ALTER TABLE `prefix_talk_blacklist` DROP FOREIGN KEY `prefix_talk_blacklist_fk_target`;
ALTER TABLE `prefix_talk_user` DROP FOREIGN KEY `prefix_talk_user_fk`;
ALTER TABLE `prefix_talk_user` DROP FOREIGN KEY `prefix_talk_user_fk1`;
ALTER TABLE `prefix_topic` DROP FOREIGN KEY `prefix_topic_fk`;
ALTER TABLE `prefix_topic` DROP FOREIGN KEY `prefix_topic_fk1`;
ALTER TABLE `prefix_topic_content` DROP FOREIGN KEY `prefix_topic_content_fk`;
ALTER TABLE `prefix_topic_read` DROP FOREIGN KEY `prefix_topic_read_fk`;
ALTER TABLE `prefix_topic_read` DROP FOREIGN KEY `prefix_topic_read_fk1`;
ALTER TABLE `prefix_topic_tag` DROP FOREIGN KEY `prefix_topic_tag_fk`;
ALTER TABLE `prefix_topic_tag` DROP FOREIGN KEY `prefix_topic_tag_fk1`;
ALTER TABLE `prefix_topic_tag` DROP FOREIGN KEY `prefix_topic_tag_fk2`;
ALTER TABLE `prefix_userfeed_subscribe` DROP FOREIGN KEY `prefix_userfeed_subscribe_ibfk_1`;
ALTER TABLE `prefix_user_changemail` DROP FOREIGN KEY `prefix_user_changemail_ibfk_1`;
ALTER TABLE `prefix_user_complaint` DROP FOREIGN KEY `prefix_user_complaint_ibfk_1`;
ALTER TABLE `prefix_user_complaint` DROP FOREIGN KEY `prefix_user_complaint_ibfk_2`;
ALTER TABLE `prefix_user_field_value` DROP FOREIGN KEY `prefix_user_field_value_ibfk_1`;
ALTER TABLE `prefix_user_field_value` DROP FOREIGN KEY `prefix_user_field_value_ibfk_2`;
ALTER TABLE `prefix_user_note` DROP FOREIGN KEY `prefix_user_note_ibfk_1`;
ALTER TABLE `prefix_user_note` DROP FOREIGN KEY `prefix_user_note_ibfk_2`;
ALTER TABLE `prefix_vote` DROP FOREIGN KEY `prefix_topic_vote_fk1`;
ALTER TABLE `prefix_wall` DROP FOREIGN KEY `prefix_wall_ibfk_1`;
ALTER TABLE `prefix_wall` DROP FOREIGN KEY `prefix_wall_ibfk_2`;

ALTER TABLE `prefix_comment` CHANGE `comment_user_ip` `comment_user_ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_session` CHANGE `session_ip_create` `session_ip_create` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_session` CHANGE `session_ip_last` `session_ip_last` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_subscribe` CHANGE `ip` `ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_talk` CHANGE `talk_user_ip` `talk_user_ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_topic` CHANGE `topic_user_ip` `topic_user_ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_user` CHANGE `user_ip_register` `user_ip_register` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE `prefix_vote` CHANGE `vote_ip` `vote_ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE `prefix_wall` CHANGE `ip` `ip` VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE `prefix_topic` ADD `topic_skip_index` TINYINT(1) NOT NULL DEFAULT '0' AFTER `topic_publish_index`, ADD INDEX (`topic_skip_index`) ;

-- 30.12.2014
ALTER TABLE `prefix_topic` ADD `blog_id2` INT UNSIGNED NULL DEFAULT NULL AFTER `blog_id`, ADD `blog_id3` INT UNSIGNED NULL DEFAULT NULL AFTER `blog_id2`, ADD `blog_id4` INT UNSIGNED NULL DEFAULT NULL AFTER `blog_id3`, ADD `blog_id5` INT UNSIGNED NULL DEFAULT NULL AFTER `blog_id4`;
ALTER TABLE `prefix_topic` ADD INDEX(`blog_id2`);
ALTER TABLE `prefix_topic` ADD INDEX(`blog_id3`);
ALTER TABLE `prefix_topic` ADD INDEX(`blog_id4`);
ALTER TABLE `prefix_topic` ADD INDEX(`blog_id5`);