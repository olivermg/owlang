open Printf

type ast =
	Node of ast * ast
	| Leaf of string

let rec printast_rec tree = match tree with
	Leaf s -> printf "%s" s
	| Node (l, r) -> printf "(";
		printast_rec l;
		printf ", ";
		printast_rec r;
		printf ")"

let printast tree = printast_rec tree;
	printf "\n"
