#include "serialterminal.h"
#include <QtSerialPort/QSerialPort>

#define MAX_BUFF_SIZE 1024
#define MAX_TIME_WAIT_MS 100

SerialTerminal::SerialTerminal()
{
    serialPort = new QSerialPort(this);
   // QPlainTextEdit *editor = new QPlainTextEdit();//) (this);
    QString fileName = "C:\\Users\\willi\\OneDrive\\Desktop\\xray Prj\\xray panel\\serial.txt";
    logger = new Logger(this, fileName/*, editor*/);
    logger->setShowDateTime(1);
    waitForAnAck = 0;
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

    serialPort->setReadBufferSize(MAX_BUFF_SIZE);
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
        logger->write( " -> serial " + msgToSend + "\n\r");
        serialPort->write(msgToSend);
    if (waitForAnAck == ackState::ACK_FREE ||
        waitForAnAck == ackState::ACK_TO_SEND)
    {
        waitForAnAck = ACK_WAITING;
        serialPort->flush();
    }
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
   static unsigned char idx = 0;
   unsigned char idToSend = 0;
   unsigned char  cksm = 0;
   QByteArray toSend;
   QString data;
   int tmp ;
        QString dt;

  //  if (serialPort->canReadLine()){
       static QByteArray rcvByte;// = serialPort->readAll();
         rcvByte.append(serialPort->readAll());
          logger->write( "<- serial " + rcvByte +"\n");
        // gestione pacchetti spezzati
        while (serialPort->waitForReadyRead(MAX_TIME_WAIT_MS)) // se aspetto meno di 500 milli
        {
            rcvByte.append(serialPort->readAll());
            logger->write( "<- waitForReadyRead" + rcvByte +"\n");
        }
          // Se non ho l'ETX nel pacchetto allora esco e aspetto il successivo

        // gestione ricezione comandi multipli
        do{
            if (idx<rcvByte.length())// serve per non entrare neanche ad analizzare se lungo 0
            {
                while ((rcvByte[idx].operator char() != static_cast<char>(0x03))&&
                       (idx<rcvByte.length()))
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
                if (idx<rcvByte.length()) // se sono uscito perchè ho finito di ricevere e
                {  // non ho ancora finito il messaggio
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
                    if (data.length()>0)
                    {// controllo se data è più lungo di 5 e ontiene ER, allora segue un errore
                        if((data.contains("ER00"))&&(data.length()>5))
                        {
                            // prendo solo l'errore che compone l'ultima parte
                            tmp = data.lastIndexOf(QRegExp("E"));
                            dt = data.right(data.length()-tmp);
                            data = dt;
                        }
                        emit getData(data);                        
                        logger->write( "             EMIT     " + data +"\n");
                        if ( waitForAnAck == ackState::ACK_WAITING)
                            waitForAnAck = ackState::ACK_FREE;
                        return;
                    }
                }
            }
            toSend.fill(0); //pulisco l'array
        }while ((idx)<rcvByte.length());


        idx = 0;
        rcvByte.fill(0);
        rcvByte.clear();

      //  QString data= QString::fromLatin1(toSend);

     // //  emit getBinaryData(rcvByte);
    //    emit getData(data);
 //   }

}






