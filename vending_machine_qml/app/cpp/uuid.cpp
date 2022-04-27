
#include "uuid.h"

#include <QUuid>

UUId::UUId(QObject *parent)
    : QObject(parent)
{
}

QString UUId::uuid()
{
    auto id = QUuid::createUuid().toString(QUuid::WithoutBraces);
    qDebug() << id;
    return id;
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
