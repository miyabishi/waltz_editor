#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/Model/mainwindowmodel.h"

using namespace waltz::editor::model;
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("MainWindowModel", &MainWindowModel::getInstance());
    engine.load(QUrl(QLatin1String("qrc:/src/View/MainWindow.qml")));

    return app.exec();
}
