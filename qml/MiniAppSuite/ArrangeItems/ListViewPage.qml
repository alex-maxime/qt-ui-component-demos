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

    Component {
        id: itemDelegate

        Item {
            id: main

            height: Constants.ARRANGE_LIST_ITEM_HEIGHT
            width: parent.width

            Rectangle{
                id: backgroundRect

                anchors.fill: parent
                anchors.leftMargin: platformStyle.paddingLarge
                anchors.rightMargin: scrollBar.visible ? platformStyle.paddingMedium * 2 : platformStyle.paddingLarge
                visible: page.state == "SORTING"

                color: mouseArea.draggedItemId == itemId ? ( window.platformInverted ? "black" :"white" ) : "transparent"
                border.color: window.platformInverted ? "black" :"white"
                opacity: 0.3
                border.width: 1
            }

            Item {
                id: item;

                property bool isDragged: mouseArea.draggedItemId == itemId
                property real dragStartX

                parent: mouseArea
                x: isDragged ? mouseArea.mouseX - dragStartX : main.x
                y: {
                    if (isDragged) {
                        if (mouseArea.mouseY > flickableView.height)
                            return flickableView.height - height/2
                        if (mouseArea.mouseY < 0)
                            return - height/2

                        return mouseArea.mouseY - height/2
                    }
                    else {
                        return index * Constants.ARRANGE_LIST_ITEM_HEIGHT - flickableView.contentY
                    }
                }

                width: main.width
                height: main.height

                Image{
                    id: thumbnail

                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    height: backgroundRect.height
                    width: height

                    source: "../Images/Icons/list_" + itemId + ".svg"
                }

                Item{
                    id: deleteCheckboxExtendedArea

                    height: parent.height
                    width: deleteCheckbox.width + 2 * platformStyle.paddingMedium

                    anchors.right: parent.right
                    anchors.rightMargin: scrollBar.visible ? platformStyle.paddingMedium * 2 : platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    Image{
                        id: deleteCheckbox

                        property bool checked: isChecked

                        anchors.right: parent.right
                        anchors.rightMargin: platformStyle.paddingMedium
                        anchors.verticalCenter: parent.verticalCenter

                        width: height
                        height: parent.height - 2 * platformStyle.paddingMedium

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

                ListItemText {
                    id: itemText

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: thumbnail.right
                    anchors.leftMargin: 10
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: "Item " + itemId
                    width: parent.width
                }

                Behavior on y {
                    enabled: (mouseArea.isAnyItemDragged && !item.isDragged)
                    NumberAnimation {id: yAnimation; duration: 200; easing.type: Easing.OutQuart }
                }

                onIsDraggedChanged: {
                    if (isDragged) {
                        dragStartX = mouseArea.mouseX
                        item.z = 10

                        if (yAnimation.running)
                            yAnimation.complete()
                    }
                    else {
                        item.z = 1
                    }
                }
            }
        }
    }

    Component{
        id: headerDelegate
        ListHeading {
            width: parent.width
            Label{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                text: page.state == "NORMAL" ? "List header" : (deleteMode ? "Sort and remove" : "Sort")
            }
        }
    }

    ListHeading {
        id: header
        anchors.top: parent.top
        width: parent.width
        platformInverted: window.platformInverted
        z: 3

        Label{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin:  2 * platformStyle.paddingMedium
            platformInverted: window.platformInverted
            text: page.state == "NORMAL" ? "List header" : (deleteMode ? "Sort and remove" : "Sort")
        }
    }

    ListView {
        id: flickableView

        function deleteCheckedItems() {
            var tempContentY = flickableView.contentY

            dataModel.deleteCheckedElements()

            if (tempContentY + flickableView.height > flickableView.contentHeight)
                flickableView.positionViewAtEnd()
            else
                flickableView.contentY = tempContentY
        }

        anchors.top: header.bottom
        anchors.topMargin: platformStyle.paddingSmall
        anchors.bottom: parent.bottom
        anchors.bottomMargin: platformStyle.paddingSmall
        width: parent.width

        delegate: itemDelegate

        interactive: page.state == "NORMAL"

        model: DataModel { id: dataModel }

        ScrollBar{
            id: scrollBar
            anchors.right: parent.right
            flickableItem: flickableView
            interactive: true
            opacity: 1
            policy: Symbian.ScrollBarWhenNeeded
            visible: flickableView.contentHeight > flickableView.height ? 1 : 0
            width: 15
            z: 11
        }

        MouseArea {
            id: mouseArea

            property int draggedItemId: -1
            property int draggedItemIndex: -1
            property bool isAnyItemDragged: draggedItemId != -1 && draggedItemIndex != -1

            property int index: flickableView.indexAt(mouseX + flickableView.contentX, mouseY + flickableView.contentY)

            property bool draggedBelowBottom: isAnyItemDragged && mouseY > flickableView.height - 30
            property bool draggedAboveTop: isAnyItemDragged && mouseY < 30

            anchors.fill: parent
            enabled: page.state == "SORTING"

            Binding{
                id: yBinding

                target: mouseArea
                property: "index"
                value: flickableView.indexAt(mouseArea.mouseX + flickableView.contentX, mouseArea.mouseY + flickableView.contentY)
                when: mouseArea.draggedItemId != -1 && !mouseArea.draggedBelowBottom && !mouseArea.draggedAboveTop
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

                interval: 400
                repeat: true

                onTriggered: {

                    var mY = mouseArea.mouseY > flickableView.height ? flickableView.height : mouseArea.mouseY
                    var moveY

                    // if mouse at flickableView boundries can't scroll more so scrolling stopped
                    if (mY > flickableView.contentHeight - flickableView.contentY - Constants.ARRANGE_LIST_ITEM_HEIGHT ||
                            mY < Constants.ARRANGE_LIST_ITEM_HEIGHT && flickableView.contentY < Constants.ARRANGE_LIST_ITEM_HEIGHT) {
                        automaticScrollTimer.stop()
                    }
                    else {
                        // scroll down if dragged item at the top
                        if (mouseArea.draggedAboveTop) {
                            moveY = flickableView.contentY - (Constants.ARRANGE_LIST_ITEM_HEIGHT * (mouseArea.index - 1))

                            if (flickableView.contentY >= moveY)
                                flickableView.contentY -= moveY

                            mouseArea.index = flickableView.indexAt(mouseArea.mouseX + flickableView.contentX, flickableView.contentY + 30)
                        }
                        // scroll up if dragged item at the bottom
                        if (mouseArea.draggedBelowBottom) {
                            moveY = Constants.ARRANGE_LIST_ITEM_HEIGHT +
                                    ((Constants.ARRANGE_LIST_ITEM_HEIGHT*(mouseArea.index + 1))
                                     - (flickableView.contentY + flickableView.height))

                            if (flickableView.contentY + flickableView.height <= flickableView.contentHeight - moveY)
                                flickableView.contentY += moveY

                            mouseArea.index = flickableView.indexAt(mouseArea.mouseX + flickableView.contentX,
                                                                    flickableView.contentY + flickableView.height - 30)
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            //model = dataModel
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
