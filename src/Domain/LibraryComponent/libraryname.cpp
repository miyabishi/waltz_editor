#include "libraryname.h"

using namespace waltz::editor::LibraryComponent;


LibraryName::LibraryName(const QString& aValue)
    : mValue_(aValue)
{

}
LibraryName::LibraryName()
    : mValue_("")
{

}

LibraryName::LibraryName(const LibraryName& aOther)
    :mValue_(aOther.mValue_)
{
}

LibraryName& LibraryName::operator=(const LibraryName& aOther)
{
    mValue_ = aOther.mValue_;
    return (* this);
}

QString LibraryName::value() const
{
    return mValue_;
}

