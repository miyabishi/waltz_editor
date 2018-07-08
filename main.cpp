#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include "src/Model/mainwindowmodel.h"
#include "src/Model/mathutility.h"
#include "src/Domain/VocalEngine/engine.h"


using namespace waltz::editor::model;
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    waltz::editor::VocalEngine::Engine vocalEngine;
    vocalEngine.start();

    QTranslator translator;
    translator.load(QLatin1String("qml_") + QLocale::system().name(),
                    QLatin1String("src/View/i18n"));
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("MainWindowModel", &MainWindowModel::getInstance());

    MathUtility mathUtility;

    engine.rootContext()->setContextProperty("MathUtility", &mathUtility);

    engine.load(QUrl(QLatin1String("qrc:/src/View/MainWindow.qml")));

    return app.exec();
}
