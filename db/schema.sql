-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Φιλοξενητής: 127.0.0.1
-- Χρόνος δημιουργίας: 06 Ιαν 2021 στις 18:21:48
-- Έκδοση διακομιστή: 10.4.13-MariaDB
-- Έκδοση PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Βάση δεδομένων: `adise20_chess11`
--

DELIMITER $$
--
-- Διαδικασίες
--
CREATE PROCEDURE `clean_board` ()  BEGIN
	replace into board select * from board_empty;
	update `players` set username=null, token=null;
    update `game_status` set `status`='not active', `p_turn`=null, `result`=null;
    END$$

CREATE PROCEDURE `move_piece` (`x1` TINYINT, `y1` TINYINT, `x2` TINYINT, `y2` TINYINT)  BEGIN
	declare  p, p_color char;
	
	select  piece, piece_color into p, p_color FROM `board` WHERE X=x1 AND Y=y1;
	
	update board
	set piece=p, piece_color=p_color
	where x=x2 and y=y2;
	
	UPDATE board
	SET piece=null,piece_color=null
	WHERE X=x1 AND Y=y1;
	update game_status set p_turn=if(p_color='W','B','W');
	
    END$$

CREATE PROCEDURE `test_move` ()  BEGIN
SELECT * FROM
board B1 INNER JOIN board B2
WHERE B1.x=2 AND B1.y=2
AND (B2.`piece_color` IS NULL OR B2.`piece_color`<>B1.`piece_color`)
AND B1.x=B2.x AND B1.y<B2.y AND (B2.y-B1.y)<=2 ;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `board`
--

CREATE TABLE `board` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `b_color` enum('B','W') NOT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15') DEFAULT NULL,
  `second_piece` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `board`
--

INSERT INTO `board` (`x`, `y`, `b_color`, `piece_color`, `piece`, `second_piece`) VALUES
(0, 0, 'B', NULL, NULL, NULL),
(1, 0, 'B', NULL, NULL, NULL),
(14, 0, 'B', NULL, NULL, NULL),
(1, 1, 'B', NULL, NULL, NULL),
(2, 1, 'W', NULL, NULL, NULL),
(3, 1, 'B', NULL, NULL, NULL),
(4, 1, 'W', NULL, NULL, NULL),
(5, 1, 'B', NULL, NULL, NULL),
(6, 1, 'W', NULL, NULL, NULL),
(7, 1, 'B', NULL, NULL, NULL),
(8, 1, 'W', NULL, NULL, NULL),
(9, 1, '', NULL, NULL, NULL),
(10, 1, '', NULL, NULL, NULL),
(11, 1, '', NULL, NULL, NULL),
(12, 1, '', NULL, NULL, NULL),
(13, 1, '', NULL, NULL, NULL),
(14, 1, '', NULL, NULL, NULL),
(15, 1, '', NULL, NULL, NULL),
(1, 2, 'W', NULL, NULL, NULL),
(2, 2, 'B', NULL, NULL, NULL),
(3, 2, 'W', NULL, NULL, NULL),
(4, 2, 'B', NULL, NULL, NULL),
(5, 2, 'W', NULL, NULL, NULL),
(6, 2, 'B', NULL, NULL, NULL),
(7, 2, 'W', NULL, NULL, NULL),
(8, 2, 'B', NULL, NULL, NULL),
(9, 2, '', NULL, NULL, NULL),
(10, 2, '', NULL, NULL, NULL),
(11, 2, '', NULL, NULL, NULL),
(12, 2, '', NULL, NULL, NULL),
(13, 2, '', NULL, NULL, NULL),
(14, 2, 'W', 'W', 'P15', NULL),
(15, 2, '', NULL, NULL, NULL),
(1, 3, 'B', NULL, NULL, NULL),
(2, 3, 'W', NULL, NULL, NULL),
(3, 3, 'B', NULL, NULL, NULL),
(4, 3, 'W', NULL, NULL, NULL),
(5, 3, 'B', NULL, NULL, NULL),
(6, 3, 'W', NULL, NULL, NULL),
(7, 3, 'B', NULL, NULL, NULL),
(8, 3, 'W', NULL, NULL, NULL),
(9, 3, '', NULL, NULL, NULL),
(10, 3, '', NULL, NULL, NULL),
(11, 3, '', NULL, NULL, NULL),
(12, 3, '', NULL, NULL, NULL),
(13, 3, '', NULL, NULL, NULL),
(14, 3, 'W', 'W', 'P2', NULL),
(15, 3, 'W', 'W', 'P14', NULL),
(1, 4, 'W', NULL, NULL, NULL),
(2, 4, 'B', NULL, NULL, NULL),
(3, 4, 'W', NULL, NULL, NULL),
(4, 4, 'B', NULL, NULL, NULL),
(5, 4, 'W', NULL, NULL, NULL),
(6, 4, 'B', NULL, NULL, NULL),
(7, 4, 'W', NULL, NULL, NULL),
(8, 4, 'B', NULL, NULL, NULL),
(9, 4, '', NULL, NULL, NULL),
(10, 4, '', NULL, NULL, NULL),
(11, 4, '', NULL, NULL, NULL),
(12, 4, '', NULL, NULL, NULL),
(13, 4, '', NULL, NULL, NULL),
(14, 4, 'W', 'W', 'P1', NULL),
(15, 4, 'W', 'W', 'P13', NULL),
(1, 5, 'B', NULL, NULL, NULL),
(2, 5, 'W', NULL, NULL, NULL),
(3, 5, 'B', NULL, NULL, NULL),
(4, 5, 'W', NULL, NULL, NULL),
(5, 5, 'B', NULL, NULL, NULL),
(6, 5, 'W', NULL, NULL, NULL),
(7, 5, 'B', NULL, NULL, NULL),
(8, 5, 'W', NULL, NULL, NULL),
(9, 5, '', NULL, NULL, NULL),
(10, 5, '', NULL, NULL, NULL),
(11, 5, '', NULL, NULL, NULL),
(12, 5, '', NULL, NULL, NULL),
(13, 5, '', NULL, NULL, NULL),
(14, 5, 'W', 'W', 'P3', NULL),
(15, 5, 'W', 'W', 'P12', NULL),
(1, 6, 'W', NULL, NULL, NULL),
(2, 6, 'B', NULL, NULL, NULL),
(3, 6, 'W', NULL, NULL, NULL),
(4, 6, 'B', NULL, NULL, NULL),
(5, 6, 'W', NULL, NULL, NULL),
(6, 6, 'B', NULL, NULL, NULL),
(7, 6, 'W', NULL, NULL, NULL),
(8, 6, 'B', NULL, NULL, NULL),
(9, 6, '', NULL, NULL, NULL),
(10, 6, '', NULL, NULL, NULL),
(11, 6, '', NULL, NULL, NULL),
(12, 6, '', NULL, NULL, NULL),
(13, 6, '', NULL, NULL, NULL),
(14, 6, 'W', 'W', 'P4', NULL),
(15, 6, 'W', 'W', 'P13', NULL),
(1, 7, 'B', 'B', NULL, NULL),
(2, 7, 'W', 'B', NULL, NULL),
(3, 7, 'B', 'B', NULL, NULL),
(4, 7, 'W', 'B', NULL, NULL),
(5, 7, 'B', 'B', NULL, NULL),
(6, 7, 'W', 'B', NULL, NULL),
(7, 7, 'B', 'B', NULL, NULL),
(8, 7, 'W', 'B', NULL, NULL),
(9, 7, '', NULL, NULL, NULL),
(10, 7, '', NULL, NULL, NULL),
(11, 7, '', NULL, NULL, NULL),
(12, 7, '', NULL, NULL, NULL),
(13, 7, '', NULL, NULL, NULL),
(14, 7, 'W', 'W', 'P5', NULL),
(15, 7, 'W', 'W', 'P10', NULL),
(1, 8, 'W', 'B', NULL, NULL),
(2, 8, 'B', 'B', NULL, NULL),
(3, 8, 'W', 'B', NULL, NULL),
(4, 8, 'B', 'B', NULL, NULL),
(5, 8, 'W', 'B', NULL, NULL),
(6, 8, 'B', 'B', NULL, NULL),
(7, 8, 'W', 'B', NULL, NULL),
(8, 8, 'B', 'B', NULL, NULL),
(9, 8, '', NULL, NULL, NULL),
(10, 8, '', NULL, NULL, NULL),
(11, 8, '', NULL, NULL, NULL),
(12, 8, '', NULL, NULL, NULL),
(13, 8, '', NULL, NULL, NULL),
(14, 8, 'W', 'W', 'P6', NULL),
(15, 8, 'W', 'W', 'P9', NULL),
(1, 9, 'W', NULL, NULL, NULL),
(2, 9, '', NULL, NULL, NULL),
(3, 9, '', NULL, NULL, NULL),
(4, 9, '', NULL, NULL, NULL),
(5, 9, '', NULL, NULL, NULL),
(6, 9, '', NULL, NULL, NULL),
(7, 9, '', NULL, NULL, NULL),
(8, 9, '', NULL, NULL, NULL),
(9, 9, '', NULL, NULL, NULL),
(10, 9, '', NULL, NULL, NULL),
(11, 9, '', NULL, NULL, NULL),
(12, 9, '', NULL, NULL, NULL),
(13, 9, '', NULL, NULL, NULL),
(14, 9, 'W', 'W', 'P7', NULL),
(15, 9, 'W', 'W', 'P8', NULL),
(1, 10, 'W', NULL, NULL, NULL),
(2, 10, '', NULL, NULL, NULL),
(3, 10, '', NULL, NULL, NULL),
(4, 10, '', NULL, NULL, NULL),
(5, 10, '', NULL, NULL, NULL),
(6, 10, '', NULL, NULL, NULL),
(7, 10, '', NULL, NULL, NULL),
(8, 10, '', NULL, NULL, NULL),
(9, 10, '', NULL, NULL, NULL),
(10, 10, '', NULL, NULL, NULL),
(11, 10, '', NULL, NULL, NULL),
(12, 10, '', NULL, NULL, NULL),
(13, 10, '', NULL, NULL, NULL),
(14, 10, 'W', 'W', NULL, NULL),
(15, 10, '', NULL, NULL, NULL),
(1, 11, 'W', NULL, NULL, NULL),
(2, 11, '', NULL, NULL, NULL),
(3, 11, '', NULL, NULL, NULL),
(4, 11, '', NULL, NULL, NULL),
(5, 11, '', NULL, NULL, NULL),
(6, 11, '', NULL, NULL, NULL),
(7, 11, '', NULL, NULL, NULL),
(8, 11, '', NULL, NULL, NULL),
(9, 11, '', NULL, NULL, NULL),
(10, 11, '', NULL, NULL, NULL),
(11, 11, '', NULL, NULL, NULL),
(12, 11, '', NULL, NULL, NULL),
(13, 11, '', NULL, NULL, NULL),
(14, 11, 'B', 'B', 'P7', NULL),
(15, 11, 'B', 'B', 'P8', NULL),
(1, 12, 'W', NULL, NULL, NULL),
(2, 12, '', NULL, NULL, NULL),
(3, 12, '', NULL, NULL, NULL),
(4, 12, '', NULL, NULL, NULL),
(5, 12, '', NULL, NULL, NULL),
(6, 12, '', NULL, NULL, NULL),
(7, 12, '', NULL, NULL, NULL),
(8, 12, '', NULL, NULL, NULL),
(9, 12, '', NULL, NULL, NULL),
(10, 12, '', NULL, NULL, NULL),
(11, 12, '', NULL, NULL, NULL),
(12, 12, '', NULL, NULL, NULL),
(13, 12, '', NULL, NULL, NULL),
(14, 12, 'B', 'B', 'P7', NULL),
(15, 12, 'B', 'B', 'P8', NULL),
(1, 13, 'B', NULL, NULL, NULL),
(2, 13, '', NULL, NULL, NULL),
(3, 13, '', NULL, NULL, NULL),
(4, 13, '', NULL, NULL, NULL),
(5, 13, '', NULL, NULL, NULL),
(6, 13, '', NULL, NULL, NULL),
(7, 13, '', NULL, NULL, NULL),
(8, 13, '', NULL, NULL, NULL),
(9, 13, '', NULL, NULL, NULL),
(10, 13, '', NULL, NULL, NULL),
(11, 13, '', NULL, NULL, NULL),
(12, 13, '', NULL, NULL, NULL),
(13, 13, '', NULL, NULL, NULL),
(14, 13, 'B', 'B', 'P6', NULL),
(15, 13, 'B', 'B', 'P10', NULL),
(1, 14, '', NULL, NULL, NULL),
(2, 14, '', NULL, NULL, NULL),
(3, 14, '', NULL, NULL, NULL),
(4, 14, '', NULL, NULL, NULL),
(5, 14, '', NULL, NULL, NULL),
(6, 14, '', NULL, NULL, NULL),
(7, 14, '', NULL, NULL, NULL),
(8, 14, '', NULL, NULL, NULL),
(9, 14, '', NULL, NULL, NULL),
(10, 14, '', NULL, NULL, NULL),
(11, 14, '', NULL, NULL, NULL),
(12, 14, '', NULL, NULL, NULL),
(13, 14, '', NULL, NULL, NULL),
(14, 14, 'B', 'B', 'P4', NULL),
(15, 14, 'B', 'B', 'P11', NULL),
(1, 15, '', NULL, NULL, NULL),
(2, 15, '', NULL, NULL, NULL),
(3, 15, '', NULL, NULL, NULL),
(4, 15, '', NULL, NULL, NULL),
(5, 15, '', NULL, NULL, NULL),
(6, 15, '', NULL, NULL, NULL),
(7, 15, '', NULL, NULL, NULL),
(8, 15, '', NULL, NULL, NULL),
(9, 15, '', NULL, NULL, NULL),
(10, 15, '', NULL, NULL, NULL),
(11, 15, '', NULL, NULL, NULL),
(12, 15, '', NULL, NULL, NULL),
(13, 15, '', NULL, NULL, NULL),
(14, 15, 'B', 'B', 'P3', NULL),
(15, 15, 'B', 'B', 'P12', NULL),
(1, 16, '', NULL, NULL, NULL),
(2, 16, '', NULL, NULL, NULL),
(3, 16, '', NULL, NULL, NULL),
(4, 16, '', NULL, NULL, NULL),
(5, 16, '', NULL, NULL, NULL),
(6, 16, '', NULL, NULL, NULL),
(7, 16, '', NULL, NULL, NULL),
(8, 16, '', NULL, NULL, NULL),
(9, 16, '', NULL, NULL, NULL),
(10, 16, '', NULL, NULL, NULL),
(11, 16, '', NULL, NULL, NULL),
(12, 16, 'B', NULL, NULL, NULL),
(13, 16, '', NULL, NULL, NULL),
(14, 16, 'B', 'B', 'P5', NULL),
(15, 16, 'B', 'B', 'P13', NULL),
(1, 17, '', NULL, NULL, NULL),
(2, 17, '', NULL, NULL, NULL),
(3, 17, '', NULL, NULL, NULL),
(4, 17, '', NULL, NULL, NULL),
(5, 17, '', NULL, NULL, NULL),
(6, 17, '', NULL, NULL, NULL),
(7, 17, '', NULL, NULL, NULL),
(8, 17, '', NULL, NULL, NULL),
(9, 17, '', NULL, NULL, NULL),
(10, 17, '', NULL, NULL, NULL),
(11, 17, '', NULL, NULL, NULL),
(12, 17, '', NULL, NULL, NULL),
(13, 17, '', NULL, NULL, NULL),
(14, 17, 'B', 'B', 'P1', NULL),
(15, 17, 'B', 'B', 'P14', NULL),
(1, 18, '', NULL, NULL, NULL),
(2, 18, '', NULL, NULL, NULL),
(3, 18, '', NULL, NULL, NULL),
(4, 18, '', NULL, NULL, NULL),
(5, 18, '', NULL, NULL, NULL),
(6, 18, '', NULL, NULL, NULL),
(7, 18, '', NULL, NULL, NULL),
(8, 18, '', NULL, NULL, NULL),
(9, 18, '', NULL, NULL, NULL),
(10, 18, '', NULL, NULL, NULL),
(11, 18, '', NULL, NULL, NULL),
(12, 18, '', NULL, NULL, NULL),
(13, 18, '', NULL, NULL, NULL),
(14, 18, 'B', 'B', 'P15', NULL),
(15, 18, 'W', 'B', NULL, NULL),
(1, 19, 'B', NULL, NULL, NULL),
(2, 19, 'B', NULL, NULL, NULL),
(3, 19, 'B', NULL, NULL, NULL),
(4, 19, 'B', NULL, NULL, NULL),
(5, 19, 'B', NULL, NULL, NULL),
(6, 19, 'B', NULL, NULL, NULL),
(7, 19, 'B', NULL, NULL, NULL),
(8, 19, '', NULL, NULL, NULL),
(9, 19, 'B', NULL, NULL, NULL),
(10, 19, 'B', NULL, NULL, NULL),
(11, 19, 'B', NULL, NULL, NULL),
(12, 19, 'B', NULL, NULL, NULL),
(13, 19, '', NULL, NULL, NULL),
(14, 19, 'B', 'B', NULL, NULL),
(15, 19, 'B', NULL, NULL, NULL),
(14, 20, 'B', 'B', NULL, NULL),
(15, 20, 'B', 'B', 'P2', NULL),
(14, 21, 'B', 'B', NULL, NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `board_empty`
--

CREATE TABLE `board_empty` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `b_color` enum('B','W') NOT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15') DEFAULT NULL,
  `second_piece` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `board_empty`
--

INSERT INTO `board_empty` (`x`, `y`, `b_color`, `piece_color`, `piece`, `second_piece`) VALUES
(15, 1, '', NULL, NULL, NULL),
(14, 2, 'W', 'W', 'P15', NULL),
(15, 2, '', NULL, NULL, NULL),
(14, 3, 'W', 'W', 'P2', NULL),
(15, 3, 'W', 'W', 'P14', NULL),
(14, 4, 'W', 'W', 'P1', NULL),
(15, 4, 'W', 'W', 'P13', NULL),
(14, 5, 'W', 'W', 'P3', NULL),
(15, 5, 'W', 'W', 'P12', NULL),
(14, 6, 'W', 'W', 'P4', NULL),
(15, 6, 'W', 'W', 'P13', NULL),
(14, 7, 'W', 'W', 'P5', NULL),
(15, 7, 'W', 'W', 'P10', NULL),
(14, 8, 'W', 'W', 'P6', NULL),
(15, 8, 'W', 'W', 'P9', NULL),
(14, 9, 'W', 'W', 'P7', NULL),
(15, 9, 'W', 'W', 'P8', NULL),
(15, 10, '', NULL, NULL, NULL),
(14, 11, 'B', 'B', 'P7', NULL),
(15, 11, 'B', 'B', 'P8', NULL),
(14, 12, 'B', 'B', 'P7', NULL),
(15, 12, 'B', 'B', 'P8', NULL),
(14, 13, 'B', 'B', 'P6', NULL),
(15, 13, 'B', 'B', 'P10', NULL),
(14, 14, 'B', 'B', 'P4', NULL),
(15, 14, 'B', 'B', 'P11', NULL),
(14, 15, 'B', 'B', 'P3', NULL),
(15, 15, 'B', 'B', 'P12', NULL),
(14, 16, 'B', 'B', 'P5', NULL),
(15, 16, 'B', 'B', 'P13', NULL),
(14, 17, 'B', 'B', 'P1', NULL),
(15, 17, 'B', 'B', 'P14', NULL),
(14, 18, 'B', 'B', 'P15', NULL),
(15, 18, 'W', 'B', NULL, NULL),
(15, 19, 'B', NULL, NULL, NULL),
(15, 20, 'B', 'B', 'P2', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `game_status`
--

CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborded') NOT NULL DEFAULT 'not active',
  `p_turn` enum('W','B') DEFAULT NULL,
  `result` enum('B','W','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL,
  `dice1` int(11) DEFAULT NULL,
  `dice2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `game_status`
--

INSERT INTO `game_status` (`status`, `p_turn`, `result`, `last_change`, `dice1`, `dice2`) VALUES
('aborded', NULL, 'B', '2021-01-06 17:00:46', NULL, NULL);

--
-- Δείκτες `game_status`
--
DELIMITER $$
CREATE TRIGGER `game_status_update` BEFORE UPDATE ON `game_status` FOR EACH ROW BEGIN
		set NEW.last_change = now();
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `players`
--

CREATE TABLE `players` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','W') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `players`
--

INSERT INTO `players` (`username`, `piece_color`, `token`, `last_action`) VALUES
('asd', 'B', '390e99cb4a2f9e1cdac50fafc6c036bb', NULL),
('asdasd', 'W', 'e525f261ccfb2e4515241182bd6c962f', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(0, '', 'sdfdsffdssasddfsdf@yahoo.gr', 'f67c2bcbfcfa30fccb36f72dca22a817'),
(1, 'test', 'a4bit@yahoo.gr', 'd4e87f9100fcc83c5ff0b139f1e6ed06'),
(2, 'afdfsdfsdfsdf', 'a4dfgbit@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(3, 'adminnnnn', 'a4sdfbit@yahoo.gr', 'd4e87f9100fcc83c5ff0b139f1e6ed06'),
(4, 'adminnnnnnn', 'a4bsfdgit@yahoo.gr', 'd4e87f9100fcc83c5ff0b139f1e6ed06'),
(5, 'adminnnnnn', 'adfgit@yahoo.gr', 'd4e87f9100fcc83c5ff0b139f1e6ed06'),
(6, 'adminNN', 'a4bDFGit@yahoo.gr', '61bfd8dcae51bb2ed782c3ca3ea953ad'),
(7, 'dsfsdfsdfd', 'a4sdfsdfbit@yahoo.gr', 'd4e87f9100fcc83c5ff0b139f1e6ed06'),
(8, 'adminadfsdf', 'a4bist@yahoo.grdf', 'd4321ced737dd079924d7c92344c3076'),
(9, 'sdfsdfsdf', 'a4bisdfsdf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(10, 'admin', 'a4bitasd@yahoo.gr', '21232f297a57a5a743894a0e4a801fc3'),
(11, 'testaki', 'sdfdsffdssdfsdf@yahoo.gr', 'd286808c930528043e70def9d1681479'),
(12, 'fsdfsdfsdfsdfsdf', 'sdfdsffdssdfsdfsdfsdfsdf@yahoo.gr', 'd286808c930528043e70def9d1681479'),
(13, 'elaretwra', 'sdfdsffsdfdssdfsdf@yahoo.gr', 'fdd8b155ad99c8bae6662fba256e8d06'),
(14, 'fdsfsdfsdfdssfdsfdfds', 'sdadfsddfsfdsfsdfdsfsdfdsffdssdfsdf@yahoo.gr', '400e4b53378e468d402380e3d582f337'),
(15, 'sdfsdfsdfsdfsdfsdfsdfsdfsdfsfsdfds', 'sdfdsffdssfdsfdsfsddfsdf@yahoo.gr', 'e7a4be7865cb5a991ada3f163c9a6cce'),
(16, 'sdfsdfsdfdsfdsfsdsfdfsdfds', 'sdfsfdfdsfdsdsffdssdfsdf@yahoo.gr', 'e7a4be7865cb5a991ada3f163c9a6cce'),
(18, 'sfgfgfdgdfgdfgdgdgfggfdfg', 'sdfdsffdsadsfafsdfsdf@yahoo.gr', '62336bc1faa56c47d35e868e842f6c62'),
(19, 'testakitestaki', 'sdfdsffdstestakitestakisdfsdf@yahoo.gr', '8f2f7e8033aed95ff6c50d9fb636e980'),
(29, 'elaremlkaaaaa', 'sdfdselaremlkaaaaaffdssdfsdf@yahoo.gr', '710b8ac10b080e0bd02976f052f71574'),
(30, 'elaremlkaaaaaelaremlkaaaaa', 'sdfelaremlkaaaaadsffdssdfsdf@yahoo.gr', '710b8ac10b080e0bd02976f052f71574'),
(31, 'sdfsfsdgfsdgf', 'sdfdsffdssdfsdfsdfsdf@yahoo.gr', 'a3284c01f972441b011d0336e07ca4b7'),
(32, 'adminadmin', 'sdfdsadminadminffdssdfsdf@yahoo.gr', '21232f297a57a5a743894a0e4a801fc3'),
(33, 'adminadminadmin', 'sdfdsffdssadminadminadmindfsdf@yahoo.gr', '21232f297a57a5a743894a0e4a801fc3'),
(34, 'adminn', 'sdfdsuccesasdssffdssdfsdf@yahoo.gr', '21232f297a57a5a743894a0e4a801fc3'),
(35, 'asdasdasdasd', 'sdfdsffdssdasdasdfsdf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(36, 'gianadoume', 'sdfdsffdssdsdfsdfasdasdfsdf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(37, 'sdfsdfsdfsdf', 'sdfdsffdsdfsdfsdf2232ssdasdasdfsdf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(38, 'testttttttttttttttttttttttttt', 'sdfdsffdssdassdfsdfdasdfsdf@yahoo.gr', '21232f297a57a5a743894a0e4a801fc3'),
(39, 'asdasfasdfasdf', 'sdfdsffdssdasdasdfsasdasddf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076'),
(40, 'asdasdasd', 'sdfdsfasdfdssdasdasdfsdf@yahoo.gr', 'd4321ced737dd079924d7c92344c3076');

--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `board`
--
ALTER TABLE `board`
  ADD PRIMARY KEY (`y`,`x`);

--
-- Ευρετήρια για πίνακα `board_empty`
--
ALTER TABLE `board_empty`
  ADD PRIMARY KEY (`y`,`x`);

--
-- Ευρετήρια για πίνακα `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`piece_color`);

--
-- Ευρετήρια για πίνακα `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT για άχρηστους πίνακες
--

--
-- AUTO_INCREMENT για πίνακα `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
