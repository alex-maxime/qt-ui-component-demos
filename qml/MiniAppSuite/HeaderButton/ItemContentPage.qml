/**
 * Copyright (c) 2012 Nokia Corporation.
 */
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.HEADERBUTTON_INFOTEXT
    property string content;

    tools:  toolBarBackAndInfo

    Label{
        anchors.left: parent.left
        anchors.leftMargin: platformStyle.paddingLarge
        anchors.top: parent.top
        anchors.topMargin: platformStyle.paddingLarge
        platformInverted: window.platformInverted

        text: content
    }
}
