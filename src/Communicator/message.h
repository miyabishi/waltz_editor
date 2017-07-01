#ifndef MESSAGE_H
#define MESSAGE_H

#include <QString>
#include <QByteArray>
#include "src/Domain/Commands/parameters.h"
#include "src/Domain/Commands/commandid.h"

namespace waltz
{
    namespace editor
    {
        namespace Communicator
        {

            class Message
            {
            public:
                Message(const waltz::editor::Commands::CommandId& aCommandId,
                        const waltz::editor::Commands::Parameters& aParameters);
                Message(const Message& aOther);
                Message& operator=(const Message& aOther);

            public:
                QByteArray toByteArray() const;

            private:
                waltz::editor::Commands::CommandId  mCommandId_;
                waltz::editor::Commands::Parameters mParameters_;
            };
        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // MESSAGE_H
