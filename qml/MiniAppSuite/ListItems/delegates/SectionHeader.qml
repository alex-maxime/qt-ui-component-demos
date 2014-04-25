/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

ListHeading {
    id: heading
    property string text;

    //width: parent.width
    platformInverted: window.platformInverted

    ListItemText {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: platformStyle.paddingLarge
        platformInverted: window.platformInverted
        role: "Heading"
        text: heading.text
    }
}
