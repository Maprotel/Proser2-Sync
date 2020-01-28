-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 27-10-2019 a las 07:27:17
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
-- Estructura de tabla para la tabla `RealAudit`
--

DROP TABLE IF EXISTS `RealAudit`;
CREATE TABLE `RealAudit` (
  `audit_id` int(10) NOT NULL,
  `audit_agent_id` int(10) DEFAULT NULL,
  `audit_break_id` int(10) DEFAULT NULL,
  `audit_datetime_init` datetime DEFAULT NULL,
  `audit_datetime_end` timestamp NULL DEFAULT NULL,
  `audit_duration` time DEFAULT NULL,
  `audit_ext_parked` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__TIME__` int(10) DEFAULT NULL,
  `audit_duration_sec` int(10) DEFAULT NULL,
  `audit_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_date` date GENERATED ALWAYS AS (`audit_datetime_init`) STORED,
  `__HCA__` int(10) DEFAULT NULL,
  `audit_hca_agent_serial_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `audit_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_operation_json` varchar(175) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT '{"client":[], "queue":[], "service":[], "campaign":[]}',
  `audit_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealCallEntry`
--

DROP TABLE IF EXISTS `RealCallEntry`;
CREATE TABLE `RealCallEntry` (
  `callentry_id` int(10) UNSIGNED NOT NULL,
  `callentry_agent_id` int(10) UNSIGNED DEFAULT NULL,
  `callentry_queue_id` int(10) UNSIGNED NOT NULL,
  `callentry_contact_id` int(10) UNSIGNED DEFAULT NULL,
  `callentry_callerid` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `callentry_datetime_init` datetime DEFAULT NULL,
  `callentry_datetime_end` datetime DEFAULT NULL,
  `callentry_duration_sec` int(10) UNSIGNED DEFAULT NULL,
  `callentry_status` varchar(32) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_transfer` varchar(6) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_datetime_entry_queue` datetime DEFAULT NULL,
  `callentry_duration_sec_wait` int(11) DEFAULT NULL,
  `callentry_uniqueid` varchar(32) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_campaign_id` int(10) UNSIGNED DEFAULT NULL,
  `callentry_trunk` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_date` date GENERATED ALWAYS AS (`callentry_datetime_entry_queue`) STORED,
  `callentry_queue_time_expired` int(11) DEFAULT NULL,
  `callentry_type` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_auto_campaign` int(11) DEFAULT NULL,
  `callentry_queue_number` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__QUEUELOG__` int(1) DEFAULT NULL,
  `callentry_who_hung` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_hung_agent` int(1) DEFAULT NULL,
  `callentry_hung_caller` int(1) DEFAULT NULL,
  `__HCA__` int(10) DEFAULT NULL,
  `callentry_hca_agent_serial_id` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(11) DEFAULT NULL,
  `callentry_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `callentry_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealCdr`
--

DROP TABLE IF EXISTS `RealCdr`;
CREATE TABLE `RealCdr` (
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealCurrentAgents`
--

DROP TABLE IF EXISTS `RealCurrentAgents`;
CREATE TABLE `RealCurrentAgents` (
  `rca_audit_login_id` int(11) NOT NULL,
  `rca_audit_logout_id` int(10) DEFAULT NULL,
  `rca_date` date DEFAULT NULL,
  `__AGENT__` int(1) DEFAULT 1,
  `rca_agent_id` int(11) DEFAULT NULL,
  `rca_agent_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rca_agent_datetime_login` datetime DEFAULT NULL,
  `rca_agent_datetime_logout` datetime DEFAULT NULL,
  `rca_agent_duration` time DEFAULT NULL,
  `rca_agent_duration_sec` int(10) DEFAULT NULL,
  `rca_agent_status` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__GROUP__` int(1) DEFAULT 1,
  `rca_group_id` int(11) DEFAULT NULL,
  `rca_group_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rca_subgroup_id` int(11) DEFAULT NULL,
  `rca_subgroup_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__HCA__` int(10) DEFAULT NULL,
  `rca_hca_agent_serial_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `rca_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rca_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rca_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__RECORD__` int(10) DEFAULT NULL,
  `rca_update_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealCurrentBreaks`
--

DROP TABLE IF EXISTS `RealCurrentBreaks`;
CREATE TABLE `RealCurrentBreaks` (
  `rcb_break_audit_id` int(10) NOT NULL,
  `rcb_break_agent_id` int(10) DEFAULT NULL,
  `rcb_break_id` int(10) DEFAULT NULL,
  `rcb_break_datetime_init` datetime DEFAULT NULL,
  `rcb_break_datetime_end` datetime DEFAULT NULL,
  `rcb_break_duration` time DEFAULT NULL,
  `rcb_break_duration_sec` int(11) DEFAULT NULL,
  `rcb_break_name` varchar(100) DEFAULT NULL,
  `rcb_break_productivity` int(1) DEFAULT NULL,
  `rcb_date` date GENERATED ALWAYS AS (`rcb_break_datetime_init`) STORED,
  `__HCA__` int(10) DEFAULT NULL,
  `rcb_hca_agent_serial_id` varchar(100) DEFAULT NULL,
  `__JSON__` int(1) DEFAULT NULL,
  `rcb_people_json` varchar(250) DEFAULT NULL,
  `rcb_operation_json` varchar(250) DEFAULT NULL,
  `rcb_time_json` varchar(250) DEFAULT NULL,
  `__RECORD__` int(10) DEFAULT NULL,
  `rcb_update_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealCurrentCalls`
--

DROP TABLE IF EXISTS `RealCurrentCalls`;
CREATE TABLE `RealCurrentCalls` (
  `rcc_callentry_id` int(10) NOT NULL,
  `rcc_callentry_agent_id` int(10) DEFAULT 0,
  `rcc_callentry_queue_id` int(10) DEFAULT NULL,
  `rcc_callentry_contact_id` int(10) DEFAULT NULL,
  `rcc_callentry_callerid` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_callentry_datetime_init` datetime DEFAULT NULL,
  `rcc_callentry_datetime_end` datetime DEFAULT NULL,
  `rcc_callentry_duration` time DEFAULT NULL,
  `rcc_callentry_duration_sec` int(10) DEFAULT NULL,
  `rcc_callentry_status` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_callentry_transfer` varchar(6) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_callentry_datetime_entry_queue` datetime DEFAULT NULL,
  `rcc_callentry_duration_wait_sec` int(11) DEFAULT NULL,
  `rcc_callentry_uniqueid` varchar(32) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_callentry_campaign_id` int(10) DEFAULT NULL,
  `rcc_callentry_trunk` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_date` date GENERATED ALWAYS AS (cast(`rcc_callentry_datetime_entry_queue` as date)) STORED,
  `__HCA__` int(10) DEFAULT NULL,
  `rcc_hca_agent_serial_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `rcc_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rcc_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__RECORD__` int(10) DEFAULT NULL,
  `rcc_update_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealHcaAgent`
--

DROP TABLE IF EXISTS `RealHcaAgent`;
CREATE TABLE `RealHcaAgent` (
  `hca_agent_serial_id` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `hca_agent_origin` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_agent_date` date DEFAULT NULL,
  `hca_agent_id` int(11) DEFAULT NULL,
  `hca_agent_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_agent_extension` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_agent_status` varchar(10) COLLATE utf8_spanish_ci DEFAULT '''A''',
  `hca_agent_laborday` varchar(10) COLLATE utf8_spanish_ci DEFAULT 'NULL',
  `__JSON__` varchar(1) COLLATE utf8_spanish_ci DEFAULT '1',
  `hca_agent_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"supervisor":[], "role":[]}',
  `hca_agent_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"client":[], "queue":[], "service":[], "campaign":[]}',
  `hca_agent_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"calendar":[], "schedule":[], "scheduleday":[], "schedulehours":[]}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealHcaQueue`
--

DROP TABLE IF EXISTS `RealHcaQueue`;
CREATE TABLE `RealHcaQueue` (
  `hca_queue_serial_id` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `hca_queue_origin` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_queue_date` date DEFAULT NULL,
  `hca_queue_start` time DEFAULT NULL,
  `hca_queue_id` int(10) DEFAULT NULL,
  `hca_queue_number` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_queue_name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hca_queue_status` varchar(10) COLLATE utf8_spanish_ci DEFAULT '''A''',
  `__JSON__` int(1) DEFAULT 1,
  `hca_queue_operation_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"client":[], "service":[]}',
  `hca_queue_system_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT '{"scale":[]}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RealQueueLog`
--

DROP TABLE IF EXISTS `RealQueueLog`;
CREATE TABLE `RealQueueLog` (
  `queuelog_id` bigint(255) NOT NULL,
  `queuelog_time` varchar(26) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_uniqueid` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_queuename` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_agent` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_event` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data1` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data2` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data3` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data4` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_data5` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `queuelog_created` timestamp NULL DEFAULT NULL,
  `queuelog_date` date GENERATED ALWAYS AS (`queuelog_created`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `RealAudit`
--
ALTER TABLE `RealAudit`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `audit_date` (`audit_date`),
  ADD KEY `id_break` (`audit_break_id`),
  ADD KEY `id_agent` (`audit_agent_id`),
  ADD KEY `datetime_init` (`audit_datetime_init`),
  ADD KEY `datetime_end` (`audit_datetime_end`),
  ADD KEY `duration` (`audit_duration`),
  ADD KEY `audit_secs_duration` (`audit_duration_sec`),
  ADD KEY `audit_status` (`audit_status`),
  ADD KEY `audit_hca_agent_serial_id` (`audit_hca_agent_serial_id`),
  ADD KEY `audit_people_json` (`audit_people_json`),
  ADD KEY `audit_time_json` (`audit_time_json`),
  ADD KEY `audit_operation_json` (`audit_operation_json`);

--
-- Indices de la tabla `RealCallEntry`
--
ALTER TABLE `RealCallEntry`
  ADD PRIMARY KEY (`callentry_id`),
  ADD KEY `id_agent` (`callentry_agent_id`),
  ADD KEY `id_queue_call_entry` (`callentry_queue_id`),
  ADD KEY `id_contact` (`callentry_contact_id`),
  ADD KEY `call_entry_ibfk_4` (`callentry_campaign_id`),
  ADD KEY `datetime_init` (`callentry_datetime_init`),
  ADD KEY `datetime_entry_queue` (`callentry_datetime_entry_queue`),
  ADD KEY `status` (`callentry_status`),
  ADD KEY `callentry_hca_agent_serial_id` (`callentry_hca_agent_serial_id`),
  ADD KEY `callentry_people_json` (`callentry_people_json`),
  ADD KEY `callentry_operation_json` (`callentry_operation_json`),
  ADD KEY `callentry_time_json` (`callentry_time_json`);

--
-- Indices de la tabla `RealCdr`
--
ALTER TABLE `RealCdr`
  ADD PRIMARY KEY (`cdr_id`),
  ADD KEY `IDX_UNIQUEID` (`cdr_uniqueid`),
  ADD KEY `cdr_calldate` (`cdr_calldate`),
  ADD KEY `cdr_agent_id` (`cdr_agent_id`),
  ADD KEY `cdr_queue_id` (`cdr_queue_id`),
  ADD KEY `cdr_date` (`cdr_date`),
  ADD KEY `cdr_hca_agent_serial_id` (`cdr_hca_agent_serial_id`),
  ADD KEY `cdr_hca_queue_serial_id` (`cdr_hca_queue_serial_id`);

--
-- Indices de la tabla `RealCurrentAgents`
--
ALTER TABLE `RealCurrentAgents`
  ADD PRIMARY KEY (`rca_audit_login_id`),
  ADD UNIQUE KEY `rca_agent_id` (`rca_agent_id`),
  ADD KEY `rca_hca_agent_serial_id` (`rca_hca_agent_serial_id`),
  ADD KEY `rca_people_json` (`rca_people_json`),
  ADD KEY `rca_operation_json` (`rca_operation_json`),
  ADD KEY `rca_time_json` (`rca_time_json`);

--
-- Indices de la tabla `RealCurrentBreaks`
--
ALTER TABLE `RealCurrentBreaks`
  ADD PRIMARY KEY (`rcb_break_audit_id`),
  ADD KEY `rcb_time_json` (`rcb_time_json`),
  ADD KEY `rcb_operation_json` (`rcb_operation_json`),
  ADD KEY `rcb_people_json` (`rcb_people_json`),
  ADD KEY `rcb_hca_agent_serial_id` (`rcb_hca_agent_serial_id`);

--
-- Indices de la tabla `RealCurrentCalls`
--
ALTER TABLE `RealCurrentCalls`
  ADD PRIMARY KEY (`rcc_callentry_id`),
  ADD KEY `rca_time_json` (`rcc_time_json`),
  ADD KEY `rca_operation_json` (`rcc_operation_json`),
  ADD KEY `rca_people_json` (`rcc_people_json`),
  ADD KEY `rca_hca_agent_serial_id` (`rcc_hca_agent_serial_id`);

--
-- Indices de la tabla `RealHcaAgent`
--
ALTER TABLE `RealHcaAgent`
  ADD PRIMARY KEY (`hca_agent_serial_id`),
  ADD KEY `hca_agent_agent_id` (`hca_agent_id`),
  ADD KEY `hca_agent_date` (`hca_agent_date`),
  ADD KEY `hca_agent_extension` (`hca_agent_extension`),
  ADD KEY `hca_agent_people_json` (`hca_agent_people_json`),
  ADD KEY `hca_agent_operation_json` (`hca_agent_operation_json`),
  ADD KEY `hca_agent_time_json` (`hca_agent_time_json`);

--
-- Indices de la tabla `RealHcaQueue`
--
ALTER TABLE `RealHcaQueue`
  ADD PRIMARY KEY (`hca_queue_serial_id`),
  ADD KEY `hca_queue_date` (`hca_queue_date`),
  ADD KEY `hca_queue_number` (`hca_queue_number`),
  ADD KEY `hca_queue_queue_id` (`hca_queue_id`);

--
-- Indices de la tabla `RealQueueLog`
--
ALTER TABLE `RealQueueLog`
  ADD PRIMARY KEY (`queuelog_id`),
  ADD KEY `time` (`queuelog_time`),
  ADD KEY `queuename` (`queuelog_queuename`),
  ADD KEY `agent` (`queuelog_agent`),
  ADD KEY `event` (`queuelog_event`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
