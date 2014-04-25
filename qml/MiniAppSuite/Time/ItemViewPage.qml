/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    property string infoText: Constants.TIME_INFOTEXT

    tools: toolBarBackAndInfo

    Flickable{
        anchors.fill: parent
        contentHeight: mainItem.height + platformStyle.paddingLarge

        Item{
            id: mainItem

            anchors.top: parent.top
            width: parent.width
            height: childrenRect.height

            Item{
                id: headerItem

                anchors.top: parent.top

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: platformStyle.paddingLarge
                width: parent.width - 2 * platformStyle.paddingLarge
                height: childrenRect.height + anchors.margins


                Label{
                    id: titleLabel

                    anchors.top: parent.top
                    anchors.left: parent.left

                    font.pixelSize: platformStyle.fontSizeLarge
                    font.bold: true
                    platformInverted: window.platformInverted

                    text: "Lorem ipsum"
                }

                Label{
                    id: subjectLabel

                    anchors.top: titleLabel.bottom
                    anchors.topMargin: platformStyle.paddingLarge
                    anchors.left: parent.left

                    font.pixelSize: platformStyle.fontSizeMedium
                    platformInverted: window.platformInverted

                    text: "Re: Re: Meeting notes, session1"
                }

                Label{
                    id: timestampLabel

                    anchors.top: subjectLabel.bottom
                    anchors.topMargin: platformStyle.paddingLarge
                    anchors.left: parent.left

                    font.pixelSize: platformStyle.fontSizeMedium
                    platformInverted: window.platformInverted

                    text: "July 17, 2011 4:18 PM"
                }
            }

            Rectangle{
                id: separator

                anchors.top: headerItem.bottom
                height: 1
                width: parent.width
                color: "gray"
            }

            Label{
                anchors.top: separator.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                width: parent.width - 2 * platformStyle.paddingLarge
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft
                platformInverted: window.platformInverted
                text: Constants.LOREM_IPSUM_TEXT
            }
        }
    }
}
