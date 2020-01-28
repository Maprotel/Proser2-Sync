-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 16-12-2019 a las 04:22:46
-- Versión del servidor: 10.3.20-MariaDB-1:10.3.20+maria~bionic-log
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proser-inv-proser_base`
--
CREATE DATABASE IF NOT EXISTS `proser-inv-proser_base` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `proser-inv-proser_base`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Employee`
--

DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
  `employeeID` int(11) NOT NULL,
  `employeeFullName` varchar(100) DEFAULT NULL,
  `employeeCode` varchar(20) DEFAULT NULL,
  `employeeMobile` varchar(50) DEFAULT NULL,
  `employeePosition` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Employee`
--

INSERT INTO `Employee` (`employeeID`, `employeeFullName`, `employeeCode`, `employeeMobile`, `employeePosition`) VALUES
(4, 'Billie Jean', 'BJ', '123456789', 'Musician'),
(6, 'Jorge Barrero', 'abc', '123', 'Director');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ProAgentPlan`
--

DROP TABLE IF EXISTS `ProAgentPlan`;
CREATE TABLE `ProAgentPlan` (
  `proplan_id` int(10) NOT NULL,
  `proplan_agent_id` int(10) DEFAULT NULL,
  `proplan_date` date DEFAULT NULL,
  `proplan_start_time` time DEFAULT NULL,
  `proplan_end_time` time DEFAULT NULL,
  `proplan_source` varchar(100) DEFAULT NULL,
  `proplan_status` varchar(10) DEFAULT NULL,
  `proplan_chk` varchar(10) DEFAULT NULL,
  `__JSON__` int(1) DEFAULT NULL,
  `proplan_people_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `proplan_operation_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `proplan_time_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ProScheduleChange`
--

DROP TABLE IF EXISTS `ProScheduleChange`;
CREATE TABLE `ProScheduleChange` (
  `pro_schedulechange_id` int(10) NOT NULL,
  `pro_schedulechange_agent_id` int(10) DEFAULT NULL,
  `pro_schedulechange_agent_name` varchar(250) DEFAULT NULL,
  `pro_schedulechange_start_date` date DEFAULT NULL,
  `pro_schedulechange_end_date` date DEFAULT NULL,
  `pro_schedulechange_start_time` time DEFAULT NULL,
  `pro_schedulechange_end_time` time DEFAULT NULL,
  `pro_schedulechange_type` varchar(250) DEFAULT NULL,
  `pro_schedulechange_description` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ProShowDisplay`
--

DROP TABLE IF EXISTS `ProShowDisplay`;
CREATE TABLE `ProShowDisplay` (
  `pro_show_display_id` int(10) NOT NULL,
  `pro_show_display_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pro_show_display_start_time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `pro_show_display_selection` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '\'\\\'{"userSelection":{}}\\\'\'',
  `pro_show_display_status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Employee`
--
ALTER TABLE `Employee`
  ADD PRIMARY KEY (`employeeID`);

--
-- Indices de la tabla `ProAgentPlan`
--
ALTER TABLE `ProAgentPlan`
  ADD PRIMARY KEY (`proplan_id`);

--
-- Indices de la tabla `ProScheduleChange`
--
ALTER TABLE `ProScheduleChange`
  ADD PRIMARY KEY (`pro_schedulechange_id`);

--
-- Indices de la tabla `ProShowDisplay`
--
ALTER TABLE `ProShowDisplay`
  ADD PRIMARY KEY (`pro_show_display_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Employee`
--
ALTER TABLE `Employee`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ProAgentPlan`
--
ALTER TABLE `ProAgentPlan`
  MODIFY `proplan_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ProScheduleChange`
--
ALTER TABLE `ProScheduleChange`
  MODIFY `pro_schedulechange_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ProShowDisplay`
--
ALTER TABLE `ProShowDisplay`
  MODIFY `pro_show_display_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
