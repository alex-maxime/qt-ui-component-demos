/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.DRILLDOWN_INFOTEXT

    tools: toolBarBackAndInfo

    Model{
        id: dataModel
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
                mode: listItem.mode
                role: "Title"
                text: title
                width: parent.width
            }
            onClicked: {
                window.pageStack.push(Qt.resolvedUrl("SubListPage.qml"), { modelListContainer: subListContainer,
                                                                           parentListName: itemText.text});
            }
        }
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: dataModel.listsModel
        header:
            ListHeading {
            platformInverted: window.platformInverted
                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Drill down start list"
                }
            }
        delegate: delegate
    }
}
