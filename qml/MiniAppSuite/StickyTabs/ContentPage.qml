/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: contentPage

    property string headerText
    property string content

    ListHeading {
        platformInverted: window.platformInverted
        ListItemText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            platformInverted: window.platformInverted
            role: "Heading"
            text: headerText
        }
    }

    Label{
        anchors.centerIn: parent
        platformInverted: window.platformInverted
        text: content
    }
}

