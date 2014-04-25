/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.PROGRESS_INFOTEXT

    tools: toolBarBackAndInfo

    Flickable{
        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: col.implicitHeight

        Column{
            id: col

            width: parent.width

            ListHeading{
                width: parent.width

                platformInverted: window.platformInverted

                Label{
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    text: "Interminate progress indicators"
                }
            }

            ListItem{
                Row{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: platformStyle.paddingLarge

                    Item{
                        width: platformStyle.graphicSizeMedium
                        height: platformStyle.graphicSizeMedium

                        BusyIndicator{
                            anchors.centerIn: parent

                            running: true
                        }
                    }

                    ListItemText {
                        platformInverted: window.platformInverted

                        anchors.verticalCenter: parent.verticalCenter

                        role: "Title"
                        text: "Thumbnail loading"
                    }
                }
            }


            ListItem{
                Row{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: platformStyle.paddingLarge

                    Image{
                        width: platformStyle.graphicSizeMedium
                        height: platformStyle.graphicSizeMedium

                        source: "../Images/squircles/squircle-bile.png"
                    }

                    ListItemText {
                        platformInverted: window.platformInverted

                        anchors.verticalCenter: parent.verticalCenter

                        role: "Title"
                        text: "Thumbnail loaded"
                    }
                }
            }

            ListHeading{
                width: parent.width

                platformInverted: window.platformInverted

                Label{
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    text: "Determinate progress"
                }
            }

            ListItem{
                Column{
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: platformStyle.paddingSmall

                    ListItemText {
                        anchors.left: parent.left
                        anchors.leftMargin: platformStyle.paddingLarge

                        platformInverted: window.platformInverted

                        role: "Heading"
                        text: "Item with a progress bar"
                    }

                    ProgressBar{
                        width: parent.width - 2 * platformStyle.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter

                        platformInverted: window.platformInverted

                        minimumValue: 0
                        maximumValue: 100
                        value: 70
                    }
                }
            }

            ListItem{
                Column{
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: platformStyle.paddingSmall

                    Item{
                        anchors.left: parent.left
                        anchors.leftMargin: platformStyle.paddingLarge
                        anchors.right: parent.right
                        anchors.rightMargin: platformStyle.paddingLarge

                        height: childrenRect.height

                        ListItemText {
                            anchors.left: parent.left

                            platformInverted: window.platformInverted

                            role: "Heading"
                            text: "Item with a progress bar + info"
                        }

                        ListItemText {
                            anchors.right: parent.right

                            platformInverted: window.platformInverted

                            role: "Heading"
                            text: ((progressBar1.value / (progressBar1.maximumValue - progressBar1.minimumValue)) * 100) + " %"
                        }
                    }

                    ProgressBar{
                        id: progressBar1

                        platformInverted: window.platformInverted

                        width: parent.width - 2 * platformStyle.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter

                        minimumValue: 0
                        maximumValue: 100
                        value: 63
                    }
                }
            }

            ListHeading{
                width: parent.width

                platformInverted: window.platformInverted

                Label{
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    text: "Dialogs"
                }
            }

            ListItem{
                subItemIndicator: true

                ListItemText {
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    role: "Heading"
                    text: "Dialog with indeterminate progress bar"
                }

                onClicked: {
                    progressDialog.openIndeterminateWithRandomTimeout(3000, 15000)
                }
            }

            ListItem{
                subItemIndicator: true

                ListItemText {
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter

                    platformInverted: window.platformInverted

                    role: "Heading"
                    text: "Dialog with determinate progress bar"
                }

                onClicked: {
                    progressDialog.openDeterminateWithRandomTimeout(3000, 10000)
                }
            }
        }
    }

    CommonDialog{
        id: progressDialog

        function openIndeterminateWithRandomTimeout(from, to) {
            var timeoutTime = from + Math.floor((Math.random() * (to - from) + 1))
            timeoutTimer.interval = timeoutTime
            progressBar2.indeterminate = true
            progressBar2.maximumValue = 1000
            timeoutTimer.restart()
            open()
        }

        function openDeterminateWithRandomTimeout(from, to) {
            var maximumProgressValue = (from + Math.floor((Math.random() * (to - from) + 1))) / 10
            progressBar2.indeterminate = false
            progressBar2.maximumValue = maximumProgressValue
            progressBarTimer.restart()
            progressDialog.open()
        }

        platformInverted: window.platformInverted

        titleText: "Progress dialog title"
        content: Item{
            anchors.centerIn: parent
            width: parent.width

            LayoutMirroring.enabled: true
            LayoutMirroring.childrenInherit: true

            ProgressBar{
                id: progressBar2

                platformInverted: window.platformInverted

                anchors.centerIn: parent

                width: parent.width - 2 * platformStyle.paddingLarge

                minimumValue: 0
                maximumValue: 1000
                value: 0

                Timer{
                    id: progressBarTimer

                    interval: 10
                    repeat: true

                    onTriggered: {
                        if (progressBar2.value < progressBar2.maximumValue)
                            progressBar2.value++;
                        else {
                            stop()
                            progressDialog.close()
                            progressBar2.value = progressBar2.minimumValue
                        }
                    }
                }

                Timer{
                    id: timeoutTimer

                    onTriggered: {
                        progressDialog.close()
                        progressBar2.value = progressBar2.minimumValue
                    }
                }
            }
        }

        buttonTexts: ["Cancel"]

        onButtonClicked:{
            reject()
            progressBarTimer.stop()
            timeoutTimer.stop()
            progressBar2.value = progressBar2.minimumValue
        }
    }
}

