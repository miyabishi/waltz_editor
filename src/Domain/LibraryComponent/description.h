#ifndef DESCRIPTION_H
#define DESCRIPTION_H

#include <QString>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {
            class Description
            {
            public:
                Description();
                explicit Description(const QString& aValue);
                Description(const Description& aOther);
                Description& operator=(const Description& aOther);

            public:
                QString value() const;

            private:
                QString mValue_;
            };
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // DESCRIPTION_H
