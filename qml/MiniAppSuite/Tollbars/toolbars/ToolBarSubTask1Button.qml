/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

ToolBarLayout {
    property bool itemsEnabled

    ToolButton {
        visible: false
    }

    ToolButton {
        platformInverted: window.platformInverted
        text: "Send"
    }

    ToolButton {
        visible: false
    }
}
