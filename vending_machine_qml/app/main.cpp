#include <QDebug>
#include <QFAppDispatcher>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSListModel>
#include <QuickFlux>
#include <duperagent.h>
#include <uuid.h>

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("ecruzolivera");
    QCoreApplication::setOrganizationDomain("ecruzolivera.tech");
    QCoreApplication::setApplicationName("Starter");
    QQmlApplicationEngine engine;
    UUId::registerTypes();
    com::cutehacks::duperagent::registerTypes();
    registerQSyncableTypes();
    registerQuickFluxQmlTypes();
    engine.addImportPath("qrc:///");
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if(!obj && url == objUrl)
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    auto dispatcher = QFAppDispatcher::instance(&engine);

    dispatcher->dispatch("startApp");

    engine.load(url);
    return app.exec();
}
