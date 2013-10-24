/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.TUMBLERS_INFOTEXT

    tools: toolBarBackAndInfo

    Column{
        width: parent.width

        SelectionListItem {
            id: item1

            title: "1 drum (looping)"
            subTitle: daysModel.get(dayColumn.currentIndex).value

            platformInverted: window.platformInverted

            onClicked: selectionDialog1.open()

            ListModel {
                id: daysModel

                ListElement { value: "Monday" }
                ListElement { value: "Tuesday" }
                ListElement { value: "Wednesday" }
                ListElement { value: "Thursday" }
                ListElement { value: "Friday" }
                ListElement { value: "Saturday" }
                ListElement { value: "Sunday" }
            }

            TumblerColumn {
                id: dayColumn

                property int currentIndex: 0

                items: daysModel
            }

            TumblerDialog {
                id: selectionDialog1

                titleText: item1.title
                columns: dayColumn
                acceptButtonText: "Done"
                rejectButtonText: "Cancel"
                platformInverted: window.platformInverted

                onAccepted: dayColumn.currentIndex = dayColumn.selectedIndex

                onRejected: dayColumn.selectedIndex = dayColumn.currentIndex
            }
        }

        SelectionListItem {
            id: item2

            title: "2 drums (all non-looping)"
            platformInverted: window.platformInverted

            onClicked: selectionDialog2.open()

            ListModel {id: hours24list}
            ListModel {
                id: minutesList

                ListElement { value: "00" }
                ListElement { value: "15" }
                ListElement { value: "30" }
                ListElement { value: "45" }
            }

            TumblerColumn {
                id: hourColumn1                

                property int currentIndex: 0

                privateLoopAround: false
                items: hours24list
            }

            TumblerColumn {
                id: minutesColumn1

                property int currentIndex: 0

                privateLoopAround: false
                items: minutesList
            }

            TumblerDialog {
                id: selectionDialog2

                titleText: item2.title
                columns: [hourColumn1, minutesColumn1]
                acceptButtonText: "Done"
                rejectButtonText: "Cancel"
                platformInverted: window.platformInverted

                onAccepted: {
                    hourColumn1.currentIndex = hourColumn1.selectedIndex
                    minutesColumn1.currentIndex = minutesColumn1.selectedIndex
                    item2.subTitle = hours24list.get(hourColumn1.currentIndex).value + ":" +
                                     minutesList.get(minutesColumn1.currentIndex).value + " "
                }

                onRejected: {
                    minutesColumn1.selectedIndex = minutesColumn1.currentIndex
                    hourColumn1.selectedIndex = hourColumn1.currentIndex
                }
            }

            Component.onCompleted: {
                for (var hour = 0; hour <= 23; hour++) {
                    hours24list.append({"value" : hour});
                }
                item2.subTitle = hours24list.get(hourColumn1.currentIndex).value + ":" +
                                 minutesList.get(minutesColumn1.currentIndex).value
            }
        }

        SelectionListItem {
            id: item3

            title: "3 drums (mixed)"
            platformInverted: window.platformInverted

            onClicked: selectionDialog3.open()

            ListModel {id: hourslist}

            ListModel {
                id: timePeriodList

                ListElement { value: "AM" }
                ListElement { value: "PM" }
            }

            TumblerColumn {
                id: hourColumn2

                property int currentIndex: 0

                items: hourslist
            }

            TumblerColumn {
                id: minutesColumn2

                property int currentIndex: 0

                items: minutesList
            }

            TumblerColumn {
                id: periodColumn

                property int currentIndex: 0

                privateLoopAround: false
                items: timePeriodList
            }

            TumblerDialog {
                id: selectionDialog3

                titleText: item3.title
                columns: [hourColumn2, minutesColumn2, periodColumn]
                acceptButtonText: "Done"
                rejectButtonText: "Cancel"
                platformInverted: window.platformInverted

                onAccepted: {
                    hourColumn2.currentIndex = hourColumn2.selectedIndex
                    minutesColumn2.currentIndex = minutesColumn2.selectedIndex
                    periodColumn.currentIndex = periodColumn.selectedIndex

                    item3.subTitle = hourslist.get(hourColumn2.currentIndex).value + ":" +
                                     minutesList.get(minutesColumn2.currentIndex).value + " " +
                                     timePeriodList.get(periodColumn.currentIndex).value + " "
                }

                onRejected: {
                    minutesColumn2.selectedIndex = minutesColumn2.currentIndex
                    hourColumn2.selectedIndex = hourColumn2.currentIndex
                    periodColumn.selectedIndex = periodColumn.currentIndex
                }
            }

            Component.onCompleted: {
                for (var hour = 1; hour <= 12; hour++) {
                    hourslist.append({"value" : hour});
                }
                item3.subTitle = hourslist.get(hourColumn2.currentIndex).value + ":" +
                                 minutesList.get(minutesColumn2.currentIndex).value + " " +
                                 timePeriodList.get(periodColumn.currentIndex).value + " "
            }
        }
    }
}
