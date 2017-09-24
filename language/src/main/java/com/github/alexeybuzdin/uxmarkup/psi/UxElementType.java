package com.github.alexeybuzdin.uxmarkup.psi;

import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class UxElementType extends IElementType {
    public UxElementType(@NotNull @NonNls String debugName) {
        super(debugName, UxLanguage.getInstance());
    }
}
