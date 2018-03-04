#ifndef HISTORYDATAREPOSITORY_H
#define HISTORYDATAREPOSITORY_H

#include "historydata.h"
#include <QList>

namespace waltz
{
    namespace editor
    {
        namespace History
        {
            class HistoryDataRepository
            {
            public:
                static HistoryDataRepository& getInstance();

                void appendHistoryData(const HistoryDataPointer aData);
                HistoryDataPointer moveHeadToNextData();
                HistoryDataPointer moveHeadToPreviousData();
                bool hasNextData() const;
                bool hasPreviousData() const;

            private:
                static HistoryDataRepository* mInstance_;
                int                           mHeadPosition_;
                QList<HistoryDataPointer>     mHistoryDataList_;

            private:
                HistoryDataRepository();
                HistoryDataRepository(HistoryDataRepository& aOther);
                HistoryDataRepository& operator=(HistoryDataRepository& aOther);
            };
        } // namespace ExternalFile
    } // namespace editor
} // namespace waltz

#endif // HISTORYDATAREPOSITORY_H
