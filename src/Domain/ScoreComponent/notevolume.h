#ifndef NOTEVOLUME_H
#define NOTEVOLUME_H

#include "abstractnoteparameter.h"

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class NoteVolume : public AbstractNoteParameter
            {
            public:
                explicit NoteVolume(int aValue);
                ~NoteVolume();

            public:
                common::Commands::Parameter toParameter() const;

            private:
                common::Commands::Parameter& mParameter_;

            private:
                NoteVolume(const NoteVolume& aOther);
                NoteVolume& operator=(const NoteVolume& aOther);
            };

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // NOTEVOLUME_H
