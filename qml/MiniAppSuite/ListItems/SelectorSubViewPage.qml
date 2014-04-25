/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1

Page {
    id: mainPage

    property bool checkableMode: false
    property string selectedValue
    property string initialValue

    tools: checkableMode ? checkableModeToolBar : selectableModeToolBar
    state: "NORMAL"

    function getItemValue(index) {
        return model.get(index);
    }

    ToolBarLayout {
        id: checkableModeToolBar

        ToolButton {
            platformInverted: window.platformInverted
            text: "Done"
            onClicked: {
                selectionItem.subTitle = selectedValue;
                pageStack.pop();
            }
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: {
                pageStack.pop();
                listModel.setCheckedExclusively(initialValue);
                selectedValue = initialValue;
            }
        }
    }

    ToolBarLayout {
        id: selectableModeToolBar

        ToolButton {
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: pageStack.pop();
        }
    }

    ListModel {
        id: listModel

        function setCheckedExclusively(value) {
            for (var i = 0; i< count ;i++) {
                if (get(i).value == value)
                    setProperty(i, "itemChecked", true);
                else
                    setProperty(i, "itemChecked", false);
            }
        }

        ListElement { value: "Value is one";  itemChecked: true}
        ListElement { value: "Value is two";  itemChecked: false}
        ListElement { value: "Value is three";  itemChecked: false}
        ListElement { value: "Value is four";  itemChecked: false}
        ListElement { value: "Value is five";  itemChecked: false}
        ListElement { value: "Value is six";  itemChecked: false}
        ListElement { value: "Value is seven";  itemChecked: false}
        ListElement { value: "Value is eight";  itemChecked: false}
        ListElement { value: "Value is nine";  itemChecked: false}
        ListElement { value: "Value is ten";  itemChecked: false}
    }

    CheckableGroup{
        id: checkableGroup
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted

            ListItemText {
                id: itemText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Title"
                text: value
            }

            RadioButton{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                checked: itemChecked
                platformExclusiveGroup: checkableGroup
                visible: checkableMode

                onCheckedChanged: {
                    listModel.setProperty(index, "itemChecked", checked);

                    if (checked)
                        selectedValue = value;
                }

                onVisibleChanged: {
                    checked = itemChecked;
                }
            }

            onClicked: {
                if (!checkableMode) {
                    selectionItem.subTitle = value;
                    pageStack.pop();
                }
            }
        }
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: listModel
        delegate: delegate
    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            initialValue = selectedValue;
        }
    }
}
