/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: contentPage

    property string infoText: Constants.TABS_INFOTEXT

    property string headerText
    property string content

    tools: toolBarBackAndInfo

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

