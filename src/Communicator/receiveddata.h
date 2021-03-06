#ifndef RECEIVEDDATA_H
#define RECEIVEDDATA_H

#include <QByteArray>
#include <waltz_common/parameters.h>
#include <waltz_common/commandid.h>

namespace waltz
{
    namespace editor
    {
        namespace Communicator
        {

            class ReceivedData
            {
            public:
                explicit ReceivedData(
                        const QByteArray& aReceivedData);
                ReceivedData(const ReceivedData& aOther);
                ReceivedData& operator=(const ReceivedData& aOther);
                ~ReceivedData();
                void executeCommand();

            private:
                void parseReceivedData(const QByteArray& aReceivedData);
                waltz::common::Commands::Parameters parseParameters(const QJsonArray& aParameterArray) const;

            private:
                waltz::common::Commands::CommandId  mCommandId_;
                waltz::common::Commands::Parameters mParameters_;
            };
        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // RECEIVEDDATA_H
