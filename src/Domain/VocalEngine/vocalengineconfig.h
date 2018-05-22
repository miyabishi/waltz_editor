#ifndef VOCALENGINECONFIG_H
#define VOCALENGINECONFIG_H

#include <QString>

namespace waltz
{
    namespace editor
    {
        namespace VocalEngine
        {
            class VocalEngineConfig
            {
            public:
                VocalEngineConfig();

            public:
                QString vocalEnginePath() const;

            };

        } // namespace VocalEngine
    } // namespace editor
} // namespace waltz

#endif // VOCALENGINECONFIG_H
