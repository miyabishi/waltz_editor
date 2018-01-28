#include <QDebug>
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
    QMap<QString, QVariant>::const_iterator dataIterator = aData.constBegin();
    while(dataIterator != aData.constEnd())
    {
        qDebug() << dataIterator.key();
        if (! dataIterator.value().canConvert<QVariantList>())
        {
            qDebug() << "can't convert QVariantList";
            ++dataIterator;
            continue;
        }

        QVariantList subData = dataIterator.value().value<QVariantList>();

        foreach(const QVariant& subSubData, subData )
        {
            if(! subSubData.canConvert<QVariantMap>())
            {
                qDebug() << "can't convert QVariantMap";
                continue;
            }
            QVariantMap subSubDataMap = subSubData.value<QVariantMap>();
            QMap<QString, QVariant>::const_iterator subSubDataIterator = subSubDataMap.constBegin();

            while(subSubDataIterator != subSubDataMap.constEnd())
            {
                qDebug() << subSubDataIterator.key();
                qDebug() << subSubDataIterator.value();
                ++subSubDataIterator;
            }

        }
        ++dataIterator;
    }
    /*
    QFile saveFile(mFilePath_);
    saveFile.open(QIODevice::WriteOnly);
    saveFile.write(data);
    saveFile.close();
    */
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
