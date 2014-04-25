/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.MENUS_INFOTEXT

    tools: toolBar

    ToolBarLayout {
        id: toolBar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-menu"
            platformInverted: window.platformInverted
            onClicked: viewMenu.open()
        }
    }

    Menu {
        id: viewMenu

        platformInverted: window.platformInverted

        MenuLayout {
            MenuItem {
                platformInverted: window.platformInverted
                text: "Information"
                onClicked: pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: infoText})
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "View menu item 2"
                onClicked: viewMenu.close()
            }
        }
    }

    ContextMenu {
        id: longPressMenu1

        platformInverted: window.platformInverted

        MenuLayout {
            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 1, item 1"
                onClicked: longPressMenu1.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 1, item 2"
                onClicked: longPressMenu1.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 1, item 3"
                onClicked: longPressMenu1.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 1, item 4"
                onClicked: longPressMenu1.close()
            }
        }
    }

    ContextMenu {
        id: longPressMenu2

        platformInverted: window.platformInverted

        MenuLayout {
            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 2, item 1"
                onClicked: longPressMenu2.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 2, item 2"
                onClicked: longPressMenu2.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 2, item 3"
                onClicked: longPressMenu2.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Object menu 2, item 4"
                onClicked: longPressMenu2.close()
            }
        }
    }

    Menu {
        id: menu

        platformInverted: window.platformInverted

        MenuLayout {
            MenuItem {
                platformInverted: window.platformInverted
                text: "View menu item 1"
                onClicked: menu.close()
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "Sort by"
                platformSubItemIndicator: true
                onClicked: {
                    sortSubMenu.open()
                    longPressMenu2.close()
                }
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "View menu item 3, Submenu 2"
                platformSubItemIndicator: true
                onClicked: {
                    subMenu2.open()
                    longPressMenu2.close()
                }
            }

            MenuItem {
                platformInverted: window.platformInverted
                text: "View menu item 4"
                onClicked: menu.close()
            }
        }

        ContextMenu {
            id: sortSubMenu

            platformInverted: window.platformInverted

            MenuLayout {
                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Name"
                    onClicked: sortSubMenu.close()
                }

                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Number"
                    onClicked: sortSubMenu.close()
                }

                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Date"
                    onClicked: sortSubMenu.close()
                }
            }
        }

        ContextMenu {
            id: subMenu2

            platformInverted: window.platformInverted

            MenuLayout {
                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Submenu 2, item 1"
                    onClicked: subMenu2.close()
                }

                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Submenu 2, item 2"
                    onClicked: subMenu2.close()
                }

                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Submenu 2, item 3"
                    onClicked: subMenu2.close()
                }

                MenuItem {
                    platformInverted: window.platformInverted
                    text: "Submenu 2, item 4"
                    onClicked: subMenu2.close()
                }
            }
        }
    }

    Flickable{
        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: col.implicitHeight

        Column{
            id: col
            width: parent.width

            ListHeading{
                width: parent.width

                platformInverted: window.platformInverted

                Label{
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    text: "Menus"
                }
            }

            ListItem{
                ListItemText {
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    role: "Title"
                    text: "Long press menu 1"
                }

                onPressAndHold: {
                    longPressMenu1.open()
                }
            }

            ListItem{
                ListItemText {
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    role: "Title"
                    text: "Long press menu 2"
                }

                onPressAndHold: {
                    longPressMenu2.open()
                }
            }

            ListItem{
                ListItemText {
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    role: "Title"
                    text: "No long press menu"
                }

                onClicked: {
                    menu.open()
                }
            }
        }
    }
}
