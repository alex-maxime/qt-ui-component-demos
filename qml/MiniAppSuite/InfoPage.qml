/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: infoPage

    property alias text: label.text

    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
    }

    Flickable{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width - 2 * platformStyle.paddingLarge

        contentHeight: label.paintedHeight

        Label{
            id: label

            anchors.top: parent.top
            width: parent.width
            platformInverted: window.platformInverted
            wrapMode: Text.WordWrap

            onLinkActivated: {
                console.log(link + " link activated")
                Qt.openUrlExternally(link);
            }
        }
    }
}
