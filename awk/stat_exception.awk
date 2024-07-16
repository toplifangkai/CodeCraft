/ERROR/ && /Exception/ {
	desc=$0;
	getline;
	firstKey=$0;
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
	countMap[key]++
	key = ""
	stack = ""
}
END {
	for(k in stackMap){
		print countMap[k] " times " descMap[k] "\n" stackMap[k] "\n"
	}
}