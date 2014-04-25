/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string text: ""

    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent.paddingItem

    Column {
        anchors.left: parent.left

        ListItemText {
            anchors.left: parent.left
            platformInverted: window.platformInverted
            role: "Title"
            text: root.text
        }

        ProgressBar {
            anchors.left: parent.left
            platformInverted: window.platformInverted
            width: root.width
            minimumValue: 0
            maximumValue: 100
            value:50
        }
    }
}
