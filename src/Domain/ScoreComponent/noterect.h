#ifndef NOTERECT_H
#define NOTERECT_H

#include <QSharedPointer>

#include "tempo.h"
#include "beat.h"
#include "noterectposition.h"
#include "noterectwidth.h"
#include "noterectheight.h"
#include "notelength.h"
#include "notestarttime.h"
#include "pitch.h"
#include "src/Model/editareainformation.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteRect
            {
            public:
                NoteRect(const NoteRectPositionPointer aPosition,
                         const NoteRectWidthPointer aWidth,
                         const NoteRectHeightPointer aHeight);

            public:
                NoteStartTimePointer noteStartTime(
                        Beat aBeat,
                        Tempo aTempo,
                        const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;

                NoteLengthPointer noteLength(
                        Beat aBeat,
                        Tempo aTempo,
                        const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;
                PitchPointer pitch(const waltz::editor::model::EditAreaInformationPointer aEditAreaInformation) const;
                int x() const;
                int y() const;
                NoteRectPositionPointer position() const;
                NoteRectPositionPointer center() const;
                NoteRectHeightPointer height() const;

            private:
                NoteRectPositionPointer mPosition_;
                NoteRectWidthPointer    mWidth_;
                NoteRectHeightPointer   mHeight_;

            private:
                NoteRect(const NoteRect& aOther);
                NoteRect& operator=(const NoteRect& aOther);
            };
            typedef QSharedPointer<NoteRect> NoteRectPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTERECT_H
