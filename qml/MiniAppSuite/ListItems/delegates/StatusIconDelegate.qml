/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: root

    property string text: ""
    property string image: ""
    property bool statusIconOnThumbnail: false
    property string statusIconSource: ""

    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent.paddingItem

    Image {
        id: thumbnail
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        source: root.image === "" ? "" : "../../" + root.image
        sourceSize.width: platformStyle.graphicSizeMedium
        sourceSize.height: platformStyle.graphicSizeMedium
    }

    ListItemText {
        anchors.left: thumbnail.right
        anchors.leftMargin: platformStyle.paddingMedium
        anchors.verticalCenter: parent.verticalCenter
        platformInverted: window.platformInverted
        role: "Title"
        text: root.text
    }

    Image {
        anchors.right: root.statusIconOnThumbnail ? thumbnail.right : parent.right
        anchors.top:  root.statusIconOnThumbnail ? thumbnail.top : undefined
        anchors.verticalCenter:  root.statusIconOnThumbnail ? undefined : parent.verticalCenter
        width: root.statusIconOnThumbnail ? platformStyle.graphicSizeTiny : platformStyle.graphicSizeSmall
        height: root.statusIconOnThumbnail ? platformStyle.graphicSizeTiny : platformStyle.graphicSizeSmall
        source: statusIconSource
    }
}
