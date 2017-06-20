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

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*
KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "
STRING=[\w]*

%state WAITING_VALUE, STRING

%%

{STRING}                                    {  return UxTypes.STRING; }

 {END_OF_LINE_COMMENT}                           {return UxTypes.COMMENT; }

 {CRLF}({CRLF}|{WHITE_SPACE})+               { return TokenType.WHITE_SPACE; }

 {WHITE_SPACE}+                              { return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                                     { return TokenType.WHITE_SPACE; }

.                                                           { return TokenType.BAD_CHARACTER; }
