/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants


Page {
    id: mainPage

    property string infoText: Constants.BUTTONS_INFOTEXT

    function showInfoBanner(text, iconSource) {
        banner.text = (iconSource == "") ? "\"" + (text + "\" button clicked") : " button clicked";

        var source = "";

        if (iconSource != "") {
            var sourceString = iconSource.toString();
            var index = sourceString.lastIndexOf("_w.");

            if (index >=0 )
                source = sourceString.substring(0, index) + sourceString.substring(index + 2);
            else
                source = sourceString;
        }

        banner.iconSource = source;
        banner.open();
    }

    tools: toolBarBackAndInfo

    InfoBanner{
        id: banner
        platformInverted: window.platformInverted
        timeout: 3000
    }

    Flickable{
        anchors.fill: parent
        contentHeight: mainColumn.implicitHeight + platformStyle.paddingLarge

        Column{
            id: mainColumn
            spacing: platformStyle.paddingLarge
            width: parent.width

            ListHeading {
                platformInverted: window.platformInverted
                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Push button with text"
                }
            }

            BannerButton{
                anchors.horizontalCenter: parent.horizontalCenter
                width: mainPage.width * 0.75
                text: "Show message 1"
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: platformStyle.paddingLarge

                BannerButton{
                    width: mainPage.width / 2 - platformStyle.paddingLarge
                    text: "Message 2"
                }

                BannerButton{
                    width: mainPage.width / 2 - platformStyle.paddingLarge
                    text: "Message 3"
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
                    text: "Push button with icon"
                }
            }

            BannerButton{
                anchors.horizontalCenter: parent.horizontalCenter
                width: mainPage.width * 0.75
                iconSource: platformInverted ? "../Images/Icons/buy_w.svg" : "../Images/Icons/buy.svg"
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: platformStyle.paddingLarge

                BannerButton{
                    width: mainPage.width / 2 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/ok_w.svg" : "../Images/Icons/ok.svg"
                }

                BannerButton{
                    width: mainPage.width / 2 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/document_w.svg" : "../Images/Icons/document.svg"
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: platformStyle.paddingLarge

                BannerButton{
                    width: mainPage.width / 3 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/call_w.svg" : "../Images/Icons/call.svg"
                }

                BannerButton{
                    width: mainPage.width / 3 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/add_w.svg" : "../Images/Icons/add.svg"
                }

                BannerButton{
                    width: mainPage.width / 3 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/delete_w.svg" : "../Images/Icons/delete.svg";
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: platformStyle.paddingLarge

                BannerButton{
                    width: mainPage.width / 4 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/music_w.svg" : "../Images/Icons/music.svg"
                }

                BannerButton{
                    width: mainPage.width / 4 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/music_file_w.svg" : "../Images/Icons/music_file.svg"
                }

                BannerButton{
                    width: mainPage.width / 4 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/photo_album_w.svg" : "../Images/Icons/photo_album.svg";
                }

                BannerButton{
                    width: mainPage.width / 4 - platformStyle.paddingLarge
                    iconSource: platformInverted ? "../Images/Icons/home_w.svg" : "../Images/Icons/home.svg"
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
                    text: "Single push button as toggle"
                }
            }

            BannerButton{
                anchors.horizontalCenter: parent.horizontalCenter
                width: mainPage.width * 0.75
                iconSource: platformInverted ? "../Images/Icons/play_w.svg" : "../Images/Icons/play.svg"
                checkable: true
            }

            ListHeading {
                platformInverted: window.platformInverted
                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Disabled push button"
                }
            }

            BannerButton{
                anchors.horizontalCenter: parent.horizontalCenter
                width: mainPage.width * 0.75
                text: "Disabled"
                enabled: false
            }

            BannerButton{
                anchors.horizontalCenter: parent.horizontalCenter
                width: mainPage.width * 0.75
                iconSource: platformInverted ?
                                (enabled ? "../Images/Icons/zoom_in_w.svg" :  "../Images/Icons/zoom_in_disabled_w.svg" ):
                                (enabled ? "../Images/Icons/zoom_in.svg" : "../Images/Icons/zoom_in_disabled.svg")
                enabled: false
            }

            ListHeading {
                platformInverted: window.platformInverted
                ListItemText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    platformInverted: window.platformInverted
                    role: "Heading"
                    text: "Combination of push buttons"
                }
            }

            ButtonRow{
                width: parent.width - 2 * platformStyle.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                BannerButton{
                    text: "State 1"
                }

                BannerButton{
                    text: "State 2"
                }
            }

            ButtonRow{
                width: parent.width - 2 * platformStyle.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                BannerButton{
                    text: "State A"
                }

                BannerButton{
                    text: "State B"
                }

                BannerButton{
                    text: "State C"
                }
            }

            ButtonRow{
                width: parent.width - 2 * platformStyle.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                BannerButton{
                    iconSource: platformInverted ? "../Images/Icons/volume_w.svg" : "../Images/Icons/volume.svg"
                }

                BannerButton{
                    iconSource: platformInverted ? "../Images/Icons/mute_w.svg" : "../Images/Icons/mute.svg"

                }
            }

            ButtonRow{
                width: parent.width - 2 * platformStyle.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                BannerButton{
                    iconSource: platformInverted ? "../Images/Icons/stop_w.svg" : "../Images/Icons/stop.svg"
                }

                BannerButton{
                    iconSource: platformInverted ? "../Images/Icons/play_w.svg" : "../Images/Icons/play.svg"
                }

                BannerButton{
                    iconSource: platformInverted ? "../Images/Icons/pause_w.svg" : "../Images/Icons/pause.svg"
                }
            }
        }
    }
}
