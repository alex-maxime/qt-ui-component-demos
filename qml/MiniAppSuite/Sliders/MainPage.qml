/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.SLIDERS_INFOTEXT

    tools: toolBarBackAndInfo

    ToolBarLayout {
        id: toolBarBackAndInfo

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.pop()
        }

        ToolButton {
            platformInverted: window.platformInverted
            text: "Refresh"
            onClicked: {
                customSlider.reset()
            }
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: window.pageStack.currentPage.infoText});
        }
    }

    Flickable{
        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: col.implicitHeight

        Column{
            id: col

            width: parent.width

            Column{
                id: standardSlidersColumn

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width

                ListHeading{
                    id: heading

                    width: parent.width

                    platformInverted: window.platformInverted

                    Label{
                        anchors.right: parent.right
                        anchors.rightMargin: platformStyle.paddingLarge
                        anchors.verticalCenter: parent.verticalCenter
                        platformInverted: window.platformInverted

                        text: "Standard sliders"
                    }
                }

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    height: childrenRect.height
                    width: parent.width

                    Label{
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: platformStyle.paddingMedium
                        platformInverted: window.platformInverted

                        text: "Basic slider"
                    }
                }

                Slider{
                    id: slider

                    width: parent.width

                    platformInverted: window.platformInverted

                    minimumValue: 0
                    maximumValue: 128

                    onValueChanged: {
                        toolTip1.visible = true
                        toolTip1.opacity = 1
                        toolTip1Timer.restart()
                    }

                    Timer{
                        id: toolTip1Timer

                        interval: 1000

                        onTriggered: {
                            toolTip1.opacity = 0
                        }
                    }

                    ToolTip {
                        id: toolTip1

                        platformInverted: window.platformInverted
                        text: Math.round(slider.value)
                        target: slider
                        visible: false
                        opacity: 0
                        z:33

                        Behavior on opacity {
                            NumberAnimation {duration: 200;}
                        }
                    }
                }

                Rectangle{
                    width: mainPage.width
                    height: 1
                    color: "gray"
                }

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    height: childrenRect.height
                    width: parent.width

                    Label{
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: platformStyle.paddingMedium

                        platformInverted: window.platformInverted

                        text: "Slider with buttons"
                    }
                }

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    height: slider1.height + 2 * platformStyle.paddingMedium
                    width: parent.width

                    LayoutMirroring.enabled: false
                    LayoutMirroring.childrenInherit: true

                    Button{
                        id: decreaseButton

                        platformInverted: window.platformInverted
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: platformInverted ? "../Images/Icons/minus_button_light_theme.svg" : "../Images/Icons/minus_button.svg"
                        onClicked: slider1.value -= 8
                    }

                    Slider{
                        id: slider1

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        width: parent.width - 2 * decreaseButton.width - 2 * platformStyle.paddingLarge
                        platformInverted: window.platformInverted

                        minimumValue: 0
                        maximumValue: 128

                        onValueChanged: {
                            toolTip2.visible = true
                            toolTip2.opacity = 1
                            toolTip2Timer.restart()
                        }

                        Timer{
                            id: toolTip2Timer

                            interval: 1000

                            onTriggered: {
                                toolTip2.opacity = 0
                            }
                        }

                        ToolTip {
                            id: toolTip2

                            platformInverted: window.platformInverted
                            text: Math.round(slider1.value)
                            target: slider1
                            visible: false
                            opacity: 0
                            z:33

                            Behavior on opacity {
                                NumberAnimation {duration: 200;}
                            }
                        }
                    }

                    Button{
                        id: increaseButton

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        platformInverted: window.platformInverted
                        iconSource: platformInverted ? "../Images/Icons/plus_button_light_theme.svg" : "../Images/Icons/plus_button.svg"
                        onClicked: slider1.value += 8
                    }
                }

                Rectangle{
                    width: mainPage.width
                    height: 1
                    color: "gray"
                }

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    height: childrenRect.height
                    width: parent.width

                    Label{
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: platformStyle.paddingMedium
                        platformInverted: window.platformInverted

                        text: "Slider with counters"
                    }
                }

                Item{
                    width: parent.width
                    height: childrenRect.height + platformStyle.paddingLarge

                    Slider{
                        id: slider2

                        platformInverted: window.platformInverted
                        anchors.top: parent.top
                        width: parent.width

                        minimumValue: 0
                        maximumValue: 128
                    }

                    Label{
                        anchors.top: slider2.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: platformStyle.paddingLarge
                        platformInverted: window.platformInverted
                        text: Math.round(slider2.value)
                    }

                    Label{
                        anchors.top: slider2.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: platformStyle.paddingLarge
                        platformInverted: window.platformInverted
                        text: Math.round(slider2.maximumValue - slider2.value)
                    }
                }

                Rectangle{
                    width: mainPage.width
                    height: 1
                    color: "gray"
                }

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    height: childrenRect.height
                    width: parent.width

                    Label{
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: platformStyle.paddingMedium

                        platformInverted: window.platformInverted

                        text: "Slider with color fill"
                    }
                }

                SliderWithColorFill{
                    id: slider3

                    width: parent.width

                    platformInverted: window.platformInverted

                    minimumValue: 0
                    maximumValue: 128

                    onValueChanged: {
                        toolTip3.visible = true
                        toolTip3.opacity = 1
                        toolTip1Timer3.restart()
                    }

                    Timer{
                        id: toolTip1Timer3

                        interval: 1000

                        onTriggered: {
                            toolTip3.opacity = 0
                        }
                    }

                    ToolTip {
                        id: toolTip3

                        platformInverted: window.platformInverted
                        text: Math.round(slider3.value)
                        target: slider3
                        visible: false
                        opacity: 0
                        z:33

                        Behavior on opacity {
                            NumberAnimation {duration: 200;}
                        }
                    }
                }
            }

            ListHeading{
                id: customSliderHeading

                width: parent.width
                platformInverted: window.platformInverted

                Label{
                    anchors.right: parent.right
                    anchors.rightMargin: platformStyle.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    platformInverted: window.platformInverted
                    text: "Custom slider"
                }
            }

            Column{
                width: parent.width

                Item{
                    anchors.left: parent.left
                    anchors.leftMargin: platformStyle.paddingLarge
                    height: childrenRect.height + platformStyle.paddingMedium
                    width: parent.width

                    Label{
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: platformStyle.paddingMedium
                        platformInverted: window.platformInverted

                        text: "Playback and download"
                    }
                }

                CustomSlider{
                    id: customSlider

                    anchors.left: parent.left
                    anchors.right: parent.right

                    minimumValue: 0
                    maximumValue: 128

                    onValueChanged: {
                        if (isHandled) {
                            toolTip4.visible = true
                            toolTip4.opacity = 1
                            toolTip4Timer.restart()
                        }
                    }

                    Timer{
                        id: toolTip4Timer

                        interval: 1000

                        onTriggered: {
                            toolTip4.opacity = 0
                        }
                    }

                    ToolTip {
                        id: toolTip4

                        platformInverted: window.platformInverted
                        text: Math.round(customSlider.value)
                        target: customSlider
                        visible: false
                        opacity: 0
                        z:33

                        Behavior on opacity {
                            NumberAnimation {duration: 200;}
                        }
                    }
                }
            }
        }
    }
}
