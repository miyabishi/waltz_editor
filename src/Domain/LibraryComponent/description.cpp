#include "description.h"

using namespace waltz::editor::LibraryComponent;

Description::Description()
    :mValue_("")
{
}

Description::Description(const QString& aValue)
    :mValue_(aValue)
{
}

Description::Description(const Description &aOther)
    :mValue_(aOther.mValue_)
{
}

Description& Description::operator=(const Description &aOther)
{
    mValue_ = aOther.mValue_;
    return (*this);
}

QString Description::value() const
{
    return mValue_;
}
