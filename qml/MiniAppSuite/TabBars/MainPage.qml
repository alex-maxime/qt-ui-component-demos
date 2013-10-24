/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.TABBARS_INFOTEXT

    tools: toolBarBackAndInfo

    ListModel{
        id: dataModel

        ListElement{
            title: "2 tabs, icons and text";
            subtitle: "2 tabs, icons only in landscape"
            tabBarComponentSource: "TabBar2TabsIconAndText.qml"
        }
        ListElement{
            title: "3 tabs, icons and text";
            subtitle: "3 tabs, icons only in landscape"
            tabBarComponentSource: "TabBar3TabsIconAndText.qml"
        }
        ListElement{
            title: "4 tabs, icons and text";
            subtitle: "4 tabs, icons only in landscape"
            tabBarComponentSource: "TabBar4TabsIconAndText.qml"
        }
        ListElement{
            title: "2 tabs, icons";
            subtitle: "In portrait and landscape"
            tabBarComponentSource: "TabBar2TabsIcon.qml"
        }
        ListElement{
            title: "3 tabs, icons";
            subtitle: "In portrait and landscape"
            tabBarComponentSource: "TabBar3TabsIcon.qml"
        }
        ListElement{
            title: "4 tabs, icons";
            subtitle: "In portrait and landscape"
            tabBarComponentSource: "TabBar4TabsIcon.qml"
        }
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted

            Column {
                anchors.left: parent.left
                anchors.leftMargin: platformStyle.paddingLarge
                anchors.verticalCenter: parent.verticalCenter

                ListItemText {
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: title
                }
                ListItemText {
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    role: "SubTitle"
                    text: subtitle
                }
            }

            RadioButton{
                id: radioButton

                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                anchors.verticalCenter: parent.verticalCenter

                platformInverted: window.platformInverted

                platformExclusiveGroup: group

                onCheckedChanged: {
                    if (checked) {
                        loader.source = "TabBars/" + tabBarComponentSource
                        tabGroup.currentTab = item1
                    }
                }
            }

            onClicked: {
                radioButton.checked = true
                loader.source = "TabBars/" + tabBarComponentSource

                tabGroup.currentTab = item1
            }
        }
    }

    CheckableGroup{
        id: group
    }

    Loader{
        id: loader

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left

        source: "TabBars/TabBar2TabsIconAndText.qml"
    }

    TabGroup{
        id: tabGroup

        Item{id: item1}
        Item{id: item2}
        Item{id: item3}
        Item{id: item4}
    }


    ListView{
        anchors.top: loader.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        delegate: delegate
        model: dataModel
        clip: true

        cacheBuffer: contentHeight
    }
}

