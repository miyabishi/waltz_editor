#ifndef LIBRARYFILEPATH_H
#define LIBRARYFILEPATH_H

#include <waltz_common/parameter.h>

#include <QSharedPointer>
#include <QString>
#include <QVariantMap>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {

            class LibraryFilePath
            {
            public:
                explicit LibraryFilePath(const QString& aValue);
                QVariant toVariant() const;
                QString toString() const;
                static QSharedPointer<LibraryFilePath> fromVariantMap(const QVariantMap& aVariantMap);
                static QString variantMapKey();

            private:
                QString mValue_;
            private:
                LibraryFilePath(LibraryFilePath& aOther);
                LibraryFilePath& operator=(LibraryFilePath& aOther);
            };
            typedef QSharedPointer<LibraryFilePath> LibraryFilePathPointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYFILEPATH_H
