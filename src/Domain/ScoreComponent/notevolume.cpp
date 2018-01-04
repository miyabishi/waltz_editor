#include <waltz_common/parameter.h>
#include "notevolume.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::ScoreComponent;

NoteVolume::NoteVolume(int aValue)
    :mParameter_(*(new Parameter("NoteVolume", aValue)))
{
}

NoteVolume::~NoteVolume()
{
    delete &mParameter_;
}

Parameter NoteVolume::toParameter(Beat /*aBeat*/,
                                  Tempo /*aTempo*/,
                                  waltz::editor::model::EditAreaInformationPointer /*aEditAreaInformation*/) const
{
    return mParameter_;
}
