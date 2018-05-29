#ifndef ENGINE_H
#define ENGINE_H

#include <QProcess>

namespace waltz
{
    namespace editor
    {
        namespace VocalEngine
        {
            class Engine
            {
            public:
                Engine();
                ~Engine();
            public:
                bool start() const;

            private:
                QProcess& mProcess_;
            };
        }
    } // namespace editor
} // namespace waltz

#endif // ENGINE_H
