
#include "uuid.h"

#include <QUuid>

UUId::UUId(QObject *parent)
    : QObject(parent)
{
}

quint32 UUId::uuid()
{
    return QUuid::createUuid().toString(QUuid::Id128).toUInt(nullptr, 16);
}

void UUId::registerTypes()
{
    static bool registered = false;
    if(registered)
    {
        return;
    }
    registered = true;
    qmlRegisterSingletonType<UUId>("UUId", 1, 0, "UUId", UUId::instance);
}

QObject *UUId::instance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static UUId *mInstance = nullptr;
    if(mInstance == nullptr)
    {
        mInstance = new UUId();
    }
    return mInstance;
}
