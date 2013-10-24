/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.TIME_INFOTEXT
    property bool timestampHeaders: true

    tools: toolBarBackAndInfo

    ListModel{
        id: dataModel

        ListElement{
            title: "List title #1"
            subTitle: "List content #1"
            timeStamp: "Today"

        }
        ListElement{
            title: "List title #2"
            subTitle: "List content #2"
            timeStamp: "Today"
        }

        ListElement{
            title: "List title #3"
            subTitle: "List content #3"
            timeStamp: "Today"
        }

        ListElement{
            title: "List title #4"
            subTitle: "List content #4"
            timeStamp: "Yesterday"
        }

        ListElement{
            title: "List title #5"
            subTitle: "List content #5"
            timeStamp: "Yesterday"
        }

        ListElement{
            title: "List title #6"
            subTitle: "List content #6"
            timeStamp: "Friday, January 15"
        }

        ListElement{
            title: "List title #7"
            subTitle: "List content #7"
            timeStamp: "Friday, January 15"
        }

        ListElement{
            title: "List title #8"
            subTitle: "List content #8"
            timeStamp: "Friday, January 15"
        }

        ListElement{
            title: "List title #9"
            subTitle: "List content #9"
            timeStamp: "Thursday, January 14"
        }

        ListElement{
            title: "List title #10"
            subTitle: "List content #10"
            timeStamp: "Wednesday, January 13"
        }

        ListElement{
            title: "List title #11"
            subTitle: "List content #11"
            timeStamp: "Wednesday, January 13"
        }
    }

    InfoBanner{
        id: banner

        platformInverted: window.platformInverted
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted
            subItemIndicator: true

            Column{
                anchors.left: parent.paddingItem.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Item{
                    anchors.left: parent.left
                    width: parent.width
                    height: childrenRect.height

                    ListItemText {
                        id: titleLabel

                        anchors.left: parent.left
                        platformInverted: window.platformInverted
                        role: "Heading"
                        text: title
                    }

                    ListItemText{
                        anchors.right: parent.right
                        anchors.rightMargin: 3 * platformStyle.paddingLarge
                        anchors.verticalCenter: titleLabel.verticalCenter
                        platformInverted: window.platformInverted
                        visible: !timestampHeaders
                        role: "Heading"
                        text: {
                            if (timeStamp.lastIndexOf(",") != -1)
                                return timeStamp.substring(0, timeStamp.lastIndexOf(","))
                            return timeStamp
                        }
                    }
                }

                ListItemText {
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "SubTitle"
                    text: subTitle
                    width: parent.width
                }
            }
            onClicked: {
                banner.text = title + " opens"
                banner.open()
            }
        }
    }

    Component{
        id: sectionDelegate

        ListHeading {
            platformInverted: window.platformInverted
            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                role: "Heading"
                text: section
            }
        }
    }

    ListView {
        id: listView

        anchors.fill: parent
        model: dataModel
        section.property: timestampHeaders ? "timeStamp" : ""
        section.criteria: ViewSection.FullString
        section.delegate: sectionDelegate
        delegate: delegate
    }
}
