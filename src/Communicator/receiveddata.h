#ifndef RECEIVEDDATA_H
#define RECEIVEDDATA_H

#include <QByteArray>
#include "src/Domain/Commands/parameters.h"
#include "src/Domain/Commands/commandid.h"

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
                waltz::editor::Commands::Parameters parseParameters(const QJsonArray& aParameterArray) const;

            private:
                waltz::editor::Commands::CommandId  mCommandId_;
                waltz::editor::Commands::Parameters mParameters_;
            };
        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // RECEIVEDDATA_H
