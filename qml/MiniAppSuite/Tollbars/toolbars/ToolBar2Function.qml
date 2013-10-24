/**
 * Copyright (c) 2012 Nokia Corporation.
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
        iconSource: platformInverted ?
                        (enabled ? "../../Images/Icons/attach_w.svg" :  "../../Images/Icons/attach_w_disabled.svg" ):
                        (enabled ? "../../Images/Icons/attach.svg" : "../../Images/Icons/attach_disabled.svg")
        enabled: itemsEnabled
    }

    ToolButton {
        platformInverted: window.platformInverted
        iconSource: platformInverted ?
                        (enabled ? "../../Images/Icons/favourite_w.svg" :  "../../Images/Icons/favourite_w_disabled.svg" ):
                        (enabled ? "../../Images/Icons/favourite.svg" : "../../Images/Icons/favourite_disabled.svg")
        enabled: itemsEnabled
    }
}
