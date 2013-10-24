/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.SEARCH_INFOTEXT

    tools: toolBarBackAndInfo

    ListModel{
        id: mainViewListModel

        ListElement{title: "Search field always present"}
        ListElement{title: "Search command in the toolbar"}
        ListElement{title: "Filtering search result"}
        ListElement{title: "Non-progressive search"}
        ListElement{title: "Find next"}
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
                    window.pageStack.push(Qt.resolvedUrl("ContactsSearchPage.qml"));
                    break
                case 1:
                    window.pageStack.push(Qt.resolvedUrl("ContactsSearchPage.qml"), {toolbarMode: true});
                    break
                case 2:
                    window.pageStack.push(Qt.resolvedUrl("ContactsSearchAndFilterPage.qml", {toolbarMode: true, nonProgressiveSearchMode: true}));
                    break                    
                case 3:
                    window.pageStack.push(Qt.resolvedUrl("ContactsSearchPage.qml"), {toolbarMode: true, nonProgressiveSearchMode: true});
                    break
                case 4:
                    window.pageStack.push(Qt.resolvedUrl("FindTextPage.qml"));
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
