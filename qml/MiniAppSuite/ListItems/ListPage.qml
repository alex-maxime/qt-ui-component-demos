/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../Constants.js" as Constants
import "delegates"

Page {
    id: listPage

    property bool itemsDisabled: disableButton.checked

    tools: toolBar

    ToolBarLayout {
        id: toolBar

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            id: disableButton
            flat: true
            platformInverted: window.platformInverted
            checkable: true
            iconSource: platformInverted ? "../Images/Icons/lock_w.svg" : "../Images/Icons/lock.svg"
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: Constants.LISTITEMS_INFOTEXT});
        }
    }

    Flickable{
        anchors.fill: parent
        contentHeight: mainColumn.implicitHeight + platformStyle.paddingLarge

        Column{
            id: mainColumn
            SectionHeader{
                text: "Drill down - 1 line"
            }

            CustomListItem {
                subItemIndicator: true
                DrillDown1LineDelegate{
                    text: "Drill down item #1"
                }
            }

            CustomListItem {
                subItemIndicator: true
                DrillDown1LineDelegate{
                    text: "Drill down item #2"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                enabled: !itemsDisabled
                DrillDown1LineDelegate{
                    text: "Drill down item #3"
                }
            }

            SectionHeader{
                text: "Drill down - 2 lines"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                enabled: !itemsDisabled
                DrillDown2LinesDelegate{
                    text: "Drill down item #4"
                    subTitle: "2nd line of drill down item #4"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                enabled: !itemsDisabled
                DrillDown2LinesDelegate{
                    text: "Drill down item #5"
                    subTitle: "2nd line of drill down item #5"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                enabled: !itemsDisabled
                DrillDown2LinesDelegate{
                    text: "Drill down item #6"
                    subTitle: "2nd line of drill down item #6"
                }
            }

            SectionHeader{
                text: "Drill down - 1 line - thumbnail"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                enabled: !itemsDisabled
                DrillDown1LineDelegate{
                    text: "List title #7"
                    image: "Images/squircles/squircle-mug.png"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                DrillDown1LineDelegate{
                    text: "List title #8"
                    image: "Images/squircles/squircle-bile.png"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                DrillDown1LineDelegate{
                    text: "List title #9"
                    image: "Images/squircles/squircle-fabrics.png"
                }
            }

            SectionHeader{
                text: "Drill down - 2 lines - thumbnail"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                DrillDown2LinesDelegate{
                    text: "Drill down item #10"
                    subTitle: "2nd line of drill down item #10"
                    image: "Images/squircles/squircle-foto-guy.png"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                DrillDown2LinesDelegate{
                    text: "Drill down item #11"
                    subTitle: "2nd line of drill down item #11"
                    image: "Images/squircles/squircle-kitchen.png"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                subItemIndicator: true
                DrillDown2LinesDelegate{
                    text: "Drill down item #12"
                    subTitle: "2nd line of drill down item #12"
                    image: "Images/squircles/squircle-mug.png"
                }
            }

            SectionHeader{
                text: "Content - 3 lines - indicators - time"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                height: contentItem1.height + 2 * platformStyle.paddingLarge
                Content3LinesIndicatorsDelegate{
                    id: contentItem1
                    text: "Content item #1"
                    subTitle1: "2nd line of content item #1"
                    subTitle2: "3rd line of content item #1"
                    indicator1ImageSource: "../../Images/Icons/indi_tiny_new.svg"
                    indicatorText: "12:10"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                height: contentItem2.height + 2 * platformStyle.paddingLarge
                Content3LinesIndicatorsDelegate{
                    id: contentItem2
                    text: "Content item #2"
                    subTitle1: "2nd line of content item #2"
                    subTitle2: "3rd line of content item #2"
                    indicator1ImageSource: "../../Images/Icons/indi_tiny_new.svg"
                    indicator2ImageSource: "../../Images/Icons/indi_tiny_attachment.svg"
                    indicatorText: "07:00"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                height: contentItem3.height + 2 * platformStyle.paddingLarge
                Content3LinesIndicatorsDelegate{
                    id: contentItem3
                    text: "Content item #3"
                    subTitle1: "2nd line of content item #3"
                    subTitle2: "3rd line of content item #3"
                    indicator1ImageSource: "../../Images/Icons/indi_tiny_flag.svg"
                    indicator2ImageSource: "../../Images/Icons/indi_tiny_attachment.svg"
                    indicatorText: "22:17"
                    checked: true
                }

                Rectangle{
                    anchors.left: parent.left
                    height: parent.height
                    width: platformStyle.paddingSmall
                    color: "green"
                }
            }

            SectionHeader{
                text: "Check box"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                CheckBoxDelegate{
                    id: checkboxItem1
                    text: "Check box item #1"
                }

                onClicked: checkboxItem1.checked = !checkboxItem1.checked
            }

            CustomListItem {
                platformInverted: window.platformInverted
                CheckBoxDelegate{
                    id: checkboxItem2
                    text: "Check box item #2"
                }

                onClicked: checkboxItem2.checked = !checkboxItem2.checked
            }

            CustomListItem {
                platformInverted: window.platformInverted
                CheckBoxDelegate{
                    id: checkboxItem3
                    text: "Check box item #3"
                }

                onClicked: checkboxItem3.checked = !checkboxItem3.checked
            }

            SectionHeader{
                text: "Switch"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SwitchDelegate{
                    text: "Switch #1"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SwitchDelegate{
                    text: "Switch #2"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SwitchDelegate{
                    text: "Switch #3"
                }
            }

            SectionHeader{
                text: "Radio button group"
            }

            CheckableGroup{
                id: group
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RadioButtonDelegate{
                    id: radioButtonItem1
                    text: "Radio button #1"
                    exclusiveGroup: group
                }

                onClicked: radioButtonItem1.checked = true
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RadioButtonDelegate{
                    id: radioButtonItem2
                    text: "Radio button #2"
                    exclusiveGroup: group
                }

                onClicked: radioButtonItem2.checked = true
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RadioButtonDelegate{
                    id: radioButtonItem3
                    text: "Radio button #3"
                    exclusiveGroup: group
                }

                onClicked: radioButtonItem3.checked = true
            }


            SectionHeader{
                text: "Selector - value only"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                }
            }

            SectionHeader{
                text: "Selector - header and value"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                    itemText: "Selector item #4 (Dialog)"
                    oneLineMode: false
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                    itemText: "Selector item #5 (Sub-view)"
                    oneLineMode: false
                    dialogMode: false
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                SelectorDelegate{
                    itemText: "Selector item #6 (Sub-view)"
                    oneLineMode: false
                    dialogMode: false
                    checkableSubViewMode: false
                }
            }


            SectionHeader{
                text: "Additional items - rating"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RatingDelegate{
                    text: "List item #1"
                    rating: 3
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RatingDelegate{
                    text: "List item #2"
                    rating: 4
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RatingDelegate{
                    text: "List item #3"
                    rating: 5
                }
            }

            SectionHeader{
                text: "Additional items - rating and thumbnail"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RatingDelegate{
                    text: "List item #1"
                    image: "Images/squircles/squircle-sleeper.png"
                    rating: 4
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                RatingDelegate{
                    text: "List item #2"
                    image: "Images/squircles/squircle-tea-shop-guy.png"
                    rating: 3
                }
            }

            SectionHeader{
                text: "Additional items - progress bar"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                ProgressBarDelegate{
                    text: "List item #1"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                ProgressBarDelegate{
                    text: "List item #2"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                ProgressBarDelegate{
                    text: "List item #3"
                }
            }

            SectionHeader{
                text: "Status icons - status icon and thumbnail"
            }

            CustomListItem {
                platformInverted: window.platformInverted
                StatusIconDelegate{
                    text: "List item #1"
                    image: "Images/squircles/squircle-tree-friends.png"
                    statusIconSource: "../../Images/Icons/indi_answered.svg"
                }
            }

            CustomListItem {
                platformInverted: window.platformInverted
                StatusIconDelegate{
                    text: "List item #2"
                    image: "Images/squircles/squircle-mug.png"
                    statusIconSource: "../../Images/Icons/indi_called.svg"
                }
            }

            CustomListItem {
                StatusIconDelegate{
                    text: "List item #3"
                    image: "Images/squircles/squircle-fabrics.png"
                    statusIconSource: "../../Images/Icons/indi_missed.svg"
                }
            }

            SectionHeader{
                text: "Status icons - status icon at thumbnail"
            }

            CustomListItem {
                StatusIconDelegate{
                    text: "List item #1"
                    image: "Images/squircles/squircle-tree-friends.png"
                    statusIconSource: "../../Images/Icons/indi_tiny_online.svg"
                    statusIconOnThumbnail: true
                }
            }

            CustomListItem {
                StatusIconDelegate{
                    text: "List item #2"
                    image: "Images/squircles/squircle-mug.png"
                    statusIconSource: "../../Images/Icons/indi_tiny_busy.svg"
                    statusIconOnThumbnail: true
                }
            }

            CustomListItem {
                StatusIconDelegate{
                    text: "List item #3"                    
                    image: "Images/squircles/squircle-fabrics.png"
                    statusIconSource: "../../Images/Icons/indi_tiny_away.svg"
                    statusIconOnThumbnail: true
                }
            }
        }
    }
}
