/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "CustomTextField"
import "../Constants.js" as Constants

Page {
    id: page

    property string infoText: Constants.SEARCH_INFOTEXT
    property bool toolbarMode: false
    property bool groupsMode: false
    property bool nonProgressiveSearchMode: false

    tools: sharedToolbar

    state: toolbarMode ? "NORMAL" : "DIRECT_SEARCH"

    ToolBar{
        id: sharedToolbar

        tools: toolbarMode ? toolBarWithSearchButton : toolBarBackAndInfo
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

    ToolBarLayout {
        id: toolbarBackAndInfo

        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }

        ToolButton {
            flat: true
            iconSource: platformInverted ? "../Images/Icons/information_userguide_w.svg" : "../Images/Icons/information_userguide.svg"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.push(Qt.resolvedUrl("../InfoPage.qml"), {text: window.pageStack.currentPage.infoText});
        }
    }

    ContactsModel{
        id: contacts
    }

    Component {
        id: delegate

        ListItem {
            id: listItem

            platformInverted: window.platformInverted

            ListItemText {
                id: itemText

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: platformStyle.paddingLarge
                anchors.right: parent.right
                platformInverted: window.platformInverted
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap

                text: name
            }

            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                visible: groupsMode
                text: {
                    var groupsText = "Groups: "
                    for (var i=0; i<groups.length; i++)
                        groupsText += groups[i] + " "
                    return groupsText
                }
            }
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
            iconSource: window.platformInverted ? "../Images/Icons/light_back.svg" : "../Images/Icons/back.svg"
            visible: page.state == "SEARCHING"

            onClicked: {
                listView.model = contacts.contactsList
                page.state = "NORMAL"
            }
        }

        CustomTextField {
            id: searchInput

            anchors.left: searchCancelButton.visible ? searchCancelButton.right : parent.left
            anchors.leftMargin: searchCancelButton.visible ? platformStyle.paddingMedium : 0
            anchors.right: triggerSearchButton.visible ? triggerSearchButton.left : parent.right
            anchors.rightMargin: triggerSearchButton.visible ? platformStyle.paddingMedium : 0

            platformLeftMargin: searchImage.width
            platformRightMargin: cancelSearchImage.width

            LayoutMirroring.enabled: false

            horizontalAlignment: Text.AlignLeft

            platformInverted: window.platformInverted

            placeholderText: "Search contacts"

            onTextChanged: {
                if (!nonProgressiveSearchMode) {
                    if (text != "") {
                        listView.model = contacts.getFoundContactsModel(text, "")

                        searchInput.errorHighlight = listView.count == 0
                    }
                    else {
                        if (page.state == "SEARCHING")
                            listView.model = undefined
                        else
                            listView.model = contacts.contactsList
                    }
                }
                else{
                    listView.model = undefined
                    noMatchesLabel.visible = false
                    errorHighlight = false
                }
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

            visible: nonProgressiveSearchMode

            iconSource: {
                if (searchingBusyIndicator.running)
                    return platformInverted ? "../Images/Icons/light_pause.svg" : "../Images/Icons/pause_search.svg"
                else {
                    if (window.LayoutMirroring.enabled)
                        return platformInverted ? "../Images/Icons/search_next_r-l_light.svg" : "../Images/Icons/search_next_r-l.svg"
                    else
                        return platformInverted ? "../Images/Icons/search_next_l-r_light.svg" : "../Images/Icons/search_next_l-r.svg"
                }
            }

            onClicked: {
                if (searchingBusyIndicator.running) {
                    searchTimeoutTimer.stop()
                    searchingBusyIndicator.running = false
                    searchingBusyIndicator.visible = false
                }
                else {
                    searchingBusyIndicator.running = true
                    searchingBusyIndicator.visible = true
                    noMatchesLabel.visible = false
                    searchInput.errorHighlight = false
                    searchTimeoutTimer.restartWithRandomIntervalWithinRange(1000, 5000)
                    page.focus = true
                }
            }
        }
    }

    ScrollDecorator{
        flickableItem: listView
    }

    ListView {
        id: listView

        anchors.top: searchItem.visible ? searchItem.bottom : parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        header: Rectangle{
            height: 1
            width: parent.width
            color: window.platformInverted ? platformStyle.colorDisabledLightInverted
                                           : platformStyle.colorDisabledMid
        }

        clip: true
        model: contacts.contactsList
        delegate: delegate
    }

    Label{
        id: noMatchesLabel

        anchors.centerIn: listView
        platformInverted: window.platformInverted
        text: "No matches"
        visible: false
    }

    BusyIndicator{
        id: searchingBusyIndicator

        anchors.centerIn: listView
        platformInverted: window.platformInverted
        visible: false
    }

    Timer{
        id: searchTimeoutTimer

        function restartWithRandomIntervalWithinRange(from, to) {
            interval = from + Math.floor((Math.random() * (to - from) + 1))
            console.log("Timer interval: " + interval)
            restart()
        }

        interval: 3000

        onTriggered: {
            if (searchInput.text != "")
                listView.model = contacts.getFoundContactsModel(searchInput.text, "")
            else
                listView.model = contacts.contactsList

            searchingBusyIndicator.running = false
            searchingBusyIndicator.visible = false

            if (listView.count == 0) {
                noMatchesLabel.visible = true
                searchInput.errorHighlight = true
            }
        }
    }
    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "DIRECT_SEARCH"
        },
        State {
            name: "SEARCHING"
        }
    ]

    onStateChanged: {
        console.log("State changed to: " + state);
        switch(page.state) {
        case "NORMAL":{
            searchInput.text = ""
            listView.model = contacts.contactsList
            searchInput.text = ""
            page.focus = true
            if (toolbarMode)
                sharedToolbar.setTools(toolBarWithSearchButton)
            else
                sharedToolbar.setTools(toolbarBackAndInfo)
            break;
        }
        case "DIRECT_SEARCH":
            sharedToolbar.setTools(toolbarBackAndInfo)
            break;
        case "SEARCHING":{
            listView.model = undefined
            sharedToolbar.setTools(toolBarWithNoBackButton)
        }
            break;
        }
    }
}
