package com.github.alexeybuzdin.uxmarkup.psi;

import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.psi.tree.*;
import org.jetbrains.annotations.*;

public class UxTokenType extends IElementType {
    public UxTokenType(@NotNull @NonNls String debugName) {
        super(debugName, UxLanguage.getInstance());
    }

    @Override
    public String toString() {
        return "SimpleTokenType." + super.toString();
    }
}
