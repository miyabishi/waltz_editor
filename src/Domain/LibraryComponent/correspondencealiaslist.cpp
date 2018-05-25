#include "correspondencealiaslist.h"
#include <waltz_common/parameterslist.h>

using namespace waltz::editor::LibraryComponent;
using namespace waltz::common::Commands;


CorrespondenceAliasList::CorrespondenceAliasList(const waltz::common::Commands::Parameter& aParameter)
    :mCorrespondenceAliasList_()
{
    ParametersList aliases(aParameter.value().toArray());
    for(int index = 0; index < aliases.size(); ++index )
    {
        mCorrespondenceAliasList_.append(
                    CorrespondenceAliasPointer(
                        new CorrespondenceAlias(aliases.at(index))));
    }
}

