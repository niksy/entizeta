#!/usr/bin/env bash

function passed_value_existence() {
	if [[ -z "$1" ]]; then
		echo "You haven’t passed any value.";
		exit 2;
	fi
}

function node_available() {
	if command -v node >/dev/null 2>&1; then
		return 0;
	else
		return 1;
	fi
}

function entities_decimal() {
	local decimal_value;
	local parsed_decimal_value;
	passed_value_existence "$1"
	if [[ $2 == 'to' ]]; then
		if [[ node_available -eq 0 ]]; then
			decimal_value=$(node -e 'var input_string = process.argv[1].substring(1); console.log(input_string.charCodeAt(0));' "a$1" | tr -d '\n');
		else
			decimal_value=$(php -r '$input_string = substr($argv[1],1); list(, $ord) = unpack("N", mb_convert_encoding($input_string, "UCS-4BE", "UTF-8")); echo $ord;' "a$1");
		fi
	elif [[ $2 == 'from' ]]; then
		parsed_decimal_value=$(printf "$1" | sed "s/[^0-9]//g");
		if [[ node_available -eq 0 ]]; then
			decimal_value=$(node -e 'console.log(String.fromCharCode('$parsed_decimal_value'));' | tr -d '\n');
		else
			decimal_value=$(php -r 'echo mb_convert_encoding("&#" . intval('$parsed_decimal_value') . ";", "UTF-8", "HTML-ENTITIES");');
		fi
	fi
	printf "$decimal_value";
	if [[ $3 == 'output' ]]; then
		if [[ $2 == 'to' ]]; then
			printf "\nHTML: &#$decimal_value;\n";
		elif [[ $2 == 'from' ]]; then
			printf "\n";
		fi
	fi
}

function entities_hexadecimal() {
	local hexadecimal_value;
	local parsed_hexadecimal_value;
	passed_value_existence "$1"
	if [[ $2 == 'to' ]]; then
		hexadecimal_value=$(printf "%04x" $(entities_decimal "$1" "to"));
	elif [[ $2 == 'from' ]]; then
		parsed_hexadecimal_value=$(printf "$1" | sed "s/[^0-9A-Fa-f]{1,4}//g");
		hexadecimal_value=$(entities_decimal "$(printf "%d" 0x$parsed_hexadecimal_value)" "from");
	fi
	printf "$hexadecimal_value";
	if [[ $3 == 'output' ]]; then
		if [[ $2 == 'to' ]]; then
			printf "\nHTML: &#x$hexadecimal_value;\nCSS:  %s$hexadecimal_value \n" "\\";
		elif [[ $2 == 'from' ]]; then
			printf "\n";
		fi
	fi
}

function entities_nument() {
	local entity_string;
	passed_value_existence "$1"
	if [[ $2 == 'to' ]]; then
		if [[ node_available -eq 0 ]]; then
			entity_string=$(node -e '
				var input_string = process.argv[1].substring(1);
				var unicode_string = "";
				for(var i = 0; i < input_string.length; i++){
					var char_code = input_string.charCodeAt(i);
					char_code = "&#" + char_code + ";";
					unicode_string += char_code;
				}
				console.log(unicode_string);' "a$1" | tr -d '\n');
		else
			entity_string=$(php -r '$input_string = substr($argv[1],1); echo mb_encode_numericentity($input_string, array (0x0, 0xffff, 0, 0xffff), "UTF-8");' "a$1");
		fi
	elif [[ $2 == 'from' ]]; then
		if [[ node_available -eq 0 ]]; then
			entity_string=$(node -e '
				var input_string = process.argv[1].substring(1);
				input_string = input_string.replace(/&#/g,"").split(";");
				input_string.pop();
				console.log(String.fromCharCode.apply(null, input_string));' "a$1" | tr -d '\n');
		else
			entity_string=$(php -r '$input_string = substr($argv[1],1); echo mb_decode_numericentity($input_string, array (0x0, 0xffff, 0, 0xffff), "UTF-8");' "a$1");
		fi
	fi
	printf "$entity_string";
	printf "\n";
}

function entities_help() {
	printf "%s [option] [value]

Options:
  to-decimal                   Convert from character to decimal value
  to-hexadecimal               Convert from character to hexadecimal value
  to-numeric-entity            Convert string to numeric entities (default option)
  from-decimal                 Convert from decimal to character value
  from-hexadecimal             Convert from hexadecimal to character value
  from-numeric-entity          Convert numeric entities to string
  -h, --help                   Display this help and exit\n\n" "$(basename $0)"
		printf "Notes:\n"
		printf "  * When used without quotes, \e[1m%s\e[0m, \e[1m%s\e[0m and \e[1m%s\e[0m must be escaped.\n" "\\" "\"" "'"
		printf "  * When used with double-quotes, \e[1m%s\e[0m and \e[1m%s\e[0m must be escaped.\n" "\\" "\""
		printf "  * When used with single-quotes, \e[1m%s\e[0m can’t be processed.\n" "'"
}

if [[ $# -eq 0 ]] ; then
	entities_help;
	exit 2;
else
	case "$1" in
		to-decimal) entities_decimal "$2" "to" "output" ;;
		to-hexadecimal) entities_hexadecimal "$2" "to" "output" ;;
		from-decimal) entities_decimal "$2" "from" "output" ;;
		from-hexadecimal) entities_hexadecimal "$2" "from" "output" ;;
		to-numeric-entity) entities_nument "$2" "to" ;;
		from-numeric-entity) entities_nument "$2" "from" ;;
		-h|--help) entities_help; exit 2 ;;
		*) entities_nument "$1" "to" ;;
	esac
fi
