package com.github.alexeybuzdin.uxmarkup;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.github.alexeybuzdin.uxmarkup.psi.UxTypes;
import com.intellij.psi.TokenType;

%%

%class UxLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

TAG_START= "<"
TAG_END= ">"
SLASH=  "/"

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*
KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "

DIGIT = [0-9]
LETTER = [:letter:]|"_"
IDENTIFIER = ({LETTER})({LETTER}|{DIGIT})*
KEY  = ({LETTER})({LETTER}|{DIGIT})*

%state WAITING_VALUE

%%

<YYINITIAL> {TAG_START}                     { yybegin(WAITING_VALUE); return UxTypes.TAG_START; }

<WAITING_VALUE> {TAG_END}                   { yybegin(YYINITIAL); return UxTypes.TAG_END; }

<WAITING_VALUE> {SLASH}                     { yybegin(WAITING_VALUE); return UxTypes.SLASH; }

<WAITING_VALUE> {IDENTIFIER}                { yybegin(WAITING_VALUE);  return UxTypes.IDENTIFIER; }

{END_OF_LINE_COMMENT}                       { return UxTypes.COMMENT; }

<WAITING_VALUE>  {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(WAITING_VALUE);  return TokenType.WHITE_SPACE; }

<WAITING_VALUE>  {WHITE_SPACE}+                              { yybegin(WAITING_VALUE);  return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                     { return TokenType.WHITE_SPACE; }

.                                          { return TokenType.BAD_CHARACTER; }

