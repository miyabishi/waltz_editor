#include "vibratolist.h"

using namespace waltz::common::Commands;
using namespace waltz::editor::model;
using namespace waltz::editor::ScoreComponent;

namespace
{
    const QString PARAMETER_VIBRATO_LIST("VibratoList");
}

VibratoList::VibratoList()
{
}

void VibratoList::append(const VibratoPointer aVibrato)
{
    mVibratoList_.append(aVibrato);
}

void VibratoList::clearVibrato()
{
    mVibratoList_.clear();
}

Parameter VibratoList::toParameter(const Beat aBeat,
                                   const Tempo aTempo,
                                   const EditAreaInformationPointer aEditAreaInfromation) const
{
    QJsonArray vibratoListArray;
    QList<VibratoPointer> vibratoList = mVibratoList_;

    foreach(const VibratoPointer vibrato, vibratoList)
    {
        vibratoListArray.append(vibrato->toParameters(aBeat, aTempo, aEditAreaInfromation).toJsonArray());
    }
    return Parameter(PARAMETER_VIBRATO_LIST, vibratoListArray);
}
