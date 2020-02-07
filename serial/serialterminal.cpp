#include "serialterminal.h"
#include <QtSerialPort/QSerialPort>
//#include <QGuiApplication>
//#include <QQmlApplicationEngine>

#define MAX_BUFF_SIZE 1024
#define MAX_TIME_WAIT_MS 100


Q_INVOKABLE QString StringParsing::process(QString a){
     //   QString  status;
     QString strValue;
        bool ok;
// trasformo la stringa xxx.yyyy in numero
        double fNumValue = a.toDouble(&ok);

// moltiplico per 10 (sposto la virgola a dx)
            fNumValue *= 10;
// salvo la stringa
        strValue.setNum(fNumValue,'g',6);
//        QString::asprintf(&status.(),"%d",fNumValue);
        // taglio il tutto dopo la virgola
        int newlen = strValue.indexOf('.');
        if (newlen >=0)
            strValue = strValue.left(newlen);
        // restituisco la stringa modificata
        return strValue;
        // mErrorMessage e' un'eventuale altra proprietà (variabile) a disposizione in qml
        //mErrorMessage = status;//status? "": QString("error message: %1 + %2 is different to %3").arg(a).arg(b).arg(res);
    }






SerialTerminal::SerialTerminal()
{
    serialPort = new QSerialPort(this);
   // QPlainTextEdit *editor = new QPlainTextEdit();//) (this);
    QString fileName = ".\\serial.txt";
    logger = new Logger(this, fileName/*, editor*/);
    logger->setShowDateTime(1);
    waitForAnAck = 0;
    sendPeriodicTimer = new QTimer(this);
    waitAckTimer = new QTimer(this);
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
    connect(sendPeriodicTimer, SIGNAL(timeout()), this, SLOT(flushSendBuffer()));
    connect(waitAckTimer,SIGNAL(timeout()), this, SLOT(resetAck()));
    sendPeriodicTimer->start(1000);
    serialPort->setReadBufferSize(MAX_BUFF_SIZE);
}

void SerialTerminal::closeSerialPort(){

    serialPort->close();

}

bool SerialTerminal::getConnectionStatus(){
    return serialPort->isOpen();

}

void SerialTerminal::writeToSerialPCIMode(QString message,int flush){

    if (waitForAnAck == ACK_FREE ||
        waitForAnAck == ACK_TO_SEND)
    {
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
        if (flush)
        {
            waitForAnAck = ACK_WAITING;
            serialPort->flush();
            waitAckTimer->start(750);
        }
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
       //   logger->write( "<- serial " + rcvByte +"\n");
        // gestione pacchetti spezzati
        while (serialPort->waitForReadyRead(MAX_TIME_WAIT_MS)) // se aspetto meno di 500 milli
        {
            rcvByte.append(serialPort->readAll());
     //       logger->write( "<- waitForReadyRead" + rcvByte +"\n");
        }
          // Se non ho l'ETX nel pacchetto allora esco e aspetto il successivo

        // gestione ricezione comandi multipli
        do{
            if (idx<rcvByte.length())// serve per non entrare neanche ad analizzare se lungo 0
            {
                while ((rcvByte[idx].operator char() != static_cast<char>(0x03))&&
                       (idx<rcvByte.length()))
                {// fince' e' diverso da ETX allora continuo a salvare il dato e calcolare la cKS
                    toSend[idToSend++] = rcvByte[idx];
                    cksm+=(rcvByte[idx].operator char() & 0xff); //salvo checksum
                    idx++;  // avanzo di una posizione
                }
                if (idx<rcvByte.length()) // se sono uscito perchè ho finito di ricevere e
                {  // non ho ancora finito il messaggio
                    cksm+=(rcvByte[idx].operator char() & 0xff); // salvo lo stop
                    //controllo il cks
                    idx++;
                    // se la CKsm ricevuta e' diversa da quella calcolata allora do errore e esco
                    if ( rcvByte[idx].operator char() != static_cast<char> (cksm))
                    {
                        toSend = "ERROR";
                    }
                    cksm = 0;     // reinizializzo il cks
                    idToSend = 0;  // riposiziono l'ofset dei dati da salvare
                    idx++; // salto la posizione del chsum
// CONTROLLO SE E' IL CASO DI SPEZZARE GLI INVII DI DATA (nella risposta al comando RR le risposte sono divise da uno spazio)

                    if (!toSend.contains(""))
                    {
                        data= QString::fromLatin1(toSend);
                        if (data.length()>0)
                        {// controllo se data è più lungo di 5 e contiene ER, allora segue un errore
                            if((data.contains("ER00"))&&(data.length()>5))
                            {
                                // prendo solo l'errore che compone l'ultima parte
                                tmp = data.lastIndexOf(QRegExp("E"));
                                dt = data.right(data.length()-tmp);
                                data = dt;
                            }
                            emit getData(data);
                            logger->write( "             EMIT     " + data +"\n");
                            if ( waitForAnAck ==ACK_WAITING)
                            {
                                waitForAnAck = ACK_FREE;
                                waitAckTimer->stop();
                            }
                            return;
                        }
                    }else // se siamo nel caso in cui ho valori divisi da uno spazio devo emettere i valori in sequenza
                    {
                        unsigned char id;
                        QList <QByteArray> BuffSend = toSend.split(' ');
                        for(id= 0;id<BuffSend.length();id++)
                        {
                            data= QString::fromLatin1(BuffSend.at(id));
                            if (data.length()>0)
                            {// controllo se data è più lungo di 5 e contiene ER, allora segue un errore
                                if((data.contains("ER00"))&&(data.length()>5))
                                {
                                    // prendo solo l'errore che compone l'ultima parte
                                    tmp = data.lastIndexOf(QRegExp("E"));
                                    dt = data.right(data.length()-tmp);
                                    data = dt;
                                }
                                emit getData(data);
                                logger->write( "             EMIT     " + data +"\n");
                                if ( waitForAnAck == ACK_WAITING)
                                {
                                    waitForAnAck = ACK_FREE;
                                    waitAckTimer->stop();
                                }
                            }
                        }
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

void SerialTerminal::resetAck(){
    if (waitForAnAck != ACK_FREE)
        waitForAnAck = ACK_FREE;
    waitAckTimer->stop();
}

void SerialTerminal::flushSendBuffer(){
    int id = 0 ;
    if (SendBuffer.length()) // se il buffer non è vuoto
    {
        for (id=0;id<SendBuffer.length();id++)
        {
            if (waitForAnAck == ACK_FREE ||
                waitForAnAck == ACK_TO_SEND)
            {
                writeToSerialPCIMode(SendBuffer.at(id).cmd,SendBuffer.at(id).toWaitAck);
                SendBuffer.removeAt(id);
              //  break; // esco e processo gli altri elementi al prossimo giro
            }else
            {
                break;
            }
        }
    }
    sendPeriodicTimer->start(50);
}


void SerialTerminal::putPC1cmd(QString message,char flush)
{
   PC1SendElement el;
   el.cmd = message;
   el.toWaitAck = flush;
   SendBuffer.append(el);
}



