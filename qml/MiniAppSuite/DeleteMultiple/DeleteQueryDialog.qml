/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

QueryDialog{

    function buildListOfItemsToBeDeletedString() {
        var itemsNames = listModel.getNamesOfCheckedItems();

        var listString = "";

        var prefix;

        for (var i = itemsNames.length - 1; i >= 0 ;i--) {
            if (i == 0)
                prefix = "";
            else if (i == itemsNames.length - 1)
                prefix = " and ";
            else
                prefix = ", "

            listString = prefix + itemsNames[i] + listString;
        }

        return listString;
    }

    titleText: "Delete"
    message: "Delete " + buildListOfItemsToBeDeletedString() + " from your list?\n";
    acceptButtonText: "Ok"
    rejectButtonText: "Cancel"
    platformInverted: window.platformInverted

    onRejected: {
        reject();
        mainPage.state = "NORMAL";
    }

    onAccepted: {
        banner.text = "Deleted " + checkedItemsCount + " items."
        banner.open();
        listModel.deleteCheckedElements();
        checkedItemsCount = 0;
        mainPage.state = "NORMAL";
    }
}
