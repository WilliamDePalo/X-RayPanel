#include "serialLogger.h"

Logger::Logger(QObject *parent, QString fileName/*, QPlainTextEdit *editor*/) : QObject(parent) {
// m_editor = editor;
 m_showDate = true;
 if (!fileName.isEmpty()) {
  file = new QFile;
  file->setFileName(fileName);
  file->open(QIODevice::Append | QIODevice::Text);
 }
}

void Logger::write(const QString &value) {
 QString text = value;// + "";
 if (m_showDate)
  text = QDateTime::currentDateTime().toString("dd.MM.yyyy hh:mm:ss ") + text;
 QTextStream out(file);
 out.setCodec("UTF-8");
 if (file != 0) {
     checkDim();
  out << text;
 }
// if (m_editor != 0)
//  m_editor->appendPlainText(text);
}
void Logger::checkDim()
{

    qint64 ps = file->pos();//file->size();
    if (ps>= 2000000) // 1.461.010
        file->seek(0); // sposto all'inizio il cursore
}
void Logger::setShowDateTime(bool value) {
 m_showDate = value;
}

Logger::~Logger() {
 if (file != 0)
 file->close();
}
