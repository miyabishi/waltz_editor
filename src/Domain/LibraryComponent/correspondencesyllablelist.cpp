#include "correspondencesyllablelist.h"
#include <waltz_common/parameterslist.h>

using namespace waltz::editor::LibraryComponent;
using namespace waltz::common::Commands;


CorrespondenceSyllableList::CorrespondenceSyllableList(const waltz::common::Commands::Parameter& aParameter)
    :mCorrespondenceSyllableList_()
{
    ParametersList syllables(aParameter.value().toArray());
    for(int index = 0; index < syllables.size(); ++index )
    {
        mCorrespondenceSyllableList_.append(
                    CorrespondenceSyllablePointer(
                        new CorrespondenceSyllable(syllables.at(index))));
    }
}

