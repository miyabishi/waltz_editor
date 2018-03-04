#ifndef HISTORYDATAREPOSITORY_H
#define HISTORYDATAREPOSITORY_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace History
        {
            class HistoryDataRepository
            {
            public:
                HistoryDataRepository();
            private:
                HistoryDataRepository(HistoryDataRepository& aOther);
                HistoryDataRepository& operator=(HistoryDataRepository& aOther);
            };
            typedef QSharedPointer<HistoryDataRepository> HistoryDataRepositoryPointer;

        } // namespace ExternalFile
    } // namespace editor
} // namespace waltz

#endif // HISTORYDATAREPOSITORY_H
