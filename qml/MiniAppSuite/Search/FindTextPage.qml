/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "CustomTextField"
import "../Constants.js" as Constants

Page {
    id: page

    property string infoText: Constants.SEARCH_INFOTEXT

    tools: sharedToolbar

    state: "NORMAL"

    ToolBar{
        id: sharedToolbar

        tools: toolBarWithSearchButton
        platformInverted: window.platformInverted
    }


    ToolBarLayout {
        id: toolBarWithSearchButton

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-search"
            platformInverted: window.platformInverted
            onClicked: page.state = "SEARCHING"
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: window.pageStack.currentPage.infoText});
        }
    }

    ToolBarLayout {
        id: toolBarWithNoBackButton

        ToolButton {
            flat: true
        }

        ToolButton {
            flat: true
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: window.pageStack.currentPage.infoText});
        }
    }

    Item{
        id: searchItem

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: platformStyle.paddingMedium

        height: searchInput.height + platformStyle.paddingLarge

        visible: page.state != "NORMAL"

        Button{
            id: searchCancelButton

            anchors.left: parent.left
            anchors.verticalCenter: searchInput.verticalCenter

            LayoutMirroring.enabled: false

            platformInverted: window.platformInverted
            iconSource: window.platformInverted ? "../Images/Icons/toolbar-back_inverse.svg" : "../Images/Icons/toolbar-back.svg"

            onClicked: {
                page.state = "NORMAL"
            }
        }

        CustomTextField {
            id: searchInput

            anchors.left: searchCancelButton.right
            anchors.leftMargin: platformStyle.paddingMedium
            anchors.right: triggerSearchButton.left
            anchors.rightMargin: platformStyle.paddingMedium

            platformLeftMargin: searchImage.width
            platformRightMargin: cancelSearchImage.width

            horizontalAlignment: Text.AlignLeft

            platformInverted: window.platformInverted

            placeholderText: "Search"

            LayoutMirroring.enabled: false

            onTextChanged: {
                matchesLabel.visible = false
                mainLabel.text = mainLabel.referenceText
                mainLabel.searchedTextOccurenceCount = 0
                mainLabel.markedFoundTextIndex = 0
            }

            Image {
                id: searchImage

                anchors { top: parent.top; left: parent.left; bottom: parent.bottom}
                fillMode: Image.PreserveAspectFit
                source: "../Images/Icons/graf_search_indicator.svg"
                height: parent.height
                width: parent.height

                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        console.log("Search image clicked")
                    }
                }
            }

            Image {
                id: cancelSearchImage

                anchors { top: parent.top; right: parent.right; bottom: parent.bottom}
                fillMode: Image.PreserveAspectFit
                source: "../Images/Icons/graf_textfield_clear_normal.svg"
                height: parent.height
                width: parent.height

                visible: searchInput.text != ""

                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        console.log("Search cancel image clicked")
                        searchInput.text = ""
                    }
                }
            }
        }

        Button{
            id: triggerSearchButton

            anchors.right: parent.right
            anchors.verticalCenter: searchInput.verticalCenter
            platformInverted: window.platformInverted

            LayoutMirroring.enabled: false

            iconSource: {
                    if (window.LayoutMirroring.enabled)
                        return platformInverted ? "../Images/Icons/search_next_r-l_light.svg" : "../Images/Icons/search_next_r-l.svg"
                    else
                        return platformInverted ? "../Images/Icons/search_next_l-r_light.svg" : "../Images/Icons/search_next_l-r.svg"
            }

            onClicked: {
                if (searchInput.text != "") {
                    matchesLabel.visible = true
                    mainLabel.markNextFoundText(searchInput.text)
                    page.focus = true
                }
            }
        }
    }

    ScrollDecorator{
        flickableItem: flickable
        visible: page.state == "NORMAL"
    }

    ListHeading{
        id: heading

        anchors.top: page.state == "SEARCHING" ? searchItem.bottom : parent.top

        platformInverted: window.platformInverted

        Label{
            id: headerLabel

            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter

            platformInverted: window.platformInverted

            visible: !matchesLabel.visible

            text: "Lorem ipsum document"
        }
        Label{
            id: matchesLabel

            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingLarge
            anchors.verticalCenter: parent.verticalCenter

            platformInverted: window.platformInverted

            visible: false

            text: {
                var matchIndex
                if (mainLabel.searchedTextOccurenceCount == 0)
                    matchIndex = 0
                else {
                    if (mainLabel.markedFoundTextIndex == 0)
                        matchIndex = mainLabel.searchedTextOccurenceCount
                    else
                        matchIndex = mainLabel.markedFoundTextIndex
                }

                return "Match " + matchIndex + " of " + mainLabel.searchedTextOccurenceCount
            }
        }
    }

    Flickable{
        id: flickable

        anchors.top: heading.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        contentHeight: mainLabel.implicitHeight + 2 * platformStyle.paddingLarge

        clip: true

        Label{
            id: mainLabel

            property int searchedTextOccurenceCount: 0
            property int markedFoundTextIndex: 0

            property string referenceText: Constants.LOREM_IPSUM_TEXT + Constants.LOREM_IPSUM_TEXT

            function markNextFoundText(searchedText) {
                var currentIndex = 0
                var index = 0
                var occurenceCount = 0
                var textToSearchIn = referenceText

                var tagsTextLength = ( flickable.LayoutMirroring.enabled ?
                                          Constants.PARAGRAPH_RIGHT_OPEN_HTML_TAG.length :
                                          Constants.PARAGRAPH_LEFT_OPEN_HTML_TAG.length ) +
                        Constants.HIGHLIGT_FONT_OPEN_HTML_TAG.length +
                        Constants.HIGHLIGT_FONT_CLOSE_HTML_TAG.length

                while((index = referenceText.toLowerCase().indexOf(searchedText.toLowerCase(), currentIndex)) != -1) {
                    if (occurenceCount == markedFoundTextIndex) {

                        textToSearchIn = (flickable.LayoutMirroring.enabled ? Constants.PARAGRAPH_RIGHT_OPEN_HTML_TAG : Constants.PARAGRAPH_LEFT_OPEN_HTML_TAG)
                                + textToSearchIn.substr(0, index)
                                + Constants.HIGHLIGT_FONT_OPEN_HTML_TAG
                                + textToSearchIn.substr(index , searchedText.length)
                                + Constants.HIGHLIGT_FONT_CLOSE_HTML_TAG
                                + textToSearchIn.substr(index + searchedText.length, textToSearchIn.length)
                                + Constants.PARAGRAPH_CLOSE_HTML_TAG
                    }

                    currentIndex = index + searchedText.length
                    occurenceCount++
                }

                searchedTextOccurenceCount = occurenceCount

                if (markedFoundTextIndex < occurenceCount -1)
                    markedFoundTextIndex++
                else {
                    markedFoundTextIndex = 0
                }

                text = textToSearchIn
            }

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left

            anchors.margins: platformStyle.paddingLarge
            platformInverted: window.platformInverted;
            wrapMode: Text.WordWrap
            horizontalAlignment: anchors.mirrored ? Text.AlignRight : Text.AlignLeft
            text: referenceText            
        }
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "SEARCHING"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);
        switch(page.state) {
        case "NORMAL":{
            sharedToolbar.setTools(toolBarWithSearchButton)
            mainLabel.text = mainLabel.referenceText
            matchesLabel.visible = false
            searchInput.text = ""
            page.focus = true
        }
        break;
        case "SEARCHING":
            sharedToolbar.setTools(toolBarWithNoBackButton)
            break;
        }
    }
}
