<?php
	function handleLine($line) {
		$numbersPattern = '/^Card\s+[0-9]*:\s+(?<winning>[0-9\s]*)\s|\s(?<own>[0-9\s]*)$/';
		preg_match_all($numbersPattern, $line, $matches);

		$winnings = $matches["winning"][0] ? $matches["winning"][0] : $matches["winning"][1];
		$owns = $matches["own"][0] ? $matches["own"][0] : $matches["own"][1];

		$winningVals = explode(" ", $winnings);
		$ownsVals = explode(" ", $owns);

		$total = 0;
		foreach ($ownsVals as $v) {
			if ($v == "") continue;
			
			foreach ($winningVals as $w) {
				if ($v == $w) {
					$total += 1;
				}
			}
		}

		return $total;
	}

	$file = file_get_contents('C:\github\adventofcode-23\04\input.txt', true);
	$lines = explode("\r\n", $file);
	
	$final = 0;
	$dubCounts = array();

	$ind = 0;
	foreach ($lines as $line) {
		echo "Running " . $ind . " x " . (array_key_exists($ind, $dubCounts) ? $dubCounts[$ind] : 1);
		echo "<br>";
		$winCount = handleLine($line);

		// How ofter we have that card:
		$mult = (array_key_exists($ind, $dubCounts) ? $dubCounts[$ind] : 1);
		
		// echo "Won: " . $winCount . "<br>";
		for ($i = 1; $i <= $winCount; $i++) {
			$prev = array_key_exists($ind + $i, $dubCounts) ? $dubCounts[$ind + $i] : 1;
			$dubCounts[$ind + $i] = $prev + 1 * $mult;
		}

		// print_r($dubCounts);
		// echo "<br><br>";

		$ind += 1;
	}

	for ($i = 0; $i < count($lines); $i++) {
		$final += array_key_exists($i, $dubCounts) ? $dubCounts[$i] : 1;
	}
	print_r($dubCounts);
	echo "<br>";

	echo $final;

	exit;
?>