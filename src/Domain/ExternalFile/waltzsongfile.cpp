#include <QJsonObject>
#include <QJsonDocument>
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
    QByteArray data(document.toBinaryData());
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
    QJsonDocument jsonDoc(QJsonDocument::fromBinaryData(data));
    QJsonObject jsonObj(jsonDoc.object());
    return jsonObj.toVariantMap();
}
