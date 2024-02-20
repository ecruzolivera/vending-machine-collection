#ifndef UUID_H
#define UUID_H

#include <QObject>
#include <QQmlApplicationEngine>

class UUId : public QObject
{
    Q_OBJECT
  public:
    Q_INVOKABLE QString uuid();

    static void registerTypes();

  private:
    explicit UUId(QObject *parent = nullptr);
    static QObject *instance(QQmlEngine *engine = nullptr, QJSEngine *scriptEngine = nullptr);
};

#endif // UUID_H
