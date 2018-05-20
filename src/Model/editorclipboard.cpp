
#include <QJsonObject>
#include <QJsonDocument>
#include <QApplication>

#include "editorclipboard.h"


using namespace waltz::editor::model;

namespace
{
    const QString mimeType("application/waltznote");
}

EditorClipboard::EditorClipboard()
{
}

EditorClipboard::~EditorClipboard()
{
    if (! mMimeData_.isNull())
    {
        delete mMimeData_;
    }
}

QVariantMap EditorClipboard::load() const
{
    QClipboard* clipboard = QApplication::clipboard();
    const QMimeData* mimeData = clipboard->mimeData();

    QStringList formats = mimeData->formats();
    foreach (QString format, formats)
    {
        if (format != mimeType) continue;
        QByteArray data = mimeData->data(mimeType);
        QJsonDocument jsonDoc(QJsonDocument::fromJson(data));
        QJsonObject jsonObj(jsonDoc.object());
        return jsonObj.toVariantMap();
    }
    return QVariantMap();
}

void EditorClipboard::save(const QVariantMap &aData)
{
    QJsonObject object = QJsonObject::fromVariantMap(aData);
    QJsonDocument document(object);

    QByteArray data(document.toJson());

    if (! mMimeData_.isNull())
    {
        delete mMimeData_;
    }
    mMimeData_ = new QMimeData();

    mMimeData_->setData(mimeType, data);

    QClipboard* clipbord = QApplication::clipboard();
    clipbord->clear();
    clipbord->setMimeData(mMimeData_);
}

