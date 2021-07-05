/****************************************************************************
** Meta object code from reading C++ file 'serialterminal.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../Mu.De._Manager/serial/serialterminal.h"
#include <QtGui/qtextcursor.h>
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'serialterminal.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_StringParsing_t {
    const uint offsetsAndSize[10];
    char stringdata0[38];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_StringParsing_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_StringParsing_t qt_meta_stringdata_StringParsing = {
    {
QT_MOC_LITERAL(0, 13), // "StringParsing"
QT_MOC_LITERAL(14, 7), // "process"
QT_MOC_LITERAL(22, 0), // ""
QT_MOC_LITERAL(23, 1), // "a"
QT_MOC_LITERAL(25, 12) // "errorMessage"

    },
    "StringParsing\0process\0\0a\0errorMessage"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_StringParsing[] = {

 // content:
       9,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       1,   23, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   20,    2, 0x02,    1 /* Public */,

 // methods: parameters
    QMetaType::QString, QMetaType::QString,    3,

 // properties: name, type, flags
       4, QMetaType::QString, 0x00015001, uint(-1), 0,

       0        // eod
};

void StringParsing::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<StringParsing *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { QString _r = _t->process((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<StringParsing *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->errorMessage(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject StringParsing::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_StringParsing.offsetsAndSize,
    qt_meta_data_StringParsing,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_StringParsing_t
, QtPrivate::TypeAndForceComplete<QString, std::true_type>

, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>

>,
    nullptr
} };


const QMetaObject *StringParsing::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *StringParsing::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_StringParsing.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int StringParsing::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 1;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
struct qt_meta_stringdata_SerialTerminal_t {
    const uint offsetsAndSize[34];
    char stringdata0[216];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_SerialTerminal_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_SerialTerminal_t qt_meta_stringdata_SerialTerminal = {
    {
QT_MOC_LITERAL(0, 14), // "SerialTerminal"
QT_MOC_LITERAL(15, 7), // "getData"
QT_MOC_LITERAL(23, 0), // ""
QT_MOC_LITERAL(24, 4), // "data"
QT_MOC_LITERAL(29, 18), // "openSerialPortSlot"
QT_MOC_LITERAL(48, 7), // "comName"
QT_MOC_LITERAL(56, 4), // "baud"
QT_MOC_LITERAL(61, 21), // "writeToSerialPortSlot"
QT_MOC_LITERAL(83, 7), // "message"
QT_MOC_LITERAL(91, 18), // "readFromSerialPort"
QT_MOC_LITERAL(110, 23), // "getConnectionStatusSlot"
QT_MOC_LITERAL(134, 19), // "closeSerialPortSlot"
QT_MOC_LITERAL(154, 20), // "writeToSerialPCIMode"
QT_MOC_LITERAL(175, 5), // "flush"
QT_MOC_LITERAL(181, 9), // "putPC1cmd"
QT_MOC_LITERAL(191, 15), // "flushSendBuffer"
QT_MOC_LITERAL(207, 8) // "resetAck"

    },
    "SerialTerminal\0getData\0\0data\0"
    "openSerialPortSlot\0comName\0baud\0"
    "writeToSerialPortSlot\0message\0"
    "readFromSerialPort\0getConnectionStatusSlot\0"
    "closeSerialPortSlot\0writeToSerialPCIMode\0"
    "flush\0putPC1cmd\0flushSendBuffer\0"
    "resetAck"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SerialTerminal[] = {

 // content:
       9,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   74,    2, 0x06,    0 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       4,    2,   77,    2, 0x0a,    2 /* Public */,
       7,    1,   82,    2, 0x0a,    5 /* Public */,
       9,    0,   85,    2, 0x0a,    7 /* Public */,
      10,    0,   86,    2, 0x0a,    8 /* Public */,
      11,    0,   87,    2, 0x0a,    9 /* Public */,
      12,    2,   88,    2, 0x0a,   10 /* Public */,
      14,    2,   93,    2, 0x0a,   13 /* Public */,
      15,    0,   98,    2, 0x0a,   16 /* Public */,
      16,    0,   99,    2, 0x0a,   17 /* Public */,

 // signals: parameters
    QMetaType::QString, QMetaType::QString,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::Int,    5,    6,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::Int,    8,   13,
    QMetaType::Void, QMetaType::QString, QMetaType::Char,    8,   13,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void SerialTerminal::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<SerialTerminal *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { QString _r = _t->getData((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 1: _t->openSerialPortSlot((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 2: _t->writeToSerialPortSlot((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->readFromSerialPort(); break;
        case 4: { bool _r = _t->getConnectionStatusSlot();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->closeSerialPortSlot(); break;
        case 6: _t->writeToSerialPCIMode((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 7: _t->putPC1cmd((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< char(*)>(_a[2]))); break;
        case 8: _t->flushSendBuffer(); break;
        case 9: _t->resetAck(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = QString (SerialTerminal::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SerialTerminal::getData)) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject SerialTerminal::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_SerialTerminal.offsetsAndSize,
    qt_meta_data_SerialTerminal,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_SerialTerminal_t
, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<bool, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<char, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>


>,
    nullptr
} };


const QMetaObject *SerialTerminal::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SerialTerminal::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_SerialTerminal.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int SerialTerminal::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
QString SerialTerminal::getData(QString _t1)
{
    QString _t0{};
    void *_a[] = { const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t0))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
    return _t0;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
