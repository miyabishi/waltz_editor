#ifndef COMMANDID_H
#define COMMANDID_H
#include <QString>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class CommandId
            {
            public:
                CommandId(const QString& aValue);
                CommandId(const CommandId& aOther);
                CommandId& operator=(const CommandId& aOther);
                bool operator==(const CommandId& aOther) const;
                bool operator!=(const CommandId& aOther) const;

            public:
                QString value() const;

            private:
                QString mValue_;
            };

        } // namespace Communicator
    } // namespace editor
} // namespace waltz

#endif // COMMANDID_H
