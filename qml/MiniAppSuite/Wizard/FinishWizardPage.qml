/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: finishWizardPage

    tools:  finishWizardPageToolBar

    ToolBar{
        id: finishWizardPageToolBar

        platformInverted: window.platformInverted

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            anchors.left: parent.left
            anchors.leftMargin: screen.width < screen.height ? 0 : 2 * platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "toolbar-back"
            onClicked: {
                window.switchWizardIndicatorToPreviousPage();
                pageStack.pop()
            }
        }

        ToolButton {
            platformInverted: window.platformInverted
            anchors.centerIn: parent
            width: parent.width / 2
            text: "Finish"
            onClicked: {
                window.switchWizardIndicatorToNextPage();
                pageStack.pop(pageStack.find(function(page) {return page.uid == "wizardMainPage";}));
            }
        }

        ToolButton{
            flat: true
            platformInverted: window.platformInverted
            anchors.right: parent.right
            anchors.rightMargin: screen.width < screen.height ? 0 : 2 * platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            iconSource: platformInverted ? "../Images/Icons/close_stop_w.svg" : "../Images/Icons/close_stop.svg"
            onClicked: pageStack.pop(pageStack.find(function(page) {return page.uid == "wizardMainPage";}));
        }
    }

    Label{
        anchors.centerIn: parent
        platformInverted: window.platformInverted
        text: "Finish wizard page"
    }
}
