package com.github.alexeybuzdin.uxmarkup;

import com.github.alexeybuzdin.*;
import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class UxFileType extends LanguageFileType {

    public static final UxFileType INSTANCE = new UxFileType();

    private UxFileType() {
        super(UxLanguage.getInstance());
    }

    @NotNull
    @Override
    public String getName() {
        return "Fuse Tools UX File";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Fuse Tools UX Language File";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "ux";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return FuseToolsIcons.FILE_UX_ICO;
    }
}
