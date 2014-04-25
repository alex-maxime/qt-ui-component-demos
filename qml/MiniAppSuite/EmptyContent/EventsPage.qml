/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: page

    property string infoText: Constants.EMPTYCONTENT_INFOTEXT

    tools: toolBarBackAndInfo

    ListModel{
        id: outgoingEventsModel

        ListElement{title: "Outgoing event #1"}
        ListElement{title: "Outgoing event #2"}
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted

            Column{
                anchors.left: parent.paddingItem.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                ListItemText {
                    id: titleLabel
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: title
                }
            }
        }
    }


    TabBarLayout{
        id: tabBar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: screen.width < screen.height ? privateStyle.tabBarHeightPortrait : privateStyle.tabBarHeightLandscape

        z: 10

        TabButton {
            tab: incomingEventsItem
            iconSource: "../Images/Icons/bookmark.svg"
            platformInverted: window.platformInverted;
        }
        TabButton {
            tab: outgoingEventsList
            iconSource: "../Images/Icons/map.svg"
            platformInverted: window.platformInverted;
        }
    }

    TabGroup{
        id: tabGroup

        anchors.top: tabBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Item{
            id: incomingEventsItem

            anchors.fill: parent

            Label{
                id: incomingEventsLabel

                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                platformInverted: window.platformInverted;
                font.pixelSize: 2 * platformStyle.fontSizeLarge
                wrapMode: Text.WordWrap
                horizontalAlignment: "AlignHCenter"

                text: "No incoming events"
            }
        }

        ListView {
            id: outgoingEventsList

            anchors.fill: parent

            clip: true
            model: outgoingEventsModel
            delegate: delegate
        }
    }
}
