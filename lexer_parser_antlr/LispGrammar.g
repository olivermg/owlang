grammar LispGrammar;

@members {
  class Expression {
    public String identifier;
    public List<Integer> args;

    public Expression() {
      args = new ArrayList<Integer>();
    }
  }

  public static void main( String[] args ) throws Exception {
    LispGrammarLexer lex = new LispGrammarLexer( new ANTLRFileStream( args[0] ));
    CommonTokenStream tokens = new CommonTokenStream( lex );

    LispGrammarParser parser = new LispGrammarParser( tokens );

    try {
      List<Expression> expressions;
      expressions = parser.exprs();
      System.out.println( "expressions found: " + expressions.size() );
      for ( Expression expression : expressions ) {
        System.out.println( "  expression: " + expression.identifier );
        for ( Integer arg : expression.args ) {
          System.out.println( "    arg: " + arg );
        }
      }
    } catch ( RecognitionException e ) {
      e.printStackTrace();
    }
  }
}



// PARSER RULE DEFINITIONS:

exprs returns [List<Expression> expressions]
  @init {
    $expressions = new ArrayList<Expression>();
  }
  : ( ex = expr   { $expressions.add( ex ); } )* ;


expr returns [Expression expression]
  : '(' id = IDENTIFIER   as = args ')'   { $expression = new Expression(); $expression.identifier = $id.text; $expression.args = as; } ;


args returns [List<Integer> arguments]
  @init {
    $arguments = new ArrayList<Integer>();
  }
  : ( a = ARG   { $arguments.add( new Integer( $a.text ) ); }
    | e = expr  { $arguments.addAll( e.args ); }
    )* ;



// LEXER TOKEN DEFINITIONS:

IDENTIFIER  : ( 'a'..'z' )+ ;
ARG         : ( '0'..'9' )+ ;
WHITESPACE  : ( ' ' | '\t' | '\r' | '\n' )+   { $channel = HIDDEN; } ;

