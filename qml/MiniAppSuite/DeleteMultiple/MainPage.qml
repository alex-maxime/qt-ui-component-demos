/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property int checkedItemsCount: 0

    tools: sharedToolBar
    state: "NORMAL"

    ToolBar {
        id: sharedToolBar

        tools: mainToolBarLayout
        platformInverted: window.platformInverted
    }

    ToolBarLayout {
        id: mainToolBarLayout

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? window.pageStack.pop() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-delete"
            platformInverted: window.platformInverted
            onClicked: {
                mainPage.state = "DELETE";
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.DELETEMULTIPLE_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: deleteModeToolBarLayout

        ToolButton {
            id: deleteButton;
            platformInverted: window.platformInverted
            text: "Delete"
            enabled: checkedItemsCount > 0
            onClicked:{
                queryDialog.open();
            }
        }

        ToolButton {
            id: cancelButton;
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: mainPage.state = "NORMAL";
        }
    }

    DataModel{
        id: listModel
    }

    DeleteQueryDialog{
        id: queryDialog
    }

    InfoBanner{
        id: banner
        platformInverted: window.platformInverted
        timeout: 5000
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
                    text: name
                    width: parent.width
                }
                ListItemText {
                    role: "SubTitle"
                    platformInverted: window.platformInverted
                    text: "2nd line"
                    width: parent.width
                }
            }

            CheckBox {
                id: checkBox

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.paddingItem.right
                platformInverted: window.platformInverted
                checked: isChecked
                visible: mainPage.state == "DELETE"

                onCheckedChanged: {
                    if (checked)
                        checkedItemsCount++;
                    else
                        checkedItemsCount--;

                    listModel.setProperty(index, "isChecked", checked);
                }

                onVisibleChanged: {
                    checked = isChecked;
                }
            }

            onClicked: {
                if (mainPage.state == "DELETE")
                    checkBox.checked = !checkBox.checked
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: listModel
        delegate: delegate
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "DELETE"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);

        if (state == "NORMAL") {
            sharedToolBar.setTools(mainToolBarLayout);
            listModel.uncheckAllItems();
        }
        else
            sharedToolBar.setTools(deleteModeToolBarLayout);
    }
}
