type ast =
	Node of ast * ast
	| Leaf of string

val printast: ast -> unit
