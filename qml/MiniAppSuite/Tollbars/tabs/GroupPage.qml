/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../../Constants.js" as Constants

Item {
    id: groupPage

    property int currentIndex: 0

    function update() {
        updateToolbar(textListModel.get(currentIndex).toolbar, textListModel.get(currentIndex).itemsEnabled)
    }

    function updateToolbar(source, enabled) {
        if (source == "")
            sharedToolbar.setTools(toolBarBack)
        else {
            var component = Qt.createComponent("../toolbars/"+source+".qml")
            var toolbarObject = component.createObject(toolbarPage, {itemsEnabled: enabled})
            sharedToolbar.setTools(toolbarObject)
        }
    }

    anchors.fill: parent
    height: flickable.contentHeight

    ListModel {
        id: textListModel

        ListElement {
            itemText: "No function"
            toolbar: ""
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 grouped text buttons"
            toolbar: "ToolBarGrouped2TextButton"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 grouped icon buttons"
            toolbar: "ToolBarGrouped2IconButton"
            itemsEnabled: true
        }
        ListElement {
            itemText: "3 grouped icon buttons"
            toolbar: "ToolBarGrouped3IconButton"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 grp txt btn + VM"
            toolbar: "ToolBarGrouped2TextButtonVM"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 grp icon btn + VM"
            toolbar: "ToolBarGrouped2IconButtonVM"
            itemsEnabled: true
        }
    }

    CheckableGroup {
        id: checkableGroup
    }

    ToolBarLayout {
        id: toolBaro

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            text: "oo uu"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
    }

    Flickable{
        id: flickable

        contentHeight: col.implicitHeight + platformStyle.paddingLarge
        width: parent.width
        height: parent.height

        Column{
            id: col
            width: parent.width
            spacing: platformStyle.paddingLarge

            ListView {
                id: listView

                width: parent.width
                interactive: false

                height: Constants.DEFAULT_LIST_ITEM_HEIGHT * count

                Component {
                    id: listDelegate

                    ListItem {
                        id: listItem

                        function updateToolBar() {
                            updateToolbar(toolbar, itemsEnabled)
                            currentIndex = index
                        }

                        height: Constants.DEFAULT_LIST_ITEM_HEIGHT

                        ListItemText {
                            anchors.left: listItem.paddingItem.left
                            anchors.verticalCenter: listItem.paddingItem.verticalCenter
                            platformInverted: window.platformInverted
                            mode: listItem.mode
                            role: "Title"
                            text: itemText
                        }

                        RadioButton {
                            id: radioButton

                            anchors.right: listItem.paddingItem.right
                            anchors.verticalCenter: listItem.paddingItem.verticalCenter
                            platformInverted: window.platformInverted
                            platformExclusiveGroup: checkableGroup
                            onClicked: updateToolBar()
                        }

                        onClicked: {
                            updateToolBar()
                            radioButton.checked = true
                        }
                    }
                }

                delegate: listDelegate
                model: textListModel
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Info page"
                platformInverted: window.platformInverted
                onClicked: window.pageStack.push(Qt.resolvedUrl("../../InfoPage.qml"), {text: Constants.TOOLBARS_INFOTEXT});
            }
        }
    }
}
