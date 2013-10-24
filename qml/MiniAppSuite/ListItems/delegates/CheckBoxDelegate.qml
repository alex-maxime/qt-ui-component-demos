/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string text;
    property alias checked: checkBox.checked

    enabled: parent.enabled

    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent.paddingItem

    ListItemText {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        platformInverted: window.platformInverted
        role: "Title"
        text: root.text
    }

    CheckBox {
        id: checkBox

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        enabled: parent.enabled
        platformInverted: window.platformInverted
    }
}
