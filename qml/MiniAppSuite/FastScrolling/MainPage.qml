/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    tools: toolBar

    state: "INDICATIVE"

    ToolBarLayout {
        id: toolBar

        ToolButton {
            platformInverted: window.platformInverted
            flat: true
            iconSource: "toolbar-back"
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ButtonRow {
            id: buttonRow
            ToolButton {
                id: indicativeButton
                platformInverted: window.platformInverted
                text: "Indicator"
                onClicked: mainPage.state = "INDICATIVE"
            }
            ToolButton {
                id: interactiveButton
                width: 100
                platformInverted: window.platformInverted
                text: "Handle"
                onClicked: mainPage.state = "INTERACTIVE"
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.SCROLLING_INFOTEXT});
        }
    }

    DataModel{
        id: listModel
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted

            Column{
                anchors.fill: listItem.paddingItem

                ListItemText {
                    role: "Title"
                    platformInverted: window.platformInverted
                    text: name
                    width: parent.width
                }
                ListItemText {
                    role: "SubTitle"
                    platformInverted: window.platformInverted
                    text: "2nd line"
                    width: parent.width
                }
            }
        }
    }

    Component{
        id: sectionDelegate

        ListHeading {
            platformInverted: window.platformInverted
            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2 * platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: section
            }
        }
    }

    Timer {
        id: timer

        interval: 500;

        onTriggered: sectionIndicator.opacity = 0;
    }

    Rectangle{
        id: sectionIndicator

        property string section;

        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 80
        color: "gray"
        z: 1
        opacity: 0.0
        visible: mainPage.state == "INTERACTIVE"

        Label{
            font.pixelSize: 45
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            text: sectionIndicator.section
        }

        Behavior on opacity { PropertyAnimation { duration: 300 } }
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: listModel
        delegate: delegate
        section.property: "section"
        section.criteria: ViewSection.FullString
        section.delegate: sectionDelegate

        onCurrentSectionChanged: {
            if (moving != true) {
                if (mainPage.status == PageStatus.Active) {
                    sectionIndicator.opacity = 0.5;
                    timer.restart();
                    sectionIndicator.section = currentSection;
                }
            }
        }
    }

    ScrollBar{
        id: scrollBar

        flickableItem: listView
        anchors.right: parent.right
        width: mainPage.state == "INDICATIVE" ? 10 : 25
        interactive: mainPage.state == "INDICATIVE" ? false : true
        opacity: mainPage.state == "INDICATIVE" ? 0 : 1
        visible: true
        policy: mainPage.state == "INDICATIVE" ? Symbian.ScrollBarWhenScrolling : Symbian.ScrollBarWhenNeeded
    }

    states: [
        State {
            name: "INDICATIVE"
        },
        State {
            name: "INTERACTIVE"
        }
    ]

    onStateChanged: {
        if (state == "INDICATIVE")
            scrollBar.opacity = 0;
        else
            scrollBar.opacity = 1
    }

    onStatusChanged: {
        if (status == PageStatus.Active)
            scrollBar.opacity = mainPage.state == "INDICATIVE" ? 0 : 1

        if (state == "INDICATIVE")
            buttonRow.checkedButton = indicativeButton
        else
            buttonRow.checkedButton = interactiveButton
    }
}
