#ifndef VIBRATOFREQUENCY_H
#define VIBRATOFREQUENCY_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoFrequency
            {
            public:
                VibratoFrequency(const double aValue);
                double value() const;

            private:
                double mValue_;
            private:
                VibratoFrequency(const VibratoFrequency& aOther);
                VibratoFrequency& operator=(const VibratoFrequency& aOther);
            };
            typedef QSharedPointer<VibratoFrequency> VibratoFrequencyPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOFREQUENCY_H
