#ifndef SYLLABLE_H
#define SYLLABLE_H


#include <QString>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class Syllable
            {
            public:
                explicit Syllable(const QString& aValue);
                Syllable(const Syllable& aOther);
                Syllable& operator=(const Syllable& aOther);
                QString value() const;
            private:
                QString mValue_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // SYLLABLE_H
