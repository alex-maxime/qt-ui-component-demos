/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    tools: toolBar

    ToolBarLayout {
        id: toolBar

        ToolButton {
            platformInverted: window.platformInverted
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.ARRANGE_INFOTEXT});
        }
    }

    ListModel {
        id: dataModel
        ListElement {title: "Sort list items"}
        ListElement {title: "Sort grid items"}
        ListElement {title: "Sort and remove list items"}
        ListElement {title: "Sort and remove grid items"}
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

                role: "Title"
                platformInverted: window.platformInverted
                text: title
                width: parent.width
            }

            onClicked: {
                switch(index) {
                case 0:
                    pageStack.push(Qt.resolvedUrl("ListViewPage.qml"))
                    break;
                case 1:
                    pageStack.push(Qt.resolvedUrl("GridViewPage.qml"))
                    break;
                case 2:
                    pageStack.push(Qt.resolvedUrl("ListViewPage.qml"), {deleteMode: true})
                    break;
                case 3:
                    pageStack.push(Qt.resolvedUrl("GridViewPage.qml"), {deleteMode: true})
                    break;
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: dataModel
        delegate: delegate
    }
}
