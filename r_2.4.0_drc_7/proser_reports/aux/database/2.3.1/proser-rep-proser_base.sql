-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 11-11-2019 a las 20:15:18
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
-- Base de datos: `proser-rep-proser_base`
--
CREATE DATABASE IF NOT EXISTS `proser-rep-proser_base` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `proser-rep-proser_base`;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HcaAgent`
--

DROP TABLE IF EXISTS `HcaAgent`;
CREATE TABLE `HcaAgent` (
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
-- Estructura de tabla para la tabla `HcaQueue`
--

DROP TABLE IF EXISTS `HcaQueue`;
CREATE TABLE `HcaQueue` (
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
  `inv_queue_type` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `inv_queue_operation_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"client":[], "service":[]}',
  `inv_queue_system_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"scale":[]}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MainAudit`
--

DROP TABLE IF EXISTS `MainAudit`;
CREATE TABLE `MainAudit` (
  `audit_id` int(10) NOT NULL,
  `audit_agent_id` int(10) DEFAULT NULL,
  `audit_break_id` int(10) DEFAULT NULL,
  `audit_datetime_init` datetime DEFAULT NULL,
  `audit_datetime_end` datetime DEFAULT NULL,
  `audit_duration` time DEFAULT NULL,
  `audit_ext_parked` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__TIME__` int(10) DEFAULT NULL,
  `audit_duration_sec` int(10) DEFAULT NULL,
  `audit_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_date` date DEFAULT NULL,
  `__HCA__` int(10) DEFAULT NULL,
  `audit_hca_agent_serial_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `audit_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_operation_json` varchar(175) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL,
  `audit_time_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MainCallEntry`
--

DROP TABLE IF EXISTS `MainCallEntry`;
CREATE TABLE `MainCallEntry` (
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
  `callentry_date` date DEFAULT NULL,
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
-- Estructura de tabla para la tabla `MainCdr`
--

DROP TABLE IF EXISTS `MainCdr`;
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
  `cdr_date` date DEFAULT NULL,
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
-- Estructura de tabla para la tabla `MainQueueLog`
--

DROP TABLE IF EXISTS `MainQueueLog`;
CREATE TABLE `MainQueueLog` (
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
  `queuelog_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MainStoredQueries`
--

DROP TABLE IF EXISTS `MainStoredQueries`;
CREATE TABLE `MainStoredQueries` (
  `msq_query_id` int(11) NOT NULL,
  `msq_query_status` varchar(1) DEFAULT 'A',
  `msq_query_chk` int(1) DEFAULT 1,
  `msq_query_name` varchar(50) DEFAULT NULL,
  `msq_query_selection` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `msq_query_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ms_query_rotation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `msq_query_datetime` datetime DEFAULT NULL,
  `msq_query_date` date DEFAULT NULL,
  `msq_query_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

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
  `audit_datetime_end` datetime DEFAULT NULL,
  `audit_duration` time DEFAULT NULL,
  `audit_ext_parked` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__TIME__` int(10) DEFAULT NULL,
  `audit_duration_sec` int(10) DEFAULT NULL,
  `audit_status` varchar(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_date` date DEFAULT NULL,
  `__HCA__` int(10) DEFAULT NULL,
  `audit_hca_agent_serial_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `__JSON__` int(10) DEFAULT NULL,
  `audit_people_json` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `audit_operation_json` varchar(175) CHARACTER SET utf32 COLLATE utf32_spanish_ci DEFAULT NULL,
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
  `callentry_date` date DEFAULT NULL,
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
  `cdr_date` date DEFAULT NULL,
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
  `rcb_date` date DEFAULT NULL,
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
  `rcc_date` date DEFAULT NULL,
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
  `queuelog_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `HcaAgent`
--
ALTER TABLE `HcaAgent`
  ADD PRIMARY KEY (`hca_agent_serial_id`),
  ADD KEY `hca_agent_agent_id` (`hca_agent_id`),
  ADD KEY `hca_agent_date` (`hca_agent_date`),
  ADD KEY `hca_agent_extension` (`hca_agent_extension`),
  ADD KEY `hca_agent_people_json` (`hca_agent_people_json`),
  ADD KEY `hca_agent_operation_json` (`hca_agent_operation_json`),
  ADD KEY `hca_agent_time_json` (`hca_agent_time_json`);

--
-- Indices de la tabla `HcaQueue`
--
ALTER TABLE `HcaQueue`
  ADD PRIMARY KEY (`hca_queue_serial_id`),
  ADD KEY `hca_queue_date` (`hca_queue_date`),
  ADD KEY `hca_queue_number` (`hca_queue_number`),
  ADD KEY `hca_queue_queue_id` (`hca_queue_id`);

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
-- Indices de la tabla `MainAudit`
--
ALTER TABLE `MainAudit`
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
-- Indices de la tabla `MainCallEntry`
--
ALTER TABLE `MainCallEntry`
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
  ADD KEY `callentry_time_json` (`callentry_time_json`),
  ADD KEY `callentry_uniqueid` (`callentry_uniqueid`);

--
-- Indices de la tabla `MainCdr`
--
ALTER TABLE `MainCdr`
  ADD PRIMARY KEY (`cdr_id`),
  ADD KEY `cdr_calldate` (`cdr_calldate`),
  ADD KEY `cdr_agent_id` (`cdr_agent_id`),
  ADD KEY `cdr_queue_id` (`cdr_queue_id`),
  ADD KEY `cdr_date` (`cdr_date`),
  ADD KEY `cdr_hca_agent_serial_id` (`cdr_hca_agent_serial_id`),
  ADD KEY `cdr_hca_queue_serial_id` (`cdr_hca_queue_serial_id`),
  ADD KEY `cdr_uniqueid` (`cdr_uniqueid`);

--
-- Indices de la tabla `MainQueueLog`
--
ALTER TABLE `MainQueueLog`
  ADD PRIMARY KEY (`queuelog_id`),
  ADD KEY `time` (`queuelog_time`),
  ADD KEY `queuename` (`queuelog_queuename`),
  ADD KEY `agent` (`queuelog_agent`),
  ADD KEY `event` (`queuelog_event`),
  ADD KEY `queuelog_uniqueid` (`queuelog_uniqueid`),
  ADD KEY `queuelog_created` (`queuelog_created`);

--
-- Indices de la tabla `MainStoredQueries`
--
ALTER TABLE `MainStoredQueries`
  ADD PRIMARY KEY (`msq_query_id`);

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
-- Indices de la tabla `RealAudit`
--
ALTER TABLE `RealAudit`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `audit_date` (`audit_date`),
  ADD KEY `id_break` (`audit_break_id`),
  ADD KEY `id_agent` (`audit_agent_id`),
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
  ADD KEY `callentry_time_json` (`callentry_time_json`),
  ADD KEY `callentry_uniqueid` (`callentry_uniqueid`);

--
-- Indices de la tabla `RealCdr`
--
ALTER TABLE `RealCdr`
  ADD PRIMARY KEY (`cdr_id`),
  ADD KEY `cdr_calldate` (`cdr_calldate`),
  ADD KEY `cdr_agent_id` (`cdr_agent_id`),
  ADD KEY `cdr_queue_id` (`cdr_queue_id`),
  ADD KEY `cdr_date` (`cdr_date`),
  ADD KEY `cdr_hca_agent_serial_id` (`cdr_hca_agent_serial_id`),
  ADD KEY `cdr_hca_queue_serial_id` (`cdr_hca_queue_serial_id`),
  ADD KEY `cdr_uniqueid` (`cdr_uniqueid`);

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
  ADD KEY `rca_hca_agent_serial_id` (`rcc_hca_agent_serial_id`),
  ADD KEY `rcc_callentry_uniqueid` (`rcc_callentry_uniqueid`);

--
-- Indices de la tabla `RealQueueLog`
--
ALTER TABLE `RealQueueLog`
  ADD PRIMARY KEY (`queuelog_id`),
  ADD KEY `time` (`queuelog_time`),
  ADD KEY `queuename` (`queuelog_queuename`),
  ADD KEY `agent` (`queuelog_agent`),
  ADD KEY `event` (`queuelog_event`),
  ADD KEY `queuelog_uniqueid` (`queuelog_uniqueid`),
  ADD KEY `queuelog_created` (`queuelog_created`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `AuxColor`
--
ALTER TABLE `AuxColor`
  MODIFY `aux_color_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `AuxHour`
--
ALTER TABLE `AuxHour`
  MODIFY `aux_hour_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57402;

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
  MODIFY `inv_supervisor_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `MainStoredQueries`
--
ALTER TABLE `MainStoredQueries`
  MODIFY `msq_query_id` int(11) NOT NULL AUTO_INCREMENT;

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
