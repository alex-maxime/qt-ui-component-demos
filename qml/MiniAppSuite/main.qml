/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "Constants.js" as Constants
import "Wizard"

PageStackWindow {
    id: window

    initialPage: MainPage {tools: toolBarLayout}
    showStatusBar: true
    showToolBar: true
    LayoutMirroring.childrenInherit: true

    function enableWizardPageIndicator(enabled) {
        wizardPageIndicator.visible = enabled;
    }

    function switchWizardIndicatorToNextPage() {
        wizardPageIndicator.switchToNextWizardPage();
    }

    function switchWizardIndicatorToPreviousPage() {
        wizardPageIndicator.switchToPreviousWizardPage();
    }

    function resetWizardIndicator() {
        wizardPageIndicator.reset();
    }

    onOrientationChangeFinished: {
        console.log("Orientation change finished")
    }

    StatusBar {
        id: statusBar

        anchors.top: parent.top
    }

    ToolBarLayout {
        id: toolBarBackAndInfo

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "Images/Icons/information_userguide_w.svg" : "Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("InfoPage.qml"), {text: window.pageStack.currentPage.infoText});
        }
    }

    ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton{
            flat: true
            checkable: true
            platformInverted: window.platformInverted
            iconSource: platformInverted ? "Images/Icons/toolbar_flip_w.svg" : "Images/Icons/toolbar_flip.svg"
            onClicked: window.LayoutMirroring.enabled = !window.LayoutMirroring.enabled
        }

        ToolButton{
            flat: true
            iconSource: platformInverted ? "Images/Icons/personalise_w.svg" : "Images/Icons/personalise.svg"
            checkable: true
            platformInverted: window.platformInverted
            onCheckedChanged: window.platformInverted = checked;
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "Images/Icons/information_userguide_w.svg" : "Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("InfoPage.qml"), {text: Constants.START_VIEW_INFO_TEXT});
        }
    }

    WizardPageIndicator{
        id: wizardPageIndicator
        z: pageStack.depth + 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        pageCount: 3
        activePageIndex: 0
        visible: false
    }
}
