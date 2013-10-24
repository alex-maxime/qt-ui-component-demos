/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: initialWizardPage

    tools:  initialWizardPageToolBar

    ToolBar{
        id: initialWizardPageToolBar

        platformInverted: window.platformInverted

        ToolButton {
            platformInverted: window.platformInverted
            anchors.centerIn: parent
            width: parent.width / 2
            text: "Continue"
            onClicked: {
                window.switchWizardIndicatorToNextPage();
                pageStack.push(Qt.resolvedUrl("SubSequentWizardPage.qml"))
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
        text: "Initial wizard page"
    }
}
