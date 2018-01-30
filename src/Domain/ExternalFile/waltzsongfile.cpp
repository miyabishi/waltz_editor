#include <QDebug>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QBitArray>
#include <QFile>

#include "waltzsongfile.h"

using namespace waltz::editor::ExternalFile;

WaltzSongFile::WaltzSongFile(const QString& aFilePath)
    : mFilePath_(aFilePath)
{
}

void WaltzSongFile::save(const QVariantMap& aData) const
{
    QJsonObject object = QJsonObject::fromVariantMap(aData);
    QJsonDocument document(object);
    qDebug() << document.toJson();

    QByteArray data(document.toJson());
    QFile saveFile(mFilePath_);
    saveFile.open(QIODevice::WriteOnly);
    saveFile.write(data);
    saveFile.close();
}

QVariantMap WaltzSongFile::load() const
{
    QFile openFile(mFilePath_);
    openFile.open(QIODevice::ReadOnly);
    QByteArray data = openFile.readAll();
    openFile.close();

    QJsonDocument jsonDoc(QJsonDocument::fromJson(data));
    QJsonObject jsonObj(jsonDoc.object());
    return jsonObj.toVariantMap();
}
