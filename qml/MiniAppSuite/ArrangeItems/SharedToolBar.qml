/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

ToolBar {
    platformInverted: window.platformInverted

    function setNormalToolbar() {
        setTools(normalToolbar)
    }

    function setSortToolbar() {
        setTools(sortToolBar)
    }

    function setSortAndRemoveToolbar() {
        setTools(sortAndRemoveToolbar)
    }

    ToolBarLayout {
        id: normalToolbar

        ToolButton {
            platformInverted: window.platformInverted
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Arrange"
            onClicked: {
                page.state = "SORTING"
            }
        }


        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.ARRANGE_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: sortToolBar

        ToolButton {
            platformInverted: window.platformInverted
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Done"
            onClicked: {
                page.state = "NORMAL"
            }
        }


        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.ARRANGE_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: sortAndRemoveToolbar

        ToolButton {
            platformInverted: window.platformInverted
            text: "Done"
            onClicked: {
                flickableView.deleteCheckedItems()

                page.state = "NORMAL"
            }
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: {                
                dataModel.uncheckAllItems()
                page.state = "NORMAL"
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.ARRANGE_INFOTEXT});
        }
    }
}
