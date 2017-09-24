package com.github.alexeybuzdin.uxmarkup;

import com.intellij.lang.Language;

public class UxLanguage extends Language {
    private static UxLanguage INSTANCE = new UxLanguage();

    public static UxLanguage getInstance() {
        return INSTANCE;
    }

    private UxLanguage() {
        super("Ux");
    }
}
