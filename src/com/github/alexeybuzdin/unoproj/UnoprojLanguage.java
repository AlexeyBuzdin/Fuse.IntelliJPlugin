package com.github.alexeybuzdin.unoproj;

import com.intellij.lang.*;

public class UnoprojLanguage extends Language {
    private static UnoprojLanguage INSTANCE = new UnoprojLanguage();

    public static UnoprojLanguage getInstance() {
        return INSTANCE;
    }

    private UnoprojLanguage() {
        super("Unoproj");
    }
}
