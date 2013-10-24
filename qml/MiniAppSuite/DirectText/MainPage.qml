/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.DIRECTTEXT_INFOTEXT

    tools: toolBarBackAndInfo

    ScrollDecorator{
        flickableItem: flickable
    }

    Flickable{
        id: flickable
        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: item.height + (inputContext.visible ? (inputContext.height - toolBarBackAndInfo.height) : 0 )

        Item{
            id: item

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: platformStyle.paddingLarge
            anchors.rightMargin: platformStyle.paddingLarge
            anchors.topMargin: platformStyle.paddingLarge

            height: childrenRect.height + anchors.topMargin

            Label {
                id: titleLabel1

                anchors.top: parent.top
                anchors.left: parent.left
                platformInverted: window.platformInverted
                text: "Text field title 1"
            }

            TextArea {
                id: textField1

                anchors.top: titleLabel1.bottom
                anchors.left: parent.left
                platformInverted: window.platformInverted
                width: parent.width
                text: "Text field content 1"
                horizontalAlignment: Text.AlignLeft
            }

            Label {
                id: titleLabel2

                anchors.top: textField1.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.left: parent.left
                platformInverted: window.platformInverted
                text: "Text field title 2"
            }

            TextArea {
                id: textField2

                anchors.top: titleLabel2.bottom
                anchors.left: parent.left
                platformInverted: window.platformInverted
                width: parent.width
                text: "Text field content 2"
                horizontalAlignment: Text.AlignLeft
            }

            Label {
                id: titleLabel3

                anchors.top: textField2.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.left: parent.left
                platformInverted: window.platformInverted
                text: "Text area title"
            }

            TextArea {
                id: textField3

                function cursorYPosition() {
                    return positionToRectangle(cursorPosition).y
                }

                anchors.top: titleLabel3.bottom
                anchors.left: parent.left
                platformInverted: window.platformInverted
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                text: Constants.LOREM_IPSUM_TEXT + Constants.LOREM_IPSUM_TEXT

                onCursorPositionChanged: {
                    if (inputContext.visible) {

                        //cursor above top screen boundary
                        if (textField3.y + cursorYPosition() < flickable.contentY) {
                            flickable.contentY -= flickable.contentY - ( textField3.y + cursorYPosition() )
                        }

                        //cursor below virtual keyboard top
                        if (textField3.y + cursorYPosition() > flickable.contentY + flickable.height - inputContext.height) {
                            flickable.contentY += textField3.y + cursorYPosition()
                                                  - (flickable.contentY + flickable.height - inputContext.height)
                        }
                    }
                    else{
                        flickable.contentY = flickable.contentHeight - textField3.height + cursorYPosition()
                    }
                }
            }
        }
    }
}
