#include "vibratoamplitude.h"
#include "vibrato.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;

Vibrato::Vibrato(const NoteId aNoteId, const VibratoFormPointer aVibratoForm)
  : mNoteId_(aNoteId)
  , mVibratoForm_(aVibratoForm)
{
}


Parameters Vibrato::toParameters(const Beat aBeat,
                                 const Tempo aTempo,
                                 const model::EditAreaInformationPointer aEditAreaInformation) const
{
    Parameters parameters;
    VibratoAmplitudePointer amplitude(new VibratoAmplitude(mVibratoForm_->amplitude()));
    parameters.append(aEditAreaInformation->calculateVibratoLength(
                          mVibratoForm_->length(),
                          aBeat,
                          aTempo)->toParameter());
    parameters.append(aEditAreaInformation->calculateVibratoWavelength(
                          mVibratoForm_->wavelength(),
                          aBeat,
                          aTempo)->toParameter());
    parameters.append(amplitude->toParameter());
    return parameters;
}
