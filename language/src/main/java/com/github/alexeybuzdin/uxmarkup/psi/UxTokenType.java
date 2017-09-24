package com.github.alexeybuzdin.uxmarkup.psi;

import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class UxTokenType extends IElementType {
    public UxTokenType(@NotNull @NonNls String debugName) {
        super(debugName, UxLanguage.getInstance());
    }

    @Override
    public String toString() {
        return "UxTokenType." + super.toString();
    }
}
