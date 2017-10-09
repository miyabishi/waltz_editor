#ifndef NOTE_H
#define NOTE_H

#include <memory>
#include <QSharedPointer>

#include "pitch.h"
#include "syllable.h"
#include "notestarttime.h"
#include "notelength.h"
#include "noteid.h"
#include "noterect.h"
#include "tempo.h"
#include "beat.h"
#include "portamento.h"
#include "vibrato.h"
#include "src/Model/editareainformation.h"
#include "vibratoendpoint.h"
#include "vibratostartpoint.h"


namespace waltz
{
    namespace  common
    {
        namespace Commands
        {
            class Parameters;
        }
    }
    namespace editor
    {
        namespace ScoreComponent
        {
            class Note
            {
            public:
                Note(const NoteId&           aNoteId,
                     const Syllable&         aSyllable,
                     const NoteRectPointer   aNoteRect,
                     const PortamentoPointer aPortament,
                     const VibratoPointer    aVibrato);
            public:
                waltz::common::Commands::Parameters toParameters(Beat aBeat,
                                                                 Tempo aTempo,
                                                                 waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;
                bool xPositionIs(int aX);
                int xPosition() const;

                VibratoStartPointPointer vibratoStartPoint() const;
                VibratoEndPointPointer vibratoEndPoint() const;

                NoteId noteId() const;
                bool noteIdEquals(const NoteId& aOtherNoteId) const;

                PortamentoPointer portamento() const;
                VibratoPointer    vibrato() const;
                NoteRectPointer noteRect() const;

            private:
                NoteId            mNoteId_;
                Syllable          mSyllable_;
                NoteRectPointer   mNoteRect_;
                PortamentoPointer mPortamento_;
                VibratoPointer    mVibrato_;

            private:
                Note(const Note& aOther);
                Note& operator=(const Note& aOther);
            };
            typedef QSharedPointer<Note> NotePointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz
#endif // NOTE_H
