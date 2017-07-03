#ifndef MAINWINDOWMODEL_H
#define MAINWINDOWMODEL_H

#include <QObject>
#include <QUrl>
#include <QImage>
#include <QString>
#include "src/Domain/ScoreComponent/score.h"
#include "src/Communicator/client.h"
#include "src/Model/editareainformation.h"
#include "src/Domain/LibraryComponent/libraryinformation.h"

namespace waltz
{
    namespace editor
    {
        namespace model
        {
            class MainWindowModel : public QObject
            {
                Q_OBJECT
            public:
                static MainWindowModel& getInstance();

            public:
                void setLibraryInformation(
                        const waltz::editor::LibraryComponent::LibraryInformation& aLibraryInformation);
                void emitErrorOccurred(const QString& aErrorMessage);

            public:
                // Invocable Methods
                // For Score
                Q_INVOKABLE void setTempo(int aTempo);
                Q_INVOKABLE void setBeatParent(int aBeatParent);
                Q_INVOKABLE void setBeatChild(int aBeatChild);
                Q_INVOKABLE void appendNote(const QString& noteText,
                                            int positionX,
                                            int positionY,
                                            int noteWidth);

                Q_INVOKABLE int  tempo() const;
                Q_INVOKABLE int  beatChild() const;
                Q_INVOKABLE int  beatParent() const;

                // for EditArea
                Q_INVOKABLE int editAreaWidth() const;
                Q_INVOKABLE int columnWidth() const;
                Q_INVOKABLE int rowHeight() const;
                Q_INVOKABLE int supportOctave() const;

                // for Voice Library
                Q_INVOKABLE void loadVoiceLibrary(const QUrl& aUrl);
                Q_INVOKABLE QString characterImageUrl() const;
                Q_INVOKABLE QString libraryName() const;
                Q_INVOKABLE QString libraryDescription() const;
                Q_INVOKABLE QString vocalFileExtention() const;

                // for Controller
                Q_INVOKABLE void play();

            signals:
                void errorOccurred(const QString& aErrorMessage);
                void libraryInformationUpdated();

            private:
                static MainWindowModel*                             mInstance_;
                waltz::editor::ScoreComponent::ScorePointer         mScore_;
                EditAreaInformation                                 mEditAreaInformation_;
                waltz::editor::Communicator::Client*                mClient_;
                waltz::editor::LibraryComponent::LibraryInformation mLibraryInformation_;

            private:
                explicit MainWindowModel(QObject *parent = 0);
                ~MainWindowModel();
            };
        } // namespace model
    } // namespace editor
} // namespace waltz

#endif // MAINWINDOWMODEL_H
