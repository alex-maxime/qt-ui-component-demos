/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: subListPage

    property string infoText: Constants.TABS_INFOTEXT

    property QtObject modelListContainer
    property string parentListName

    tools: toolBarBackAndInfo

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted
            subItemIndicator: true

            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                platformInverted: window.platformInverted
                id: itemText
                mode: listItem.mode
                role: "Title"
                text: parentListName + "-" + title
                width: parent.width
            }

            onClicked: {
                window.pageStack.push(Qt.resolvedUrl("ContentPage.qml"), { content: contentText,
                                          headerText: itemText.text});
            }
        }
    }

    ListView {
        id: listView

        anchors.fill: parent
        header:
            ListHeading {
            platformInverted: window.platformInverted
                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: parentListName
                }
            }

        delegate: delegate
    }

    onModelListContainerChanged: {
        listView.model = modelListContainer.values
    }
}
