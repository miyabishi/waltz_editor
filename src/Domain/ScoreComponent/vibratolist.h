#ifndef VIBRATOLIST_H
#define VIBRATOLIST_H

#include <QSharedPointer>
#include <QList>
#include "vibrato.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoList
            {
            public:
                VibratoList();
                void append(const VibratoPointer aVibrato);
                void clearVibrato();

            private:
                QList<VibratoPointer> mVibratoList_;

            private:
                VibratoList(const VibratoList& aOther);
                VibratoList& operator=(const VibratoList& aOther);
            };
            typedef QSharedPointer<VibratoList> VibratoListPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOLIST_H
