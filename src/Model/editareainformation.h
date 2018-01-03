#ifndef EDITAREAINFORMATION_H
#define EDITAREAINFORMATION_H

#include <QSharedPointer>
#include "src/Domain/ScoreComponent/notestarttime.h"
#include "src/Domain/ScoreComponent/pitchchangingpointtime.h"
#include "src/Domain/ScoreComponent/pitchchangingpointfrequency.h"
#include "src/Domain/ScoreComponent/pitch.h"
#include "src/Domain/ScoreComponent/beat.h"
#include "src/Domain/ScoreComponent/tempo.h"
#include "src/Domain/ScoreComponent/notelength.h"
#include "src/Domain/ScoreComponent/vibratolength.h";
#include "src/Domain/ScoreComponent/vibratowavelength.h";


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

            public:
                int columnWidth(int aBeatParent) const;
                int rowHeight() const;
                int supportOctave() const;
                int editAreaWidth() const;
                int calculatePositionX(ScoreComponent::NoteStartTimePointer aNoteStartTIme,
                                       ScoreComponent::Beat aBeat,
                                       ScoreComponent::Tempo aTempo) const;
                ScoreComponent::NoteStartTimePointer calculateNoteStartTime(int aX,
                                                                            ScoreComponent::Beat aBeat,
                                                                            ScoreComponent::Tempo aTempo) const;
                ScoreComponent::PitchChangingPointTimePointer calculatePitchChangningPointTime(int aX,
                                                                                               ScoreComponent::Beat aBeat,
                                                                                               ScoreComponent::Tempo aTempo) const;
                ScoreComponent::PitchChangingPointFrequencyPointer calculatePitchChangningPointFrequency(int aY) const;
                ScoreComponent::NoteLengthPointer calculateNoteLength(int aWidth,
                                                                      ScoreComponent::Beat aBeat,
                                                                      ScoreComponent::Tempo aTempo) const;
                ScoreComponent::PitchPointer calculatePitch(int aY) const;

                ScoreComponent::VibratoLengthPointer calculateVibratoLength(int aLength,
                                                                            ScoreComponent::Beat aBeat,
                                                                            ScoreComponent::Tempo aTempo) const;
                ScoreComponent::VibratoWavelengthPointer calculateVibratoWavelength(int aWavelength,
                                                                                    ScoreComponent::Beat aBeat,
                                                                                    ScoreComponent::Tempo aTempo) const;

            private:
                double calculateSec(int aX,
                                    waltz::editor::ScoreComponent::Beat aBeat,
                                    waltz::editor::ScoreComponent::Tempo aTempo) const;
                int octaveHeight() const;
                int calculateBelongingOctave(int aY) const;
                waltz::editor::ScoreComponent::Tone calculateTone(int aY) const;
                int barWidth(waltz::editor::ScoreComponent::Beat aBeat) const;
                double timeLengthOfABar(waltz::editor::ScoreComponent::Tempo aTempo) const;
                int editAreaHeight() const;

            private:
                double mWidthRate_;
                double mHeightRate_;
                int    mSupportOctarve_;
                int    mEditAreaWidth_;

            private:
                EditAreaInformation(const EditAreaInformation& aOther);
                EditAreaInformation& operator=(const EditAreaInformation& aOther);
            };
            typedef QSharedPointer<EditAreaInformation> EditAreaInformationPointer;
        } // namespace model
    }
} // namespace waltz

#endif // EDITAREAINFORMATION_H
