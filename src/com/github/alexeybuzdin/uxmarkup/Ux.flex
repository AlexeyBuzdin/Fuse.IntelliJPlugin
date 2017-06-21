package com.github.alexeybuzdin.uxmarkup;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.github.alexeybuzdin.uxmarkup.psi.UxTypes;
import com.intellij.psi.TokenType;

import static com.github.alexeybuzdin.uxmarkup.UxParserDefinition.JAVASCRIPT_CODE;
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
EQUALS= "="
COLON= ":"

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
START_COMMENT=("<!--")
END_COMMENT=("-->")

START_JS="<JavaScript>"
END_JS="</JavaScript>"
JAVASCRIPT_CODE = .*

DIGIT = [0-9]
LETTER = [:letter:]|"_"
IDENTIFIER = ({LETTER})({LETTER}|{DIGIT})*
KEY  = ({LETTER})({LETTER}|{DIGIT})*
NODE_NAME = {IDENTIFIER}

STRING_SINGLE_QUOTED=\'([^\\\'\r\n]|{CRLF})*(\'|\\)? | \'\'\' ( (\'(\')?)? [^\'] )* \'\'\'
STRING_DOUBLE_QUOTED=\"([^\\\"\r\n]|{CRLF})*(\"|\\)? | \"\"\" ( (\"(\")?)? [^\"] )* \"\"\"
STRING = {STRING_SINGLE_QUOTED} | {STRING_DOUBLE_QUOTED}

JS_KEYWORDS =  "function"

%state WAITING_VALUE, COMMENT, INSIDE_TAG, JAVASCRIPT

%%

{START_COMMENT}                        { yybegin(COMMENT); return UxTypes.COMMENT; }
<COMMENT> {
  {END_COMMENT}                        { yybegin(YYINITIAL); return UxTypes.COMMENT; }
  .                                    { yybegin(COMMENT); return UxTypes.COMMENT; }
}

<YYINITIAL> {START_JS}                 { yybegin(JAVASCRIPT); return UxTypes.JS_NODE; }
<JAVASCRIPT>{
  {END_JS}                             { yybegin(YYINITIAL); return UxTypes.JS_NODE; }
  {JAVASCRIPT_CODE}                    { yybegin(JAVASCRIPT); return UxTypes.JS_BODY; }
}

<YYINITIAL> {

{TAG_START}                        { return UxTypes.TAG_START; }
{NODE_NAME}    { yybegin(INSIDE_TAG);  return UxTypes.NODE_NAME; }

}

<INSIDE_TAG> {
          "ux"                { return UxTypes.ATTRIBUTE_SCHEMA; }
          {IDENTIFIER}        { return UxTypes.ATTRIBUTE_NAME; }
          {STRING}            { return UxTypes.STRING; }
          {COLON}             { return UxTypes.SIGN; }
          {EQUALS}            { return UxTypes.SIGN; }
          <YYINITIAL> {SLASH} { return UxTypes.SLASH; }
          {TAG_END}           { yybegin(YYINITIAL); return UxTypes.TAG_END; }
}

{CRLF}({CRLF}|{WHITE_SPACE})+ { return TokenType.WHITE_SPACE; }

{WHITE_SPACE}+                { return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                        { return TokenType.WHITE_SPACE; }

.                                              { return TokenType.BAD_CHARACTER; }

