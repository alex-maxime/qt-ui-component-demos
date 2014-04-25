/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../Constants.js" as Constants

Page {
    id: page

    property int selectedItemIndex: 0
    property bool pageCompleted: false

    signal itemSelected(int index)

    tools: toolbar

    ToolBarLayout {
        id: toolbar

        ToolButton {
            flat: true
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.DIALOGS_INFOTEXT});
        }
    }

    CheckableGroup{
        id: group
    }

    Component {
        id: delegate

        ListItem {
            id: listItem
            platformInverted: window.platformInverted
            Column{
                anchors.fill: parent.paddingItem

                ListItemText {
                    role: "Title"
                    platformInverted: window.platformInverted
                    text: value
                    width: parent.width
                }
            }

            RadioButton {
                id: radioButton

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.paddingItem.right
                platformInverted: window.platformInverted

                platformExclusiveGroup: group

                checked: selectedItemIndex == index
            }

            onClicked: {
                radioButton.checked = true
                if (pageCompleted) {
                    pageStack.pop()
                    itemSelected(index)
                }
            }
        }
    }

    ScrollDecorator{
        flickableItem: listView
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: model2
        delegate: delegate
        cacheBuffer: contentHeight
    }

    Component.onCompleted: {
        pageCompleted = true
    }
}
