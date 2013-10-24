/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: page

    property string infoText: Constants.EMPTYCONTENT_INFOTEXT
    property string contentText: ""
    property bool fromToolBarMode: false
    property bool fromContentAreaMode: false

    state: "NORMAL"

    tools: {
        if (fromToolBarMode)
            return toolBarWithAddButton

        if (fromContentAreaMode)
            return sharedToolBar

        return toolBarBackAndInfo
    }

    ToolBar {
        id: sharedToolBar

        tools: fromContentMainToolBar
        platformInverted: window.platformInverted

        visible: fromContentAreaMode
    }

    ToolBarLayout {
        id: fromContentMainToolBar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            iconSource: platformInverted ? "../Images/Icons/attach_w.svg" : "../Images/Icons/attach.svg"
        }

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            iconSource: platformInverted ? "../Images/Icons/favourite_w.svg" : "../Images/Icons/favourite.svg"
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.EMPTYCONTENT_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: fromContentEditToolBar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            text: "Done"
            platformInverted: window.platformInverted
            onClicked:{
                page.state = "NORMAL"
            }
        }

        ToolButton {
            text: "Cancel"
            platformInverted: window.platformInverted
            onClicked:{
                page.state = "NORMAL"
                contentText = ""
            }
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-add"
            platformInverted: window.platformInverted
            onClicked: {
                if (contentText.length < 5 * Constants.LOREM_IPSUM_TEXT.length )
                    contentText += Constants.LOREM_IPSUM_TEXT
            }
        }
    }

    ToolBarLayout {
        id: toolBarWithAddButton

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-add"
            platformInverted: window.platformInverted
            onClicked: {
                if (contentText.length < 5 * Constants.LOREM_IPSUM_TEXT.length )
                    contentText += Constants.LOREM_IPSUM_TEXT
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.EMPTYCONTENT_INFOTEXT});
        }
    }

    ScrollDecorator{
        flickableItem: flickable
    }

    Flickable{
        id: flickable

        anchors.fill: parent

        contentHeight: label.implicitHeight + 2 * label.anchors.margins

        Label{
            id: label

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left

            anchors.margins: platformStyle.paddingLarge
            platformInverted: window.platformInverted;
            wrapMode: Text.WordWrap
            horizontalAlignment: anchors.mirrored ? Text.AlignRight : Text.AlignLeft
            text: contentText
        }
    }

    Column{
        anchors.centerIn: parent
        width: parent.width
        visible: contentText == "" && page.state == "NORMAL"
        spacing: platformStyle.paddingLarge

        Label{
            width: parent.width
            platformInverted: window.platformInverted;
            font.pixelSize: 2 * platformStyle.fontSizeLarge
            wrapMode: Text.WordWrap
            horizontalAlignment: "AlignHCenter"

            text: "No example content"
        }

        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            platformInverted: window.platformInverted;
            visible: fromContentAreaMode
            width: page.width/2

            iconSource: platformInverted ? "../Images/Icons/add_w.svg" : "../Images/Icons/add.svg"

            onClicked: {
                page.state = "CONTENT_EDIT"
            }
        }
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "CONTENT_EDIT"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);

        if (state == "NORMAL") {
            sharedToolBar.setTools(fromContentMainToolBar);
        }
        else
            sharedToolBar.setTools(fromContentEditToolBar);
    }
}
