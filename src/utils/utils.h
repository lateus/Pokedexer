#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QFile>
#include <QtQml>

class Utils : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit Utils(QObject *parent = nullptr);

public slots:
    static bool fileExists(const QString &filePath);
    static QString dirPathForFile(const QString &filePath);
    static QString tempLocation();
    static QString formatFileSize(qint64 bytes);

    static void copyTextToClipboard(const QString &text);

    static QString getCurrentDateTime(const QString &format);

    static QString trimmedString(const QString &value);
    static bool isValidEmail(const QString &value);

signals:
    void error(int code, const QString &message);
};

#endif // UTILS_H
