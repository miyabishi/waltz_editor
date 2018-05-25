#ifndef CorrespondenceAliasLIST_H
#define CorrespondenceAliasLIST_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameter.h>
#include "correspondencealias.h"


namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {

            class CorrespondenceAliasList
            {
            public:
                explicit CorrespondenceAliasList(const waltz::common::Commands::Parameter& aParameter);

            private:
                QList<CorrespondenceAliasPointer> mCorrespondenceAliasList_;

            private:
                CorrespondenceAliasList(const CorrespondenceAliasList& aOther);
                CorrespondenceAliasList& operator=(const CorrespondenceAliasList& aOther);

            };
            typedef QSharedPointer<CorrespondenceAliasList> CorrespondenceAliasListPointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CorrespondenceAliasLIST_H
