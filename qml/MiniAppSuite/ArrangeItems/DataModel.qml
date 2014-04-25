/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1

ListModel {
    id: dataModel
    
    property ListModel itemsCopy: ListModel{}
    
    function deleteCheckedElements() {
        if ( isAnyItemChecked() ) {
            updateItemsCopy()

            // for avoiding a bug that causes that flickable contentY is set to wrong value
            // when removing non visible items, the model is cleared and filled from the begining
            clear()

            // scan through itemsCopy model and append exact model items only when item is not
            // marked for removing
            for (var i = 0; i< itemsCopy.count ;i++) {
                if (!itemsCopy.get(i).isChecked) {
                    append({itemId: itemsCopy.get(i).itemId, isChecked: itemsCopy.get(i).isChecked})
                }
            }

            itemsCopy.clear()
        }
    }

    function uncheckAllItems() {
        for (var i = 0; i< count ;i++) {
            setProperty(i, "isChecked", false);
        }
    }

    function isAnyItemChecked() {
        for (var i = 0; i< count ;i++) {
            if (get(i).isChecked) {
                return true
            }
        }

        return false
    }

    function replaceItems(from, to) {
        move(from, to, 1)
    }

    function updateItemsCopy() {
        for (var i = 0; i< count ;i++) {
            itemsCopy.append({itemId: get(i).itemId, isChecked: get(i).isChecked})
        }
    }    

    ListElement {itemId: 1; isChecked: false}
    ListElement {itemId: 2; isChecked: false}
    ListElement {itemId: 3; isChecked: false}
    ListElement {itemId: 4; isChecked: false}
    ListElement {itemId: 5; isChecked: false}
    ListElement {itemId: 6; isChecked: false}
    ListElement {itemId: 7; isChecked: false}
    ListElement {itemId: 8; isChecked: false}
    ListElement {itemId: 9; isChecked: false}
    ListElement {itemId: 10; isChecked: false}
    ListElement {itemId: 11; isChecked: false}
    ListElement {itemId: 12; isChecked: false}
    ListElement {itemId: 13; isChecked: false}
    ListElement {itemId: 14; isChecked: false}
    ListElement {itemId: 15; isChecked: false}
}
