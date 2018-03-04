#ifndef HISTORYDATA_H
#define HISTORYDATA_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ExternalFile
        {

            class HistoryData
            {
            public:
                HistoryData();
            private:
                HistoryData(HistoryData& aOther);
                HistoryData& operator=(HistoryData& aOther);
            };
            typedef QSharedPointer<HistoryData> HistoryDataPointer;

        } // namespace ExternalFile
    } // namespace editor
} // namespace waltz

#endif // HISTORYDATA_H
