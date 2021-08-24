#ifndef EXCELMGM_H
#define EXCELMGM_H
#include "qaxobject.h"
#include "qdebug.h"
#include <QObject>
class Excelmgm: public QObject
{
     Q_OBJECT    // per vederlo in QML
public:
    Excelmgm();   
    ~Excelmgm();

public slots:
    int openFile();
    void writeParam();
    void setList(int pos, QString value);
    void closeFile();
private:
    struct TrimElem{
        QString sTrim;
        char position;
    };
 //    QList <int> trimBuff;
     QAxObject * excel;
     QAxObject * sheets;
     QAxObject * sheet;
     QAxObject * workbook;
     QAxObject * workbooks;
     QList <QString> trimBuff;
     //QList <QVariant> trimBuff;
};

#endif // EXCELMGM_H
