/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string image: ""
    property string text: ""
    property string subTitle: ""

    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent.paddingItem


    Image {
        id: thumbnail
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        source: root.image === "" ? "" : "../../" + root.image
        sourceSize.width: platformStyle.graphicSizeMedium
        sourceSize.height: platformStyle.graphicSizeMedium
    }

    Column {
        anchors.left: thumbnail.right
        anchors.leftMargin: thumbnail.width > 0 ? platformStyle.paddingMedium : 0

        ListItemText {
            anchors.left: parent.left
            platformInverted: window.platformInverted
            role: "Title"
            text: root.text
        }
        ListItemText {
            anchors.left: parent.left
            role: "SubTitle"
            text: root.subTitle
        }
    }
}
