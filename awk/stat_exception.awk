/ERROR/ && /Exception/ {
	desc=$0;
	getline;
	exk=$0;
	map[exk]=desc;
	tmap[exk]++;
	nextl=$0;

	if(!smap[exk]) {
		while(match(nextl, "\tat") || match(nextl, "Caused by:")) {
			smap[exk]=smap[exk] ? smap[exk]"\n"$0 : $0;
			getline;
			nextl=$0
		}
	}
	
}
END {
	for(k in smap){
		print tmap[k] " times " map[k] "\n" smap[k]
	}
}