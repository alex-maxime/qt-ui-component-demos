/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1

Item {
    id: root

    property string text: ""
    property string image: ""
    property int rating: 0

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

        RatingIndicator {
            anchors.left: parent.left
            platformInverted: window.platformInverted
            ratingValue: root.rating
            maximumValue: 5
        }
    }
}
