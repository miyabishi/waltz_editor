#ifndef BEAT_H
#define BEAT_H

#include <QSharedPointer>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Beat
            {
            public:
                Beat(int mParent_, int mChild_);
                Beat(const Beat& aOther);
                Beat& operator=(const Beat& aOther);

                int childValue() const;
                int parentValue() const;

                Beat changeParent(int aParent);
                Beat changeChild(int aChild);

            private:
                int mParent_;
                int mChild_;

            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // BEAT_H
