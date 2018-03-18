#include "libraryname.h"

using namespace waltz::editor::LibraryComponent;


LibraryName::LibraryName(const QString& aValue)
    : mValue_(aValue)
{

}

QString LibraryName::value() const
{
    return mValue_;
}

