#ifndef LIBRARYFILEPATH_H
#define LIBRARYFILEPATH_H

#include <QSharedPointer>
#include <QString>

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
