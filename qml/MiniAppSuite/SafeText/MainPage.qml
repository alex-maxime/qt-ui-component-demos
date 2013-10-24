/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    tools: sharedToolBar
    state: "NORMAL"

    ToolBar {
        id: sharedToolBar

        tools: mainToolBarLayout
        platformInverted: window.platformInverted
    }

    ToolBarLayout {
        id: mainToolBarLayout

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            iconSource: platformInverted ? "../Images/Icons/edit_w.svg" : "../Images/Icons/edit.svg"
            platformInverted: window.platformInverted
            onClicked: mainPage.state = "EDIT";
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.SAFETEXT_INFOTEXT});
        }
    }

    ToolBarLayout {
        id: editToolBarLayout

        ToolButton {
            platformInverted: window.platformInverted
            text: "Save"
            onClicked: {
                mainPage.state = "NORMAL";
                textContentLabel1.text = textField1.text
                textContentLabel2.text = textField2.text
                textContentLabel3.text = textField3.text
            }
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Cancel"
            onClicked: {
                mainPage.state = "NORMAL";
                textField1.text = textContentLabel1.text
                textField2.text = textContentLabel2.text
                textField3.text = textContentLabel3.text
            }
        }
    }

    ScrollDecorator{
        flickableItem: flickable
    }

    Flickable{
        id: flickable

        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: item.height + (inputContext.visible ? (inputContext.height - sharedToolBar.height) : 0 )

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

            Label {
                id: textContentLabel1

                anchors.verticalCenter: textField1.verticalCenter
                anchors.left: parent.left
                platformInverted: window.platformInverted
                visible: mainPage.state == "NORMAL" ? true : false
                text: "Text field content 1"
            }

            TextArea {
                id: textField1

                anchors.top: titleLabel1.bottom
                anchors.left: parent.left
                platformInverted: window.platformInverted
                width: parent.width
                text: textContentLabel1.text
                horizontalAlignment: Text.AlignLeft
                visible: !textContentLabel1.visible
            }


            Label {
                id: titleLabel2

                anchors.top: textField1.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.left: parent.left
                platformInverted: window.platformInverted
                text: "Text field title 2"
            }

            Label {
                id: textContentLabel2

                anchors.verticalCenter: textField2.verticalCenter
                anchors.left: parent.left
                platformInverted: window.platformInverted
                visible: mainPage.state == "NORMAL" ? true : false
                text: "Text field content 2"
            }

            TextArea {
                id: textField2

                anchors.top: titleLabel2.bottom
                anchors.left: parent.left
                platformInverted: window.platformInverted
                width: parent.width
                text: textContentLabel2.text
                horizontalAlignment: Text.AlignLeft
                visible: !textContentLabel2.visible
            }

            Label {
                id: titleLabel3

                anchors.top: textField2.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.left: parent.left
                platformInverted: window.platformInverted
                text: "Text field title 3"
            }

            Label {
                id: textContentLabel3

                anchors.top: titleLabel3.bottom
                anchors.topMargin: platformStyle.paddingLarge
                anchors.left: parent.left
                anchors.right: parent.right
                platformInverted: window.platformInverted
                horizontalAlignment: Text.AlignLeft
                visible: mainPage.state == "NORMAL" ? true : false
                wrapMode: Text.WordWrap
                text: "Text area content. \n"
                      + Constants.LOREM_IPSUM_TEXT + Constants.LOREM_IPSUM_TEXT
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
                text: textContentLabel3.text
                horizontalAlignment: Text.AlignLeft
                visible: !textContentLabel3.visible

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
                    else
                        flickable.contentY = flickable.contentHeight - textField3.height + cursorYPosition()
                }
            }
        }
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "EDIT"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);

        if (state == "NORMAL")
            sharedToolBar.setTools(mainToolBarLayout)
        else
            sharedToolBar.setTools(editToolBarLayout)

        mainPage.focus = true;
    }
}
