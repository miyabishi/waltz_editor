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
#include "src/Domain/ScoreComponent/note.h"

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
                void emitActivePlayButton();

            public:
                // Invocable Methods
                // For Score
                Q_INVOKABLE void setTempo(int aTempo);
                Q_INVOKABLE void setBeatParent(int aBeatParent);
                Q_INVOKABLE void setBeatChild(int aBeatChild);
                Q_INVOKABLE void appendNote(int aNoteId,
                                            const QString& aNoteText,
                                            int aPositionX,
                                            int aPositionY,
                                            int noteWidth,
                                            int aPortamentStartX,
                                            int aPortamentStartY,
                                            int aPortamentEndX,
                                            int aPortamentEndY,
                                            double aVibratoAmplitude,
                                            double aVibratoFrequency,
                                            int aVibratoLength);

                Q_INVOKABLE void updateNote(int aNoteId,
                                            const QString& aNoteText,
                                            int aPositionX,
                                            int aPositionY,
                                            int noteWidth,
                                            int aPortamentStartX,
                                            int aPortamentStartY,
                                            QList<int> aPitchChangingPointX,
                                            QList<int> aPitchChangingPointY,
                                            int aPortamentEndX,
                                            int aPortamentEndY,
                                            double aVibratoAmplitude,
                                            double aVibratoFrequency,
                                            int aVibratoLength);

                Q_INVOKABLE int noteIdFromIndex(int aIndex);

                Q_INVOKABLE int tempo() const;
                Q_INVOKABLE int beatChild() const;
                Q_INVOKABLE int beatParent() const;

                Q_INVOKABLE int publishNoteId();

                // for EditArea
                Q_INVOKABLE int editAreaWidth() const;
                Q_INVOKABLE int columnWidth() const;
                Q_INVOKABLE int rowHeight() const;
                Q_INVOKABLE int supportOctave() const;
                Q_INVOKABLE int noteCount() const;
                Q_INVOKABLE int findNotePositionX(int aIndex) const;

                // for Voice Library
                Q_INVOKABLE void loadVoiceLibrary(const QUrl& aUrl);
                Q_INVOKABLE QString characterImageUrl() const;
                Q_INVOKABLE QString libraryName() const;
                Q_INVOKABLE QString libraryDescription() const;
                Q_INVOKABLE QString vocalFileExtention() const;

                // for Portament
                Q_INVOKABLE QPoint portamentStartPoint(int aNoteId) const;

                Q_INVOKABLE int pitchChangingPointCount(int aNoteId) const;
                Q_INVOKABLE QPoint pitchChangingPoint(int aNoteId, int aIndex) const;

                Q_INVOKABLE QPoint portamentEndPoint(int aNoteId) const;

                Q_INVOKABLE int yPositionOfPreviousNote(int aXPosition,
                                                        int aYPosition,
                                                        int aNoteId) const;

                // for Vibrato
                //Q_INVOKABLE QPoint vibratoStartPoint(int aNoteId) const;
                //Q_INVOKABLE QPoint vibratoEndPoint(int aNoteId) const;
                //Q_INVOKABLE double vibratoAmplitude(int aNoteId) const;


                // for Controller
                Q_INVOKABLE void play();

                // for toolBar
                Q_INVOKABLE void saveWav(const QUrl& aUrl);

            signals:
                void errorOccurred(const QString& aErrorMessage);
                void activePlayButton();
                void libraryInformationUpdated();

            private:
                ScoreComponent::NotePointer findNote(int aNoteId)const;

            private:
                static MainWindowModel*              mInstance_;
                ScoreComponent::ScorePointer         mScore_;
                EditAreaInformationPointer           mEditAreaInformation_;
                Communicator::Client*                mClient_;
                LibraryComponent::LibraryInformation mLibraryInformation_;
                int                                  mNoteIdCounter_;

            private:
                explicit MainWindowModel(QObject *parent = 0);
                ~MainWindowModel();
            };
        } // namespace model
    } // namespace editor
} // namespace waltz

#endif // MAINWINDOWMODEL_H
