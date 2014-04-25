/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.EMPTYCONTENT_INFOTEXT

    tools: toolBarBackAndInfo

    ListModel{
        id: mainViewListModel

        ListElement{
            title: "Example 1"
            subTitle: ""
            section: "Basic information"
        }
        ListElement{
            title: "Example 2"
            subTitle: "Last access: 12.2.2012, (empty)"
            section: "Anticipatory information"
        }
        ListElement{
            title: "From Toolbar"
            subTitle: ""
            section: "Content generation support"
        }
        ListElement{
            title: "From Content area"
            subTitle: ""
            section: "Content generation support"
        }
    }

    Component {
        id: delegate

        ListItem {
            id: listItem
            platformInverted: window.platformInverted
            subItemIndicator: true

            Column{
                anchors.left: parent.paddingItem.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                ListItemText {
                    id: titleLabel
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: title
                }

                ListItemText {
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "SubTitle"
                    text: subTitle
                    width: parent.width
                    visible: text != ""
                }
            }

            onClicked: {
                switch(index) {
                case 0:
                    window.pageStack.push(Qt.resolvedUrl("EventsPage.qml"));
                    break
                case 1:
                    window.pageStack.push(Qt.resolvedUrl("ContentPage.qml"));
                    break
                case 2:
                    window.pageStack.push(Qt.resolvedUrl("ContentPage.qml"), {fromToolBarMode: true});
                    break
                case 3:
                    window.pageStack.push(Qt.resolvedUrl("ContentPage.qml"), {fromContentAreaMode: true});
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
