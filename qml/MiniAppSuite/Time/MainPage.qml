/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.TIME_INFOTEXT

    tools: toolBarBackAndInfo

    ListModel{
        id: mainViewListModel

        ListElement{title: "Item view with time stamp"}
        ListElement{title: "Sub list header with timestamps"}
        ListElement{title: "List item with timestamps"}
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted
            subItemIndicator: true

            ListItemText {
                id: itemText

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                platformInverted: window.platformInverted
                role: "Title"
                text: title
                width: parent.width
            }
            onClicked: {
                switch(index) {
                case 0:
                    window.pageStack.push(Qt.resolvedUrl("ItemViewPage.qml"));
                    break
                case 1:
                    window.pageStack.push(Qt.resolvedUrl("ListPage.qml"), {timestampHeaders: true});
                    break
                case 2:
                    window.pageStack.push(Qt.resolvedUrl("ListPage.qml"), {timestampHeaders: false});
                    break
                }
            }
        }
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: mainViewListModel
        delegate: delegate
    }
}
