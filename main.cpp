/**
 * Copyright (c) 2012 Nokia Corporation.
 */

#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setMainQmlFile(QLatin1String("qml/MiniAppSuite/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
