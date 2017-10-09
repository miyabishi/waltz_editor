#ifndef POINT_H
#define POINT_H

#include <QPoint>

namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {
            class Point
            {
            public:
                Point(int aX, int aY);
                virtual ~Point();

            public:
                int x() const;
                int y() const;
                QPoint toQPoint() const;

            private:
                int mX_;
                int mY_;
            };

        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // POINT_H
