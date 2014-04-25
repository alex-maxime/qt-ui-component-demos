/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string image: "";
    property string text: "";

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

    ListItemText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: thumbnail.right
        anchors.leftMargin: thumbnail.width > 0 ? platformStyle.paddingMedium : 0
        platformInverted: window.platformInverted
        role: "Title"
        text: root.text
    }
}
