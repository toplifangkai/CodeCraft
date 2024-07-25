/ERROR/ && /Exception/ {
	desc=$0;
	t = $1;
	if(P1) {
		split($2, hms, /:/)
		switch(P1) {
			case "H":
				t = t"-"hms[1]
				break
			case "M":
				t = t"-"hms[1]"-"hms[2]
				break
			case "S":
				split($2, ms, /\./)
				t = t"-"ms[1]
				break
		}
	}
	getline;
	firstKey=$0;
	if(match(firstKey, "igg")) {
		key = firstKey
	}
	nextl=$0;

	while(match(nextl, "\tat") || match(nextl, "Caused by:")) {
		stack=stack ? stack"\n"$0 : $0;
		if(!key && match(nextl, "igg")) {
			key = firstKey""nextl
		}
		getline;
		nextl=$0
	}
	if(!stackMap[key]) {
		stackMap[key] = stack
		descMap[key] = desc
	}
	timeMap[key][t]++
	countMap[key]++
	key = ""
	stack = ""
}
END {
	i = 1
	for(k in stackMap){
		print i++ ". \"" descMap[k] "\"\n" stackMap[k]
		print "stat:"
		print "\toccur " countMap[k] " times"
		for(t in timeMap[k]) {
			print "\t" t ": " timeMap[k][t]
		}
		print "\n"
	}
}