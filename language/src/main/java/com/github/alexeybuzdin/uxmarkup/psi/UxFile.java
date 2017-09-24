package com.github.alexeybuzdin.uxmarkup.psi;

import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.jetbrains.annotations.NotNull;

import javax.swing.*;

public class UxFile extends PsiFileBase {
    public UxFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, UxLanguage.getInstance());
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return UxFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "Ux File";
    }

    @Override
    public Icon getIcon(int flags) {
        return super.getIcon(flags);
    }
}
