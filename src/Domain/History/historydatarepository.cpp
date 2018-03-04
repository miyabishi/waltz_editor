#include "historydatarepository.h"

using namespace waltz::editor::History;

HistoryDataRepository* HistoryDataRepository::mInstance_ = 0;

HistoryDataRepository& HistoryDataRepository::getInstance()
{
    if (mInstance_ == 0)
    {
        static HistoryDataRepository instance;
        mInstance_ = &instance;
    }
    return *mInstance_;
}

void HistoryDataRepository::appendHistoryData(const HistoryDataPointer aData)
{
    mHistoryDataList_ = mHistoryDataList_.mid(0, mHeadPosition_ + 1);
    mHistoryDataList_.append(aData);
    mHeadPosition_ = mHistoryDataList_.size() - 1;
}

HistoryDataPointer HistoryDataRepository::moveHeadToNextData()
{
    ++mHeadPosition_;
    return mHistoryDataList_[mHeadPosition_];
}

HistoryDataPointer HistoryDataRepository::moveHeadToPreviousData()
{
    --mHeadPosition_;
    return mHistoryDataList_[mHeadPosition_];
}

bool HistoryDataRepository::hasNextData() const
{
    return mHeadPosition_ < mHistoryDataList_.size() - 1;
}

bool HistoryDataRepository::hasPreviousData() const
{
    return mHeadPosition_ != 0;
}

HistoryDataRepository::HistoryDataRepository()
    :mHeadPosition_(0)
{
}
