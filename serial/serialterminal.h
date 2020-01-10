#ifndef SERIALTERMINAL_H
#define SERIALTERMINAL_H

#include <QtSerialPort/QSerialPort>

#include <QObject>
#include "serialLogger.h"


class SerialTerminal : public QObject
{
    Q_OBJECT
public:
    SerialTerminal();
    void openSerialPort(QString comName, int baud);
    void writeToSerialPort(QString message);
    bool getConnectionStatus();
    void closeSerialPort();

public slots:

    void openSerialPortSlot(QString comName, int baud);
    void writeToSerialPortSlot(QString message);
    void readFromSerialPort();
    bool getConnectionStatusSlot();
    void closeSerialPortSlot();
    void writeToSerialPCIMode(QString message);


private:

    QSerialPort *serialPort;
    Logger *logger;


signals:

    QString getData(QString data);
    QByteArray getBinaryData(QByteArray rcvByte);


};

#endif // SERIALTERMINAL_H
