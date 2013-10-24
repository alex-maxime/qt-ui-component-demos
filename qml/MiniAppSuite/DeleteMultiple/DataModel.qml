import QtQuick 1.0

ListModel {

    function deleteCheckedElements() {
        for (var i = 0; i< count ;i++) {
            if (get(i).isChecked) {
                remove(i);
                i--;
            }
        }
    }

    function getNamesOfCheckedItems() {
        var list = new Array();

        for (var i = 0; i< count ;i++) {
            if (get(i).isChecked)
                list.push(get(i).name);
        }

        return list;
    }

    function uncheckAllItems() {
        for (var i = 0; i< count ;i++) {
            setProperty(i, "isChecked", false);
        }
    }

    ListElement {
        name: "List item 1"
        isChecked: false
    }
    ListElement {
        name: "List item 2"
        isChecked: false
    }
    ListElement {
        name: "List item 3"
        isChecked: false
    }
    ListElement {
        name: "List item 4"
        isChecked: false
    }
    ListElement {
        name: "List item 5"
        isChecked: false
    }
    ListElement {
        name: "List item 6"
        isChecked: false
    }
    ListElement {
        name: "List item 7"
        isChecked: false
    }
    ListElement {
        name: "List item 8"
        isChecked: false
    }
    ListElement {
        name: "List item 9"
        isChecked: false
    }
    ListElement {
        name: "List item 10"
        isChecked: false
    }
}
