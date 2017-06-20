package com.github.alexeybuzdin.uxmarkup.psi;

import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.psi.tree.*;
import org.jetbrains.annotations.*;

public class UxElementType extends IElementType {
    public UxElementType(@NotNull @NonNls String debugName) {
        super(debugName, UxLanguage.getInstance());
    }
}
