#ifndef VIBRATO_H
#define VIBRATO_H

#include <QSharedPointer>
#include "vibratoform.h"
#include "noteid.h"


namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Vibrato
            {
            public:
                Vibrato(const NoteId aNoteId,
                        const VibratoFormPointer aVibratoForm);

            private:
                NoteId mNoteId_;
                VibratoFormPointer mVibratoForm_;

            private:
                Vibrato(const Vibrato& aOther);
                Vibrato& operator=(const Vibrato& aOther);
            };
            typedef QSharedPointer<Vibrato> VibratoPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATO_H
