#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <boost/dynamic_bitset.hpp>
#define TICKTIME 250
typedef struct{
    int time, trafficLigt;
} trafficLightGreen;

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public slots:
    void run();
    void readFile();
    void Stop();
    void refreshTimer();
private slots:
    void nextTick();
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    QTimer timer;
    QImage getNormalImage(boost::dynamic_bitset<> trafficLights);
    int minTime, maxTime, currentTime;
    std::vector< boost::dynamic_bitset<> > timepoints;
};

#endif // MAINWINDOW_H
