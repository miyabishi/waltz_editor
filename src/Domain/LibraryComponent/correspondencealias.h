#ifndef CorrespondenceAlias_H
#define CorrespondenceAlias_H

#include <QSharedPointer>
#include <QString>
#include <waltz_common/parameters.h>

namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {

            class CorrespondenceAlias
            {
            public:
                explicit CorrespondenceAlias(const waltz::common::Commands::Parameters& aParameters);

            private:
                QString mValue_;


            private:
                CorrespondenceAlias(const CorrespondenceAlias& aOther);
                CorrespondenceAlias& operator=(const CorrespondenceAlias& aOther);

            };
            typedef QSharedPointer<CorrespondenceAlias> CorrespondenceAliasPointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CorrespondenceAlias_H
