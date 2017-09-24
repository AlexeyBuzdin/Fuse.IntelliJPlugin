package com.github.alexeybuzdin;

import com.github.alexeybuzdin.unoproj.*;
import com.github.alexeybuzdin.uxmarkup.*;
import com.intellij.openapi.fileTypes.FileTypeConsumer;
import com.intellij.openapi.fileTypes.FileTypeFactory;
import org.jetbrains.annotations.NotNull;

public class FuseToolsTypeFactory extends FileTypeFactory {

    @Override
    public void createFileTypes(@NotNull FileTypeConsumer fileTypeConsumer) {
        fileTypeConsumer.consume(UnoprojFileType.INSTANCE, "unoproj");
        fileTypeConsumer.consume(UxFileType.INSTANCE, "ux");
    }
}
