/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import "../Constants.js" as Constants

Item {
    id: main

    height: handleItem.height

    property int minimumValue: 0
    property int maximumValue: 0
    property int value: 0
    property int bufferedValue: 0

    property int range: maximumValue - minimumValue
    property double singleStepPeriod: Constants.PLAYBACK_SLIDER_TIME / range

    property alias isHandled: handleItem.active

    property bool toBeReset: false

    function reset() {
        if (progressTimer.running)
            toBeReset = true
        else {
            value = 0
            bufferedValue = 0
            progressTimer.start()
        }
    }

    Binding {
        target: main

        when: handleItem.active
        property: "value"
        value: handleItem.x * (range) /
               (track.x + track.width - handle.width - platformStyle.paddingLarge)
    }

    BorderImage {
        id: track

        anchors.centerIn: parent
        width: parent.width - 2 * platformStyle.paddingLarge
        height: privateStyle.sliderThickness

        source: window.platformInverted ? "../Images/Icons/qtg_fr_slider_h_track_normal_inverse.svg"
                                        : "../Images/Icons/qtg_fr_slider_h_track_normal.svg"

        border {
            left: 20
            right: 20
            top: 0
            bottom: 0
        }

        BorderImage {
            id: bufferedRail

            function increaseProgressSmoothly(val) {
                progressWidthBehavior.enabled = true

                if (main.bufferedValue <= (main.range - val ) ) {
                    progressWidthBehavior.bufferedValueChangeRange = val
                    main.bufferedValue += val
                }

                progressWidthBehavior.enabled = false
            }

            source: "../Images/Icons/green_bar.svg"

            border {
                left: 20
                right: 20
                top: 0
                bottom: 0
            }

            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 1
            anchors.left: parent.left

            height: 8
            width: bufferedValue >= range ? track.width - 2 :
                                            ( parent.width * bufferedValue ) / range

            LayoutMirroring.enabled: false

            // Behavior for smooth widht change when progress value changes
            Behavior on width {
                id: progressWidthBehavior

                property int bufferedValueChangeRange: 0

                enabled: false
                NumberAnimation{
                    duration: progressWidthBehavior.bufferedValueChangeRange != 0 ?
                              main.singleStepPeriod / progressWidthBehavior.bufferedValueChangeRange : 0
                }
            }
        }

        BorderImage {
            id: playbackRail

            anchors.left: track.left
            anchors.leftMargin: 1
            anchors.verticalCenter: track.verticalCenter

            width: handleItem.x + handleItem.width/2 - 2
            height: 8

            LayoutMirroring.enabled: false

            source: "../Images/Icons/blue_bar.svg"

            border {
                left: 20
                right: 20
                top: 0
                bottom: 0
            }
        }
    }

    Item{
        id: handleItem

        property bool active: false

        function increaseValueSmoothly(val) {
            handleItemXBehavior.enabled = true

            if (!active && main.value <= (main.maximumValue - val)) {
                handleItemXBehavior.valueChangeRange = val
                main.value += val
            }

            handleItemXBehavior.enabled = false
        }

        height: handle.height + 2 * platformStyle.paddingLarge
        width: handle.width + 2 * platformStyle.paddingLarge

        anchors.verticalCenter: track.verticalCenter
        x: 0        

        Binding{
            target: handleItem

            when: !handleItem.active
            property: "x"
            value: main.value > main.maximumValue ? track.width - handle.width :
                                                    ((track.width - handle.width) * main.value) / main.range
        }

        // Behavior for smooth handle moving when value changes
        Behavior on x {
            id: handleItemXBehavior

            property int valueChangeRange: 0

            enabled: false
            NumberAnimation{ id: handleXAnimation
                             duration: handleItemXBehavior.valueChangeRange != 0 ?
                                       main.singleStepPeriod / handleItemXBehavior.valueChangeRange : 0 }

        }

        Image{
            id: handle

            anchors.centerIn: parent
            sourceSize.height: platformStyle.graphicSizeSmall
            sourceSize.width: platformStyle.graphicSizeSmall

            source: window.platformInverted ? "../Images/Icons/qtg_graf_slider_handle_normal_inverse.svg" :
                                              "../Images/Icons/qtg_graf_slider_handle_normal.svg"
        }

        MouseArea{
            id: mouseArea

            property bool isDragged: false

            anchors.fill: parent

            drag.target: handleItem
            drag.axis: Drag.XandYAxis
            drag.minimumX: 0
            drag.maximumX: bufferedRail.width - handle.width
            drag.minimumY: 0
            drag.maximumY: 0

            onPressed: {
                handle.source = "../Images/Icons/qtg_graf_slider_handle_pressed.svg"
                handleItem.active = true
            }

            onReleased: {
                handle.source = window.platformInverted ? "../Images/Icons/qtg_graf_slider_handle_normal_inverse.svg" :
                                                          "../Images/Icons/qtg_graf_slider_handle_normal.svg"
                handleItem.active = false
            }
        }
    }

    Timer{
        id: progressTimer

        interval: main.singleStepPeriod
        repeat: true

        onTriggered: {
            if (toBeReset) {
                value = 0
                bufferedValue = 0
                main.toBeReset = false
                restart()
            }

            bufferedRail.increaseProgressSmoothly(2)
            handleItem.increaseValueSmoothly(1)

            if (main.value >= main.maximumValue)
                stop()
        }
    }

    Component.onCompleted: {
        progressTimer.start()
    }
}
