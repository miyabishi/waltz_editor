#ifndef PAUSESEEKBARCOMMAND_H
#define PAUSESEEKBARCOMMAND_H


namespace waltz
{
    namespace editor
    {
        namespace Commands
        {
            class PauseSeekBarCommand : public waltz::common::Commands::Command
            {
            public:
                PauseSeekBarCommand();
                void exec(const waltz::common::Commands::Parameters& aParameters);
            };
        } // namespace Commands
    } // namespace editor
} // namespace waltz

#endif // PAUSESEEKBARCOMMAND_H
