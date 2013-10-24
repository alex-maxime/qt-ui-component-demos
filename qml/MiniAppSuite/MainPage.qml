/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constants.js" as Constants

Page {
    id: mainPage

    ListModel {
        id: componentsModel

        ListElement {
            title: "Buttons"
            picture: "Images/Icons/menu_buttons.svg"
            page: "Buttons/MainPage.qml"
        }

        ListElement {
            title: "Dialogs"
            picture: "Images/Icons/menu_dialogs.svg"
            page: "Dialogs/MainPage.qml"
        }

        ListElement {
            title: "Info banners"
            picture: "Images/Icons/menu_infobanners.svg"
            page: "InfoBanner/MainPage.qml"
        }

        ListElement {
            title: "List items"
            picture: "Images/Icons/menu_listitems.svg"
            page: "ListItems/ListPage.qml"
        }

        ListElement {
            title: "Menus"
            picture: "Images/Icons/menu_menus.svg"
            page: "Menus/MainPage.qml"
        }

        ListElement {
            title: "Progress"
            picture: "Images/Icons/menu_progress.svg"
            page: "ProgressIndicators/MainPage.qml"
        }

        ListElement {
            title: "Sliders"
            picture: "Images/Icons/menu_sliders.svg"
            page: "Sliders/MainPage.qml"
        }

        ListElement {
            title: "Tab bars"
            picture: "Images/Icons/menu_tabs.svg"
            page: "TabBars/MainPage.qml"
        }

        ListElement {
            title: "Time stamps"
            picture: "Images/Icons/menu_time.svg"
            page: "Time/MainPage.qml"
        }

        ListElement {
            title: "Toolbars"
            picture: "Images/Icons/menu_toolbars.svg"
            page: "Tollbars/ToolbarPage.qml"
        }

        ListElement {
            title: "Tumblers"
            picture: "Images/Icons/menu_tumblers.svg"
            page: "Tumblers/MainPage.qml"
        }
    }

    ListModel {
        id: patternsModel

        ListElement {
            title: "Arrange items"
            picture: "Images/Icons/menu_arrange.svg"
            page: "ArrangeItems/MainPage.qml"
        }

        ListElement {
            title: "Delete multiple"
            picture: "Images/Icons/menu_delete.svg"
            page: "DeleteMultiple/MainPage.qml"
        }

        ListElement {
            title: "Drill down"
            picture: "Images/Icons/menu_drill.svg"
            page: "DrillDown/MainPage.qml"
        }

        ListElement {
            title: "Empty content"
            picture: "Images/Icons/menu_empty.svg"
            page: "EmptyContent/MainPage.qml"
        }

        ListElement {
            title: "Header + button"
            picture: "Images/Icons/menu_headerbutton.svg"
            page: "HeaderButton/MainPage.qml"
        }

        ListElement {
            title: "Scrolling"
            picture: "Images/Icons/menu_scrolling.svg"
            page: "FastScrolling/MainPage.qml"
        }

        ListElement {
            title: "Search"
            picture: "Images/Icons/menu_search.svg"
            page: "Search/MainPage.qml"
        }

        ListElement {
            title: "Tabs"
            picture: "Images/Icons/menu_tabs.svg"
            page: "Tabs/MainPage.qml"
        }

        ListElement {
            title: "Tabs - sticky"
            picture: "Images/Icons/menu_stickeytabs.svg"
            page: "StickyTabs/MainPage.qml"
        }

        ListElement {
            title: "Tabs - toolbar"
            picture: "Images/Icons/menu_toolbartabs.svg"
            page: "ToolBarTabs/MainPage.qml"
        }        

        ListElement {
            title: "Text - direct"
            picture: "Images/Icons/menu_text.svg"
            page: "DirectText/MainPage.qml"
        }

        ListElement {
            title: "Text - safe"
            picture: "Images/Icons/menu_text_safe.svg"
            page: "SafeText/MainPage.qml"
        }

        ListElement {
            title: "Wizard"
            picture: "Images/Icons/menu_wizard.svg"
            page: "Wizard/WizardMainPage.qml"
        }

        ListElement {
            title: "Zooming"
            picture: "Images/Icons/menu_image.svg"
            page: "ImageControl/MainPage.qml"
        }
    }

    Component {
        id: mainGridDelegate

        Rectangle {
            color: mousearea.pressed ? platformStyle.colorDisabledLight
                                     : (window.platformInverted ? platformStyle.colorBackgroundInverted: platformStyle.colorBackground)
            width: mainGrid.cellWidth
            height: mainGrid.cellHeight

            Column {
                id: column

                anchors.centerIn: parent
                spacing: 10
                Image { source: picture; anchors.horizontalCenter: parent.horizontalCenter }
                Label {
                    text: title;
                    platformInverted: window.platformInverted;
                    font.pixelSize: 15
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            MouseArea {
                id: mousearea

                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.push(Qt.resolvedUrl(page))
                }
            }
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

            ListHeading {
                platformInverted: window.platformInverted

                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Components"
                }
            }

            GridView {
                id: mainGrid

                property int colsNumber: mainPage.height > mainPage.width ?
                                             Constants.GRID_COLS_PER_SCREEN_VERTICAL :
                                             Constants.GRID_COLS_PER_SCREEN_HORIZONTAL

                property int rowsNumber: mainPage.height > mainPage.width ?
                                             Constants.GRID_ROWS_PER_SCREEN_VERTICAL :
                                             Constants.GRID_ROWS_PER_SCREEN_HORIZONTAL

                width: parent.width
                height: cellHeight * Math.ceil(count / colsNumber)
                model: componentsModel
                interactive: false
                cellWidth: mainPage.width / colsNumber
                cellHeight: mainPage.height / rowsNumber

                delegate: mainGridDelegate
            }

            ListHeading {
                platformInverted: window.platformInverted

                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Patterns"
                }
            }

            GridView {
                property int colsNumber: mainPage.height > mainPage.width ?
                                             Constants.GRID_COLS_PER_SCREEN_VERTICAL :
                                             Constants.GRID_COLS_PER_SCREEN_HORIZONTAL

                property int rowsNumber: mainPage.height > mainPage.width ?
                                             Constants.GRID_ROWS_PER_SCREEN_VERTICAL :
                                             Constants.GRID_ROWS_PER_SCREEN_HORIZONTAL

                width: parent.width
                height: cellHeight * Math.ceil(count / colsNumber)
                model: patternsModel
                interactive: false
                cellWidth: mainPage.width / colsNumber
                cellHeight: mainPage.height / rowsNumber

                delegate: mainGridDelegate
            }
        }
    }
}

