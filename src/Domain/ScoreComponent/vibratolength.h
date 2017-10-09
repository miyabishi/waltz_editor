#ifndef VIBRATOLENGTH_H
#define VIBRATOLENGTH_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class VibratoLength
            {
            public:
                VibratoLength(int aValue);

                int value() const;

            private:
                int mValue_;

            private:
                VibratoLength(VibratoLength& aOther);
                VibratoLength& operator=(VibratoLength& aOther);
            };
            typedef QSharedPointer<VibratoLength> VibratoLengthPointer;
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // VIBRATOLENGTH_H
