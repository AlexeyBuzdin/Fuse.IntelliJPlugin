package com.github.alexeybuzdin.unoproj;

import com.github.alexeybuzdin.*;
import com.intellij.openapi.fileTypes.*;
import org.jetbrains.annotations.*;

import javax.swing.*;

public class UnoprojFileType extends LanguageFileType {

    public static final UnoprojFileType INSTANCE = new UnoprojFileType();

    private UnoprojFileType() {
        super(UnoprojLanguage.getInstance());
    }

    @NotNull
    @Override
    public String getName() {
        return "Fuse Tools Unoproj File";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Fuse Tools Unoproj Language File";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "unoproj";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return FuseToolsIcons.FILE_UNOPROJ_ICO;
    }
}
