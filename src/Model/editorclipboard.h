#ifndef EDITORCLIPBOARD_H
#define EDITORCLIPBOARD_H

#include <QMimeData>
#include <QPointer>
#include <QClipboard>
#include <QSharedPointer>
#include <QVariantMap>

namespace waltz
{
    namespace editor
    {
        namespace model
        {
            class EditorClipboard
            {
            public:
                EditorClipboard();
                ~EditorClipboard();

            public:
                void save(const QVariantMap& aData);
                QVariantMap load()const;

            private:
                QSharedPointer<QMimeData> mMimeData_;
            };
            typedef QSharedPointer<EditorClipboard> EditorClipboardPointer;

        } // namespace model
    } // namespace editor
} // namespace waltz

#endif // EDITORCLIPBOARD_H
