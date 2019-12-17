TEMPLATE = app
TARGET = xrayPanel
INCLUDEPATH += .
QT += quick

SOURCES += \
    main.cpp \
    serial/console.cpp \
    serial/main.cpp \
    serial/mainwindow.cpp \
    serial/settingsdialog.cpp

RESOURCES += \
    xraypanel.qrc

OTHER_FILES += \
    qml/dashboard.qml \
    qml/DashboardGaugeStyle.qml \
    qml/IconGaugeStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/ValueSource.qml

target.path = ./quickcontrols/extras/dashboard
INSTALLS += target

FORMS += \
    serial/mainwindow.ui \
    serial/settingsdialog.ui

HEADERS += \
    serial/console.h \
    serial/mainwindow.h \
    serial/settingsdialog.h
