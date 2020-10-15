/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtGui/QFont>
#include <QtGui/QFontDatabase>
//#include <QDeclarativeEngine>
#include <QQuickView>
#include <QQmlContext>

//#include <QApplication>
//#include "serial/mainwindow.h"

#include <QtSerialPort/QSerialPortInfo>
#include "serial/serialterminal.h"
#include "serial/settingsdialog.h"
#include <QDebug>

#include <QQmlEngine>

int main(int argc, char *argv[])
{

 //  QGuiApplication app(argc, argv);


//    QFontDatabase::addApplicationFont(":/fonts/DejaVuSans.ttf");
//    app.setFont(QFont("DejaVu Sans"));

//    QQmlApplicationEngine engine(QUrl("qrc:/qml/dashboard.qml"));

//    if (engine.rootObjects().isEmpty())
//        return -1;

 //   return app.exec();
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QSerialPortInfo serialPortInfo;
    QList<QSerialPortInfo> ports = serialPortInfo.availablePorts();
    QList<qint32> bauds = serialPortInfo.standardBaudRates();
    QStringList portsName;
    QStringList baudsStr;


    foreach (QSerialPortInfo port, ports) {

        portsName.append(port.portName());

    }

    foreach (qint32 baud, bauds) {

        baudsStr.append(QString::number(baud));

    }



    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    SerialTerminal serialTerminal;

    context->setContextProperty("serialTerminal",&serialTerminal);
    context->setContextProperty("portsNameModel",QVariant::fromValue(portsName));
    context->setContextProperty("baudsModel",QVariant::fromValue(baudsStr));
   // SettingsDialog settingsDialog;
   // context->setContextProperty("settingsDialog",&settingsDialog);

  //  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QFontDatabase::addApplicationFont(":/fonts/DejaVuSans.ttf");
        app.setFont(QFont("DejaVu Sans"));
    qmlRegisterType<StringParsing>("WdpClass", 1, 0, "StringParsing");
    //    QQmlApplicationEngine engine(QUrl("qrc:/qml/dashboard.qml"));
        engine.load(QUrl(QLatin1String("qrc:/qml/dashboard.qml")));

        if (engine.rootObjects().isEmpty())
            return -1;

     //   return app.exec();

    return app.exec();
}


//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
//#include <QQmlContext>
//#include <QtSerialPort/QSerialPortInfo>
//#include "serialterminal.h"
//#include <QDebug>
/*
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QSerialPortInfo serialPortInfo;
    QList<QSerialPortInfo> ports = serialPortInfo.availablePorts();
    QList<qint32> bauds = serialPortInfo.standardBaudRates();
    QStringList portsName;
    QStringList baudsStr;


    foreach (QSerialPortInfo port, ports) {

        portsName.append(port.portName());

    }

    foreach (qint32 baud, bauds) {

        baudsStr.append(QString::number(baud));

    }



    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    SerialTerminal serialTerminal;
    context->setContextProperty("serialTerminal",&serialTerminal);
    context->setContextProperty("portsNameModel",QVariant::fromValue(portsName));
    context->setContextProperty("baudsModel",QVariant::fromValue(baudsStr));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}*/
