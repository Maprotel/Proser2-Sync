-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 12-11-2019 a las 05:23:45
-- Versión del servidor: 10.3.18-MariaDB-1:10.3.18+maria~bionic-log
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
-- Estructura de tabla para la tabla `ProScheduleChange`
--

DROP TABLE IF EXISTS `ProScheduleChange`;
CREATE TABLE `ProScheduleChange` (
  `pro_schedulechange_id` int(10) NOT NULL,
  `pro_schedulechange_agent_serial_id` varchar(100) DEFAULT NULL,
  `pro_schedulechange_agent_id` int(10) DEFAULT NULL,
  `pro_schedulechange_agent_name` varchar(250) DEFAULT NULL,
  `pro_schedulechange_start_date` date DEFAULT NULL,
  `pro_schedulechange_end_date` date DEFAULT NULL,
  `pro_schedulechange_start_time` time DEFAULT NULL,
  `pro_schedulechange_end_time` time DEFAULT NULL,
  `pro_schedulechange_type` varchar(250) DEFAULT NULL,
  `pro_schedulechange_supervisor_id` int(11) DEFAULT NULL,
  `pro_schedulechange_description` varchar(250) DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `pro_schedulechange_people_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ProShowDisplay`
--

DROP TABLE IF EXISTS `ProShowDisplay`;
CREATE TABLE `ProShowDisplay` (
  `pro_show_display_id` int(10) NOT NULL,
  `pro_show_display_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `pro_show_display_weekday` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"weekday":[]}',
  `pro_show_display_start_time` time DEFAULT '00:00:00',
  `pro_show_display_end_time` time DEFAULT '24:00:00',
  `pro_show_display_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT 'NULL',
  `pro_show_display_selection` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '\'\\\'{"userSelection":{}}\\\'\'',
  `pro_show_display_view` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '\'{"view": {}}\'',
  `pro_show_display_status` varchar(10) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `ProShowDisplay`
--

INSERT INTO `ProShowDisplay` (`pro_show_display_id`, `pro_show_display_name`, `pro_show_display_weekday`, `pro_show_display_start_time`, `pro_show_display_end_time`, `pro_show_display_type`, `pro_show_display_selection`, `pro_show_display_view`, `pro_show_display_status`) VALUES
(16, 'Test', '[{\"id\":1,\"name\":\"lunes\",\"value\":1},{\"id\":2,\"name\":\"martes\",\"value\":2},{\"id\":3,\"name\":\"miércoles\",\"value\":3},{\"id\":4,\"name\":\"jueves\",\"value\":4},{\"id\":5,\"name\":\"viernes\",\"value\":5}]', '00:00:00', '23:59:59', '{\"id\":1,\"name\":\"Llamadas entrantes\",\"value\":\"inbound\"}', '{\"title\":\"Título\",\"entity_selection\":\"Selector\",\"options\":\"Opciones\",\"legend\":\"Leyenda\",\"start_date\":{\"year\":2019,\"month\":11,\"day\":9},\"end_date\":{\"year\":2019,\"month\":11,\"day\":9},\"mode\":{\"id\":0,\"name\":\"Actual\",\"value\":true},\"type\":{\"id\":0,\"name\":\"Ejecutado\"},\"start_time\":{\"id\":0,\"value\":\"00:00:00\"},\"end_time\":{\"id\":0,\"value\":\"23:59:59\"},\"login\":{\"id\":0,\"name\":\"username\",\"profile\":\"profile\"},\"last_minutes\":null,\"interval\":null,\"groupBy\":{\"id\":3,\"name\":\"COLA\",\"Inv_id\":\"inv_queue_id\",\"Inv_name\":\"inv_queue_name\",\"MainCallEntry_json_id\":\"JSON_UNQUOTE(JSON_EXTRACT(callentry_operation_json, \\\"$.queue[0].id\\\"))\",\"MainCdr_json_id\":\"JSON_UNQUOTE(JSON_EXTRACT(cdr_operation_json, \\\"$.queue[0].id\\\"))\",\"MainAudit_json_id\":\"JSON_UNQUOTE(JSON_EXTRACT(audit_operation_json, \\\"$.queue[0].id\\\"))\"},\"orderBy\":{},\"limitBy\":{},\"status\":{\"id\":0,\"name\":\"Activo\",\"value\":\"A\"},\"client\":[],\"queue\":[],\"service\":[],\"campaign\":[],\"supervisor\":[],\"agent\":[],\"role\":[],\"schedule\":[],\"auxiliar\":[],\"assignation\":[],\"start_time_hour\":{\"hour\":0,\"minute\":0,\"second\":0,\"value\":\"00:00:00\"},\"end_time_hour\":{\"hour\":23,\"minute\":59,\"second\":59,\"value\":\"23:59:59\"},\"views\":[{\"id\":1,\"name\":\"dashbord\",\"time\":30,\"option\":\"actual\"},{\"id\":1,\"name\":\"graph\",\"time\":30},{\"id\":1,\"name\":\"group\",\"time\":30,\"option\":\"COLAS\"},{\"id\":1,\"name\":\"dashbord\",\"time\":30,\"option\":\"historic\"}],\"creation_date\":\"2019-11-09\",\"creation_time\":\"04:47:08\",\"current_date\":{\"year\":2019,\"month\":11,\"day\":9}}', '[{\"id\":1,\"name\":\"standard\",\"value\":1}]', 'A');

--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de la tabla `ProScheduleChange`
--
ALTER TABLE `ProScheduleChange`
  MODIFY `pro_schedulechange_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ProShowDisplay`
--
ALTER TABLE `ProShowDisplay`
  MODIFY `pro_show_display_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
