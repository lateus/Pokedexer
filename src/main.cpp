#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Lateus");
    app.setApplicationName("Pokédexer");
    app.setApplicationVersion("1.0");
    app.setWindowIcon(QIcon(":/images/icons/app/appIcon.png"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/ui/qml/main.qml")); // If the application takes time to load, consider using the splash screen (qrc:/ui/qml/splash.qml)
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
#ifdef Q_OS_ANDROID
    QtAndroid::hideSplashScreen(50);
#endif

    return app.exec();
}
