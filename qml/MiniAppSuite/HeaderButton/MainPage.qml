/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    tools:  sharedToolBar
    state: "LIST_VIEW_STATE"

    ToolBar {
        id: sharedToolBar

        tools: mainToolBarLayout
        platformInverted: window.platformInverted
    }

    ToolBarLayout {
        id: listToolbar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? window.pageStack.pop() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-previous"
            platformInverted: window.platformInverted
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-next"
            platformInverted: window.platformInverted
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.HEADERBUTTON_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: mapToolbar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? window.pageStack.pop() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-home"
            platformInverted: window.platformInverted
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-list"
            platformInverted: window.platformInverted
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.HEADERBUTTON_INFOTEXT});
        }
    }

    ListModel {
        id: listModel

        ListElement {
            name: "Item #1-1"
        }
        ListElement {
            name: "Item #1-2"
        }
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted
            subItemIndicator: true

            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Title"
                text: name
                width: parent.width
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("ItemContentPage.qml"), {content: name});
            }
        }
    }

    ListHeading {
        id: header

        height: 60
        anchors.top: parent.top
        platformInverted: window.platformInverted

        z: 1

        ListItemText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: platformStyle.paddingLarge
            platformInverted: window.platformInverted
            font.pixelSize: platformStyle.fontSizeLarge
            role: "Heading"
            text: "Header"
        }

        Button{
            id: switchViewButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingLarge
            platformInverted: window.platformInverted
            iconSource: "../Images/Icons/map.svg"

            onClicked: {
                if (mainPage.state == "LIST_VIEW_STATE")
                    mainPage.state = "MAP_VIEW_STATE";
                else
                    mainPage.state=  "LIST_VIEW_STATE"
            }
        }
    }

    Flipable{
        id: flipable

        property bool flipped: false

        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        width: parent.width

        front:
            ListView {
            anchors.fill: parent
            width: parent.width
            model: listModel
            delegate: delegate
        }
        back:
            Image {
            id: mapImage
            anchors.fill: parent
            source: mainPage.height > mainPage.width ? "../Images/map_image_portrait.png" : "../Images/map_image_landscape.png"
            width: parent.width

            LandmarkDelegate{
                x: 60
                y: 160
                text: "Item #1-1"
                visible: mainPage.height > mainPage.width
            }

            LandmarkDelegate{
                x: 170
                y: 270
                text: "Item #1-2"
                visible: mainPage.height > mainPage.width
            }

            LandmarkDelegate{
                x: 150
                y: 20
                text: "Item #1-1"
                visible: mainPage.height < mainPage.width
            }

            LandmarkDelegate{
                x: 250
                y: 150
                text: "Item #1-2"
                visible: mainPage.height < mainPage.width
            }
        }

        transform: Rotation {
            id: rotation

            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0;
            axis.y: 1;
            axis.z: 0
            angle: 0
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: -180 }
            when: flipable.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 300 }
        }
    }


    states: [
        State {
            name: "MAP_VIEW_STATE"
        },
        State {
            name: "LIST_VIEW_STATE"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);

        if (state == "LIST_VIEW_STATE") {
            switchViewButton.iconSource = "../Images/Icons/map.svg"
            flipable.flipped = false;
            sharedToolBar.setTools(listToolbar);
        }
        else {
            switchViewButton.iconSource = "../Images/Icons/notes.svg"
            flipable.flipped = true;
            sharedToolBar.setTools(mapToolbar);
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Inactive)
            state = "LIST_VIEW_STATE";
    }
}
