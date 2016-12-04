#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "sender.hpp"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Sender>("xyz.prinkov", 1, 0, "Sender");
    qmlRegisterSingletonType(QUrl("qrc:/objects/User.qml"), "xyz.prinkov", 1, 0, "User" );
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
