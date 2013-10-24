/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "tabs"

Page {
    id: toolbarPage

    tools: sharedToolbar

    ToolBar{
        id: sharedToolbar

        platformInverted: window.platformInverted
    }

    ToolBarLayout {
        id: toolBarBack

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
    }


    TabBarLayout {
        id: tabBar

        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: toolbarPage.height > toolbarPage.width ? 60 : 50

        TabButton {
            tab: iconsPage;

            platformInverted: window.platformInverted;
            text: "Icons";
            iconSource: platformInverted ? "../Images/Icons/tab_icons_w.svg" : "../Images/Icons/tab_icons.svg"
        }

        TabButton {
            tab: textPage;

            platformInverted: window.platformInverted;
            text: "Text";
            iconSource: platformInverted ? "../Images/Icons/tab_text_w.svg" : "../Images/Icons/tab_text.svg"
        }

        TabButton {
            tab: groupPage;

            platformInverted: window.platformInverted;
            text: "Group";
            iconSource: platformInverted ? "../Images/Icons/tab_groups_w.svg" : "../Images/Icons/tab_groups.svg"
        }
    }

    TabGroup {
        anchors { left: parent.left; right: parent.right; top: tabBar.bottom; bottom: parent.bottom }

        IconsPage {
            id: iconsPage

            clip: true
        }

        TextPage {
            id: textPage

            clip: true
        }

        GroupPage {
            id: groupPage

            clip: true
        }

        onCurrentTabChanged: { currentTab.update() }
    }
}
