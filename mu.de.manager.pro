TEMPLATE = app
TARGET = mu.de.manager
INCLUDEPATH += .
QT += quick
QT += widgets
QT += serialport
QT += qml quick
QT += core gui axcontainer
static {
   QT += svg
   QTPLUGIN += qtvirtualkeyboardplugin
}

# With C++11 support
greaterThan(QT_MAJOR_VERSION, 4){
    CONFIG += c++11   
} else {
    QMAKE_CXXFLAGS += -std=c++0x
}

CONFIG  += link_pkgconfig
#target.path = $$[QT_INSTALL_EXAMPLES]/virtualkeyboard/basic
#INSTALLS += target

SOURCES += \
    ./main.cpp \
    ./serial/serialLogger.cpp \
    ./serial/serialterminal.cpp \
    ./serial/settingsdialog.cpp \
    excelmgm.cpp \
    serial/readconffile.cpp

RESOURCES += \
    ./mu.de.manager.qrc

OTHER_FILES += \
    ./qml/dashboard.qml \
    ./qml/DashboardGaugeStyle.qml \
    ./qml/IconGaugeStyle.qml \
    ./qml/TachometerStyle.qml \
    ./qml/TurnIndicator.qml \
    ./qml/ValueSource.qml \
    ./qml/NumberPadSupport/Display.qml \
    ./qml/menuSupport/BlackButtonStyle.qml \
#  ./qml/MACallPoint.qml

target.path = ./quickcontrols/extras/dashboard
INSTALLS += target

FORMS += \
    ./serial/mainwindow.ui \
    ./serial/settingsdialog.ui \


HEADERS += \
    ./serial/serialLogger.h \
    ./serial/serialterminal.h \
    ./serial/settingsdialog.h \
    excelmgm.h \
    serial/readconffile.h

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
    qml/KvCallStep.qml \
    qml/KvCallStep_rev.qml \
    qml/MACallPoint.qml \
    qml/keyPadSupport/FloatingButton_Active.svg \
    qml/keyPadSupport/FloatingButton_Available.svg \
    qml/keyPadSupport/FloatingButton_Unavailable.svg \
    qml/keyPadSupport/TextField.qml \
    images/background.png \
    images/background.svg \
    images/needle.svg \
    images/tickmark.svg \
    qml/NumberPad.qml \
    qml/NumberPadSupport/Display.qml \
    qml/NumberPadSupport/NP_Button.qml \
    qml/NumberPadSupport/calculator.js \
    qml/menuSupport/BlackButtonBackground.qml \
    qml/menuSupport/BlackButtonStyle.qml \
    qml/dashboard.qml

