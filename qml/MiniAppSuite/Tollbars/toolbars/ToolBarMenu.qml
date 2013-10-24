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
        iconSource: enabled ? "toolbar-menu" : platformInverted ? "../../Images/Icons/options_w_disabled.svg" : "../../Images/Icons/options_disabled.svg"
        enabled: itemsEnabled
    }
}
