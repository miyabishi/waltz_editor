#ifndef EDITORSETTINGS_H
#define EDITORSETTINGS_H

namespace waltz
{
    namespace editor
    {
        namespace Settings
        {
            class EditorSettings
            {
            public:
                static EditorSettings& getInstance();
                void save() const;
                void load();
                QString clientPort() const;
                QString enginePath() const;

            private:
                static EditorSettings* mInstance_;

                QString mClientPort_;
                QString mEnginePath_;

            private:
                EditorSettings();
            };

        } // namespace Settings
    } // namespace editor
} // namespace waltz

#endif // EDITORSETTINGS_H
