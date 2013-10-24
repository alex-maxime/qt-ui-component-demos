/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../../Constants.js" as Constants

Item {
    id: textPage

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
            itemText: "Sub task view, 1 button"
            toolbar: "ToolBarSubTask1Button"
            itemsEnabled: true
        }
        ListElement {
            itemText: "Sub task view, 2 buttons"
            toolbar: "ToolBarSubTask2Button"
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 button"
            toolbar: "ToolBar1Button"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 buttons"
            toolbar: "ToolBar2Button"
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 button latch down"
            toolbar: "ToolBar1LatchButton"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 buttons latch down"
            toolbar: "ToolBar2LatchButton"
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 button + view menu"
            toolbar: "ToolBar1ButtonVM"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 buttons + view menu"
            toolbar: "ToolBar2ButtonVM"
            itemsEnabled: true
        }

        ListElement {
            itemText: "1 button, disabled"
            toolbar: "ToolBar1Button"
            itemsEnabled: false
        }
        ListElement {
            itemText: "2 buttons, disabled"
            toolbar: "ToolBar2Button"
            itemsEnabled: false
        }
        ListElement {
            itemText: "1 button + VM, disabled"
            toolbar: "ToolBar1ButtonVM"
            itemsEnabled: false
        }
        ListElement {
            itemText: "2 buttons + VM, disabled"
            toolbar: "ToolBar2ButtonVM"
            itemsEnabled: false
        }    }

    CheckableGroup {
        id: checkableGroup
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
                width: parent.width
                height: 70 * count

                interactive: false

                Component {
                    id: listDelegate

                    ListItem {
                        id: listItem

                        function updateToolBar() {
                            updateToolbar(toolbar, itemsEnabled)
                            currentIndex = index
                        }

                        height: 70

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
