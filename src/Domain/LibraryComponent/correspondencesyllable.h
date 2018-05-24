#ifndef CORRESPONDENCESYLLABLE_H
#define CORRESPONDENCESYLLABLE_H

#include <QSharedPointer>
#include <QString>
#include <waltz_common/parameters.h>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {

            class CorrespondenceSyllable
            {
            public:
                explicit CorrespondenceSyllable(const waltz::common::Commands::Parameters& aParameters);

            private:
                QString mValue_;


            private:
                CorrespondenceSyllable(const CorrespondenceSyllable& aOther);
                CorrespondenceSyllable& operator=(const CorrespondenceSyllable& aOther);

            };
            typedef QSharedPointer<CorrespondenceSyllable> CorrespondenceSyllablePointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CORRESPONDENCESYLLABLE_H
