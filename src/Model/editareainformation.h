#ifndef EDITAREAINFORMATION_H
#define EDITAREAINFORMATION_H

#include "src/Domain/ScoreComponent/notestarttime.h"
#include "src/Domain/ScoreComponent/pitch.h"
#include "src/Domain/ScoreComponent/beat.h"
#include "src/Domain/ScoreComponent/tempo.h"
#include "src/Domain/ScoreComponent/notelength.h"

namespace waltz
{
    namespace editor
    {
        namespace model
        {
            class EditAreaInformation
            {
            public:
                EditAreaInformation(double aWidthRate,
                                    double aHeightRate,
                                    int aSupportOctave,
                                    int aEditAreaWidth);
                EditAreaInformation(const EditAreaInformation& aOther);
                EditAreaInformation& operator=(const EditAreaInformation& aOther);

            public:
                int columnWidth(int aBeatParent) const;
                int rowHeight() const;
                int supportOctave() const;
                int editAreaWidth() const;
                waltz::editor::ScoreComponent::NoteStartTime calculateNoteStartTime(int aX,
                                                                                      waltz::editor::ScoreComponent::Beat aBeat,
                                                                                      waltz::editor::ScoreComponent::Tempo aTempo) const;
                waltz::editor::ScoreComponent::NoteLength calculateNoteLength(int aWidth,
                                                                                waltz::editor::ScoreComponent::Beat aBeat,
                                                                                waltz::editor::ScoreComponent::Tempo aTempo) const;
                waltz::editor::ScoreComponent::Pitch calculatePitch(int aY) const;

            private:
                double calculateSec(int aX,
                                    waltz::editor::ScoreComponent::Beat aBeat,
                                    waltz::editor::ScoreComponent::Tempo aTempo) const;
                int octaveHeight() const;
                int calculateBelongingOctave(int aY) const;
                waltz::editor::ScoreComponent::Tone calculateTone(int aY) const;
                int barWidth(waltz::editor::ScoreComponent::Beat aBeat) const;
                double timeLengthOfABar(waltz::editor::ScoreComponent::Tempo aTempo) const;

            private:
                double mWidthRate_;
                double mHeightRate_;
                int    mSupportOctarve_;
                int    mEditAreaWidth_;
            };

        } // namespace model
    }
} // namespace waltz

#endif // EDITAREAINFORMATION_H
