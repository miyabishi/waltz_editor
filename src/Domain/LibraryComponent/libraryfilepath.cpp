#include <QVariant>
#include "libraryfilepath.h"

using namespace waltz::editor::LibraryComponent;

LibraryFilePath::LibraryFilePath(const QString& aValue)
    :mValue_(aValue)
{
}

QVariant LibraryFilePath::toVariant() const
{
    return QVariant(mValue_);
}

QSharedPointer<LibraryFilePath> LibraryFilePath::fromVariantMap(const QVariantMap& aVariantMap)
{
    return LibraryFilePathPointer(
                new LibraryFilePath(
                    aVariantMap.find(variantMapKey()).value().toString()));
}

QString LibraryFilePath::variantMapKey()
{
    return QString("LibraryFilePath");
}

QString LibraryFilePath::toString() const
{
    return mValue_;
}
