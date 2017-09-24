package com.github.alexeybuzdin.actions;

import com.github.alexeybuzdin.FuseToolsIcons;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.ui.Messages;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class OpenFuseAction extends AnAction {

    @Override
    public void actionPerformed(AnActionEvent anActionEvent) {
        try {
            Process p = Runtime.getRuntime().exec("fuse", null, null);

            BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));

            StringBuilder s = new StringBuilder("");
            String tmp;
            while ((tmp = stdErr.readLine()) != null) {
                s.append(tmp);
            }

            if (s.length() > 0) {
                throw new RuntimeException(s.toString());
            }

        } catch (Exception e) {
            Messages.showDialog(e.getMessage(), "Failed to Open Fuse", new String[]{"OK"}, -1, FuseToolsIcons.FILE_UX_ICO);
        }

    }
}
