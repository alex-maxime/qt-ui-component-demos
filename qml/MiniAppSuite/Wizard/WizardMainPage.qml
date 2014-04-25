/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: wizardMainPage

    property string uid: "wizardMainPage"

    tools:  mainWizardPageToolBar

    ToolBar{
        id: mainWizardPageToolBar

        platformInverted: window.platformInverted

        ToolButton {
            flat: true
            platformInverted: window.platformInverted
            anchors.left: parent.left
            anchors.leftMargin: screen.width < screen.height ? 0 : 2 * platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "toolbar-back"
            onClicked: pageStack.depth <= 1 ? window.pageStack.pop() : window.pageStack.pop()
        }

        ToolButton {
            platformInverted: window.platformInverted
            anchors.centerIn: parent
            width: parent.width / 2
            text: "Wizard"
            onClicked: {
                pageStack.push(Qt.resolvedUrl("InitialWizardPage.qml"))
                window.enableWizardPageIndicator(true);
            }
        }

        ToolButton{
            flat: true
            platformInverted: window.platformInverted
            anchors.right: parent.right
            anchors.rightMargin: screen.width < screen.height ? 0 : 2 * platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.WIZARD_INFOTEXT});
        }
    }

    Label{
        anchors.centerIn: parent
        platformInverted: window.platformInverted
        text: "Main page"
    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            window.resetWizardIndicator();
            window.enableWizardPageIndicator(false);
        }
    }
}
