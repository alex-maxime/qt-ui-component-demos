/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

ToolBarLayout {
    property bool itemsEnabled

    ToolButton {
        flat: true
        platformInverted: window.platformInverted
        iconSource: "toolbar-back"
        onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
    }

    ToolButton {
        platformInverted: window.platformInverted
        text: "Send"
        enabled: itemsEnabled
    }

    ToolButton {
        visible: false
    }
}
