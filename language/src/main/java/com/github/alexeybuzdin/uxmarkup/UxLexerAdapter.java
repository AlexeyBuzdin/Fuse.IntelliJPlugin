package com.github.alexeybuzdin.uxmarkup;

import com.intellij.lexer.FlexAdapter;

import java.io.Reader;

public class UxLexerAdapter extends FlexAdapter {
    public UxLexerAdapter() {
        super(new UxLexer((Reader) null));
    }
}
