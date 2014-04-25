/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property bool doubleClickInProgress: false
    property double maximumImageScale: 3
    property double minimumImageScale: 0.5
    property double zoomStep: 0.2

    tools:
        ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.pop()
        }

        ToolButton{
            flat: true
            platformInverted: window.platformInverted
            iconSource: platformInverted ?
                            (enabled ? "../Images/Icons/zoom_in_w.svg" :  "../Images/Icons/zoom_in_disabled_w.svg" ):
                            (enabled ? "../Images/Icons/zoom_in.svg" : "../Images/Icons/zoom_in_disabled.svg")
            enabled: image.scale < maximumImageScale - zoomStep
            onClicked: image.zoomImageIn();
        }

        ToolButton{
            flat: true
            platformInverted: window.platformInverted
            iconSource: platformInverted ?
                            (enabled ? "../Images/Icons/zoom_out_w.svg" :  "../Images/Icons/zoom_out_disabled_w.svg" ):
                            (enabled ? "../Images/Icons/zoom_out.svg" : "../Images/Icons/zoom_out_disabled.svg")
            enabled: image.scale > minimumImageScale + zoomStep
            onClicked: image.zoomImageOut();
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.IMAGECONTROL_INFOTEXT});
        }
    }

    Timer {
        id: timer
        interval: 300

        onTriggered: {
            doubleClickInProgress = false;
        }
    }

    Image {
        id: image

        function zoomImageIn() {
            var imageScale = image.scale + zoomStep;
            image.setImageScale(imageScale);
        }

        function zoomImageOut() {
            var imageScale = image.scale - zoomStep;
            image.setImageScale(imageScale);
        }

        function setImageScale(scale) {
            if (scale >= minimumImageScale && scale <= maximumImageScale )
                image.scale = scale;
        }

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../Images/sample_image.jpg"
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit        

        PinchArea {
            id: pinchy

            anchors.fill: parent
            pinch.dragAxis: Pinch.XandYAxis
            pinch.minimumScale: 0.5
            pinch.maximumScale: 2
            onPinchUpdated: image.setImageScale(image.scale - pinch.previousScale + pinch.scale)
        }

        MouseArea{
            id: mouseArea

            anchors.fill: parent

            drag.target: image
            drag.axis: Drag.XandYAxis

            onReleased: {
                if (!drag.active) {
                    doubleClickInProgress = true;
                    timer.restart();
                }
            }

            onPressed:
            {
                if (doubleClickInProgress) {
                    if (image.scale == 1 && image.x == 0 && image.y == 0) {
                        image.scale = maximumImageScale;
                    }
                    else {
                    image.scale = 1;
                    image.anchors.verticalCenter = mainPage.verticalCenter;
                    image.anchors.horizontalCenter = mainPage.horizontalCenter;
                    doubleClickInProgress = false;
                    }
                }
                else {
                    image.anchors.verticalCenter = undefined;
                    image.anchors.horizontalCenter = undefined;
                }
            }
        }
    }
}
