#ifndef LIBRARYNAME_H
#define LIBRARYNAME_H

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
                LibraryName();
                LibraryName(const QString& aValue);
                LibraryName(const LibraryName& aOther);
                LibraryName& operator=(const LibraryName& aOther);
            public:
                QString value() const;

            private:
                QString mValue_;
            };

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // LIBRARYNAME_H
