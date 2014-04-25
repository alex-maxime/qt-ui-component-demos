/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

ToolBarLayout {
    property bool itemsEnabled

    ToolButton {
        platformInverted: window.platformInverted
        flat: true
        iconSource: "toolbar-back"
        onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
    }

    ToolButton {
        platformInverted: window.platformInverted
        iconSource: platformInverted ? "../../Images/Icons/play_w.svg" : "../../Images/Icons/play.svg"
        checkable: true
    }

    ToolButton {
        platformInverted: window.platformInverted
        iconSource: platformInverted ? "../../Images/Icons/favourite_w.svg" : "../../Images/Icons/favourite.svg"
        checkable: true
        checked: true
    }

    ToolButton {
        platformInverted: window.platformInverted
        iconSource: "toolbar-menu"
    }
}
