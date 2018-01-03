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
                VibratoForm(const int aLength,
                            const int aWavelength,
                            const double aAmplitude);

                int length() const;
                int wavelength() const;
                double amplitude() const;


            private:
                int mLength_;
                int mWavelength_;
                double mAmplitude_;

            private:
                VibratoForm(const VibratoForm& aOther);
                VibratoForm& operator=(const VibratoForm& aOther);
            };
            typedef QSharedPointer<VibratoForm> VibratoFormPointer;

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOFORM_H
