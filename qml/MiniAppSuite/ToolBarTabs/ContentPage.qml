/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: contentPage

    property string headerText
    property string content

    tools:
        ToolBarLayout {
            id: toolBarLayout

            ToolButton {
                flat: true
                platformInverted: window.platformInverted
                iconSource: "toolbar-back"
                onClicked: pageStack.pop()
            }

            ToolButton {
                flat: true
                iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
                platformInverted: window.platformInverted
                onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.TOOLBARTABS_INFOTEXT});
            }
        }


    ListHeading {
        id: header

        platformInverted: window.platformInverted

        ListItemText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            platformInverted: window.platformInverted
            role: "Heading"
            text: "List header"
        }
    }

    Label{
        anchors {
            top: header.bottom
            topMargin: 20
            left: parent.left
            leftMargin: 10
        }

        platformInverted: window.platformInverted

        text: content
    }
}

