/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.TABS_INFOTEXT

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

    TabBarLayout {
        id: tabBar

        z: 1
        anchors { left: parent.left; right: parent.right; top: parent.top }
        TabButton { tab: listView1; platformInverted: window.platformInverted; text: "View A" }
        TabButton { tab: listView2; platformInverted: window.platformInverted; text: "View B" }
        TabButton { tab: listView3; platformInverted: window.platformInverted; text: "View C" }
        TabButton { tab: listView4; platformInverted: window.platformInverted; text: "View D" }
    }

    TabGroup {
        id: tabGroup

        anchors { left: parent.left; right: parent.right; top: tabBar.bottom; bottom: parent.bottom }

        // define the content for tab 1
        ListView {
            id: listView1

            anchors.fill: parent
            model: dataModel.tab1ListModel
            delegate: delegate
        }

        // define the content for tab 2
        ListView {
            id: listView2

            anchors.fill: parent
            model: dataModel.tab2ListModel
            delegate: delegate
        }

        // define content for tab 3
        ListView {
            id: listView3

            anchors.fill: parent
            model: dataModel.tab3ListModel
            delegate: delegate
        }

        // define content for tab 4
        ListView {
            id: listView4

            anchors.fill: parent
            model: dataModel.tab4ListModel
            delegate: delegate
        }
    }
}
