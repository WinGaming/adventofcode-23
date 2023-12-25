<?php
	function handleLine($line) {
		$numbersPattern = '/^Card\s+[0-9]*:\s+(?<winning>[0-9\s]*)\s|\s(?<own>[0-9\s]*)$/';
		preg_match_all($numbersPattern, $line, $matches);

		// echo substr($line, 0, 8) . ": ";

		$winnings = $matches["winning"][0] ? $matches["winning"][0] : $matches["winning"][1];
		$owns = $matches["own"][0] ? $matches["own"][0] : $matches["own"][1];

		$winningVals = explode(" ", $winnings);
		$ownsVals = explode(" ", $owns);

		$total = 0.5;
		foreach ($ownsVals as $v) {
			if ($v == "") continue;
			
			foreach ($winningVals as $w) {
				if ($v == $w) {
					$total = $total * 2;
				}
			}
		}

		if ($total < 1) return 0;

		return $total;
	}

	$file = file_get_contents('C:\github\adventofcode-23\04\input.txt', true);
	$lines = explode("\r\n", $file);
	
	$final = 0;
	foreach ($lines as $line) {
		$final += handleLine($line);
	}

	echo $final;

	exit;
?>