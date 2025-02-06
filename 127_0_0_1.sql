-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2025 at 09:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-04-26 22:22:04', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `reservations`
--
CREATE DATABASE IF NOT EXISTS `reservations` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `reservations`;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `VehicleID` int(50) NOT NULL,
  `VehicleName` varchar(50) NOT NULL,
  `DateTime` datetime NOT NULL,
  `Status` varchar(50) NOT NULL,
  `RevervedBy` varchar(50) NOT NULL,
  `ReserverEmail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `VehicleID` int(50) NOT NULL,
  `VehicleName` varchar(50) NOT NULL,
  `Date` date NOT NULL,
  `Timeslot` varchar(50) NOT NULL,
  `Status` varchar(50) NOT NULL,
  `ReservedBy` varchar(100) NOT NULL,
  `Reserver_Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`VehicleID`, `VehicleName`, `Date`, `Timeslot`, `Status`, `ReservedBy`, `Reserver_Email`) VALUES
(1, 'CAB5051', '2025-02-05', '08:00-09:00', 'Reserved', 'apex', 'apex@gmail.com'),
(2, 'CAB5052', '2025-02-05', '08:00-09:00', 'Reserved', 'apex could', 'apex@gmail.com\n```');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`VehicleID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`VehicleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `VehicleID` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `VehicleID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Database: `safari`
--
CREATE DATABASE IF NOT EXISTS `safari` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `safari`;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(100) NOT NULL,
  `Date` date NOT NULL,
  `user_ID` int(100) NOT NULL,
  `comment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reset`
--

CREATE TABLE `reset` (
  `feedback_id` int(15) NOT NULL,
  `test1` int(75) NOT NULL,
  `ters2` int(100) NOT NULL,
  `test3` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE `tours` (
  `tour_ID` int(100) NOT NULL,
  `title` varchar(75) NOT NULL,
  `description` varchar(100) NOT NULL,
  `location` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tours`
--

INSERT INTO `tours` (`tour_ID`, `title`, `description`, `location`, `price`, `image`) VALUES
(4, 'this is amazing', 'lets to this man', 'nuwara', 500, 'tourpacks.jpg'),
(5, 'fdhfh', 'lets to this man', 'nuwara', 500, 'test1.jpg'),
(6, 'tour3', 'dsfbsdkj', 'kohehari', 400, 'tourpacks.jpg'),
(7, 'tour4', 'danne na', 'pala', 999, 'tourpack1.jpg'),
(8, 'call test ', 'this is a long tours we need', 'rathnapure', 152, 'home1.jpg'),
(9, 'myname', 'fun', 'nuwara', 666, 'admin-back.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

CREATE TABLE `useraccounts` (
  `user_ID` int(100) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL,
  `contact` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`user_ID`, `first_name`, `last_name`, `email`, `password`, `type`, `contact`) VALUES
(1, 'samantha', 'malintha', 'me@gamil.com', '6', '', 0),
(2, 'nelu', 'Vee', 'neluvee@gmail.com', '0', '', 0),
(3, 'samantha', 'tom', 'oba@gamil', '2c9341ca4cf3d87b9e4e', '', 0),
(7, 'user01', 'person', 'user01@gmail.com', 'cc03e747a6afbbcbf8be7668acfebee5', 'user', 0),
(8, 'samantha', 'tom', 'test4@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `reset`
--
ALTER TABLE `reset`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`tour_ID`);

--
-- Indexes for table `useraccounts`
--
ALTER TABLE `useraccounts`
  ADD PRIMARY KEY (`user_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reset`
--
ALTER TABLE `reset`
  MODIFY `feedback_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tours`
--
ALTER TABLE `tours`
  MODIFY `tour_ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
  MODIFY `user_ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `test2`
--
CREATE DATABASE IF NOT EXISTS `test2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `test2`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uer_id` int(11) NOT NULL,
  `usename` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `paasword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uer_id`, `usename`, `email`, `paasword`) VALUES
(1, 'user01', 'test1@gmail.com', 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Database: `testdb`
--
CREATE DATABASE IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `testdb`;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);
--
-- Database: `testdb2`
--
CREATE DATABASE IF NOT EXISTS `testdb2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `testdb2`;

-- --------------------------------------------------------

--
-- Table structure for table `feeback`
--

CREATE TABLE `feeback` (
  `feedid` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `des` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feeback`
--
ALTER TABLE `feeback`
  ADD PRIMARY KEY (`feedid`);
--
-- Database: `tranqilsafari`
--
CREATE DATABASE IF NOT EXISTS `tranqilsafari` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tranqilsafari`;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `I_ID` int(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` int(20) NOT NULL,
  `inq_type` varchar(200) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `privacy` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`I_ID`, `first_name`, `last_name`, `email`, `mobile`, `inq_type`, `message`, `privacy`) VALUES
(1, 'tom', 'odel', 'tom@gmail.com', 2147483647, 'customer', 'I want to inquire about the safari trip on 24th may', 0),
(2, 'sam', 'smith', 'smith@gmail.com', 744521365, 'bePartner', 'I would like to invest in your company', 0),
(3, 'sole', 'Hunter', 'hunter@gmail.com', 2147483647, 'partner', 'I would like to schedule a meeting with you  on next Monday', 0);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(100) NOT NULL,
  `Date` date NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` varchar(1500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `Date`, `name`, `comment`) VALUES
(1, '2024-05-08', 'Matrin Diaz', 'profile wenternberine'),
(2, '2024-05-14', 'Gasly', 'fantastique'),
(3, '2024-05-15', 'mooose', 'sam altman is the best'),
(4, '2024-05-10', 'Saman', 'dood safari tou');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `street` varchar(400) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `zip_code` int(100) NOT NULL,
  `name_on_card` varchar(500) NOT NULL,
  `credit_card_number` int(11) NOT NULL,
  `exp_month` date NOT NULL,
  `exp_year` date NOT NULL,
  `cvv` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `full_name`, `email`, `street`, `city`, `country`, `zip_code`, `name_on_card`, `credit_card_number`, `exp_month`, `exp_year`, `cvv`) VALUES
(1, 'sara', 'test4@gmail.com', 'locahost', 'Camp', 'USA', 123456, 'vawanmea', 2147483647, '0000-00-00', '0000-00-00', 456),
(2, 'master', 'mihisara@gmail.com', 'authur Lane', 'Kandy', 'sri lanka', 1154, 'fhusdhg', 111, '0000-00-00', '0000-00-00', 22),
(3, '', '', '', '', '', 0, '', 0, '0000-00-00', '0000-00-00', 0),
(4, 'sam', 'test4@gmail.com', 'authur Lane', 'Kandy', 'Sri Lanka', 2000, 'sam altman', 11111111, '0000-00-00', '0000-00-00', 123),
(5, 'sam', 'ad@gmail.com', 'authur Lane', 'Yala', 'Sri Lanka', 123, 'sam altman', 1111, '0000-00-00', '0000-00-00', 111),
(6, 'man', 'vee@gmail.com', 'sa', 'kandy', 'sala', 15, 'sincostan', 1111, '0000-00-00', '0000-00-00', 44),
(7, 'sam', 'ad@gmail.com', 'testing', 'Kandy', 'Sri Lanka', 55225, '9999999999', 9999999, '0000-00-00', '0000-00-00', 999),
(8, 'sam', 'test4@gmail.com', 'authur Lane', 'Kandy', 'Sri Lanka', 0, 'sam altman', 2147483647, '0000-00-00', '0000-00-00', 4455556),
(9, '', '', '', '', '', 0, '', 0, '0000-00-00', '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_ID` int(50) NOT NULL,
  `user_ID` int(50) NOT NULL,
  `tour_ID` int(50) NOT NULL,
  `tour_name` varchar(250) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `duration` int(10) NOT NULL,
  `no_of_people` int(50) NOT NULL,
  `amount` double NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_ID`, `user_ID`, `tour_ID`, `tour_name`, `first_name`, `last_name`, `start_date`, `end_date`, `duration`, `no_of_people`, `amount`, `email`, `phone`) VALUES
(8, 8, 4, 'this is amazing', 'sam', 'odel', '2024-05-07', '2024-05-24', 0, 1, 500, 'user01@gmail.com', 77899),
(9, 8, 4, 'this is amazing', 'sam', 'odel', '2024-05-07', '2024-05-24', 0, 1, 500, 'user01@gmail.com', 77899),
(10, 8, 5, 'Giraffe Watching', 'user01', 'odel', '2024-05-08', '2024-05-23', 0, 4, 2000, 'user03@gmail.com', 77456985),
(11, 8, 4, 'Lion Watching', 'sam', 'last ', '2024-05-08', '2024-05-08', 0, 7, 3500, 'vv@gmail.com', 7744),
(12, 8, 5, 'Giraffe Watching', 'fhbd', 'hbdsjhb', '2024-05-08', '2024-05-22', 0, 5, 2500, 'bugb@gmail.com', 0),
(13, 8, 4, 'Lion Watching', 'march', 'tim', '2024-04-30', '2024-06-05', 0, 5, 2500, 'werehere@gmail.com', 77),
(14, 8, 5, 'Giraffe Watching', 'nean', 'nea', '2024-05-17', '2024-05-30', 0, 5, 2500, 'vee@gmai.com', 774152),
(15, 8, 4, 'Lion Watching', 'sam', 'odel', '2024-05-07', '2024-05-30', 0, 5, 2500, 'user03@gmail.com', 9956),
(16, 8, 4, 'Lion Watching', 'sam', 'odel', '2024-05-07', '2024-05-30', 0, 5, 2500, 'user03@gmail.com', 9956),
(17, 8, 10, 'Wildlife Tracking Camps', 'veenath', 'tom', '2024-10-01', '2024-10-01', 0, 15, 14985, 'test4@gmail.com', 0),
(18, 8, 14, 'Bird watching safari', 'sam', 'odel', '0005-05-05', '0005-05-05', 0, 55555, 13888750, 'user01@gmail.com', 0),
(19, 8, 14, 'Bird watching safari', 'sam', 'odel', '0005-05-05', '0005-05-05', 0, 55555, 13888750, 'user01@gmail.com', 0),
(20, 8, 5, 'Giraffe Watching', 'sam', 'odel', '2024-10-03', '2024-10-24', 0, 111, 55500, 'test4@gmail.com', 77899);

-- --------------------------------------------------------

--
-- Table structure for table `reset`
--

CREATE TABLE `reset` (
  `feedback_id` int(15) NOT NULL,
  `test1` int(75) NOT NULL,
  `ters2` int(100) NOT NULL,
  `test3` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE `tours` (
  `tour_ID` int(100) NOT NULL,
  `title` varchar(75) NOT NULL,
  `description` varchar(500) NOT NULL,
  `location` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `image` varchar(100) NOT NULL,
  `tour_type` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tours`
--

INSERT INTO `tours` (`tour_ID`, `title`, `description`, `location`, `price`, `image`, `tour_type`) VALUES
(4, 'Lion Watching', 'Amboseli National Park is in Kenya near the border of Tanzania.  The park encompasses 151 square miles (392 sq km).  It is part of the larger ecosystem that stretches across Kenya and Tanzania covering an area of 3,100 square miles (8,000 sq km).\r\n\r\n', 'Amboseli National Park', 500, 'tourpacks.jpg', 'safari'),
(5, 'Giraffe Watching', 'Cruse through the jungle ,.the emerald canopy filtering the sunlight into dappled patterns on the deck of your small, wooden vessel. The air hangs heavy with the scent of humid earth and exotic flowers, punctuated by the screeches of unseen birds and the rhythmic drone of cicadas.', 'Mole National Park', 500, 'test1.jpg', 'safari'),
(7, 'Serengeti National Park', 'Serengeti National Park is located in Tanzania and is part of the larger Serengeti ecosystem which covers 12,000 square miles (30,000 sq km) and includes several other game reserves.  The national park itself covers an area of 5,700 square miles (14,750 sq km).  It is a GANP Ambassador Park and runs contiguously with the Masai Mara in Kenya.', 'Africa', 999, 'tourpack1.jpg', 'safari'),
(9, 'Ruaha National Park\r\n', 'Ruaha National Park is located just south of the central midpoint of Tanzania.    The national park encompasses an area of 7,809 square miles (20,226 sq km) making it the largest national park in Tanzania and one of the largest in Africa.', 'Africa', 666, 'admin-back.jpg', 'safari'),
(10, 'Wildlife Tracking Camps', 'These camps teach campers how to identify animal tracks and signs. Campers learn about different animal species, their habitats, and how to track them in the wild.', 'Willpathu national park', 999, 'test1.jpg', 'camp'),
(11, 'Luxurious Tented Safari Camp', 'Immerse yourself in luxury amidst the wilderness. Spacious, en-suite canvas tents feature private verandas overlooking the savannah. Enjoy guided game drives, bush walks with Maasai warriors, and relax by the infinity pool overlooking the Mara River.', 'Masai Mara, Kenya', 999, 'home1.jpg', 'Camp'),
(12, 'Family-Friendly Safari Lodge ', 'This lodge caters to families with spacious rooms, a children\'s pool, and supervised activities. Go on game drives specifically designed for families, with shorter durations and interactive elements. Learn about elephant conservation efforts and participate in educational programs.', 'Addo Elephant National Park, South Africa', 0, 'slide-1.jpg', 'Camp'),
(14, 'Bird watching safari', 'he term SAFARI is a type of experience where you have the opportunity to observe and photograph wildlife. An African safari in an overland truck is an adventure with lots of sightseeing and activities. Specialist forms of safaris cater for a variety of needs and budgets.\r\n\r\nSome examples include migratory safaris, birding, medical safaris, hiking, culinary, family, horse back and photographic safaris. A safari tour can range is length from a couple of days to longer overland trips. While the lon', 'yala', 250, 'newcontact.jpg', 'Safari');

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

CREATE TABLE `useraccounts` (
  `user_ID` int(100) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL,
  `contact` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`user_ID`, `first_name`, `last_name`, `email`, `password`, `type`, `contact`) VALUES
(7, 'user01', 'person', 'user01@gmail.com', 'cc03e747a6afbbcbf8be7668acfebee5', 'user', 0),
(8, 'Veenath', 'mihisara', 'test4@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 77596324),
(9, 'veenath', 'mihisara', 'vee@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 0),
(10, 'veenath1', 'mihisara1', 'vee1@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 0),
(11, 'tom', 'jerry', 'jertom@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 0),
(12, 'admintha', 'adambara', 'ad@gmail.com', '8770a902ff36d8d365c8fb5f371fae7b', 'admin', 123456),
(13, 'vest', 'london', 'vee@ts.com', '827ccb0eea8a706c4c34a16891f84e7b', 'user', 78965412),
(18, 'sam', 'person', 'user03@gmail.com', '9708d66b9338e4ee6f5db99a65f202de', 'user', 21465),
(19, 'veenath', 'Mihisara', 'mee@gmail.com', '200820e3227815ed1756a6b531e7e0d2', 'user', 774745),
(20, 'mane', 'you', 'eee@gmail.com', '0951ba11ae1427612d3de66ed5dafacc', 'user', 9996589),
(21, 'veenath', 'Mihisara', 'veenath123@gmail.com', '5a105e8b9d40e1329780d62ea2265d8a', 'user', 77454563),
(22, 'Veenath', 'mihisara', 'test4@gmail.com', '16d7a4fca7442dda3ad93c9a726597e4', 'user', 774598125);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`I_ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_ID`);

--
-- Indexes for table `reset`
--
ALTER TABLE `reset`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`tour_ID`);

--
-- Indexes for table `useraccounts`
--
ALTER TABLE `useraccounts`
  ADD PRIMARY KEY (`user_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `I_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `reset`
--
ALTER TABLE `reset`
  MODIFY `feedback_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tours`
--
ALTER TABLE `tours`
  MODIFY `tour_ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
  MODIFY `user_ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
