Mini App Suite
==============

This Nokia Qt Quick example application demonstrates the intended use of UI
elements and interaction patterns as described in the Symbian Design Guidelines.

The idea is to put the style guide to life and to show vastly different layout
and interaction examples in a condensed format.

Each mini app demonstrates either a set of UI elements or certain pattern.
The apps are without application engine and they just show flows or sample
layouts, but have no deeper functionality. There are two exceptions:

User can set:
 - application reading direction
    - left-to-right (default)
    - right-to-left (optional)
 - application theme
    - dark theme (non-inverted, default)
    - light theme (inverted)

You can find detailed information about the purpose of each mini app with the
"i" button in the mini application. The same descriptions are also available
in the wiki pages.

What's new in version 2.0
-------------------------
10 new mini apps added:
- Arrange items
- Dialogs
- Empty content
- Menus
- Progress indicators
- Search
- Sliders
- Tab bars
- Time
- Tumblers

This example application is hosted in Nokia Developer Projects:
- http://projects.developer.nokia.com/uivisualisation

This example application demonstrates:
- The proper use of UI elements and interaction patterns based on the Symbian
  Design Guidelines
- Various use cases of Qt Quick Components

For more information on implementation, visit the wiki pages:
- http://projects.developer.nokia.com/uivisualisation/wiki


1. Project structure and implementation
-------------------------------------------------------------------------------

1.1 Folders
-----------

 |                          The root folder contains the project file, the
 |                          license information and this file (release notes).
 |
 |- bin                     Contains the installable Symbian binaries.
 |
 |- qml
 |  |
 |  |- MiniAppSuite             Root folder for QML and Javascript files.
 |     |
 |     |- ArrangeItems          ArrangeItems mini app root folder
 |     |
 |     |- Buttons               Buttons mini app root folder
 |     |
 |     |- DeleteMultiple        DeleteMultiple mini app root folder
 |     |
 |     |- Dialogs               Dialogs mini app root folder
 |     |
 |     |- DirectText            DirectText mini app root folder
 |     |
 |     |- DrillDown             DrillDown mini app root folder	
 |     |
 |     |- EmptyContent          EmptyContent mini app root folder
 |     |
 |     |- FastScrolling         FastScrolling mini app root folder
 |     |
 |     |- HeaderButton          HeaderButton mini app root folder
 |     |
 |     |- ImageControl          ImageControl mini app root folder
 |     |
 |     |- Images                Folder containing graphics
 |     |
 |     |- InfoBanner            InfoBanner mini app root folder
 |     |
 |     |- ListItems             ListItems mini app root folder
 |     |
 |     |- Menus                 Menus mini app root folder
 |     |
 |     |- ProgressIndicators    ProgressIndicators mini app root folder
 |     |
 |     |- SafeText              SafeText mini app root folder
 |     |
 |     |- Search                Search mini app root folder
 |     |
 |     |- Sliders               Sliders mini app root folder
 |     |
 |     |- StickyTabs            StickyTabs mini app root folder
 |     |
 |     |- TabBars               TabBars mini app root folder
 |     |
 |     |- Tabs                  Tabs mini app root folder
 |     |
 |     |- Time                  Time mini app root folder
 |     |
 |     |- ToolBars              ToolBars mini app root folder
 |     |
 |     |- ToolBarTabs           ToolBarTabs mini app root folder
 |     |
 |     |- Tumblers              Tumblers mini app root folder
 |     |
 |     |- Wizard                Wizard mini app root folder
 |


1.2 Used APIs/QML elements/Qt Quick Components
----------------------------------------------

Most essential QML components used in the project:

Qt Quick elements (v 1.1):

- Flickable
- Flipable
- GridView
- Image
- ListView
- Loader
- PinchArea
- Timer

Symbian Qt Quick Components (v 1.1)

- BusyIndicator
- Button
- Checkbox
- CommonDialog
- ContextMenu
- ListHeading
- ListItem
- ListItemText
- Menu
- MenuItem
- MenuLayout
- Page
- PageStack
- ProgressBar
- QueryDialog
- RadioButton
- ScrollBar
- ScrollDecorator
- SelectionDialog
- Slider
- Switch
- TabBar
- TabBarLayout
- TabGroup
- TextArea
- TextField
- ToolTip

Symbian Extras Qt Quick Components (v 1.1)

- InfoBanner
- RatingIndicator
- TumblerColumn
- TumblerDialog

Qt Labs elements (v 1.1)

- CheckableGroup


2. Compatibility
-------------------------------------------------------------------------------

 - Symbian devices with Qt 4.7.4, Qt Mobility 1.2.1 and Qt Quick Components 1.1.

Tested to work on Nokia C7-00, E7-00. Developed with Qt SDK 1.2.

2.1 Required Capabilities
-------------------------

None; the application can be self-signed on Symbian.


3. Building, installing, and running the application
-------------------------------------------------------------------------------

3.1 Preparations
----------------

Check that you have the latest Qt SDK installed in the development environment
and the latest Qt version on the device.

Qt Quick Components 1.1 or higher is required.

3.2 Using the Qt SDK
--------------------

You can install and run the application on the device by using the Qt SDK.
Open the project in the SDK, set up the correct target (depending on the device
platform), and click the Run button. For more details about this approach,
visit the Qt Getting Started section at Nokia Developer
(http://www.developer.nokia.com/Develop/Qt/Getting_started/).

3.3 Symbian device
------------------

Make sure your device is connected to your computer. Locate the .sis
installation file and open it with Ovi Suite. Accept all requests from Ovi
Suite and the device. Note that you can also install the application by copying
the installation file onto your device and opening it with the Symbian File
Manager application.

After the application is installed, locate the application icon from the
application menu and launch the application by tapping the icon.


4. License
-------------------------------------------------------------------------------

See the license text file delivered with this project. The license file is also
available online at
http://projects.developer.nokia.com/uivisualisation/browser/trunk/Licence.txt


5. Related documentation
-------------------------------------------------------------------------------

Qt Quick Components
- http://doc.qt.nokia.com/qt-components-symbian-1.1/index.html

Symbian Design Guidelines
- http://www.developer.nokia.com/Resources/Library/Symbian_Design_Guidelines/


6. Version history
-------------------------------------------------------------------------------

2.0 10 new mini apps added.
1.0 Initial release
