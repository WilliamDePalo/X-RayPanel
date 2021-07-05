#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,1,0,0,0,1,0,0,0,
8,0,2,0,0,0,16,0,0,0,2,0,0,1,64,0,
0,0,0,0,1,0,0,0,0,0,0,0,250,0,0,0,
0,0,1,0,0,0,0,0,0,1,228,0,2,0,0,0,
1,0,0,0,23,0,0,0,52,0,2,0,0,0,2,0,
0,0,21,0,0,3,20,0,0,0,0,0,1,0,0,0,
0,0,0,1,24,0,0,0,0,0,1,0,0,0,0,0,
0,2,104,0,2,0,0,0,3,0,0,0,18,0,0,2,
78,0,0,0,0,0,1,0,0,0,0,0,0,0,182,0,
0,0,0,0,1,0,0,0,0,0,0,0,20,0,0,0,
0,0,1,0,0,0,0,0,0,2,234,0,0,0,0,0,
1,0,0,0,0,0,0,1,144,0,0,0,0,0,1,0,
0,0,0,0,0,2,36,0,0,0,0,0,1,0,0,0,
0,0,0,0,214,0,0,0,0,0,1,0,0,0,0,0,
0,1,108,0,0,0,0,0,1,0,0,0,0,0,0,1,
194,0,0,0,0,0,1,0,0,0,0,0,0,2,206,0,
0,0,0,0,1,0,0,0,0,0,0,2,142,0,0,0,
0,0,1,0,0,0,0,0,0,2,174,0,0,0,0,0,
1,0,0,0,0,0,0,0,80,0,0,0,0,0,1,0,
0,0,0,0,0,0,136,0,0,0,0,0,1,0,0,0,
0,0,0,2,4,0,0,0,0,0,1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,3,0,0,120,60,0,113,0,
109,0,108,0,13,13,240,81,156,0,78,0,117,0,109,0,
98,0,101,0,114,0,80,0,97,0,100,0,46,0,113,0,
109,0,108,0,11,10,32,253,212,0,109,0,101,0,110,0,
117,0,83,0,117,0,112,0,112,0,111,0,114,0,116,0,
25,1,86,248,252,0,66,0,108,0,97,0,99,0,107,0,
66,0,117,0,116,0,116,0,111,0,110,0,66,0,97,0,
99,0,107,0,103,0,114,0,111,0,117,0,110,0,100,0,
46,0,113,0,109,0,108,0,20,2,183,226,252,0,66,0,
108,0,97,0,99,0,107,0,66,0,117,0,116,0,116,0,
111,0,110,0,83,0,116,0,121,0,108,0,101,0,46,0,
113,0,109,0,108,0,13,13,148,135,60,0,100,0,97,0,
115,0,104,0,98,0,111,0,97,0,114,0,100,0,46,0,
113,0,109,0,108,0,15,15,80,63,252,0,77,0,65,0,
67,0,97,0,108,0,108,0,80,0,111,0,105,0,110,0,
116,0,46,0,113,0,109,0,108,0,12,1,168,175,60,0,
77,0,97,0,115,0,71,0,97,0,117,0,103,0,101,0,
46,0,113,0,109,0,108,0,17,10,159,131,252,0,84,0,
117,0,114,0,110,0,73,0,110,0,100,0,105,0,99,0,
97,0,116,0,111,0,114,0,46,0,113,0,109,0,108,0,
19,0,155,123,92,0,84,0,97,0,99,0,104,0,111,0,
109,0,101,0,116,0,101,0,114,0,83,0,116,0,121,0,
108,0,101,0,46,0,113,0,109,0,108,0,15,15,228,235,
188,0,86,0,97,0,108,0,117,0,101,0,83,0,111,0,
117,0,114,0,99,0,101,0,46,0,113,0,109,0,108,0,
22,15,10,140,220,0,80,0,114,0,101,0,115,0,115,0,
65,0,110,0,100,0,72,0,111,0,108,0,100,0,66,0,
117,0,116,0,116,0,111,0,110,0,46,0,113,0,109,0,
108,0,14,15,243,35,220,0,75,0,118,0,67,0,97,0,
108,0,108,0,83,0,116,0,101,0,112,0,46,0,113,0,
109,0,108,0,13,9,91,184,116,0,107,0,101,0,121,0,
80,0,97,0,100,0,83,0,117,0,112,0,112,0,111,0,
114,0,116,0,13,1,184,80,156,0,84,0,101,0,120,0,
116,0,70,0,105,0,101,0,108,0,100,0,46,0,113,0,
109,0,108,0,18,15,54,188,28,0,75,0,118,0,67,0,
97,0,108,0,108,0,83,0,116,0,101,0,112,0,95,0,
114,0,101,0,118,0,46,0,113,0,109,0,108,0,10,11,
104,113,92,0,66,0,117,0,116,0,116,0,111,0,110,0,
46,0,113,0,109,0,108,0,16,11,92,201,84,0,78,0,
117,0,109,0,98,0,101,0,114,0,80,0,97,0,100,0,
83,0,117,0,112,0,112,0,111,0,114,0,116,0,13,11,
179,12,243,0,99,0,97,0,108,0,99,0,117,0,108,0,
97,0,116,0,111,0,114,0,46,0,106,0,115,0,13,13,
166,112,28,0,78,0,80,0,95,0,66,0,117,0,116,0,
116,0,111,0,110,0,46,0,113,0,109,0,108,0,11,2,
30,68,220,0,68,0,105,0,115,0,112,0,108,0,97,0,
121,0,46,0,113,0,109,0,108,0,18,14,182,138,28,0,
73,0,99,0,111,0,110,0,71,0,97,0,117,0,103,0,
101,0,83,0,116,0,121,0,108,0,101,0,46,0,113,0,
109,0,108,0,23,10,109,113,124,0,68,0,97,0,115,0,
104,0,98,0,111,0,97,0,114,0,100,0,71,0,97,0,
117,0,103,0,101,0,83,0,116,0,121,0,108,0,101,0,
46,0,113,0,109,0,108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace _qml_DashboardGaugeStyle_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_IconGaugeStyle_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_NumberPadSupport_Display_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_Button_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_KvCallStep_rev_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_keyPadSupport_TextField_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_KvCallStep_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_PressAndHoldButton_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_ValueSource_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_TachometerStyle_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_TurnIndicator_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_NumberPadSupport_NP_Button_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_NumberPadSupport_calculator_js { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_MasGauge_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_MACallPoint_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_dashboard_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_menuSupport_BlackButtonStyle_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_menuSupport_BlackButtonBackground_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _qml_NumberPad_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/DashboardGaugeStyle.qml"), &QmlCacheGeneratedCode::_qml_DashboardGaugeStyle_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/IconGaugeStyle.qml"), &QmlCacheGeneratedCode::_qml_IconGaugeStyle_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/NumberPadSupport/Display.qml"), &QmlCacheGeneratedCode::_qml_NumberPadSupport_Display_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/Button.qml"), &QmlCacheGeneratedCode::_qml_Button_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/KvCallStep_rev.qml"), &QmlCacheGeneratedCode::_qml_KvCallStep_rev_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/keyPadSupport/TextField.qml"), &QmlCacheGeneratedCode::_qml_keyPadSupport_TextField_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/KvCallStep.qml"), &QmlCacheGeneratedCode::_qml_KvCallStep_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/PressAndHoldButton.qml"), &QmlCacheGeneratedCode::_qml_PressAndHoldButton_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/ValueSource.qml"), &QmlCacheGeneratedCode::_qml_ValueSource_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/TachometerStyle.qml"), &QmlCacheGeneratedCode::_qml_TachometerStyle_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/TurnIndicator.qml"), &QmlCacheGeneratedCode::_qml_TurnIndicator_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/NumberPadSupport/NP_Button.qml"), &QmlCacheGeneratedCode::_qml_NumberPadSupport_NP_Button_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/NumberPadSupport/calculator.js"), &QmlCacheGeneratedCode::_qml_NumberPadSupport_calculator_js::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/MasGauge.qml"), &QmlCacheGeneratedCode::_qml_MasGauge_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/MACallPoint.qml"), &QmlCacheGeneratedCode::_qml_MACallPoint_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/dashboard.qml"), &QmlCacheGeneratedCode::_qml_dashboard_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/menuSupport/BlackButtonStyle.qml"), &QmlCacheGeneratedCode::_qml_menuSupport_BlackButtonStyle_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/menuSupport/BlackButtonBackground.qml"), &QmlCacheGeneratedCode::_qml_menuSupport_BlackButtonBackground_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/qml/NumberPad.qml"), &QmlCacheGeneratedCode::_qml_NumberPad_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_mu_de_manager)() {
    ::unitRegistry();
    Q_INIT_RESOURCE(mu_de_manager_qmlcache);
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_mu_de_manager))
int QT_MANGLE_NAMESPACE(qCleanupResources_mu_de_manager)() {
    Q_CLEANUP_RESOURCE(mu_de_manager_qmlcache);
    return 1;
}
