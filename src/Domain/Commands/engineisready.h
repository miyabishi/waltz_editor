#ifndef ENGINEISREADY_H
#define ENGINEISREADY_H

#include <waltz_common/command.h>
#include <waltz_common/parameters.h>

namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class EngineIsReady : public waltz::common::Commands::Command
            {
            public:
                EngineIsReady();
                void exec(const waltz::common::Commands::Parameters& aParameters);
            };

        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // ENGINEISREADY_H
