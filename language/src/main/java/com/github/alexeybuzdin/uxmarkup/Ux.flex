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
%{
        private int start_comment;
        private int comment_depth;
        private boolean attributeNext;
%}

TAG_START= "<"
TAG_END= ">"
SLASH=  "/"
EQUALS= "="
COLON= ":"

CRLF=\R
WHITE_SPACE=[\ \n\t\f]

DIGIT = [0-9]
LETTER = [:letter:]|"_"
IDENTIFIER = ({LETTER})({LETTER}|{DIGIT})*
NODE_NAME = ({LETTER})({LETTER}|{DIGIT}|".")*

STRING_SINGLE_QUOTED=\'([^\\\'\r\n]|{CRLF})*(\'|\\)? | \'\'\' ( (\'(\')?)? [^\'] )* \'\'\'
STRING_DOUBLE_QUOTED=\"([^\\\"\r\n]|{CRLF})*(\"|\\)? | \"\"\" ( (\"(\")?)? [^\"] )* \"\"\"
STRING = {STRING_SINGLE_QUOTED} | {STRING_DOUBLE_QUOTED}
NODE_INNER_TEXT = [^<]*

JS_KEYWORDS =  "function"

%state WAITING_VALUE, IN_BLOCK_COMMENT, INSIDE_TAG, INSIDE_TAG_NAME

%%

<YYINITIAL> "<!--" { yybegin(IN_BLOCK_COMMENT); start_comment = zzStartRead; comment_depth = 1; }
<IN_BLOCK_COMMENT> {
	"-->"        {
		if (--comment_depth == 0) {
			yybegin(YYINITIAL);
			zzStartRead = start_comment;
			return UxTypes.BLOCK_COMMENT;
		} else {
			yybegin(IN_BLOCK_COMMENT);
		}
	}
	"<!--"      { yybegin(IN_BLOCK_COMMENT); ++comment_depth; }
	[^>]+       { yybegin(IN_BLOCK_COMMENT); }
	<<EOF>>     { yybegin(YYINITIAL); zzStartRead = start_comment; return UxTypes.BLOCK_COMMENT; }
	.           { yybegin(IN_BLOCK_COMMENT); }
}

{CRLF}({CRLF}|{WHITE_SPACE})+          { return TokenType.WHITE_SPACE; }

{WHITE_SPACE}+                         { return TokenType.WHITE_SPACE; }

({CRLF}|{WHITE_SPACE})+                { return TokenType.WHITE_SPACE; }

<YYINITIAL> {

  {TAG_START}                            { yybegin(INSIDE_TAG_NAME); return UxTypes.TAG_START; }

}

<INSIDE_TAG_NAME> {
          "ux"                         { return UxTypes.ATTRIBUTE_SCHEMA; }
          {NODE_NAME}                 {
                                          if(!attributeNext) {
                                            attributeNext = true;
                                            return UxTypes.NODE_NAME;
                                          }
                                          return UxTypes.ATTRIBUTE_NAME; }
          {STRING}                     { return UxTypes.STRING; }
          {COLON}                      { return UxTypes.SIGN; }
          {EQUALS}                     { return UxTypes.SIGN; }
          {SLASH}                      { return UxTypes.SLASH; }
          {TAG_END}                    { attributeNext = false; yybegin(INSIDE_TAG); return UxTypes.TAG_END; }
}

<INSIDE_TAG> {
          {TAG_START}                  { yybegin(INSIDE_TAG_NAME); return UxTypes.TAG_START; }
          {NODE_INNER_TEXT}            { return UxTypes.NODE_INNER_TEXT; }
}

.                                      { return TokenType.BAD_CHARACTER; }

