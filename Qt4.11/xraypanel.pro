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
    ../X-RayPanel/main.cpp \
    ../X-RayPanel/serial/serialLogger.cpp \
    ../X-RayPanel/serial/serialterminal.cpp \
    ../X-RayPanel/serial/settingsdialog.cpp \

RESOURCES += \
    ../X-RayPanel/xraypanel.qrc

OTHER_FILES += \
    ../X-RayPanel/qml/dashboard.qml \
    ../X-RayPanel/qml/DashboardGaugeStyle.qml \
    ../X-RayPanel/qml/IconGaugeStyle.qml \
    ../X-RayPanel/qml/TachometerStyle.qml \
    ../X-RayPanel/qml/TurnIndicator.qml \
    ../X-RayPanel/qml/ValueSource.qml

target.path = ./quickcontrols/extras/dashboard
INSTALLS += target

FORMS += \
    ../X-RayPanel/serial/mainwindow.ui \
    ../X-RayPanel/serial/settingsdialog.ui \


HEADERS += \
    ../X-RayPanel/serial/serialLogger.h \
    ../X-RayPanel/serial/serialterminal.h \
    ../X-RayPanel/serial/settingsdialog.h \

DISTFILES += \
    ../X-RayPanel/fonts/DejaVuSans.ttf \
    ../X-RayPanel/fonts/LICENSE \
    ../X-RayPanel/images/fuel-icon.png \
    ../X-RayPanel/images/green.png \
    ../X-RayPanel/images/minus-sign.png \
    ../X-RayPanel/images/plus-sign.png \
    ../X-RayPanel/images/red.png \
    ../X-RayPanel/images/temperature-icon.png \
    ../X-RayPanel/images/yellow.png \
    ../X-RayPanel/qml/Button.qml \
    ../X-RayPanel/qml/DashboardGaugeStyle.qml \
    ../X-RayPanel/qml/IconGaugeStyle.qml \
    ../X-RayPanel/qml/MasGauge.qml \
    ../X-RayPanel/qml/PressAndHoldButton.qml \
    ../X-RayPanel/qml/TachometerStyle.qml \
    ../X-RayPanel/qml/TurnIndicator.qml \
    ../X-RayPanel/qml/ValueSource.qml \
    ../X-RayPanel/qml/dashboard.qml
