/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: page

    property bool deleteMode: false

    tools: SharedToolBar{id: sharedToolBar}

    state: "NORMAL"

    function countRowForIndex(itemIndex) {
        return Math.floor(itemIndex / flickableView.colsNumber)
    }

    Component {
        id: itemDelegate
        Item {
            id: main

            height: flickableView.cellHeight
            width: flickableView.cellWidth

            Rectangle{
                id: backgroundRect

                anchors.fill: parent
                visible: page.state == "SORTING"

                color: mouseArea.draggedItemId == itemId ? ( window.platformInverted ? "black" :"white" ) : "transparent"
                border.color: window.platformInverted ? "black" :"white"
                opacity: 0.3
                border.width: 1
            }

            Item {
                id: item;

                property bool isDragged: mouseArea.draggedItemId == itemId

                parent: mouseArea

                width: main.width; height: main.height ;
                x: isDragged ? mouseArea.mouseX - width/2 : main.x - flickableView.contentX

                y: {
                    if (isDragged) {
                        if (mouseArea.mouseY > flickableView.height)
                            return flickableView.height - height/2
                        if (mouseArea.mouseY < 0)
                            return - height/2

                        return mouseArea.mouseY - height/2
                    }
                    else{
                        return flickableView.cellHeight * (countRowForIndex(index)) - flickableView.contentY
                    }
                }

                Image{
                    id: thumbnail

                    anchors.top: parent.top
                    anchors.topMargin: platformStyle.paddingMedium
                    anchors.horizontalCenter: parent.horizontalCenter

                    height: item.height > item.width ? item.width - 2 * platformStyle.paddingLarge :
                    item.height - 4 * platformStyle.paddingLarge
                    width: height

                    source: "../Images/Icons/list_" + itemId + ".svg"
                }

                Label {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: platformStyle.paddingLarge
                    text: "Item " + itemId;
                    platformInverted: window.platformInverted;
                    font.pixelSize: 15
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Item{
                    id: deleteCheckboxExtendedArea

                    height: deleteCheckbox.width + 2 * platformStyle.paddingMedium
                    width: deleteCheckbox.width + 2 * platformStyle.paddingMedium

                    anchors.top: parent.top
                    anchors.right: parent.right

                    Image{
                        id: deleteCheckbox

                        property bool checked: isChecked

                        anchors.centerIn: parent

                        width: platformStyle.graphicSizeSmall
                        height: platformStyle.graphicSizeSmall

                        visible: deleteMode && page.state == "SORTING"

                        source: {
                            if (checkboxMouseArea.pressed)
                                return "../Images/Icons/x-pressed.svg"

                            return checked ? "../Images/Icons/x-marked.svg" :
                                             "../Images/Icons/qgn_prop_checkbox_off.svg"
                        }

                        onVisibleChanged: {
                            checked = isChecked
                        }

                        onCheckedChanged: {
                            dataModel.setProperty(index, "isChecked", checked);
                        }
                    }

                    MouseArea{
                        id: checkboxMouseArea
                        anchors.fill: parent

                        onClicked: {
                            deleteCheckbox.checked = !deleteCheckbox.checked
                        }
                    }
                }

                Behavior on y {
                    enabled: (mouseArea.isAnyItemDragged && !item.isDragged) /*|| (page.state == "NORMAL" && !flickableView.moving)*/;
                    NumberAnimation {id: yAnimation; duration: 200; easing.type: Easing.OutQuart }
                }

                Behavior on x {
                    enabled: (mouseArea.isAnyItemDragged && !item.isDragged) /*|| (page.state == "NORMAL" && !flickableView.moving)*/;
                    NumberAnimation {id: xAnimation; duration: 200; easing.type: Easing.OutQuart }
                }

                onIsDraggedChanged: {
                    if (isDragged) {
                        console.log("Activated item: " + itemId)
                        item.z = 10

                        if (yAnimation.running)
                            yAnimation.complete()

                        if (xAnimation.running)
                            xAnimation.complete()
                    }
                    else{
                        item.z = 1
                    }
                }
            }
        }
    }

    ListHeading {
        id: header
        anchors.top: parent.top
        width: parent.width
        platformInverted: window.platformInverted;
        z: 3

        Label{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin:  platformStyle.paddingLarge
            platformInverted: window.platformInverted;
            text: page.state == "NORMAL" ? "Grid header" : (deleteMode ? "Sort and remove" : "Sort")
        }
    }

    Item{

        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        ScrollBar{
            id: scrollBar
            anchors.right: parent.right
            flickableItem: flickableView
            interactive: true
            policy: Symbian.ScrollBarWhenNeeded
            visible: flickableView.contentHeight > flickableView.height ? 1 : 0
            opacity: 1
            width: 15
            z: 11

            onVisibleChanged: {
                scrollBar.opacity = 1
            }
        }

        GridView {
            id: flickableView

            property int colsNumber: height > width ? Constants.GRID_COLS_PER_SCREEN_VERTICAL :
                                                      Constants.GRID_COLS_PER_SCREEN_HORIZONTAL

            property int rowsNumber: height > width ? Constants.GRID_ROWS_PER_SCREEN_VERTICAL :
                                                      Constants.GRID_ROWS_PER_SCREEN_HORIZONTAL

            property bool itemsDeletionInProgress: false

            function deleteCheckedItems() {
                var tempContentY = flickableView.contentY

                dataModel.deleteCheckedElements()

                flickableView.contentY = tempContentY
            }

            anchors.top: parent.top
            anchors.topMargin: platformStyle.paddingSmall
            anchors.bottom: parent.bottom
            anchors.bottomMargin: platformStyle.paddingSmall
            anchors.left: parent.left
            anchors.leftMargin: platformStyle.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: scrollBar.visible ? 2 * platformStyle.paddingMedium : platformStyle.paddingLarge

            model: DataModel{id: dataModel}
            delegate: itemDelegate

            interactive: page.state == "NORMAL"

            visible: false

            Connections{
                target: window

                onOrientationChangeFinished: {
                    var offset = page.height > page.width ? -10 : 10

                    flickableView.cellWidth = Math.floor((flickableView.width) / flickableView.colsNumber)
                    flickableView.cellHeight = Math.floor((flickableView.height + offset) / flickableView.rowsNumber)
                }
            }

            onContentHeightChanged: {
                if (contentHeight > cellHeight) {
                    flickableView.cellWidth = Math.floor((flickableView.width) / flickableView.colsNumber)
                }
            }

            MouseArea {
                id: mouseArea

                property int draggedItemId: -1
                property int draggedItemIndex: -1
                property bool isAnyItemDragged: draggedItemId != -1 && draggedItemIndex != -1

                property int index: flickableView.indexAt(mouseX + flickableView.contentX, mouseY + flickableView.contentY)

                property bool draggedBelowBottom: isAnyItemDragged && mouseY > flickableView.height - flickableView.cellHeight / 4
                property bool draggedAboveTop: isAnyItemDragged && mouseY < flickableView.cellHeight / 4

                anchors.fill: parent
                enabled: page.state == "SORTING"

                Binding{
                    id: yBinding

                    target: mouseArea
                    property: "index"
                    value: flickableView.indexAt(mouseArea.mouseX + flickableView.contentX, mouseArea.mouseY + flickableView.contentY)
                    when: mouseArea.draggedItemId != - 1 && !mouseArea.draggedBelowBottom && !mouseArea.draggedAboveTop
                }

                onPressed: {
                    var pressedItemIndex = flickableView.indexAt(mouseX + flickableView.contentX, mouseY + flickableView.contentY)

                    if (pressedItemIndex != -1) {
                        draggedItemId = flickableView.model.get(pressedItemIndex).itemId
                        index = pressedItemIndex
                        draggedItemIndex = index
                    }
                }

                onReleased: {
                    draggedItemId = -1
                    draggedItemIndex = -1
                }

                onIndexChanged: {

                    if (isAnyItemDragged && index != -1) {
                        dataModel.replaceItems(draggedItemIndex, index)
                        draggedItemIndex = index
                    }
                }

                onDraggedBelowBottomChanged: {
                    if (draggedBelowBottom && index != -1) {
                        automaticScrollTimer.start()
                    }
                    else{
                        automaticScrollTimer.stop()
                    }
                }

                onDraggedAboveTopChanged: {
                    if (draggedAboveTop) {
                        automaticScrollTimer.start()
                    }
                    else{
                        automaticScrollTimer.stop()
                    }
                }

                Timer{
                    id: automaticScrollTimer

                    interval: 500
                    repeat: true

                    onTriggered: {

                        var mY = mouseArea.mouseY > flickableView.height ? flickableView.height : mouseArea.mouseY
                        var moveY

                        // if mouse at flickableView boundries can't scroll more so scrolling stopped
                        if (mY > flickableView.contentHeight - flickableView.contentY - flickableView.cellHeight ||
                                mY < flickableView.cellHeight && flickableView.contentY < flickableView.cellHeight) {
                            automaticScrollTimer.stop()
                        }
                        else{
                            // scroll down if dragged item at the top
                            if (mouseArea.draggedAboveTop) {
                                moveY = flickableView.contentY - (flickableView.cellHeight * (countRowForIndex(mouseArea.index) - 1))

                                if (flickableView.contentY >= moveY)
                                    flickableView.contentY -= moveY

                                mouseArea.index = flickableView.indexAt(mouseArea.mouseX + flickableView.contentX, flickableView.contentY + flickableView.cellHeight / 2)
                            }
                            // scroll up if dragged item at the bottom
                            if (mouseArea.draggedBelowBottom) {
                                console.log("Dragged below bottom")
                                moveY = flickableView.cellHeight + ((flickableView.cellHeight*(countRowForIndex(mouseArea.index) + 1)) - (flickableView.contentY + flickableView.height))

                                if (flickableView.contentY + flickableView.height <= flickableView.contentHeight - moveY) {
                                    flickableView.contentY += moveY
                                }

                                mouseArea.index = flickableView.indexAt(mouseArea.mouseX + flickableView.contentX, flickableView.contentY + flickableView.height - flickableView.cellHeight / 2)
                            }
                        }
                    }
                }
            }
        }
    }

    onStatusChanged: {
        if (status == PageStatus.Active) {
            flickableView.cellWidth = Math.floor((flickableView.width - 2 * platformStyle.paddingMedium) / flickableView.colsNumber)
            flickableView.cellHeight = Math.floor((flickableView.height) / flickableView.rowsNumber)

            flickableView.visible = true
        }
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "SORTING"
        }
    ]

    onStateChanged: {
        if (state == "NORMAL")
            sharedToolBar.setNormalToolbar()
        else {
            if (deleteMode)
                sharedToolBar.setSortAndRemoveToolbar()
            else
                sharedToolBar.setSortToolbar()
        }
    }
}
