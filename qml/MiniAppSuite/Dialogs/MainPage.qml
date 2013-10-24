/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../Constants.js" as Constants

Page {
    id: mainPage

    property string infoText: Constants.DIALOGS_INFOTEXT

    tools: toolBarBackAndInfo

    ScrollDecorator{
        flickableItem: flickable
    }

    Flickable{
        id: flickable

        anchors.fill: parent
        width: parent.width
        clip: true

        contentHeight: col.implicitHeight

        Column{
            id: col

            width: parent.width

            ListItem {
                ListItemText {
                    anchors.left: parent.paddingItem.left
                    anchors.verticalCenter: parent.verticalCenter
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: "Query dialog"
                }

                QueryDialog{
                    id: queryDialog

                    platformInverted: window.platformInverted

                    titleText: "Query dialog title"
                    icon: "../Images/Icons/note_query.svg"
                    message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"

                    acceptButtonText: "Delete"
                    rejectButtonText: "Cancel"
                }

                onClicked: {
                    queryDialog.open()
                }
            }

            ListItem {
                ListItemText {
                    anchors.left: parent.paddingItem.left
                    anchors.verticalCenter: parent.verticalCenter
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: "Information dialog"
                }

                QueryDialog{
                    id: informationDialog

                    platformInverted: window.platformInverted

                    titleText: "Information dialog title"
                    icon: "../Images/Icons/note_info.svg"
                    message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"

                    acceptButtonText: "Ok"
                }

                onClicked: {
                    informationDialog.open()
                }
            }

            ListItem {
                platformInverted: window.platformInverted

                ListItemText {
                    anchors.left: parent.paddingItem.left
                    anchors.verticalCenter: parent.verticalCenter
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: "Progress dialog"
                }

                CommonDialog{
                    id: progressDialog

                    platformInverted: window.platformInverted

                    titleText: "Progress dialog title"
                    content: Item{
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        height: childrenRect.height

                        Label{
                            id: messageLabel

                            platformInverted: window.platformInverted

                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.leftMargin: platformStyle.paddingLarge

                            text: "Work unit information"
                        }

                        ProgressBar{
                            id: progressBar

                            platformInverted: window.platformInverted

                            anchors.top: messageLabel.bottom
                            anchors.topMargin: platformStyle.paddingSmall
                            anchors.left: messageLabel.left

                            width: parent.width - 2 * platformStyle.paddingLarge

                            minimumValue: 0
                            maximumValue: 1000
                            value: 0

                            Timer{
                                id: timer

                                interval: 10
                                repeat: true

                                onTriggered: {
                                    if (progressBar.value < progressBar.maximumValue)
                                        progressBar.value++;
                                    else
                                        stop()
                                }
                            }
                        }
                    }

                    buttonTexts: ["Cancel"]

                    onButtonClicked:{
                        reject()
                        timer.stop()
                        progressBar.value = progressBar.minimumValue
                    }
                }

                onClicked: {
                    progressDialog.open()
                    timer.restart()
                }
            }

            ListItem {
                id: inputDialogItem

                platformInverted: window.platformInverted

                ListItemText {
                    anchors.left: parent.paddingItem.left
                    anchors.verticalCenter: parent.verticalCenter
                    platformInverted: window.platformInverted
                    role: "Title"
                    text: "Input dialog"
                }

                QueryDialog{
                    id: inputDialog

                    property string username: ""
                    property string password: ""

                    platformInverted: window.platformInverted

                    titleText: "Input dialog title"

                    acceptButtonText: "Ok"
                    rejectButtonText: "Cancel"

                    content: Item{
                        anchors.left: parent.left
                        anchors.leftMargin: platformStyle.paddingLarge
                        anchors.right: parent.right
                        anchors.rightMargin: platformStyle.paddingLarge
                        anchors.verticalCenter: parent.verticalCenter
                        height: childrenRect.height + 2 * platformStyle.paddingLarge

                        Label{
                            id: userNameLabel

                            platformInverted: window.platformInverted

                            anchors.top: parent.top
                            anchors.topMargin: platformStyle.paddingLarge
                            anchors.left: parent.left

                            text: "Username"
                        }

                        TextField{
                            id: userNameTextField

                            platformInverted: window.platformInverted

                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: userNameLabel.bottom
                        }

                        Label{
                            id: passwordLabel

                            platformInverted: window.platformInverted

                            anchors.top: userNameTextField.bottom
                            anchors.topMargin: platformStyle.paddingSmall
                            anchors.left: parent.left

                            text: "Password"
                        }

                        TextField{
                            id: passwordTextField

                            platformInverted: window.platformInverted

                            anchors.top: passwordLabel.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right

                            echoMode: TextInput.Password
                        }

                        CheckBox{
                            id: checkBox

                            platformInverted: window.platformInverted

                            anchors.top: passwordTextField.bottom
                            anchors.topMargin: 2 * platformStyle.paddingMedium
                            anchors.left: parent.left
                        }

                        Label{
                            platformInverted: window.platformInverted

                            anchors.left: checkBox.right
                            anchors.leftMargin: platformStyle.paddingSmall
                            anchors.verticalCenter: checkBox.verticalCenter

                            text: "Remember my password"
                        }
                    }

                    onAccepted: {
                        username = userNameTextField.text
                        password = passwordTextField.text
                    }

                    onRejected: {
                        userNameTextField.text = username
                        passwordTextField.text = password
                    }
                }

                onClicked: {
                    inputDialog.open()
                }
            }

            SelectionListItem {
                platformInverted: window.platformInverted
                title: "Selection dialog"
                subTitle: model.get(selectionDialog.selectedIndex).value

                onClicked: {
                    selectionDialog.open();
                }

                ListModel {
                    id: model
                    ListElement { value: "List item 1" }
                    ListElement { value: "List item 2" }
                    ListElement { value: "List item 3" }
                    ListElement { value: "List item 4" }
                }

                SelectionDialog {
                    id: selectionDialog
                    platformInverted: window.platformInverted
                    titleText: "Selection dialog"
                    selectedIndex: 0
                    model: model
                }
            }

            SelectionListItem {
                platformInverted: window.platformInverted
                title: model.get(selectionDialog1.selectedIndex).value

                onClicked: {
                    selectionDialog1.open();
                }

                SelectionDialog {
                    id: selectionDialog1
                    platformInverted: window.platformInverted
                    titleText: "Selection dialog"
                    selectedIndex: 0
                    model: model
                }
            }

            SelectionListItem {
                id: dialogInViewSelectionItem

                property int selectedItemIndex: 0

                platformInverted: window.platformInverted
                title: "Dialog in a view"
                subTitle: model2.get(0).value

                ListModel {
                    id: model2
                    ListElement { value: "List item 1" }
                    ListElement { value: "List item 2" }
                    ListElement { value: "List item 3" }
                    ListElement { value: "List item 4" }
                    ListElement { value: "List item 5" }
                    ListElement { value: "List item 6" }
                    ListElement { value: "List item 7" }
                    ListElement { value: "List item 8" }
                    ListElement { value: "List item 9" }
                }

                onClicked: {
                    pageStack.push(selectionDialogPage, { selectedItemIndex: selectedItemIndex})
                }

                SelectionDialogPage{
                    id: selectionDialogPage

                    onItemSelected: {
                        selectedItemIndex = index
                        dialogInViewSelectionItem.subTitle = model2.get(index).value
                    }
                }
            }

            SelectionListItem {
                platformInverted: window.platformInverted
                title: "Scrollable dialog"
                subTitle: model3.get(selectionDialog3.selectedIndex).value

                onClicked: {
                    selectionDialog3.open();
                }

                ListModel {
                    id: model3
                    ListElement { value: "List item 1" }
                    ListElement { value: "List item 2" }
                    ListElement { value: "List item 3" }
                    ListElement { value: "List item 4" }
                    ListElement { value: "List item 5" }
                    ListElement { value: "List item 6" }
                    ListElement { value: "List item 7" }
                    ListElement { value: "List item 8" }
                    ListElement { value: "List item 9" }
                }

                SelectionDialog {
                    id: selectionDialog3
                    platformInverted: window.platformInverted
                    titleText: "Selection dialog"
                    selectedIndex: 0
                    model: model3
                }
            }
        }
    }
}
