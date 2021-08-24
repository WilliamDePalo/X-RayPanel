#include "excelmgm.h"
#include <QFileDialog>
#include <string.h>
#include <vcruntime_string.h>
#include <qbytearray.h>
#include <qbytearraylist.h>
#include <qglobal.h>
#include <QStandardPaths>

Excelmgm::Excelmgm()
{
    unsigned char id = 0;
  //  trimBuff.reserve(25);
     trimBuff.begin();
    while (id < 25)
    {
        trimBuff.append("");
        id++;
    }

}
int Excelmgm::openFile(){
    QString FilePath = "../Mu.De._Manager/other/T0XXX.xlsx";
    //
    //             "c:\\progetti\\Interfaccia Mu.De. Manager\\Mu.De.Manager\\sv_Mu.De.Manager\\Mu.De._Manager\\other\\90053.C VDC XRST30_rev08.xls");


    QFileInfo info(FilePath);

    FilePath = info.absoluteFilePath();                   //Getting the Jedi Path of the Template
    FilePath = QDir::toNativeSeparators(FilePath);   //Change paths,Give Way windows Able to identify

    if(!info.exists())
    {
        return 0;
    }



 //   QString ExcelFile = QDir::toNativeSeparators(saveas());  //Open the File Save dialog box,Find the location to save
//    if(ExcelFile=="")
 //              return  0;

//   QFile::copy(FilePath, ExcelFile);                   //Copy the template file to the location to be saved

//   info.setFile(ExcelFile);
//   info.setFile(info.dir().path()+"/~$"+info.fileName());

//   if(info.exists())          //Judge,Do you have it or not?"~$XXX.xlsx"File exists,Is it for read-only?
//   {
//       qDebug()<<"Report property is read-only,Please check that the file is open!";
//        return   0;
//   }
//
   excel     = new QAxObject("Excel.Application");


   workbooks = excel->querySubObject("Workbooks");

    workbook  = workbooks->querySubObject("Open(const QString&)",FilePath);
    sheets    = workbook->querySubObject("Worksheets");
    sheet     = sheets->querySubObject("Item(int)", 1);    // use first worksheet
    // setup a range of 700 rows and 10 columns
  //  auto range     = sheet->querySubObject("Range(A1,1000)");
    return 1;
}

void Excelmgm::writeParam()
{
    QString tmo = "";
    int r = 0;
    QAxObject * cCell;
    // read the 7th cells in row 22..40 jumping row 30
    for (int row = 22; (row <= 40)&&(r<trimBuff.length()); ++row)
    {
        if (row == 30)
            continue;
       // else
       //     r++;
        //    if (row>30)
         //  r = row - 22+ 1;
        //cCell->dynamicCall("Write()",trimBuff.operator[](r-22));            
      //  else
        //   r  = row - 22;

        tmo = trimBuff.at(r++);
        cCell = sheet->querySubObject("Cells(int,int)",row,7);
        cCell->setProperty("Value",tmo);
        QString dbg = cCell->dynamicCall("Value()").toString();
    }
    workbook->dynamicCall("Save()" );
}

void Excelmgm::setList(int pos, QString value)
{
    TrimElem tmp;
    tmp.position = pos;
    tmp.sTrim=value;

    //if (trimBuff.at(pos-9) == NULL)
    trimBuff[(pos-1)] = value;
   // trimBuff.insert(pos-9,value);
  //  trimBuff.at(pos-9) = "value";//)) value.toStdString()"value";
    // lo scrivo nel posto giusto
  //  strcpy((char*)trimBuff.at(pos-9),(const void *)&value.toStdString());
}

void Excelmgm::closeFile()
{
     excel->dynamicCall("Quit()");
}

Excelmgm::~Excelmgm()
{
        // workbook->dynamicCall("Close()");  //Close file
    // don't forget to quit Excel
  //  excel->dynamicCall("Quit()");
    delete excel;
}
