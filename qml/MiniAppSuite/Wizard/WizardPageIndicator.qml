/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1

Rectangle {
    property int pageCount
    property int activePageIndex: 0

    function switchToNextWizardPage() {
        markIndicatorDisabled(activePageIndex);

        if (activePageIndex < repeater.count - 1) {
            activePageIndex++;
            markIndicatorEnabled(activePageIndex);
        }
    }

    function switchToPreviousWizardPage() {
        markIndicatorDisabled(activePageIndex);

        if (activePageIndex > 0) {
            activePageIndex--;
            markIndicatorEnabled(activePageIndex);
        }
    }

    function reset() {
        for(var i = 0; i < repeater.count; i++)
        {
            markIndicatorDisabled(i);
        }

        activePageIndex = 0;
        markIndicatorEnabled(activePageIndex);
    }

    function markIndicatorDisabled(index) {
        repeater.itemAt(index).color = "gray";
        repeater.itemAt(index).opacity = 0.5;
    }

    function markIndicatorEnabled(index) {
        repeater.itemAt(index).color = window.platformInverted ? platformStyle.colorNormalDark : platformStyle.colorNormalLight;
        repeater.itemAt(index).opacity = 1;
    }

    width: mainRow.implicitWidth
    height: 90

    color: "transparent"

    Row {
        id: mainRow

        anchors.verticalCenter: parent.top
        spacing: 12

         Repeater {
             id: repeater

             model: pageCount

             Rectangle {
                  width: 16
                  height: width
                  color: "gray"
                  border.color: "black"
                  opacity: 0.5
                  border.width: 1
                  radius: width/2
             }
         }
     }
}
