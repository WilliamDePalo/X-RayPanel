#ifndef READCONFFILE_H
#define READCONFFILE_H

#include <QObject>
#include <QFile>

//#include <QPlainTextEdit>
#include <QTextStream>
//#include <QDateTime>

class readConfFile : public QObject
{
    Q_OBJECT
public:
    explicit readConfFile(QObject *parent, QString fileName/* = nullptr*/);
 //   ~readConfFile();
public slots:
    void rdCurHiLvl(QString &value);
    void rdCurLowLvl(QString &value);

private:
    QFile *file;
     int lowpecent = -10;
    int Hipercent = -6;
// QPlainTextEdit *m_editor;
// bool m_showDate;
    signals:


};


#endif // READCONFFILE_H









