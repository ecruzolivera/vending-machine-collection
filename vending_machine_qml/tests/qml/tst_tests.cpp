#include <QQmlContext>
#include <QQmlEngine>
#include <QtQuickTest/quicktest.h>

class Setup : public QObject
{
    Q_OBJECT
public:
    Setup() {}
    virtual ~Setup() {}

  public slots:
    void qmlEngineAvailable(QQmlEngine *engine)
    {
        qDebug() << "engine->importPathList(): " << engine->importPathList();
    }
};

QUICK_TEST_MAIN_WITH_SETUP(test, Setup)

//#include "tst_tests.moc"
