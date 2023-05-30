-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 15:23:22
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `customersdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `id_customer` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

CREATE TABLE `customer` (
  `id` int(6) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`id`, `name`, `address`, `phone`) VALUES
(38, 'luci', 'bbbbbbbb', '1223'),
(39, 'maria', 'nhujnm', '1223');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precioVenta` decimal(5,2) NOT NULL,
  `precioCompra` decimal(5,2) NOT NULL,
  `existencia` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `descripcion`, `precioVenta`, `precioCompra`, `existencia`) VALUES
(99, '1212121', 'anana', '400.00', '300.00', '22.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_vendidos`
--

CREATE TABLE `productos_vendidos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_producto` bigint(20) UNSIGNED NOT NULL,
  `cantidad` bigint(20) UNSIGNED NOT NULL,
  `precio` decimal(5,2) NOT NULL,
  `id_venta` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `id_customer` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fecha`, `id_customer`) VALUES
(1, '2023-05-29 14:47:42', 38);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_customer` (`id_customer`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD CONSTRAINT `productos_vendidos_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `productos_vendidos_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
