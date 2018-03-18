#ifndef LIBRARYNAME_H
#define LIBRARYNAME_H

#include <QSharedPointer>
#include <QString>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {
            class LibraryName
            {
            public:
                explicit LibraryName(const QString& aValue);

            public:
                QString value() const;

            private:
                QString mValue_;

            private:
                LibraryName(const LibraryName& aOther);
                LibraryName& operator=(const LibraryName& aOther);
            };
            typedef QSharedPointer<LibraryName> LibraryNamePointer;
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYNAME_H
