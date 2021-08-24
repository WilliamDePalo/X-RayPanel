#ifndef SERIALTERMINAL_H
#define SERIALTERMINAL_H

#include <QtSerialPort/QSerialPort>
#include <QObject>
#include "serialLogger.h"
#include <QTimer>

class StringParsing: public QObject{
    Q_OBJECT
    Q_PROPERTY(QString errorMessage READ errorMessage)
public:
    using QObject::QObject;
    Q_INVOKABLE QString process(QString a);
    QString errorMessage() const{
        return mErrorMessage;
    }
private:
    QString mErrorMessage;
};



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
    void writeToSerialPCIMode(QString message,int flush);
    void putPC1cmd(QString message,char flush);
    void flushSendBuffer();
    void resetAck();

private:
    struct PC1SendElement{
        QString cmd;
        char toWaitAck;
    } ;
enum ackState{
       ACK_FREE = 0,
       ACK_WAITING,
       ACK_TO_SEND
    };
    QSerialPort *serialPort;
    Logger *logger;
    char waitForAnAck;  //0 free, 1 Wait to receive an ack, 2 wat to send an ack
    QTimer *sendPeriodicTimer;
    QList <PC1SendElement>  SendBuffer;
    QTimer *waitAckTimer;  // timer che evita che la seriale si blocchi all'infinito ad attendere un ack
signals:

    QString getData(QString data);
 //   QByteArray getBinaryData(QByteArray rcvByte);


};

#endif // SERIALTERMINAL_H
