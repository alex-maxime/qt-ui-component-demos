/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1

Item{
    property list<QtObject> tab1ListModel: [
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

    property list<QtObject> tab2ListModel: [
        QtObject {
            property string title: "Item #1 (B)";

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
            property string title: "Item #2 (B)";

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

    property list<QtObject> tab3ListModel: [
        QtObject {
            property string title: "Item #1 (C)";

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
            property string title: "Item #2 (C)";

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

    property list<QtObject> tab4ListModel: [
        QtObject {
            property string title: "Item #1 (D)";

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
            property string title: "Item #2 (D)";

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
