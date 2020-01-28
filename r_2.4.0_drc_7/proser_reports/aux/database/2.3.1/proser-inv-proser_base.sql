-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 09-11-2019 a las 07:03:17
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
-- Estructura de tabla para la tabla `AccessToken`
--

DROP TABLE IF EXISTS `AccessToken`;
CREATE TABLE `AccessToken` (
  `id` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `ttl` int(11) DEFAULT NULL,
  `scopes` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `AccessToken`
--

INSERT INTO `AccessToken` (`id`, `ttl`, `scopes`, `created`, `userId`) VALUES
('aSaM8R4AHFAejfFadRM9ajlFSqHu1bgQimh3O4dEW210FWzS7edBorvkWVZ8WcyS', 1209600, NULL, '2019-11-01 13:56:15', 1),
('cCA16TZmAfFrmgCP43w2NAGfFOl6cy6JCNBLkr5JYOqs4njQcTdNsfWHXpK10Gku', 1209600, NULL, '2019-10-31 09:58:35', 1),
('dgSCfd83jRl7Cm5xzO4OySUAAtFGY76reA6ET8FPI9KcY3iuLDaUfLkzuHGiN6UM', 1209600, NULL, '2019-10-31 14:04:19', 1),
('eKKrO3SAjellNEVPsiq5fWlrvoQ1d4e07eMRLOE2Sl1FFeu4GSkKbXwN7hDf0Aqt', 1209600, NULL, '2019-10-30 14:42:16', 1),
('fh8orinFbGqrsIQVW2DU8LMbn73eZ90AZNxxpGHD3uaDdEdzGzGgrukqpKKUOMC4', 1209600, NULL, '2019-10-30 16:27:56', 1),
('IVPACHCAZCF0mg4HhB7BV4o0yny2D6hr70jOd22kDM8Jbqe6z4PhdA9tVjzvwiBl', 1209600, NULL, '2019-10-30 16:27:46', 1),
('NsCaFdby2TR05T9RlTHOMGRfMpiJ8MKiTdU3wXTLIgiVrBTe7bAhYPlzJsU86OTS', 1209600, NULL, '2019-11-09 08:01:09', 1),
('oqwzFUhXNURdOq2JIeeAdCRZX4iSS7D8UAoPukJWO0008rvYcpj14MsZmC9TBA92', 1209600, NULL, '2019-10-31 15:11:59', 1),
('pVjfmmuOHcjNVO6fWb81QAVTt8YXLgxMeIUWFIHZAuVLCSc06eQyWqtbcqWoYH64', 1209600, NULL, '2019-10-31 22:24:24', 1),
('uHWBTdDllatapWTWVwLxjFPO8LZZJnfMUWKNfJMIUGQe67McDHoHCwHbyBBHGm2C', 1209600, NULL, '2019-10-31 16:10:36', 1),
('vdzBfZ3epG4yb9qo1So6YKjBZYIuFW2ydF8eaDVeTWAFC3BmbxdW507GOd5Xz2vR', 1209600, NULL, '2019-10-31 18:16:43', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ACL`
--

DROP TABLE IF EXISTS `ACL`;
CREATE TABLE `ACL` (
  `id` int(11) NOT NULL,
  `model` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `property` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `accessType` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `permission` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `principalType` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `principalId` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuxColor`
--

DROP TABLE IF EXISTS `AuxColor`;
CREATE TABLE `AuxColor` (
  `aux_color_id` int(10) NOT NULL,
  `aux_color_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_color_string` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_color_use` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_color_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `AuxColor`
--

INSERT INTO `AuxColor` (`aux_color_id`, `aux_color_name`, `aux_color_string`, `aux_color_use`, `aux_color_status`) VALUES
(1, 'verde', '#28a745', 'Disponible', 'A'),
(2, 'rojo', '#dc3545', 'Ocupado', 'A'),
(3, 'amarillo', '#ffc107', 'Auxiliar', 'A'),
(4, 'violeta', '#6f42c1', 'Asignado', 'A'),
(6, NULL, NULL, NULL, NULL),
(7, 'Otro color', '#123456', 'Otro', 'I'),
(11, 'Vinotinto', '#3B1715', 'Juego de la seleccion', 'A'),
(12, 'Jornada', '#D705F4 ', 'Jornda de INTT', 'A'),
(13, 'Base', 'New', 'My frist color', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuxHour`
--

DROP TABLE IF EXISTS `AuxHour`;
CREATE TABLE `AuxHour` (
  `aux_hour_id` int(11) NOT NULL,
  `aux_hour_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_hour_value` time DEFAULT NULL,
  `aux_hour_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `AuxHour`
--

INSERT INTO `AuxHour` (`aux_hour_id`, `aux_hour_name`, `aux_hour_value`, `aux_hour_status`) VALUES
(0, '00 AM', '00:00:00', 'A'),
(1, '01 AM', '01:00:00', 'A'),
(2, '02 AM', '02:00:00', 'A'),
(3, '03 AM', '03:00:00', 'A'),
(4, '04 AM', '04:00:00', 'A'),
(5, '05 AM', '05:00:00', 'A'),
(6, '06 AM', '06:00:00', 'A'),
(7, '07 AM', '07:00:00', 'A'),
(8, '08 AM', '08:00:00', 'A'),
(9, '09 AM', '09:00:00', 'A'),
(10, '10 AM', '10:00:00', 'A'),
(11, '11 AM', '11:00:00', 'A'),
(12, '12 AM', '12:00:00', 'A'),
(13, '01 PM', '13:00:00', 'A'),
(14, '02 PM', '14:00:00', 'A'),
(15, '03 PM', '15:00:00', 'A'),
(16, '04 PM', '16:00:00', 'A'),
(17, '05 PM', '17:00:00', 'A'),
(18, '06 PM', '18:00:00', 'A'),
(19, '07 PM', '19:00:00', 'A'),
(20, '08 PM', '20:00:00', 'A'),
(21, '09 PM', '21:00:00', 'A'),
(22, '10 PM', '22:00:00', 'A'),
(23, '11 PM', '23:00:00', 'A'),
(24, '12 PM', '24:00:00', 'A'),
(41, '10am', '10:00:00', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuxInfo`
--

DROP TABLE IF EXISTS `AuxInfo`;
CREATE TABLE `AuxInfo` (
  `aux_info_id` int(10) NOT NULL,
  `aux_info_name` varchar(100) DEFAULT NULL,
  `aux_info_value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuxInterval`
--

DROP TABLE IF EXISTS `AuxInterval`;
CREATE TABLE `AuxInterval` (
  `aux_interval_id` int(10) NOT NULL,
  `aux_interval_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_interval_minutes` int(11) DEFAULT NULL,
  `aux_interval_value` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_interval_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `AuxInterval`
--

INSERT INTO `AuxInterval` (`aux_interval_id`, `aux_interval_name`, `aux_interval_minutes`, `aux_interval_value`, `aux_interval_status`) VALUES
(1, '1 min', 1, '00:01:00', 'A'),
(5, '5 min', 5, '00:05:00', 'A'),
(10, '10 min', 10, '00:10:00', 'A'),
(15, '15 min', 15, '00:15:00', 'A'),
(30, '30 min', 30, '00:30:00', 'A'),
(45, '45 min', 45, '00:45:00', 'A'),
(60, '60 min', 60, '01:00:00', 'A'),
(120, '120 min', 120, '02:00:00', 'A'),
(180, '180 min', 180, '03:00:00', 'A'),
(240, '240 min', 240, '04:00:00', 'A'),
(241, '45646 min', 45646, '16:46:00', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AuxLine`
--

DROP TABLE IF EXISTS `AuxLine`;
CREATE TABLE `AuxLine` (
  `aux_line_id` int(11) NOT NULL,
  `aux_line_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aux_line_value` int(11) DEFAULT NULL,
  `aux_line_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `AuxLine`
--

INSERT INTO `AuxLine` (`aux_line_id`, `aux_line_name`, `aux_line_value`, `aux_line_status`) VALUES
(1, '1 lineas', 1, 'A'),
(2, '5 líneas', 5, 'A'),
(3, '10 líneas', 10, 'A'),
(4, '15 líneas', 15, 'A'),
(5, '20 líneas', 20, 'A'),
(7, '25 líneas', 25, 'A'),
(8, '30 líneas', 30, 'A'),
(9, '35 líneas', 35, 'A'),
(10, '40 líneas', 40, 'A'),
(11, '45 líneas', 45, 'A'),
(12, '50 líneas', 50, 'A'),
(13, '55 líneas', 55, 'A'),
(14, '60 líneas', 60, 'A'),
(15, '65 lineas', 65, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HcxChange`
--

DROP TABLE IF EXISTS `HcxChange`;
CREATE TABLE `HcxChange` (
  `hcx_id` int(10) NOT NULL,
  `hcx_timestamp` timestamp NULL DEFAULT current_timestamp(),
  `hcx_date_from` date DEFAULT NULL,
  `hcx_time_from` time DEFAULT NULL,
  `hcx_table` text DEFAULT NULL,
  `hcx_action` varchar(50) NOT NULL DEFAULT 'NULL',
  `hcx_record` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `hcx_record_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvAgent`
--

DROP TABLE IF EXISTS `InvAgent`;
CREATE TABLE `InvAgent` (
  `inv_agent_id` int(10) NOT NULL,
  `inv_agent_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_chk` int(10) DEFAULT 1,
  `inv_agent_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_extension` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_legal_id` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_internal_id` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_agent_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(1) DEFAULT NULL,
  `inv_agent_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"supervisor":[], "role":[]}',
  `inv_agent_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '	{"client":[], "queue":[], "service":[], "campaign":[]}',
  `inv_agent_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"calendar":[], "schedule":[]}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `InvAgent`
--

INSERT INTO `InvAgent` (`inv_agent_id`, `inv_agent_status`, `inv_agent_chk`, `inv_agent_name`, `inv_agent_shortname`, `inv_agent_extension`, `inv_agent_legal_id`, `inv_agent_internal_id`, `inv_agent_type`, `__JSON__`, `inv_agent_people_json`, `inv_agent_operation_json`, `inv_agent_time_json`) VALUES
(15, 'A', 1, 'Coordinador Integral  Tecnico Nocturno', NULL, '538', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(18, 'A', 1, 'JANETH RIERA', NULL, '540', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(20, 'A', 1, 'OMAIRA PEREZ', NULL, '542', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(28, 'A', 1, 'LISBETH RODRIGUEZ', NULL, '508', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(29, 'A', 1, 'ANAIS CARMONA', NULL, '509', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(30, 'A', 1, 'CARLOS GOITIA', NULL, '510', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(31, 'A', 1, 'GRENELIS PEREZ', NULL, '511', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(32, 'A', 1, 'JUAN LUGO', NULL, '512', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(33, 'A', 1, 'VIRGINIA TORTOZA', NULL, '513', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(34, 'A', 1, 'YOMAIRA CHIRINOS', NULL, '514', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(35, 'A', 1, 'Vacante', NULL, '515', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(42, 'A', 1, 'Diana Borges', NULL, '522', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(43, 'A', 1, 'ARMARYS ALVARADO', NULL, '523', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(44, 'A', 1, 'EDUARDO GARCÃA', NULL, '524', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(45, 'A', 1, 'ELBERT ALBARRAN', NULL, '525', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(46, 'A', 1, 'JUAN OLIVO', NULL, '526', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(48, 'A', 1, 'JHOSCARLY RODRIGUEZ', NULL, '528', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(67, 'A', 1, 'Carlos Caraballo', NULL, '543', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(68, 'A', 1, 'Iris Guillen', NULL, '544', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(69, 'A', 1, 'Analista integral', NULL, '561', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(70, 'A', 1, 'Analista Integral', NULL, '554', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(71, 'A', 1, 'Analista Integral', NULL, '559', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(72, 'A', 1, 'Eglis Sulbaran', NULL, '529', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(73, 'A', 1, 'Cherish Abedank', NULL, '530', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(74, 'A', 1, 'YAINIRES DUARTE', NULL, '541', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(75, 'A', 1, 'Mayler Rivas', NULL, '527', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(76, 'A', 1, 'Analista Integral', NULL, '556', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(77, 'A', 1, 'Analista Integral', NULL, '557', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(78, 'A', 1, 'Analista Integral', NULL, '558', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(79, 'A', 1, 'Analista Integral', NULL, '560', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(80, 'A', 1, 'Analista Integral', NULL, '562', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(81, 'A', 1, 'GABRIEL MEZA', NULL, '505', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(82, 'A', 1, 'Analista Integral', NULL, '539', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(83, 'A', 1, 'Analista Integral', NULL, '563', NULL, NULL, 'SIP', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(84, 'A', 1, 'Luisa Valles', NULL, '545', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(85, 'A', 1, 'Eduardo Aldana', NULL, '546', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(86, 'A', 1, 'Veruska Rodriguez', NULL, '547', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(87, 'A', 1, 'Sixner Rodriguez', NULL, '548', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(88, 'A', 1, 'Olga Rodriguez', NULL, '549', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(89, 'A', 1, 'Lisbeth Rodriguez', NULL, '550', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(90, 'A', 1, 'Elizabeth Davila', NULL, '551', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(91, 'A', 1, 'Lesly Santos', NULL, '552', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(92, 'A', 1, 'Luz Rodriguez', NULL, '553', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(93, 'A', 1, 'Juan Gonzalez', NULL, '564', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(94, 'A', 1, 'Linet Alcala', NULL, '565', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(95, 'A', 1, 'Yuleixsy Rodriguez', NULL, '566', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(96, 'A', 1, 'Wilmer Valles', NULL, '567', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(97, 'A', 1, 'Jose Guerrero', NULL, '568', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(98, 'A', 1, 'Charlie Correa', NULL, '569', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(99, 'A', 1, 'Dulce Perez', NULL, '570', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(100, 'A', 1, 'Maryibeth Martinez', NULL, '571', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(101, 'A', 1, 'Luis Riera', NULL, '572', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(102, 'A', 1, 'Everts Jimenez', NULL, '573', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(103, 'A', 1, 'Bronny Piters', NULL, '574', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(104, 'A', 1, 'Francisco Velasquez', NULL, '576', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}'),
(105, 'A', 1, 'Erika Vivas', NULL, '575', NULL, NULL, 'Agent', NULL, '{\"supervisor\":[], \"role\":[]}', '	{\"client\":[], \"queue\":[], \"service\":[], \"campaign\":[]}', '{\"calendar\":[], \"schedule\":[]}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvAgentRole`
--

DROP TABLE IF EXISTS `InvAgentRole`;
CREATE TABLE `InvAgentRole` (
  `inv_agentrole_id` int(10) NOT NULL,
  `inv_agentrole_name` varchar(100) DEFAULT NULL,
  `inv_agentrole_status` varchar(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvBreak`
--

DROP TABLE IF EXISTS `InvBreak`;
CREATE TABLE `InvBreak` (
  `inv_break_id` int(10) NOT NULL,
  `inv_break_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT 'A',
  `inv_break_chk` int(1) DEFAULT 1,
  `inv_break_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_break_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_break_codename` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_break_description` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_break_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_break_productivity` int(11) DEFAULT 0,
  `inv_break_class` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvBreak`
--

INSERT INTO `InvBreak` (`inv_break_id`, `inv_break_status`, `inv_break_chk`, `inv_break_name`, `inv_break_shortname`, `inv_break_codename`, `inv_break_description`, `inv_break_type`, `inv_break_productivity`, `inv_break_class`) VALUES
(1, 'A', 1, 'Hold', NULL, NULL, 'Hold', 'H', 0, 'Auxiliar'),
(2, 'A', 1, 'Almuerzo', NULL, NULL, 'Almuerzo', 'B', 0, 'Auxiliar'),
(3, 'A', 1, 'BaÃ±o', NULL, NULL, 'Sanitario', 'B', 0, 'Auxiliar'),
(4, 'A', 1, 'Descanso', NULL, NULL, 'Descanso (30min pausa de Ley)', 'B', 0, 'Auxiliar'),
(5, 'A', 1, 'Break (cafÃ©/agua)', NULL, NULL, 'Break (cafÃ©/agua)', 'B', 0, 'Auxiliar'),
(6, 'A', 1, 'Asignacion Especial (Reunion/Induccion/Asignacion/Feed Back)', NULL, NULL, 'Asignacion Especial (Reunion/Induccion/Asignacion/Feed Back)', 'B', 0, 'Auxiliar'),
(7, 'A', 1, 'Descanso Nocturno', NULL, NULL, 'Descanso Nocturno', 'B', 0, 'Auxiliar'),
(10, 'A', 1, 'Llamada saliente', NULL, NULL, 'Llamada saliente', 'B', 0, 'Auxiliar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvCalendar`
--

DROP TABLE IF EXISTS `InvCalendar`;
CREATE TABLE `InvCalendar` (
  `inv_calendar_id` int(10) NOT NULL,
  `inv_calendar_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_calendar_type` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_calendar_status` varchar(11) COLLATE utf8_spanish_ci DEFAULT 'A',
  `inv_calendar_chk` int(100) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvCalendar`
--

INSERT INTO `InvCalendar` (`inv_calendar_id`, `inv_calendar_name`, `inv_calendar_type`, `inv_calendar_status`, `inv_calendar_chk`) VALUES
(1, 'Feriados Venezuela', 'Feriados', 'A', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvCalendarDay`
--

DROP TABLE IF EXISTS `InvCalendarDay`;
CREATE TABLE `InvCalendarDay` (
  `inv_calendarday_id` int(10) NOT NULL,
  `inv_calendar_id` int(11) DEFAULT NULL,
  `inv_calendarday_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT 'A',
  `inv_calendarday_date` date DEFAULT NULL,
  `inv_calendarday_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_calendarday_type` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_calendarday_date_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `InvCalendarDay`
--

INSERT INTO `InvCalendarDay` (`inv_calendarday_id`, `inv_calendar_id`, `inv_calendarday_status`, `inv_calendarday_date`, `inv_calendarday_name`, `inv_calendarday_type`, `__JSON__`, `inv_calendarday_date_json`) VALUES
(1, 1, 'A', '2019-01-02', 'Año Nuevo', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":1,\"day\":2}'),
(2, 1, 'A', '2019-03-04', 'Carnaval', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":3,\"day\":4}'),
(3, 1, 'A', '2019-03-05', 'Carnaval', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":3,\"day\":5}'),
(4, 1, 'A', '2019-04-18', 'Jueves Santo', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":4,\"day\":18}'),
(5, 1, 'A', '2019-04-19', 'Viernes Santo/Declaración de la Independencia', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":4,\"day\":19}'),
(6, 1, 'A', '2019-05-01', 'Día del Trabajo', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":5,\"day\":1}'),
(7, 1, 'A', '2019-06-24', 'Batalla de Carabobo', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":6,\"day\":24}'),
(8, 1, 'A', '2019-07-07', 'Dí­a de la Independencia', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":7,\"day\":7}'),
(9, 1, 'A', '2019-07-24', 'Día de Simón Bolívar', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":7,\"day\":24}'),
(10, 1, 'A', '2019-10-10', 'Día de la Resistencia Indígena', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":10,\"day\":10}'),
(11, 1, 'A', '2019-12-24', 'Víspera de Navidad', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":12,\"day\":24}'),
(12, 1, 'A', '2019-12-25', 'Navidad', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":12,\"day\":25}'),
(13, 1, 'A', '2019-12-31', 'Fiesta de Fin de Año', 'Feriado Nacional', NULL, '{\"year\":2019,\"month\":12,\"day\":31}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvCampaign`
--

DROP TABLE IF EXISTS `InvCampaign`;
CREATE TABLE `InvCampaign` (
  `inv_campaign_id` int(10) NOT NULL,
  `inv_campaign_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_chk` int(10) DEFAULT NULL,
  `inv_campaign_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_description` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_queue_id` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_queue_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_queue_number` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_campaign_aftercall_time` int(10) DEFAULT NULL,
  `inv_campaign_start_date` date DEFAULT NULL,
  `inv_campaign_end_date` date DEFAULT NULL,
  `inv_campaign_start_time` time DEFAULT NULL,
  `inv_campaign_end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvClient`
--

DROP TABLE IF EXISTS `InvClient`;
CREATE TABLE `InvClient` (
  `inv_client_id` int(10) NOT NULL,
  `inv_client_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_client_chk` int(10) DEFAULT NULL,
  `inv_client_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_client_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_client_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvClient`
--

INSERT INTO `InvClient` (`inv_client_id`, `inv_client_status`, `inv_client_chk`, `inv_client_name`, `inv_client_shortname`, `inv_client_type`) VALUES
(4, 'A', NULL, 'digitel', 'digitel', 'especial'),
(5, 'A', NULL, 'ubiipagos', 'ubiipagos', '123456'),
(6, 'A', NULL, 'seguros universitas', 'universitas', '123456'),
(7, 'I', NULL, 'Universidad', 'universidad', '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvQueue`
--

DROP TABLE IF EXISTS `InvQueue`;
CREATE TABLE `InvQueue` (
  `inv_queue_id` int(10) NOT NULL,
  `inv_queue_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_chk` int(10) DEFAULT NULL,
  `inv_queue_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_sms_name` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_number` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_type` varchar(50) GENERATED ALWAYS AS (if(substr(`inv_queue_number`,1,1) = 9,'automatic','inbound')) STORED,
  `__JSON__` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_operation_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"client":[], "service":[]}',
  `inv_queue_system_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"scale":[]}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvQueue`
--

INSERT INTO `InvQueue` (`inv_queue_id`, `inv_queue_status`, `inv_queue_chk`, `inv_queue_name`, `inv_queue_shortname`, `inv_queue_sms_name`, `inv_queue_number`, `__JSON__`, `inv_queue_operation_json`, `inv_queue_system_json`) VALUES
(3, 'A', NULL, NULL, NULL, NULL, '5000', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(4, 'A', NULL, NULL, NULL, NULL, '5001', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(5, 'A', NULL, NULL, NULL, NULL, '5002', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(6, 'A', NULL, NULL, NULL, NULL, '5003', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(7, 'A', NULL, NULL, NULL, NULL, '5004', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(8, 'A', NULL, NULL, NULL, NULL, '5005', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(9, 'A', NULL, NULL, NULL, NULL, '5006', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(10, 'A', NULL, NULL, NULL, NULL, '5010', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}'),
(11, 'A', NULL, NULL, NULL, NULL, '5007', NULL, '{\"client\":[], \"service\":[]}', '{\"scale\":[]}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvQueueConfig`
--

DROP TABLE IF EXISTS `InvQueueConfig`;
CREATE TABLE `InvQueueConfig` (
  `queueconfig_extension` varchar(20) NOT NULL DEFAULT '',
  `queueconfig_descr` varchar(35) NOT NULL DEFAULT '',
  `queueconfig_grppre` varchar(100) NOT NULL DEFAULT '',
  `queueconfig_alertinfo` varchar(254) NOT NULL DEFAULT '',
  `queueconfig_ringing` tinyint(1) NOT NULL DEFAULT 0,
  `queueconfig_maxwait` varchar(8) NOT NULL DEFAULT '',
  `queueconfig_password` varchar(20) NOT NULL DEFAULT '',
  `queueconfig_ivr_id` varchar(8) NOT NULL DEFAULT '0',
  `queueconfig_dest` varchar(50) NOT NULL DEFAULT '',
  `queueconfig_cwignore` tinyint(1) NOT NULL DEFAULT 0,
  `queueconfig_qregex` varchar(255) DEFAULT NULL,
  `queueconfig_agentannounce_id` int(11) DEFAULT NULL,
  `queueconfig_joinannounce_id` int(11) DEFAULT NULL,
  `queueconfig_queuewait` tinyint(1) DEFAULT 0,
  `queueconfig_use_queue_context` tinyint(1) DEFAULT 0,
  `queueconfig_togglehint` tinyint(1) DEFAULT 0,
  `queueconfig_qnoanswer` tinyint(1) DEFAULT 0,
  `queueconfig_callconfirm` tinyint(1) DEFAULT 0,
  `queueconfig_callconfirm_id` int(11) DEFAULT NULL,
  `queueconfig_monitor_type` varchar(5) DEFAULT NULL,
  `queueconfig_monitor_heard` int(11) DEFAULT NULL,
  `queueconfig_monitor_spoken` int(11) DEFAULT NULL,
  `queueconfig_callback_id` varchar(8) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `InvQueueConfig`
--

INSERT INTO `InvQueueConfig` (`queueconfig_extension`, `queueconfig_descr`, `queueconfig_grppre`, `queueconfig_alertinfo`, `queueconfig_ringing`, `queueconfig_maxwait`, `queueconfig_password`, `queueconfig_ivr_id`, `queueconfig_dest`, `queueconfig_cwignore`, `queueconfig_qregex`, `queueconfig_agentannounce_id`, `queueconfig_joinannounce_id`, `queueconfig_queuewait`, `queueconfig_use_queue_context`, `queueconfig_togglehint`, `queueconfig_qnoanswer`, `queueconfig_callconfirm`, `queueconfig_callconfirm_id`, `queueconfig_monitor_type`, `queueconfig_monitor_heard`, `queueconfig_monitor_spoken`, `queueconfig_callback_id`) VALUES
('1000', 'Disponible', '', '', 0, '', '0987', 'none', 'app-blackhole,hangup,1', 1, '', 10, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('2701', 'grupo Ubiipago', '', '', 0, '1800', '', 'none', 'app-blackhole,hangup,1', 1, '', 0, 24, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('3700', 'sal-marcador', '', '', 0, '', '', 'none', '', 1, '', 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 'none'),
('1001', 'Disponible', ':ASE', '', 0, '', '0987', 'none', 'app-blackhole,hangup,1', 1, '', 11, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1007', 'Contingencia', '', '', 0, '', '', 'none', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1006', 'Disponible', '', '', 0, '', '0987', 'none', '', 1, '', 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 'none'),
('1003', 'Disponible', ':MAT', '', 0, '', '0987', 'none', 'app-blackhole,hangup,1', 1, '', 9, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1005', 'Disponible', '', '', 0, '', '0987', 'none', 'app-blackhole,hangup,1', 1, '', 0, 12, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('4000', 'Cola APS', '', '', 0, '', '', 'none', '', 1, '', 15, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('4001', 'Farmacia', '', '', 0, '', '', 'none', '', 1, '', 14, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('4002', 'VIP', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('4003', 'Grupo medico APS', '', '', 0, '', '', 'none', '', 1, '', 0, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5000', 'cola diurna  7am  a 1pm', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5007', 'Funeraria', '', '', 0, '', '', 'none', '', 1, '', 17, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5003', 'cola diurna fin de semana', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5004', 'cola tarde fin de semana', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5002', 'cola noche 19pm a 7am', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5005', 'cola noche fin de semana', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5006', 'cola VIP', '', '', 0, '', '', 'none', '', 1, '', 15, 15, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5010', '24 horas', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('5001', 'cola tarde 13 pm a 19pm', '', '', 0, '', '', 'none', '', 1, '', 16, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1002', 'Turno Nocturno 12/48', '', '', 0, '300', '', 'none', 'timeconditions,7,1', 0, '', 14, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1010', 'Turno Noche Fin de semana', '', '', 0, '300', '', 'none', 'timeconditions,2,1', 1, '', 14, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1009', 'Turno Tarde Fin de Semana', '', '', 0, '300', '', 'none', 'timeconditions,2,1', 1, '', 14, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1008', 'Asesor Medico', '', '', 0, '300', '', 'none', 'timeconditions,2,1', 1, '', 0, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none'),
('1011', 'Paramedicos call center', '', '', 0, '', '', 'none', 'ext-queues,1011,1', 1, '', 0, 0, 0, 0, 0, 0, 0, 0, 'b', 0, 0, 'none');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvScale`
--

DROP TABLE IF EXISTS `InvScale`;
CREATE TABLE `InvScale` (
  `inv_scale_id` int(10) NOT NULL,
  `inv_scale_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_scale_chk` int(10) DEFAULT NULL,
  `inv_scale_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_scale_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_scale_red` int(10) DEFAULT NULL,
  `inv_scale_yellow` int(10) DEFAULT NULL,
  `inv_scale_green` int(10) DEFAULT NULL,
  `inv_scale_blue` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvScale`
--

INSERT INTO `InvScale` (`inv_scale_id`, `inv_scale_status`, `inv_scale_chk`, `inv_scale_shortname`, `inv_scale_name`, `inv_scale_red`, `inv_scale_yellow`, `inv_scale_green`, `inv_scale_blue`) VALUES
(1, 'A', NULL, 'Normal', 'Normal', 1, 90, 95, 99);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvSchedule`
--

DROP TABLE IF EXISTS `InvSchedule`;
CREATE TABLE `InvSchedule` (
  `inv_schedule_id` int(10) NOT NULL,
  `inv_schedule_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_schedule_chk` int(10) DEFAULT NULL,
  `inv_schedule_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_schedule_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_schedule_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_schedule_description` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvSchedule`
--

INSERT INTO `InvSchedule` (`inv_schedule_id`, `inv_schedule_status`, `inv_schedule_chk`, `inv_schedule_type`, `inv_schedule_name`, `inv_schedule_shortname`, `inv_schedule_description`) VALUES
(1, 'A', NULL, NULL, 'dia', NULL, 'dia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvScheduleDay`
--

DROP TABLE IF EXISTS `InvScheduleDay`;
CREATE TABLE `InvScheduleDay` (
  `inv_scheduleday_id` int(11) NOT NULL,
  `inv_schedule_id` int(11) DEFAULT NULL,
  `inv_scheduleday_weekday` int(11) DEFAULT NULL,
  `inv_scheduleday_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_scheduleday_start_time` time DEFAULT NULL,
  `inv_scheduleday_end_time` time DEFAULT NULL,
  `inv_scheduleday_legal_break` time DEFAULT NULL,
  `inv_scheduleday_laborday` int(11) DEFAULT NULL,
  `inv_scheduleday_duration` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvScheduleDay`
--

INSERT INTO `InvScheduleDay` (`inv_scheduleday_id`, `inv_schedule_id`, `inv_scheduleday_weekday`, `inv_scheduleday_name`, `inv_scheduleday_start_time`, `inv_scheduleday_end_time`, `inv_scheduleday_legal_break`, `inv_scheduleday_laborday`, `inv_scheduleday_duration`) VALUES
(1, 1, 1, 'lunes', '09:00:00', '17:00:00', '01:00:00', 1, '-09:00:00'),
(2, 1, 2, 'martes', '08:00:00', '17:00:00', '01:00:00', 1, NULL),
(3, 1, 3, 'miércoles', '08:00:00', '17:00:00', '01:00:00', 1, NULL),
(4, 1, 4, 'jueves', '08:00:00', '17:00:00', '01:00:00', 1, NULL),
(5, 1, 5, 'viernes', '08:00:00', '17:00:00', '01:00:00', 1, NULL),
(6, 1, 6, 'sábado', NULL, NULL, NULL, 0, NULL),
(7, 1, 7, 'domingo', NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvService`
--

DROP TABLE IF EXISTS `InvService`;
CREATE TABLE `InvService` (
  `inv_service_id` int(10) NOT NULL,
  `inv_service_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_service_chk` int(10) DEFAULT NULL,
  `inv_service_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_service_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_service_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_service_use` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvSms`
--

DROP TABLE IF EXISTS `InvSms`;
CREATE TABLE `InvSms` (
  `inv_sms_id` int(10) NOT NULL,
  `inv_sms_date` date DEFAULT NULL,
  `inv_sms_time` time DEFAULT NULL,
  `inv_sms_msg` varchar(140) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_sms_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_sms_chk` int(10) DEFAULT NULL,
  `inv_sms_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `InvSupervisor`
--

DROP TABLE IF EXISTS `InvSupervisor`;
CREATE TABLE `InvSupervisor` (
  `inv_supervisor_id` int(10) NOT NULL,
  `inv_supervisor_status` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_chk` int(10) DEFAULT NULL,
  `inv_supervisor_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_shortname` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_legal_id` varchar(20) COLLATE utf8_spanish_ci DEFAULT 'NULL',
  `inv_supervisor_internal_id` varchar(20) COLLATE utf8_spanish_ci DEFAULT 'NULL',
  `__JSON__` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_supervisor_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `InvSupervisor`
--

INSERT INTO `InvSupervisor` (`inv_supervisor_id`, `inv_supervisor_status`, `inv_supervisor_chk`, `inv_supervisor_name`, `inv_supervisor_shortname`, `inv_supervisor_legal_id`, `inv_supervisor_internal_id`, `__JSON__`, `inv_supervisor_people_json`, `inv_supervisor_operation_json`, `inv_supervisor_time_json`) VALUES
(1, 'A', 1, 'Erika González', 'Erika', '123456', '123456', NULL, '{\"supervisor\":[{\"id\":1,\"name\":\"Erika González\"}],\"agent\":[],\"role\":[],\"type\":{\"id\":1,\"name\":\"Activo\"}}', '{\"campaign\":null,\"client\":null,\"queue\":[{\"id\":3,\"name\":\"5000 - 5000 - cola diurna  7am  a 1pm\"}],\"service\":null}', '{\"calendar\":[],\"schedule\":null,\"scheduledays\":[],\"schedulehours\":[]}');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Role`
--

DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role` (
  `id` int(11) NOT NULL,
  `name` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `description` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created` datetime DEFAULT current_timestamp(),
  `modified` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `Role`
--

INSERT INTO `Role` (`id`, `name`, `description`, `created`, `modified`) VALUES
(1, 'admin', 'Administrator', '2019-08-08 20:43:17', '2019-08-08 20:43:17'),
(2, 'system', 'Sistema', '2019-09-16 12:00:21', '2019-09-16 12:00:21'),
(3, 'config', 'Configuracion', '2019-09-16 12:00:21', '2019-09-16 12:00:21'),
(4, 'user', 'Usuario', '2019-09-16 12:00:21', '2019-09-16 12:00:21'),
(5, 'develop', 'Developer', '2019-09-20 13:36:55', '2019-09-20 13:36:55'),
(7, 'guest', 'Invitado', '2019-10-27 12:33:17', '2019-10-27 12:33:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RoleMapping`
--

DROP TABLE IF EXISTS `RoleMapping`;
CREATE TABLE `RoleMapping` (
  `id` int(11) NOT NULL,
  `principalType` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `principalId` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `RoleMapping`
--

INSERT INTO `RoleMapping` (`id`, `principalType`, `principalId`, `roleId`) VALUES
(1, 'USER', '1', 1),
(2, 'USER', '2', 2),
(3, 'USER', '3', 3),
(4, 'USER', '4', 4),
(5, 'USER', '5', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `realm` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `username` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `verificationToken` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Userbase`
--

DROP TABLE IF EXISTS `Userbase`;
CREATE TABLE `Userbase` (
  `id` int(11) NOT NULL,
  `firstname` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `lastname` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `profile` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `realm` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `username` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(512) COLLATE utf8_spanish_ci NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `verificationToken` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL,
  `memberId` int(11) DEFAULT NULL,
  `user_legal_id` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_internal_id` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_photo_path` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `profile_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `Userbase`
--

INSERT INTO `Userbase` (`id`, `firstname`, `lastname`, `profile`, `realm`, `username`, `password`, `email`, `emailVerified`, `verificationToken`, `memberId`, `user_legal_id`, `user_internal_id`, `user_photo_path`, `profile_json`) VALUES
(1, 'maprotel', 'admin', 'admin', 'maprotel', 'maprotel-admin', '$2a$10$9ARBD.KCRMCchquHi/Tzje7eGgaTqq5jHzFZwzns.P7nMaMb8blG.', 'maprotel@maprotel.com', 1, NULL, NULL, 'string', 'string', 'string', NULL),
(2, 'maprotel', 'system', 'system', 'maprotel', 'maprotel-system', '$2a$10$ubijinVTR2QxuDad1nAtPuGET81oFpjGs3oJwjPRGU1jJXtF2EJT6', 'maprotel-system@maprotel.com', 1, NULL, NULL, 'string', 'string', 'string', NULL),
(3, 'maprotel', 'config', 'config', 'maprotel', 'maprotel-config', '$2a$10$PuY8q/KduTIRTHUohE3qk.XkY2j37Ep3TTYna0DAWtEAAwzDiCAZu', 'maprotel-config@maprotel.com', 1, NULL, NULL, 'string', 'string', 'string', NULL),
(4, 'maprotel', 'user', 'user', 'maprotel', 'maprotel-user', '$2a$10$.cihkjrfvDqxPUBMfzQW6Ov3YzTi1P8yq.JyZ/uviFzaUocKUWGB.', 'maprotel-user@maprotel.com', 1, NULL, NULL, 'string', 'string', 'string', NULL),
(5, 'maprotel', 'develop', 'develop', 'maprotel', 'maprotel-develop', '$2a$10$EJ.KqS7A5m3Ydj.Gy1NioO4.hiKnCI8ehznWrT9SuaSTLk.4799iW', 'maprotel-develop@maprotel.com', 1, NULL, NULL, '123456789', '123456789', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `AccessToken`
--
ALTER TABLE `AccessToken`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ACL`
--
ALTER TABLE `ACL`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `AuxColor`
--
ALTER TABLE `AuxColor`
  ADD PRIMARY KEY (`aux_color_id`);

--
-- Indices de la tabla `AuxHour`
--
ALTER TABLE `AuxHour`
  ADD PRIMARY KEY (`aux_hour_id`);

--
-- Indices de la tabla `AuxInfo`
--
ALTER TABLE `AuxInfo`
  ADD PRIMARY KEY (`aux_info_id`);

--
-- Indices de la tabla `AuxInterval`
--
ALTER TABLE `AuxInterval`
  ADD PRIMARY KEY (`aux_interval_id`);

--
-- Indices de la tabla `AuxLine`
--
ALTER TABLE `AuxLine`
  ADD PRIMARY KEY (`aux_line_id`);

--
-- Indices de la tabla `HcxChange`
--
ALTER TABLE `HcxChange`
  ADD PRIMARY KEY (`hcx_id`);

--
-- Indices de la tabla `InvAgent`
--
ALTER TABLE `InvAgent`
  ADD PRIMARY KEY (`inv_agent_id`),
  ADD KEY `inv_agent_legal_id` (`inv_agent_legal_id`),
  ADD KEY `inv_agent_internal_id` (`inv_agent_internal_id`),
  ADD KEY `inv_agent_extension` (`inv_agent_extension`),
  ADD KEY `inv_agent_status` (`inv_agent_status`),
  ADD KEY `inv_agent_type` (`inv_agent_type`),
  ADD KEY `inv_agent_people_json` (`inv_agent_people_json`),
  ADD KEY `inv_agent_operation_json` (`inv_agent_operation_json`),
  ADD KEY `inv_agent_time_json` (`inv_agent_time_json`);

--
-- Indices de la tabla `InvAgentRole`
--
ALTER TABLE `InvAgentRole`
  ADD PRIMARY KEY (`inv_agentrole_id`);

--
-- Indices de la tabla `InvBreak`
--
ALTER TABLE `InvBreak`
  ADD PRIMARY KEY (`inv_break_id`),
  ADD KEY `inv_break_status` (`inv_break_status`),
  ADD KEY `inv_break_productivity` (`inv_break_productivity`),
  ADD KEY `inv_break_class` (`inv_break_class`);

--
-- Indices de la tabla `InvCalendar`
--
ALTER TABLE `InvCalendar`
  ADD PRIMARY KEY (`inv_calendar_id`);

--
-- Indices de la tabla `InvCalendarDay`
--
ALTER TABLE `InvCalendarDay`
  ADD PRIMARY KEY (`inv_calendarday_id`),
  ADD UNIQUE KEY `inv_calendarday_date` (`inv_calendarday_date`),
  ADD KEY `inv_calendar_id` (`inv_calendar_id`);

--
-- Indices de la tabla `InvCampaign`
--
ALTER TABLE `InvCampaign`
  ADD PRIMARY KEY (`inv_campaign_id`),
  ADD KEY `inv_campaign_status` (`inv_campaign_status`),
  ADD KEY `inv_campaign_queue_id` (`inv_campaign_queue_id`),
  ADD KEY `inv_campaign_queue_number` (`inv_campaign_queue_number`),
  ADD KEY `inv_campaign_start_date_text` (`inv_campaign_start_date`),
  ADD KEY `inv_campaign_end_date_text` (`inv_campaign_end_date`),
  ADD KEY `inv_campaign_start_time_text` (`inv_campaign_start_time`),
  ADD KEY `inv_campaign_end_time_text` (`inv_campaign_end_time`);

--
-- Indices de la tabla `InvClient`
--
ALTER TABLE `InvClient`
  ADD PRIMARY KEY (`inv_client_id`),
  ADD KEY `inv_client_status` (`inv_client_status`),
  ADD KEY `inv_client_type` (`inv_client_type`);

--
-- Indices de la tabla `InvQueue`
--
ALTER TABLE `InvQueue`
  ADD PRIMARY KEY (`inv_queue_id`),
  ADD KEY `inv_queue_status` (`inv_queue_status`),
  ADD KEY `inv_queue_number` (`inv_queue_number`);

--
-- Indices de la tabla `InvQueueConfig`
--
ALTER TABLE `InvQueueConfig`
  ADD PRIMARY KEY (`queueconfig_extension`);

--
-- Indices de la tabla `InvScale`
--
ALTER TABLE `InvScale`
  ADD PRIMARY KEY (`inv_scale_id`);

--
-- Indices de la tabla `InvSchedule`
--
ALTER TABLE `InvSchedule`
  ADD PRIMARY KEY (`inv_schedule_id`),
  ADD KEY `inv_schedule_status` (`inv_schedule_status`);

--
-- Indices de la tabla `InvScheduleDay`
--
ALTER TABLE `InvScheduleDay`
  ADD PRIMARY KEY (`inv_scheduleday_id`),
  ADD KEY `inv_schedule_id` (`inv_schedule_id`),
  ADD KEY `inv_scheduleday_weekday` (`inv_scheduleday_weekday`);

--
-- Indices de la tabla `InvService`
--
ALTER TABLE `InvService`
  ADD PRIMARY KEY (`inv_service_id`),
  ADD KEY `inv_service_status` (`inv_service_status`),
  ADD KEY `inv_service_use` (`inv_service_use`),
  ADD KEY `inv_service_type` (`inv_service_type`);

--
-- Indices de la tabla `InvSms`
--
ALTER TABLE `InvSms`
  ADD PRIMARY KEY (`inv_sms_id`);

--
-- Indices de la tabla `InvSupervisor`
--
ALTER TABLE `InvSupervisor`
  ADD PRIMARY KEY (`inv_supervisor_id`),
  ADD KEY `inv_supervisor_legal_id` (`inv_supervisor_legal_id`),
  ADD KEY `inv_supervisor_internal_id` (`inv_supervisor_internal_id`),
  ADD KEY `inv_supervisor_status` (`inv_supervisor_status`);

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
-- Indices de la tabla `Role`
--
ALTER TABLE `Role`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `RoleMapping`
--
ALTER TABLE `RoleMapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `principalId` (`principalId`);

--
-- Indices de la tabla `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Userbase`
--
ALTER TABLE `Userbase`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ACL`
--
ALTER TABLE `ACL`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `AuxColor`
--
ALTER TABLE `AuxColor`
  MODIFY `aux_color_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `AuxHour`
--
ALTER TABLE `AuxHour`
  MODIFY `aux_hour_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `AuxInfo`
--
ALTER TABLE `AuxInfo`
  MODIFY `aux_info_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `AuxInterval`
--
ALTER TABLE `AuxInterval`
  MODIFY `aux_interval_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT de la tabla `AuxLine`
--
ALTER TABLE `AuxLine`
  MODIFY `aux_line_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `HcxChange`
--
ALTER TABLE `HcxChange`
  MODIFY `hcx_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `InvAgentRole`
--
ALTER TABLE `InvAgentRole`
  MODIFY `inv_agentrole_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `InvCalendar`
--
ALTER TABLE `InvCalendar`
  MODIFY `inv_calendar_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `InvCalendarDay`
--
ALTER TABLE `InvCalendarDay`
  MODIFY `inv_calendarday_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `InvClient`
--
ALTER TABLE `InvClient`
  MODIFY `inv_client_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `InvScale`
--
ALTER TABLE `InvScale`
  MODIFY `inv_scale_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `InvSchedule`
--
ALTER TABLE `InvSchedule`
  MODIFY `inv_schedule_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `InvScheduleDay`
--
ALTER TABLE `InvScheduleDay`
  MODIFY `inv_scheduleday_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `InvService`
--
ALTER TABLE `InvService`
  MODIFY `inv_service_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `InvSms`
--
ALTER TABLE `InvSms`
  MODIFY `inv_sms_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `InvSupervisor`
--
ALTER TABLE `InvSupervisor`
  MODIFY `inv_supervisor_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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

--
-- AUTO_INCREMENT de la tabla `Role`
--
ALTER TABLE `Role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `RoleMapping`
--
ALTER TABLE `RoleMapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `User`
--
ALTER TABLE `User`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Userbase`
--
ALTER TABLE `Userbase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
