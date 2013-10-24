/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    id: rootItem

    property string text

    Rectangle{
        id: rect

        width: 50
        height: width

        color: "white"

        radius: 10
        border.width: 2
        border.color: "black"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ItemContentPage.qml"), {content: text});
            }
            onPressed: rect.color = "gray";
            onReleased: rect.color = "white";
        }
    }

    Item{
        id: textItem

        LayoutMirroring.enabled: false;
        LayoutMirroring.childrenInherit: true

        anchors.left: rect.right
        anchors.leftMargin: platformStyle.paddingLarge
        anchors.rightMargin: platformStyle.paddingLarge
        anchors.verticalCenter: rect.verticalCenter

        Rectangle{
            id: landmarkRect

            width: label.width + 2 * platformStyle.paddingMedium
            height: label.height
            anchors.verticalCenter: label.verticalCenter
            anchors.horizontalCenter: label.horizontalCenter
            color: "white"
            border.color: "black"
        }

        Label{
            id: label

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: platformStyle.paddingLarge
            platformInverted: window.platformInverted
            color: "black"
            text: rootItem.text
        }
    }
}
