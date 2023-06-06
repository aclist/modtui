#!/usr/bin/env bash
#https://fomod-docs.readthedocs.io/en/latest/tutorial.html
#Types
#SelectAny”, “SelectAll”, “SelectExactlyOne”, “SelectAtMostOne” and “SelectAtLeastOne”.
#TODO: flags
is=$(xmllint --xpath "count(//installStep)" "$file")
module(){
	local file="$1"
	for (( i = 1; i <= $is; i++ )); do
		printf "Install Step: "
		xmllint --xpath "string(//installStep[$i]/@name)" "$file"
		ogc=$(xmllint --xpath "count(//installStep[$i]/optionalFileGroups)" "$file")
		for (( j = 1; j <= $ogc; j++ )); do
			gc=$(xmllint --xpath "count(//installStep[$i]/optionalFileGroups[$j]/group)" "$file")
				for (( k = 1; k <= $gc; k++ )); do
					printf " Group: "
					xmllint --xpath "string(//installStep[$i]/optionalFileGroups[$j]/group[$k]/@name)" "$file"
					printf "    Type: "
					xmllint --xpath "string(//installStep[$i]/optionalFileGroups[$j]/group[$k]/@type)" "$file"
					pc=$(xmllint --xpath "count(//installStep[$i]/optionalFileGroups[$j]/group[$k]/plugins/plugin)" "$file")
						for (( l = 1; l <= $pc; l++ )); do
							printf "    Plugin: "
							xmllint --xpath "string(//installStep[$i]/optionalFileGroups[$j]/group[$k]/plugins/plugin[$l]/@name)" "$file"
							printf "       "
							xmllint --xpath "string(//installStep[$i]/optionalFileGroups[$j]/group[$k]/plugins/plugin[$l]/description)" "$file"
						done
				done
		done
	done
}
info(){
	local fmt=$(< "$1" xmllint --format -)
	name=$(<<< "$fmt" xmllint --xpath "string(//Name)" -)
	author=$(<<< "$fmt" xmllint --xpath "string(//Author)" -)
	version=$(<<< "$fmt" xmllint --xpath "string(//Version)" -)
	url=$(<<< "$fmt" xmllint --xpath "string(//Website)" -)
	desc=$(<<< "$fmt" xmllint --xpath "string(//Description)" -)
	cat <<- EOF
	$name
	$author
	$version
	$url
	$desc
	EOF
}
"$@"
