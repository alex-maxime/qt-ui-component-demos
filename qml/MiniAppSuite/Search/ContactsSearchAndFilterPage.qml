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
            onClicked: page.state = "FILTERING"
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
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft

                text: name
            }

            ListItemText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: platformStyle.paddingLarge
                platformInverted: window.platformInverted
                text: {
                    var groupsText = "Group "
                    for (var i=0; i<groups.length; i++) {
                        groupsText += groups[i]
                        if (i < groups.length - 1) {
                            groupsText += ", "
                        }
                    }
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
            iconSource: window.platformInverted ? "../Images/Icons/toolbar-back_inverse.svg" : "../Images/Icons/toolbar-back.svg"

            onClicked: {
                listView.model = contacts.contactsList
                page.state = "NORMAL"
            }
        }

        CustomTextField {
            id: searchInput

            function copy() {
                var contacts = contacts.getFoundContactsModel(text, "1")

                var a = new Array()

                for (var i=0; i<contacts.length; i++) {
                    groupsText += groups[i]
                    if (i < groups.length - 1)
                        groupsText += ", "
                }
            }

            platformLeftMargin: searchImage.width
            platformRightMargin: cancelSearchImage.width
            anchors.left: searchCancelButton.right
            anchors.leftMargin: platformStyle.paddingMedium
            anchors.right: parent.right

            LayoutMirroring.enabled: false

            horizontalAlignment: Text.AlignLeft

            platformInverted: window.platformInverted

            placeholderText: "Search contacts"

            onTextChanged: {
                if (text != "") {
                    listView1.foundContactsModel = contacts.getFoundContactsArray(text, "1")
                    listView2.foundContactsModel = contacts.getFoundContactsArray(text, "2")
                    listView3.foundContactsModel = contacts.getFoundContactsArray(text, "3")
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
    }

    TabBarLayout {
        id: tabBar

        anchors { left: parent.left; right: parent.right; top: searchItem.bottom }
        TabButton { tab: listView1; platformInverted: window.platformInverted; text: "Group 1" }
        TabButton { tab: listView2; platformInverted: window.platformInverted; text: "Group 2" }
        TabButton { tab: listView3; platformInverted: window.platformInverted; text: "Group 3" }
        z: 2
        visible: page.state == "FILTERING"
    }

    TabGroup {
        id: tabGroup

        anchors { left: parent.left; right: parent.right; top: tabBar.bottom ; bottom: parent.bottom }
        z: 2
        visible: page.state == "FILTERING"

        // FoundContactsListView the content for tab 1
        FoundContactsListView {
            id: listView1

            anchors.fill: parent
            delegate: delegate
            model: searchInput.text != "" ? foundContactsModel : undefined

            ScrollDecorator{
                flickableItem: listView1
            }
        }

        // define the content for tab 2
        FoundContactsListView {
            id: listView2

            anchors.fill: parent
            delegate: delegate
            model: searchInput.text != "" ? foundContactsModel : undefined

            ScrollDecorator{
                flickableItem: listView2
            }
        }

        // define content for tab 3
        FoundContactsListView {
            id: listView3

            anchors.fill: parent
            delegate: delegate
            model: searchInput.text != "" ? foundContactsModel : undefined

            ScrollDecorator{
                flickableItem: listView3
            }
        }
    }

    ScrollDecorator{
        flickableItem: listView
        visible: page.state == "NORMAL"
    }

    ListView {
        id: listView

        anchors.top: searchItem.visible ? searchItem.bottom : parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        clip: true
        model: contacts.contactsList
        delegate: delegate
    }

    Label{
        id: noMatchesLabel

        anchors.centerIn: tabGroup
        platformInverted: window.platformInverted
        visible: searchInput.text.length > 0 && tabGroup.currentTab.count == 0
        text: "No matches"

        onVisibleChanged: {
            console.log("visible: " + visible)
        }
    }

    states: [
        State {
            name: "NORMAL"
        },
        State {
            name: "FILTERING"
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
            sharedToolbar.setTools(toolBarWithSearchButton)
        }
        break;
        case "FILTERING":{
            listView.model = undefined
            sharedToolbar.setTools(toolBarWithNoBackButton)
        }
        break;
        }
    }
}
