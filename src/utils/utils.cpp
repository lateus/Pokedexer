#include "utils.h"

#include <QtMath>
#include <QFileDialog>
#include <QClipboard>
#include <QGuiApplication>
#include <QRegularExpression>
#include <QStandardPaths>
#include <QFileInfo>
#include <QDateTime>

Utils::Utils(QObject *parent) : QObject(parent)
{

}

bool Utils::fileExists(const QString &filePath)
{
    return QFile(filePath).exists();
}

QString Utils::dirPathForFile(const QString &filePath)
{
    QFileInfo fInfo(filePath);
    return fInfo.canonicalPath();
}

QString Utils::tempLocation()
{
    return QStandardPaths::standardLocations(QStandardPaths::TempLocation).first();
}

QString Utils::formatFileSize(qint64 bytes)
{
    const char* units[] = { "B", "KB", "MB", "GB", "TB", "PB", "EB" };
    int currentUnit = 0;
    int newAmount(bytes);
    int decimal(0);

    while (newAmount > 1024) {
        decimal = newAmount % 1024;
        newAmount /= 1024;
        currentUnit++;
    }

    return QString("%1.%2 %3").arg(newAmount).arg(qFloor((decimal/1024.0)*100)).arg(units[currentUnit]);
}

void Utils::copyTextToClipboard(const QString &text)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text);
}

QString Utils::getCurrentDateTime(const QString &format)
{
    return QDateTime::currentDateTime().toString(format);
}

QString Utils::trimmedString(const QString &value)
{
    return value.trimmed();
}

bool Utils::isValidEmail(const QString &value)
{
    QRegularExpression regExpMail(".+@.+");
    return regExpMail.match(value).hasMatch();
}
