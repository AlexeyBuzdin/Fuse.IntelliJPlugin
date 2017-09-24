package com.github.alexeybuzdin.uxmarkup;

import com.github.alexeybuzdin.*;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class UxColorSettingsPage implements ColorSettingsPage {
    private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{
            new AttributesDescriptor("Key", UxSyntaxHighlighter.KEY),
            new AttributesDescriptor("Separator", UxSyntaxHighlighter.SEPARATOR),
            new AttributesDescriptor("Value", UxSyntaxHighlighter.VALUE),
            new AttributesDescriptor("Attribute", UxSyntaxHighlighter.ATTRIBUTE),
    };

    @Nullable
    @Override
    public Icon getIcon() {
        return FuseToolsIcons.FILE_UX_ICO;
    }

    @NotNull
    @Override
    public SyntaxHighlighter getHighlighter() {
        return new UxSyntaxHighlighter();
    }

    @NotNull
    @Override
    public String getDemoText() {
        return "<App Background=\"#022328\">\n" +
                "</App>";
    }

    @Nullable
    @Override
    public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
        return null;
    }

    @NotNull
    @Override
    public AttributesDescriptor[] getAttributeDescriptors() {
        return DESCRIPTORS;
    }

    @NotNull
    @Override
    public ColorDescriptor[] getColorDescriptors() {
        return ColorDescriptor.EMPTY_ARRAY;
    }

    @NotNull
    @Override
    public String getDisplayName() {
        return "UX Markup";
    }
}
