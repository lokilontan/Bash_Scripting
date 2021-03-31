BEGIN {
	total_earnings = 0
	total_withholding = 0
	lowest_earnings = 10000000
	highest_earnings = 0
}

NR > 1 {
	total_earnings += $3
	total_withholding += $4
	if ($3 <lowest_earnings)  lowest_earnings =$3
	else if ($3 >highest_earnings) highest_earnings =$3
}

END {
	print "Average earnings:", total_earnings / (NR-1);
	print "Average withholding:", total_withholding / (NR-1);
	print "Lowest earnings", lowest_earnings;
	print "Highest earnings", highest_earnings;
}