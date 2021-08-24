/****************************************************************************
** Meta object code from reading C++ file 'excelmgm.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../Mu.De._Manager/excelmgm.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'excelmgm.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Excelmgm_t {
    QByteArrayData data[8];
    char stringdata0[58];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Excelmgm_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Excelmgm_t qt_meta_stringdata_Excelmgm = {
    {
QT_MOC_LITERAL(0, 0, 8), // "Excelmgm"
QT_MOC_LITERAL(1, 9, 8), // "openFile"
QT_MOC_LITERAL(2, 18, 0), // ""
QT_MOC_LITERAL(3, 19, 10), // "writeParam"
QT_MOC_LITERAL(4, 30, 7), // "setList"
QT_MOC_LITERAL(5, 38, 3), // "pos"
QT_MOC_LITERAL(6, 42, 5), // "value"
QT_MOC_LITERAL(7, 48, 9) // "closeFile"

    },
    "Excelmgm\0openFile\0\0writeParam\0setList\0"
    "pos\0value\0closeFile"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Excelmgm[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x0a /* Public */,
       3,    0,   35,    2, 0x0a /* Public */,
       4,    2,   36,    2, 0x0a /* Public */,
       7,    0,   41,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    5,    6,
    QMetaType::Void,

       0        // eod
};

void Excelmgm::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Excelmgm *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { int _r = _t->openFile();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 1: _t->writeParam(); break;
        case 2: _t->setList((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 3: _t->closeFile(); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Excelmgm::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_Excelmgm.data,
    qt_meta_data_Excelmgm,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Excelmgm::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Excelmgm::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Excelmgm.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Excelmgm::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
