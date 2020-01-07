#include "serialterminal.h"
#include <QtSerialPort/QSerialPort>

SerialTerminal::SerialTerminal()
{
    serialPort = new QSerialPort(this);
}

void SerialTerminal::openSerialPort(QString comName, int baud){

    serialPort->setPortName(comName);
    serialPort->setBaudRate(baud);
  //  serialPort->setBaudRate(baud);
    serialPort->setFlowControl(QSerialPort::NoFlowControl);
    serialPort->setDataBits(QSerialPort::Data8);
    serialPort->setStopBits(QSerialPort::TwoStop);
    serialPort->open(QIODevice::ReadWrite);
    connect(serialPort,SIGNAL(readyRead()),this,SLOT(readFromSerialPort()));
}

void SerialTerminal::closeSerialPort(){

    serialPort->close();

}

bool SerialTerminal::getConnectionStatus(){

    return serialPort->isOpen();

}

void SerialTerminal::writeToSerialPCIMode(QString message){
    QByteArray msgToSend(message.size()+2,0);
    const QByteArray &messageArray = message.toLocal8Bit();
    unsigned char checksum = 0;
    unsigned char id = 0;
    for(id = 0 ; id<messageArray.length();id++)
    {
        msgToSend[id] = messageArray[id];
        checksum += (messageArray[id] & 0xff);
    }
    msgToSend[messageArray.length()] = 0x03;
    checksum += (0x03 & 0xff);
    msgToSend[messageArray.length()+1] = static_cast<char>(checksum);
    serialPort->write(msgToSend);
    serialPort->flush();
}

void SerialTerminal::writeToSerialPort(QString message){

    const QByteArray &messageArray = message.toLocal8Bit();
    serialPort->write(messageArray);
}

void SerialTerminal::openSerialPortSlot(QString comName, int baud){

    this->openSerialPort(comName,baud);
}

void SerialTerminal::writeToSerialPortSlot(QString message){

    this->writeToSerialPort(message);
}

void SerialTerminal::closeSerialPortSlot(){

    this->closeSerialPort();
}

bool SerialTerminal::getConnectionStatusSlot(){

    return this->getConnectionStatus();
}

void SerialTerminal::readFromSerialPort(){
   unsigned char idx = 0;
   unsigned char idToSend = 0;
   unsigned char  cksm = 0;
  QByteArray toSend;
   QString data;


  //  if (serialPort->canReadLine()){
       static QByteArray rcvByte;// = serialPort->readAll();
         rcvByte.append(serialPort->readAll());
        // gestione pacchetti spezzati
        while (serialPort->waitForReadyRead(500)) // se aspetto meno di 500 milli
                rcvByte.append(serialPort->readAll());
        // gestione ricezione comandi multipli
        do{
            while (rcvByte[idx].operator char() != static_cast<char>(0x03)&&
                   (idx)<=rcvByte.length())
            {
  /*              if((rcvByte[idx].operator char()=='F')&&            // gestione fuoco
                        (rcvByte[idx+1]=="O"))
                {
                    if (data[idx+2]==="0") // fuoco piccolo
                        valueSource.fuoco = false
                    else
                        valueSource.fuoco = true
                }*/
                toSend[idToSend++] = rcvByte[idx];
                cksm+=(rcvByte[idx].operator char() & 0xff); //salvo checksum
                idx++;  // avanzo di una posizione
            }
            cksm+=(rcvByte[idx].operator char() & 0xff); // salvo lo stop
            //controllo il cks
            idx++;
            if ( rcvByte[idx].operator char() != static_cast<char> (cksm))
            {
                toSend = "ERROR";
            }
            cksm = 0;     // reinizializzo il cks
            idToSend = 0;  // riposiziono l'ofset dei dati da salvare
            idx++; // salto la posizione del chsum
            data= QString::fromLatin1(toSend);
            emit getData(data);
            toSend.fill(0); //pulisco l'array
        }while ((idx)<=rcvByte.length());



        rcvByte.fill(0);
        rcvByte.clear();

      //  QString data= QString::fromLatin1(toSend);

     // //  emit getBinaryData(rcvByte);
    //    emit getData(data);
 //   }

}






