#ifndef CORRESPONDENCESYLLABLELIST_H
#define CORRESPONDENCESYLLABLELIST_H

#include <QSharedPointer>
#include <QList>
#include <waltz_common/parameter.h>
#include "correspondencesyllable.h"


namespace waltz
{
    namespace editor
    {
        namespace LibraryComponent
        {

            class CorrespondenceSyllableList
            {
            public:
                explicit CorrespondenceSyllableList(const waltz::common::Commands::Parameter& aParameter);

            private:
                QList<CorrespondenceSyllablePointer> mCorrespondenceSyllableList_;

            private:
                CorrespondenceSyllableList(const CorrespondenceSyllableList& aOther);
                CorrespondenceSyllableList& operator=(const CorrespondenceSyllableList& aOther);

            };
            typedef QSharedPointer<CorrespondenceSyllableList> CorrespondenceSyllableListPointer;

        } // namespace LibraryComponent
    } // namespace editor
} // namespace waltz

#endif // CORRESPONDENCESYLLABLELIST_H
