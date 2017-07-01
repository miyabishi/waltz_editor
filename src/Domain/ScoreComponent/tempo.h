#ifndef TEMPO_H
#define TEMPO_H


namespace waltz
{
    namespace editor
    {
        namespace ScoreComponent
        {

            class Tempo
            {
            public:
                explicit Tempo(int aValue);
                int value() const;

                Tempo(const Tempo& aOther);
                Tempo& operator=(const Tempo& aOther);

            private:
                int mValue_;
            };
        } // namespace ScoreComponent
    } // namespace editor
} // namespace waltz

#endif // TEMPO_H
