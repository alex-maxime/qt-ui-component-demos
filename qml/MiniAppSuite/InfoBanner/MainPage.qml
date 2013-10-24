/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.INFOBANNER_INFOTEXT

    tools: toolBarBackAndInfo

    InfoBanner{
        id: banner

        platformInverted: window.platformInverted
        timeout: 3000
    }

    Column{
        id: mainColumn

        anchors.fill: parent
        spacing: platformStyle.paddingLarge

        ListHeading {
            platformInverted: window.platformInverted

            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: "1 line info banner in portrait orientation"
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: platformStyle.paddingLarge

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "Icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet";
                    banner.iconSource = "../Images/Icons/indi_tiny_notification.svg";
                    banner.open();
                }
            }

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "No icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet";
                    banner.iconSource = "";
                    banner.open();
                }
            }
        }

        ListHeading {
            platformInverted: window.platformInverted
            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: "2 lines info banner in portrait orientation"
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: platformStyle.paddingLarge

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "Icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit";
                    banner.iconSource = "../Images/Icons/indi_tiny_notification.svg";
                    banner.open();
                }
            }

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "No icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit";
                    banner.iconSource = "";
                    banner.open();
                }
            }
        }

        ListHeading {
            platformInverted: window.platformInverted
            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: "3 lines info banner in portrait orientation"
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: platformStyle.paddingLarge

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "Icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt";
                    banner.iconSource = "../Images/Icons/indi_tiny_notification.svg";
                    banner.open();
                }
            }

            Button{
                platformInverted: window.platformInverted
                width: mainPage.width / 2 - platformStyle.paddingLarge
                text: "No icon"
                onClicked: {
                    banner.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt";
                    banner.iconSource = "";
                    banner.open();
                }
            }
        }
    }
}
