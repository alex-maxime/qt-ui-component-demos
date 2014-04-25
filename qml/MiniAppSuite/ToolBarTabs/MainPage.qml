/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property int currentTabIndex: 0

    tools:  toolBarLayout

    ListModel {
        id: view1Model

        ListElement {
            name: "Item #1(A)"
        }
        ListElement {
            name: "Item #2(A)"
        }
        ListElement {
            name: "Item #3(A)"
        }
    }

    ListModel {
        id: view2Model

        ListElement {
            name: "Item #1(B)"
        }
        ListElement {
            name: "Item #2(B)"
        }
        ListElement {
            name: "Item #3(B)"
        }
        ListElement {
            name: "Item #4(B)"
        }
    }

    ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            iconSource: "toolbar-back"
            onClicked: window.pageStack.pop()
        }

        ButtonRow {
            id: row

            TabButton {
                id: view1Button;

                platformInverted: window.platformInverted
                text: "View A"
                tab: listView1
                onClicked: mainPage.currentTabIndex = 0;
            }

            TabButton {
                id: view2Button;

                platformInverted: window.platformInverted
                text: "View B"
                tab: listView2
                onClicked: mainPage.currentTabIndex = 1;
            }

            onCheckedButtonChanged: {
                if (checkedButton != children[currentTabIndex])
                    checkedButton = children[currentTabIndex];
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.TOOLBARTABS_INFOTEXT});
        }
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
                anchors.leftMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                mode: listItem.mode
                role: "Title"
                text: name
                width: parent.width
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ContentPage.qml"), { content: name });
            }
        }
    }

    Component{
        id: listHeader

        ListHeading {
            platformInverted: window.platformInverted
            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: "List header"
            }
        }
    }

    TabGroup{
        anchors.fill: parent

        ListView {
            id: listView1

            anchors.fill: parent
            model: view1Model
            header: listHeader
            delegate: delegate
        }

        ListView {
            id: listView2

            anchors.fill: parent
            model: view2Model
            header: listHeader
            delegate: delegate
        }
    }
}
