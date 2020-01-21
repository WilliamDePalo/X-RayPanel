TEMPLATE = app
TARGET = xrayPanel
INCLUDEPATH += .
QT += quick
QT += widgets
QT += serialport

# With C++11 support
greaterThan(QT_MAJOR_VERSION, 4){
    CONFIG += c++11
} else {
    QMAKE_CXXFLAGS += -std=c++0x
}

SOURCES += \
    ./main.cpp \
    ./serial/serialLogger.cpp \
    ./serial/serialterminal.cpp \
    ./serial/settingsdialog.cpp \

RESOURCES += \
    ./xraypanel_4.11.qrc

OTHER_FILES += \
    ./qml/dashboard.qml \
    ./qml/DashboardGaugeStyle.qml \
    ./qml/IconGaugeStyle.qml \
    ./qml/TachometerStyle.qml \
    ./qml/TurnIndicator.qml \
    ./qml/ValueSource.qml

target.path = ./quickcontrols/extras/dashboard
INSTALLS += target

FORMS += \
    ./serial/mainwindow.ui \
    ./serial/settingsdialog.ui \


HEADERS += \
    ./serial/serialLogger.h \
    ./serial/serialterminal.h \
    ./serial/settingsdialog.h \

DISTFILES += \
    ./fonts/DejaVuSans.ttf \
    ./fonts/LICENSE \
    ./images/fuel-icon.png \
    ./images/green.png \
    ./images/minus-sign.png \
    ./images/plus-sign.png \
    ./images/red.png \
    ./images/temperature-icon.png \
    ./images/yellow.png \
    ./qml/Button.qml \
    ./qml/DashboardGaugeStyle.qml \
    ./qml/IconGaugeStyle.qml \
    ./qml/MasGauge.qml \
    ./qml/PressAndHoldButton.qml \
    ./qml/TachometerStyle.qml \
    ./qml/TurnIndicator.qml \
    ./qml/ValueSource.qml \
    ./qml/dashboard.qml \
    images/background.png \
    images/background.svg \
    images/needle.svg \
    images/tickmark.svg
