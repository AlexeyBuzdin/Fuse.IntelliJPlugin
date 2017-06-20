package com.github.alexeybuzdin.uxmarkup;

import com.intellij.lexer.*;

import java.io.*;

public class UxLexerAdapter extends FlexAdapter {
    public UxLexerAdapter() {
        super(new UxLexer((Reader) null));
    }
}
