#include "readconffile.h"

readConfFile::readConfFile(QObject *parent, QString fileName/*, QPlainTextEdit *editor*/) : QObject(parent) {
    if (!fileName.isEmpty()) {
        file = new QFile;
         file->setFileName(fileName);
        file->open(QIODevice::ReadOnly | QIODevice::Text);
    }
}

void readConfFile::rdCurHiLvl(QString &value){
 QString row;// + "";
 QTextStream rd(file);
    if (file != 0) {
         rd >> row;
         value = row;
     }
// out.setCodec("UTF-8");
 }
void readConfFile::rdCurLowLvl(QString &value){
 QString row;// + "";
 QTextStream rd(file);
    if (file != 0) {
         rd >> row;
         value = row;
     }
// out.setCodec("UTF-8");
 }
