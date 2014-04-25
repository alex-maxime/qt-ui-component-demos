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

    ButtonRow {
        checkedButton: list
        ToolButton {
            id: list
            platformInverted: window.platformInverted
            text: "List"
            enabled: itemsEnabled
        }
        ToolButton {
            platformInverted: window.platformInverted
            text: "Map"
            enabled: itemsEnabled
        }
    }



    ToolButton {
        platformInverted: window.platformInverted
        iconSource: "toolbar-menu"
    }
}
