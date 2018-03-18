#ifndef DESCRIPTION_H
#define DESCRIPTION_H

#include <QSharedPointer>
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
                explicit Description(const QString& aValue);

            public:
                QString value() const;

            private:
                QString mValue_;

            private:
                Description(const Description& aOther);
                Description& operator=(const Description& aOther);
            };
            typedef QSharedPointer<Description> DescriptionPointer;
        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // DESCRIPTION_H
