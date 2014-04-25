/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string text: ""
    property string subTitle1: ""
    property string subTitle2: ""
    property string indicator1ImageSource: ""
    property string indicator2ImageSource: ""
    property string indicatorText: ""
    property bool checked: false

    height: textItems.implicitHeight
    width: parent.width

    Item{
        anchors.fill: parent
        anchors.margins: platformStyle.paddingLarge

        Column {
            id: textItems
            anchors.left: parent.left

            ListItemText {
                id: titleItem
                anchors.left: parent.left
                platformInverted: window.platformInverted
                role: "Title"
                text: root.text
            }
            ListItemText {
                id: subItem
                anchors.left: parent.left
                platformInverted: window.platformInverted
                role: "SubTitle"
                text: root.subTitle1
            }
            ListItemText {
                anchors.left: parent.left
                platformInverted: window.platformInverted
                role: "SubTitle"
                text: root.subTitle2
            }
        }

        Image{
            id: indicator1
            anchors.top: parent.top
            anchors.topMargin: platformStyle.paddingSmall
            anchors.right: parent.right
            width: platformStyle.graphicSizeTiny
            height: platformStyle.graphicSizeTiny
            source: indicator1ImageSource
            visible: indicator1ImageSource !== ""
        }

        Image{
            id: indicator2
            anchors.top: indicator1.top
            anchors.right: indicator1.left
            anchors.rightMargin: platformStyle.paddingSmall
            width: platformStyle.graphicSizeTiny
            height: platformStyle.graphicSizeTiny
            source: indicator2ImageSource
            visible: indicator2ImageSource !== ""
        }

        Label {
            anchors {
                right: parent.right
                top: indicator1.bottom
                topMargin: platformStyle.paddingSmall
            }

            platformInverted: window.platformInverted
            font.pixelSize: platformStyle.fontSizeSmall
            color: platformStyle.colorNormalMid
            text: indicatorText
        }
    }
}
