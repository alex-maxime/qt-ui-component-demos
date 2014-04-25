/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../../Constants.js" as Constants

Item {
    id: iconsPage

    property int currentIndex: 0

    function update() {
        updateToolbar(iconsListModel.get(currentIndex).toolbar, iconsListModel.get(currentIndex).itemsEnabled)
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
        id: iconsListModel

        ListElement {
            itemText: "No function"
            toolbar: ""
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 function"
            toolbar: "ToolBar1Function"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 functions"
            toolbar: "ToolBar2Function"
            itemsEnabled: true
        }
        ListElement {
            itemText: "3 functions"
            toolbar: "ToolBar3Function"
            itemsEnabled: true
        }
        ListElement {
            itemText: "View menu only"
            toolbar: "ToolBarMenu"
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 function + view menu"
            toolbar: "ToolBarMenu1Function"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 functions + view menu"
            toolbar: "ToolBarMenu2Function"
            itemsEnabled: true
        }
        ListElement {
            itemText: "1 latch down function"
            toolbar: "ToolBar1LatchFunction"
            itemsEnabled: true
        }
        ListElement {
            itemText: "2 latch down functions + VM"
            toolbar: "ToolBar2LatchFunction"
            itemsEnabled: true
        }

        ListElement {
            itemText: "1 function, disabled"
            toolbar: "ToolBar1Function"
            itemsEnabled: false
        }
        ListElement {
            itemText: "2 functions, disabled"
            toolbar: "ToolBar2Function"
            itemsEnabled: false
        }
        ListElement {
            itemText: "3 functions, disabled"
            toolbar: "ToolBar3Function"
            itemsEnabled: false
        }
        ListElement {
            itemText: "VM only, disabled"
            toolbar: "ToolBarMenu"
            itemsEnabled: false
        }
        ListElement {
            itemText: "1 function + VM, disabled"
            toolbar: "ToolBarMenu1Function"
            itemsEnabled: false
        }
        ListElement {
            itemText: "2 functions + VM, disabled"
            toolbar: "ToolBarMenu2Function"
            itemsEnabled: false
        }
    }

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
                id: listView

                width: parent.width
                interactive: false

                height: 70 * count

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
                model: iconsListModel
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
