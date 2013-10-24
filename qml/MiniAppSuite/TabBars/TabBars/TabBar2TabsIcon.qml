/**
 * Copyright (c) 2012 Nokia Corporation.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../Constants.js" as Constants

TabBarLayout{
    height: screen.width < screen.height ? privateStyle.tabBarHeightPortrait : privateStyle.tabBarHeightLandscape

    TabButton {
        tab: item1
        iconSource: "../../Images/Icons/bookmark.svg"
        platformInverted: window.platformInverted;
    }
    TabButton {
        tab: item2
        iconSource: platformInverted ? "../../Images/Icons/map_w.svg" : "../../Images/Icons/map.svg"
        platformInverted: window.platformInverted;
    }
}
