#ifndef VIBRATOFORM_H
#define VIBRATOFORM_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoForm
            {
            public:
                VibratoForm(int aLength,
                            int aWavelength,
                            int aAmplitude);
            private:
                int mLength_;
                int mWavelength_;
                int mAmplitude_;

            private:
                VibratoForm(const VibratoForm& aOther);
                VibratoForm& operator=(const VibratoForm& aOther);
            };
            typedef QSharedPointer<VibratoForm> VibratoFormPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOFORM_H
