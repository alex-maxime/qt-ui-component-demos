/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string text;
    property QtObject exclusiveGroup
    property alias checked: radioButton.checked

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

    RadioButton {
        id: radioButton

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        enabled: parent.enabled
        platformInverted: window.platformInverted
        platformExclusiveGroup: root.exclusiveGroup
    }
}
