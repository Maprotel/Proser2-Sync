-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 27-10-2019 a las 09:09:20
-- Versión del servidor: 10.3.18-MariaDB-1:10.3.18+maria~bionic-log
-- Versión de PHP: 7.2.19-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proser_display_version`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MainCdr`
--

CREATE TABLE `MainCdr` (
  `cdr_id` int(11) UNSIGNED NOT NULL,
  `cdr_calldate` datetime DEFAULT '0000-00-00 00:00:00',
  `cdr_clid` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_src` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_dst` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_dcontext` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_channel` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_dstchannel` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_lastapp` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_lastdata` varchar(80) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_duration_sec` int(11) DEFAULT 0,
  `cdr_billsec_sec` int(11) DEFAULT 0,
  `cdr_disposition` varchar(45) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_amaflags` int(11) DEFAULT 0,
  `cdr_accountcode` varchar(20) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_uniqueid` varchar(32) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_userfield` varchar(255) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_recordingfile` varchar(255) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_cnum` varchar(40) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_cnam` varchar(40) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_outbound_cnum` varchar(40) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_outbound_cnam` varchar(40) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_dst_cnam` varchar(40) COLLATE utf8_spanish_ci DEFAULT '',
  `cdr_did` varchar(50) COLLATE utf8_spanish_ci DEFAULT '',
  `__CALLCENTER__` int(1) DEFAULT NULL,
  `cdr_callcenter_name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_call_type` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_call_class` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_agent_extension` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_queue_number` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_agent_id` int(11) DEFAULT NULL,
  `cdr_queue_id` int(1) DEFAULT NULL,
  `__DATE__` int(1) DEFAULT NULL,
  `cdr_date` date GENERATED ALWAYS AS (`cdr_calldate`) STORED,
  `__HCA__` int(1) DEFAULT NULL,
  `cdr_hca_agent_serial_id` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_hca_queue_serial_id` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__MADE__` int(11) DEFAULT NULL,
  `cdr_call_made` int(11) DEFAULT NULL,
  `cdr_call_fail` int(11) DEFAULT NULL,
  `cdr_call_answered` int(11) DEFAULT NULL,
  `cdr_call_efective` int(11) DEFAULT NULL,
  `cdr_call_hungout` int(11) DEFAULT NULL,
  `__JSON__` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cdr_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `MainCdr`
--
ALTER TABLE `MainCdr`
  ADD PRIMARY KEY (`cdr_id`),
  ADD KEY `IDX_UNIQUEID` (`cdr_uniqueid`),
  ADD KEY `cdr_calldate` (`cdr_calldate`),
  ADD KEY `cdr_agent_id` (`cdr_agent_id`),
  ADD KEY `cdr_queue_id` (`cdr_queue_id`),
  ADD KEY `cdr_date` (`cdr_date`),
  ADD KEY `cdr_hca_agent_serial_id` (`cdr_hca_agent_serial_id`),
  ADD KEY `cdr_hca_queue_serial_id` (`cdr_hca_queue_serial_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
