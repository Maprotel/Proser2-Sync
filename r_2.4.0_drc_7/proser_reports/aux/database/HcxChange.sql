-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 28-10-2019 a las 07:11:02
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
-- Estructura de tabla para la tabla `HcxChange`
--

DROP TABLE IF EXISTS `HcxChange`;
CREATE TABLE `HcxChange` (
  `hcx_id` int(10) NOT NULL,
  `hcx_timestamp` timestamp NULL DEFAULT NULL,
  `hcx_date_from` date DEFAULT NULL,
  `hcx_time_from` time DEFAULT NULL,
  `hcx_table` text DEFAULT NULL,
  `hcx_action` varchar(50) NOT NULL DEFAULT 'NULL',
  `hcx_record` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `hcx_record_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `HcxChange`
--
ALTER TABLE `HcxChange`
  ADD PRIMARY KEY (`hcx_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `HcxChange`
--
ALTER TABLE `HcxChange`
  MODIFY `hcx_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
