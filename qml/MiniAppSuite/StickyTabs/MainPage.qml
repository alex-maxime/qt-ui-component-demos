/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property PageStackWindow currentTabPageStack: nestedPageWindow1

    tools:  toolBarLayout

    Model {
        id: dataModel
    }

    ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            iconSource: "toolbar-back"
            onClicked: currentTabPageStack.pageStack.depth <= 1 ? window.pageStack.pop() : currentTabPageStack.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.STICKYTABS_INFOTEXT});
        }
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted
            subItemIndicator: true

            ListItemText {
                id: itemText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                platformInverted: window.platformInverted
                mode: listItem.mode
                role: "Title"
                text: title
                width: parent.width
            }
            onClicked: {
                currentTabPageStack.pageStack.push(Qt.resolvedUrl("SubListPage.qml"), { modelListContainer: subListContainer,
                                                       parentListName: itemText.text});
            }
        }
    }

    TabBarLayout {
        id: tabBar

        z: 1
        anchors { left: parent.left; right: parent.right; top: parent.top }

        TabButton { tab: nestedPageWindow1; platformInverted: window.platformInverted; text: "View A";
            onClicked: {
                currentTabPageStack.pageStack.pop(currentTabPageStack.initialPage)
            }
        }
        TabButton { tab: nestedPageWindow2; platformInverted: window.platformInverted; text: "View B";
            onClicked: {
                currentTabPageStack.pageStack.pop(currentTabPageStack.initialPage)
            }
        }
        TabButton { tab: nestedPageWindow3; platformInverted: window.platformInverted; text: "View C";
            onClicked: {
                currentTabPageStack.pageStack.pop(currentTabPageStack.initialPage)
            }
        }
        TabButton { tab: nestedPageWindow4; platformInverted: window.platformInverted; text: "View D";
            onClicked: {
                currentTabPageStack.pageStack.pop(currentTabPageStack.initialPage)
            }
        }
    }

    TabGroup {
        id: tabGroup

        anchors { left: parent.left; right: parent.right; top: tabBar.bottom; bottom: parent.bottom }

        PageStackWindow{
            id: nestedPageWindow1

            showStatusBar: false
            showToolBar: false
            platformInverted: window.platformInverted
            initialPage: mainListPage1
        }

        PageStackWindow{
            id: nestedPageWindow2

            showStatusBar: false
            showToolBar: false
            platformInverted: window.platformInverted
            initialPage: mainListPage2
        }

        PageStackWindow{
            id: nestedPageWindow3

            showStatusBar: false
            showToolBar: false
            platformInverted: window.platformInverted
            initialPage: mainListPage3
        }

        PageStackWindow{
            id: nestedPageWindow4

            showStatusBar: false
            showToolBar: false
            platformInverted: window.platformInverted
            initialPage: mainListPage4
        }

        onCurrentTabChanged: {
            currentTabPageStack = currentTab
        }
    }

    Page{
        id: mainListPage1

        // define the content for tab 1
        ListView {
            anchors.fill: parent
            model: dataModel.tab1ListModel
            delegate: delegate
        }
    }

    Page{
        id: mainListPage2

        // define the content for tab 1
        ListView {
            anchors.fill: parent
            model: dataModel.tab2ListModel
            delegate: delegate
        }
    }

    Page{
        id: mainListPage3

        // define the content for tab 1
        ListView {
            anchors.fill: parent
            model: dataModel.tab3ListModel
            delegate: delegate
        }
    }

    Page{
        id: mainListPage4

        // define the content for tab 1
        ListView {
            anchors.fill: parent
            model: dataModel.tab4ListModel
            delegate: delegate
        }
    }
}

