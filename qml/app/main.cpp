#include <QDebug>
#include <QFAppDispatcher>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSListModel>
#include <QuickFlux>
#include <duperagent.h>
#include <uuid.h>

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg);

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("ecruzolivera");
    QCoreApplication::setApplicationName("Vending Machine QML Example");
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
        [url](QObject *obj, const QUrl &objUrl)
        {
            if(!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    auto dispatcher = QFAppDispatcher::instance(&engine);

    dispatcher->dispatch("startApp");

    engine.load(url);

    qInstallMessageHandler(myMessageOutput);
    return app.exec();
}

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    auto type2String = [](QtMsgType t)
    {
        switch(t)
        {
            case QtDebugMsg:
                return "debug";
            case QtInfoMsg:
                return "info";
            case QtWarningMsg:
                return "warning";
            case QtCriticalMsg:
                return "critical";
            case QtFatalMsg:
                return "fatal";
            default:
                return "unknown";
        }
    };

    const auto file      = QString{context.file ? context.file : ""};
    const auto line      = context.line ? context.line : 0;
    const auto fileLine  = file.isEmpty() ? QString{""} : QString{"%1:%2"}.arg(file).arg(line);
    const auto outputMsg = QString{"[%1] %2 %3\n"}.arg(type2String(type), fileLine, msg);
    auto       outStream = QTextStream{stderr};
    outStream << outputMsg;
}
