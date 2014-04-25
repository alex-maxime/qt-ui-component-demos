/**
 * Copyright (c) 2012-2014 Microsoft Mobile.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Button{
    platformInverted: window.platformInverted
    onClicked: showInfoBanner(text, iconSource);
}
