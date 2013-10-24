/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1

Item{
    property list<QtObject> listsModel: [
        QtObject {
            property string title: "Item #1 (A)";

            property QtObject subListContainer:
                QtObject{
                property list<QtObject> values: [
                    QtObject {
                        property string title: "1";
                        property string contentText: "Content"
                    },
                    QtObject {
                        property string title: "2";
                        property string contentText: "Content"
                    },
                    QtObject {
                        property string title: "3";
                        property string contentText: "Content"
                    },
                    QtObject {
                        property string title: "4";
                        property string contentText: "Content"
                    }
                ]
            }
        },

        QtObject {
            property string title: "Item #2 (A)";

            property QtObject subListContainer:
                QtObject{
                property list<QtObject> values: [
                    QtObject {
                        property string title: "1";
                        property string contentText: "Content"
                    },
                    QtObject {
                        property string title: "2";
                        property string contentText: "Content"
                    },
                    QtObject {
                        property string title: "3";
                        property string contentText: "Content"
                    }
                ]
            }
        }
    ]    
}
