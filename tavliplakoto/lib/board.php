<?php


function get_phase($token)
{
	global $conn;

	$color = current_color($token);
	$sql = 'select * from repository where color=?';
	$st = $conn->prepare($sql);
	$st->bind_param('s',$color);
	$st->execute();
	$res = $st->get_result();
	if($row=$res->fetch_assoc()) {
		return($row['phase']);
	}
	return(null);
}

function change_phase($token)
{
	global $conn;

	$color = current_color($token);
	$sql = "update repository set phase='end' where color=?";
	$st = $conn->prepare($sql);
	$st->bind_param('s',$color);
	$st->execute();


}
function move_piece($x,$y,$x2,$y2,$dice1,$dice2,$token) {
	global $conn;

	$color = current_color($token);

	$dice_sum = $dice1 + $dice2;
	$steps_count = 0;

	if($dice1==$dice2)
	{
		$dice_sum = ($dice1 + $dice2)*2;
	}


	$moves_played = get_moves_played($token);

	$available_steps = $dice_sum - $moves_played;

$black_mother = get_piece_info("1","1");
			$white_mother = get_piece_info("2","1");

			if($black_mother['pieces']==2)
			{
				if($black_mother['first_piece']!=$black_mother['second_piece'])
				{
					game_winner($color);
				}
			}

			if($white_mother['pieces']==2)
			{
				if($white_mother['first_piece']!=$white_mother['second_piece'])
				{
					game_winner($color);
				}
			}


		
			$available_steps -= $steps_count;
			$moves_played += $steps_count;

			if($available_steps<1)
			{
				$sql3 = "update players set sum=0 , moves_played=0 where piece_color='".$color."'";
				$st3 = $conn->prepare($sql3);
				$r3 = $st3->execute();

				header('Content-type: application/json');
				print json_encode(read_board(), JSON_PRETTY_PRINT);
				change_turn();
				exit;
			}
			else
			{
				$sql3 = "update players set sum=".$dice_sum." , moves_played=".$moves_played." where piece_color='".$color."'";
				$st3 = $conn->prepare($sql3);
				$r3 = $st3->execute();

				header('Content-type: application/json');
				print json_encode(read_board(), JSON_PRETTY_PRINT);
				exit;
			}

	}

	header("HTTP/1.1 400 Bad Request");
	print json_encode(['errormesg'=>"This move is illegal."]);
	exit;
}
   
function move_piece($x,$y,$x2,$y2,$token) {
	
	if($token==null || $token=='') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"token is not set."]);
		exit;
	}
	
	$color = current_color($token);
	if($color==null ) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"You are not a player of this game."]);
		exit;
	}
	$status = read_status();
	if($status['status']!='started') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"Game is not in action."]);
		exit;
	}
	if($status['p_turn']!=$color) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"It is not your turn."]);
		exit;
	}
	$orig_board=read_board();
	$board=convert_board($orig_board);
	$n = add_valid_moves_to_piece($board,$color,$x,$y);
	if($n==0) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"This piece cannot move."]);
		exit;
	}
	foreach($board[$x][$y]['moves'] as $i=>$move) {
		if($x2==$move['x'] && $y2==$move['y']) {
			do_move($x,$y,$x2,$y2);
			exit;
		}
	}
	header("HTTP/1.1 400 Bad Request");
	print json_encode(['errormesg'=>"This move is illegal."]);
	exit;
}
		
function show_board($input) {
	global $mysqli;
	
	$b=current_color($input['token']);
	if($b) {
		show_board_by_player($b);
	} else {
		header('Content-type: application/json');
		print json_encode(read_board(), JSON_PRETTY_PRINT);
	}
}

function reset_board() {
	global $mysqli;
	$sql = 'call clean_board()';
	$mysqli->query($sql);
	
}

function read_board() {
	global $mysqli;
	$sql = 'select * from board';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	return($res->fetch_all(MYSQLI_ASSOC));
}

function convert_board(&$orig_board) {
	$board=[];
	foreach($orig_board as $i=>&$row) {
		$board[$row['x']][$row['y']] = &$row;
	} 
	return($board);
}

function show_board_by_player($b) {

	global $mysqli;

	$orig_board=read_board();
	$board=convert_board($orig_board);
	$status = read_status();
	if($status['status']=='started' && $status['p_turn']==$b && $b!=null) {
		// It my turn !!!!
		$n = add_valid_moves_to_board($board,$b);
		
		// Εάν n==0, τότε έχασα !!!!!
		// Θα πρέπει να ενημερωθεί το game_status.
	}
	header('Content-type: application/json');
	print json_encode($orig_board, JSON_PRETTY_PRINT);
}

function add_valid_moves_to_board(&$board,$b) {
	$number_of_moves=0;
	
	for($x=1;$x<9;$x++) {
		for($y=1;$y<9;$y++) {
			$number_of_moves+=add_valid_moves_to_piece($board,$b,$x,$y);
		}
	}
	return($number_of_moves);
}

function add_valid_moves_to_piece(&$board,$b,$x,$y) {
	$number_of_moves=0;
	if($board[$x][$y]['piece_color']==$b) {
		switch($board[$x][$y]['piece']){
			case 'P1': $number_of_moves;break;
			case 'P2': $number_of_moves;break;
			case 'P3': $number_of_moves;break;
			case 'P4': $number_of_moves;break;
			case 'P5': $number_of_moves;break;
			case 'P6': $number_of_moves;break;
			case 'P7': $number_of_moves;break;
			case 'P8': $number_of_moves;break;
			case 'P9': $number_of_moves;break;
			case 'P10': $number_of_moves;break;
			case 'P11': $number_of_moves;break;
			case 'P12': $number_of_moves;break;
			case 'P13': $number_of_moves;break;
			case 'P14': $number_of_moves;break;
			case 'P15': $number_of_moves;break;
			
		}
	} 
	return($number_of_moves);
}


	
	];	
	return(bishop_rook_queen_moves($board,$b,$x,$y,$directions));

}













?>
