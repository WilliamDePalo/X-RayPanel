TEMPLATE = app
TARGET = xrayPanel
INCLUDEPATH += .
QT += quick

SOURCES += \
    main.cpp

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
