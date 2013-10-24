/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import "../Constants.js" as Constants

QtObject{
    id: model

    property list<Contact> foundContactsModel

    property list<Contact> contactsList: [
        Contact {
            name: "Amy Anderson"
            groups: ["1", "2", "3"]
        },
        Contact {
            name: "Anders"
            groups: ["1", "3"]
        },
        Contact {
            name: "Barbara Brown"
            groups: ["2", "3"]
        },
        Contact {
            name: "Charlie Mickelson"
            groups: ["3"]
        },
        Contact {
            name: "Danny"
            groups: ["2"]
        },
        Contact {
            name: "Emily"
            groups: ["1", "3"]
        },
        Contact {
            name: "Gloria"
            groups: ["1"]
        },
        Contact {
            name: "Jerome Walton"
            groups: ["1", "2", "3"]
        },
        Contact {
            name: "Joan"
            groups: ["1", "3"]
        },
        Contact {
            name: "Lynne"
            groups: ["1", "2", "3"]
        },
        Contact {
            name: "Mike Sparks"
            groups: ["2", "3"]
        },
        Contact {
            name: "Nataly Grant"
            groups: ["1", "3"]
        },
        Contact {
            name: "Peter"
            groups: ["2"]
        },
        Contact {
            name: "Patricia"
            groups: ["1", "2", "3"]
        },
        Contact {
            name: "Randy Allen"
            groups: ["1", "3"]
        },
        Contact {
            name: "Steve"
            groups: ["2"]
        },
        Contact {
            name: "Stephanie Baker"
            groups: ["1", "2"]
        },
        Contact {
            name: "William Cooper"
            groups: ["1", "3"]
        }
    ]

    function getFoundContactsModel(text, group) {
        // assing javascript array to QML list property
        foundContactsModel = getFoundContactsArray(text, group)

        return foundContactsModel
    }

    function getFoundContactsArray(text, group) {
        // temporary javascript array that is about to be fille with found contacts
        // this due to the fact QML list can't be modified dynamically
        // so we operate on this temporary array
        // and at the end we assign it to QML list property (it's legal)
        var foundContactsArray = new Array()

        for (var i = 0; i< contactsList.length ;i++) {
            var matchingGroup = false

            if (group == "")
                matchingGroup = true
            else {
                for (var j=0; j<contactsList[i].groups.length; j++) {
                    if (contactsList[i].groups[j] == group) {
                        matchingGroup = true
                        break
                    }
                }
            }

            if (contactsList[i].name.toLowerCase().indexOf(text.toLowerCase()) != -1 && matchingGroup) {
                var contact = Qt.createQmlObject("import QtQuick 1.1; Contact{}", model);
                contact.name = contactsList[i].name
                contact.groups = contactsList[i].groups
                foundContactsArray.push(contact)
            }
        }

        return foundContactsArray
    }
}
