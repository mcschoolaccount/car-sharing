-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 15 Sty 2024, 10:27
-- Wersja serwera: 10.4.24-MariaDB
-- Wersja PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `b`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `departamenty_po_kodzie_pocztowym` (`kod_pocztowy` VARCHAR(5))   SELECT * from `placowki` where `placowki`.`kod_pocztowy` = `kod_pocztowy`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dostepne_samochody_w_przedziale_cenowym` (IN `min_value` INT, IN `max_value` INT)   SELECT `id`, `koszt`, `marka`, `model`, `typ`, `vin`, `rok_produkcji`, `przebieg`, `siedzenia`, `placowka_id`, `ubezpieczenie_id`
FROM `pojazdy` 
WHERE `dostepnosc` = "AVAILABLE" AND `koszt` >= min_value AND `koszt` <= max_value
ORDER BY `koszt`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `najczesciej_uzywane_auto` ()   SELECT * FROM `pojazdy` WHERE id = (SELECT pojazd_id FROM `rezerwacje` INNER JOIN `wypozyczenia` ON `rezerwacje`.`id` = `wypozyczenia`.`rezerwacja_id` GROUP BY pojazd_id ORDER BY count(pojazd_id) DESC LIMIT 1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pojazdy_po_vin` (IN `vin` VARCHAR(50))   SELECT id, vin, marka, model FROM `pojazdy` WHERE `pojazdy`.`vin` = vin$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pojazdy_zarezerwowane_w_dniach` (IN `data_odbioru` DATE, IN `data_zwrotu` DATE)   SELECT `rezerwacje`.`data_odbioru`, `rezerwacje`.`data_zwrotu`, `pojazdy`.`id` as pojazd_id, `pojazdy`.`marka`, `pojazdy`.`model` FROM `rezerwacje` INNER JOIN `pojazdy` ON `rezerwacje`.`pojazd_id` = `pojazdy`.`id` 
WHERE `rezerwacje`.`data_odbioru` >= data_odbioru AND `rezerwacje`.`data_zwrotu` <= data_zwrotu$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `polisy_po_vin_pojazdu` (IN `vin` VARCHAR(50))   SELECT `ubezpieczenia`.* FROM `pojazdy` INNER JOIN `ubezpieczenia` ON `pojazdy`.`ubezpieczenie_id` = `ubezpieczenia`.`id` WHERE `pojazdy`.`vin` = vin$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `przychod_w_danym_roku_i_miesiacu` (IN `p_year` INT, IN `p_month` ENUM('January','February','March','April','May','June','July','August','September','October','November','December'))   SELECT SUM(kwota) AS przychod
    FROM `platnosci`
    WHERE YEAR(`data`) = p_year AND MONTH(`data`) = p_month$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `samochody_wynajete_przez_pracownika` (IN `imie` VARCHAR(255), IN `nazwisko` VARCHAR(255))   SELECT `pojazdy`.`id`,`pojazdy`.`marka`,`pojazdy`.`model` FROM `pojazdy` 
INNER JOIN `rezerwacje` ON `pojazdy`.`id` = `rezerwacje`.`pojazd_id`
INNER JOIN `wypozyczenia` ON `wypozyczenia`.`id` =`rezerwacje`.`id`
INNER JOIN `pracownicy` ON `pracownicy`.id = `wypozyczenia`.`pracownik_id`
WHERE `pracownicy`.`imie` = `imie` AND `pracownicy`.`nazwisko` =`nazwisko`
GROUP BY `pojazdy`.`id`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `samochody_wypozyczone_przez_klienta` (IN `imie` VARCHAR(255), IN `nazwisko` VARCHAR(255), IN `numer_telefonu` INT(15))   SELECT `pojazdy`.`id`,`pojazdy`.`marka`,`pojazdy`.`model` FROM `pojazdy`
INNER JOIN `rezerwacje` ON `pojazdy`.`id` = `rezerwacje`.`pojazd_id`
INNER JOIN `klienci` ON `klienci`.`id` = `rezerwacje`.`klient_id`
WHERE `klienci`.`imie` = `imie` AND `klienci`.`nazwisko` =`nazwisko` AND  `klienci`.`numer_telefonu` = `numer_telefonu`  GROUP BY `pojazdy`.`id`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `samochody_w_departamencie` (IN `dep_id` INT)   SELECT * 
FROM `pojazdy` 
WHERE placowka_id = dep_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ilosc_samochodow_po_dostepnosci`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `ilosc_samochodow_po_dostepnosci` (
`dostepnosc` enum('RESERVED','OCCUPIED','AVAILABLE','SERVICE')
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ilosc_samochodow_po_typie`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `ilosc_samochodow_po_typie` (
`typ` enum('Micro','Sedan','Hatchback','Coupe','Cabriolet,Sport Car','SUV','Van','Minivan')
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `id` int(11) NOT NULL,
  `imie` varchar(255) NOT NULL,
  `nazwisko` varchar(255) NOT NULL,
  `numer_telefonu` varchar(15) NOT NULL,
  `ulica` varchar(255) NOT NULL,
  `miasto` varchar(255) NOT NULL,
  `kod_pocztowy` varchar(5) NOT NULL,
  `prawo_jazdy` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zastąpiona struktura widoku `piec_najaktywniejszych_klientow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `piec_najaktywniejszych_klientow` (
`id` int(11)
,`imie` varchar(255)
,`nazwisko` varchar(255)
,`numer_telefonu` varchar(15)
,`ulica` varchar(255)
,`miasto` varchar(255)
,`kod_pocztowy` varchar(5)
,`prawo_jazdy` varchar(255)
,`reservation_amount` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `placowki`
--

CREATE TABLE `placowki` (
  `id` int(11) NOT NULL,
  `imie` varchar(255) NOT NULL,
  `ulica` varchar(255) NOT NULL,
  `miasto` varchar(255) NOT NULL,
  `wojewodztwo` varchar(255) NOT NULL,
  `kraj` varchar(255) NOT NULL DEFAULT 'Poland',
  `kod_pocztowy` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `platnosci`
--

CREATE TABLE `platnosci` (
  `id` int(11) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp(),
  `kwota` int(11) NOT NULL,
  `rezerwacja_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pojazdy`
--

CREATE TABLE `pojazdy` (
  `id` int(11) NOT NULL,
  `typ` enum('Micro','Sedan','Hatchback','Coupe','Cabriolet,Sport Car','SUV','Van','Minivan') NOT NULL DEFAULT 'Hatchback',
  `placowka_id` int(11) NOT NULL,
  `ubezpieczenie_id` int(11) NOT NULL,
  `vin` varchar(50) NOT NULL,
  `dostepnosc` enum('RESERVED','OCCUPIED','AVAILABLE','SERVICE') NOT NULL,
  `marka` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `rok_produkcji` year(4) NOT NULL,
  `przebieg` int(11) NOT NULL,
  `koszt` decimal(10,0) NOT NULL,
  `siedzenia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `id` int(11) NOT NULL,
  `placowka_id` int(11) NOT NULL,
  `imie` varchar(255) NOT NULL,
  `nazwisko` varchar(255) NOT NULL,
  `data_urodzenia` date NOT NULL,
  `ulica` varchar(255) NOT NULL,
  `miasto` varchar(255) NOT NULL,
  `kod_pocztowy` varchar(5) NOT NULL,
  `zarobki` int(11) NOT NULL,
  `pozycja` enum('CEO','Manager','Agent','Marketer') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `id` int(11) NOT NULL,
  `klient_id` int(11) NOT NULL,
  `pojazd_id` int(11) NOT NULL,
  `lokacja_odbioru` int(11) NOT NULL,
  `lokacja_zwrotu` int(11) NOT NULL,
  `data_odbioru` date NOT NULL,
  `data_zwrotu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ubezpieczenia`
--

CREATE TABLE `ubezpieczenia` (
  `id` int(11) NOT NULL,
  `imie` varchar(255) NOT NULL,
  `polisa` varchar(255) NOT NULL,
  `koszt` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wypozyczenia`
--

CREATE TABLE `wypozyczenia` (
  `id` int(11) NOT NULL,
  `pracownik_id` int(11) NOT NULL,
  `placowka_id` int(11) NOT NULL,
  `rezerwacja_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura widoku `ilosc_samochodow_po_dostepnosci`
--
DROP TABLE IF EXISTS `ilosc_samochodow_po_dostepnosci`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ilosc_samochodow_po_dostepnosci`  AS SELECT `pojazdy`.`dostepnosc` AS `dostepnosc`, count(`pojazdy`.`dostepnosc`) AS `amount` FROM `pojazdy` GROUP BY `pojazdy`.`dostepnosc`  ;

-- --------------------------------------------------------

--
-- Struktura widoku `ilosc_samochodow_po_typie`
--
DROP TABLE IF EXISTS `ilosc_samochodow_po_typie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ilosc_samochodow_po_typie`  AS SELECT `pojazdy`.`typ` AS `typ`, count(`pojazdy`.`typ`) AS `amount` FROM `pojazdy` GROUP BY `pojazdy`.`typ`  ;

-- --------------------------------------------------------

--
-- Struktura widoku `piec_najaktywniejszych_klientow`
--
DROP TABLE IF EXISTS `piec_najaktywniejszych_klientow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `piec_najaktywniejszych_klientow`  AS SELECT `klienci`.`id` AS `id`, `klienci`.`imie` AS `imie`, `klienci`.`nazwisko` AS `nazwisko`, `klienci`.`numer_telefonu` AS `numer_telefonu`, `klienci`.`ulica` AS `ulica`, `klienci`.`miasto` AS `miasto`, `klienci`.`kod_pocztowy` AS `kod_pocztowy`, `klienci`.`prawo_jazdy` AS `prawo_jazdy`, count(`rezerwacje`.`id`) AS `reservation_amount` FROM (`klienci` join `rezerwacje` on(`klienci`.`id` = `rezerwacje`.`klient_id`)) GROUP BY `klienci`.`id` ORDER BY count(`rezerwacje`.`id`) DESC LIMIT 0, 55  ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;