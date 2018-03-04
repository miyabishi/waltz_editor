#include "historydata.h"

using namespace waltz::editor::History;

HistoryData::HistoryData(const QVariantMap& aData)
    : mData_(aData)
{
}

QVariantMap HistoryData::value() const
{
    return mData_;
}

