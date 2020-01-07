TEMPLATE = app
TARGET = xrayPanel
INCLUDEPATH += .
QT += quick
QT += widgets
QT += serialport


SOURCES += \
    main.cpp \
    serial/serialterminal.cpp \
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
    serial/serialterminal.h \
    serial/settingsdialog.h

DISTFILES +=
