#ifndef NOTEINFORMATION_H
#define NOTEINFORMATION_H

#include <QSharedPointer>
#include "noteid.h"
#include "syllable.h"
#include "noterect.h"
#include "note.h"
#include "portamentoinformation.h"
#include "vibratoinformation.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteInformation
            {
            public:
                NoteInformation(int            aNoteId,
                                const QString& aNoteText,
                                int            aPositionX,
                                int            aPositionY,
                                int            aNoteWidth,
                                int            aNoteHeight);
                NotePointer note(const PortamentoInformationPointer aPortamento,
                                 const VibratoInformationPointer aVibrato) const;

            private:
                NoteId noteId() const;
                Syllable syllable() const;
                NoteRectPointer noteRect() const;



            private:
                int     mNoteId_;
                QString mNoteText_;
                int     mPositionX_;
                int     mPositionY_;
                int     mNoteWidth_;
                int     mNoteHeight_;

            private:
                NoteInformation(const NoteInformation& aOther);
                NoteInformation& operator=(const NoteInformation& aOther);
            };
            typedef QSharedPointer<NoteInformation> NoteInformationPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTEINFORMATION_H
