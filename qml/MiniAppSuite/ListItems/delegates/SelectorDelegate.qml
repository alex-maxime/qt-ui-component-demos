/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

SelectionListItem {
    id: selectionItem

    property string itemText: ""
    property bool oneLineMode: true
    property bool dialogMode: true
    property bool checkableSubViewMode: true

    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent

    platformInverted: window.platformInverted
    enabled: parent.enabled
    title: titleText()
    subTitle: subTitleText()
    onClicked: {
        if (dialogMode)
            selectionDialog.open()
        else
            pageStack.push(selectorSubViewPage, { checkableMode: checkableSubViewMode});
    }

    ListModel {
        id: model
        ListElement { value: "Value is one" }
        ListElement { value: "Value is two" }
        ListElement { value: "Value is three" }
    }

    SelectionDialog {
        id: selectionDialog
        platformInverted: window.platformInverted
        titleText: "Select one of the values"
        selectedIndex: 0
        model: model
    }

    SelectorSubViewPage{
        id: selectorSubViewPage
    }

    function titleText() {
        if (!oneLineMode)
            return itemText;

        return selectionDialog.selectedIndex >= 0
                ? selectionDialog.model.get(selectionDialog.selectedIndex).value
                : "Value is one"
    }

    function subTitleText() {
        if (oneLineMode)
            return "";

        if (dialogMode) {
            return selectionDialog.selectedIndex >= 0
                    ? selectionDialog.model.get(selectionDialog.selectedIndex).value
                    : "Value is one"
        }
        else {
            return selectorSubViewPage.getItemValue(0).value;
        }
    }
}

