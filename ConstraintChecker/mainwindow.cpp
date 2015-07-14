#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QImage>
#include <QPixmap>
#include <QPainter>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <iostream>
#include <QFileDialog>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    timepoints.resize(75601);
    for(int i=0; i< 75601; ++i){
        timepoints[i].resize(17, 0);
    }
    ui->setupUi(this);

}

MainWindow::~MainWindow()
{
    delete ui;
}


/**************************************************************************************************
 *                              normal cross
 * ***********************************************************************************************/
QImage MainWindow::getNormalImage(boost::dynamic_bitset<> trafficLights){
    QImage img(640, 480, QImage::Format_RGB32);

    QPainter qPainter(&img);
    qPainter.setBrush(Qt::black);
    qPainter.drawRect(0,0, 640,480);
   // Kaufland
    qPainter.setBrush(Qt::white);
    qPainter.drawRect(0,0, 150, 150);
    qPainter.setPen(Qt::red);
    qPainter.drawText(50, 70, "Kaufland");
// Borsi 34
    qPainter.setPen(Qt::white);
    qPainter.drawRect(0, 330, 150, 150);
    qPainter.setPen(Qt::red);
    qPainter.drawText(50, 400, "Borsi 34");

// schrottplatz
    qPainter.setPen(Qt::white);
    qPainter.drawRect(490, 0, 150, 150);
    qPainter.setPen(Qt::red);
    qPainter.drawText(540, 70, "Schrottplatz");

// Möbelhaus
    qPainter.setPen(Qt::white);
    qPainter.drawRect(490, 330, 150, 150);
    qPainter.setPen(Qt::red);
    qPainter.drawText(540, 400, "Möbelhaus");

// Grüner streifen
    qPainter.setBrush(Qt::blue);
    qPainter.setPen(Qt::NoPen);
    qPainter.drawRect(300, 0, 50, 150);
    qPainter.drawRect(300, 330, 50, 150);

    qPainter.drawRect(490, 180, 150, 20);
    qPainter.drawRect(490, 250, 150, 20);

    qPainter.setBrush(Qt::green);
// Ampel 1 Schandauer Straße
    if(trafficLights[1] == true){
        qPainter.drawRect(0, 290, 640, 20);
        qPainter.drawRect(180, 290, 20, 190);
    }
// Ampel 1 Schandauer Straße
    if(trafficLights[2] == true){
        qPainter.drawRect(0, 290, 480, 20);
        qPainter.drawRect(460, 0, 20, 290);
    }
// Ampe 3
    if(trafficLights[3] == true){
        qPainter.drawRect(460, 0, 20, 480);
        qPainter.drawRect(460, 290, 180, 20);
    }
// Ampel 4
    if(trafficLights[4] == true){
        qPainter.drawRect(460, 190, 20, 290);
        qPainter.drawRect(0, 190, 460, 20);
    }

// Ampel 5
    if(trafficLights[5] == true){
        qPainter.drawRect(0, 160, 640, 20);
        qPainter.drawRect(400, 0, 20, 160);
    }
// Ampel 6
    if(trafficLights[6] == true){
        qPainter.drawRect(200, 160, 20, 320);
        qPainter.drawRect(200, 160, 440, 20);
    }
// Ampel 7
    if(trafficLights[7] == true){
        qPainter.drawRect(200, 0, 20, 480);
        qPainter.drawRect(0, 200, 200, 20);
    }
// ampel 8
    if(trafficLights[8] == true){
        qPainter.drawRect(200, 0, 20, 300);
        qPainter.drawRect(200, 300, 480, 20);
    }

// Ampel 9
    if(trafficLights[9] == true){
        qPainter.drawRect(100, 150, 20, 180);
    }
// Ampel 10
    if(trafficLights[10] == true){
        qPainter.drawRect(350, 350, 140, 20);
    }
// Ampel 11
    if(trafficLights[11] == true){
        qPainter.drawRect(150, 350, 140, 20);
    }
// ampel 12
    if(trafficLights[12] == true){
        qPainter.drawRect(510, 150, 20, 30);
    }
// Ampel 13
    if(trafficLights[13] == true){
        qPainter.drawRect(510, 200, 20, 50);
    }

    // Ampel 14
    if(trafficLights[14] == true){
        qPainter.drawRect(510, 270, 20, 60);
    }
// Ampel 15
    if(trafficLights[15] == true){
        qPainter.drawRect(350, 100, 140, 20);
    }
// Ampel 16
    if(trafficLights[16] == true){
        qPainter.drawRect(150, 100, 150, 20);
    }
    qPainter.end();

    return img;
}
/**************************************************************************************************
 *                      private slots
 * ***********************************************************************************************/
void MainWindow::nextTick(){

    timer.start(TICKTIME);
    currentTime++;
    if(currentTime == maxTime)
        disconnect(&timer, SIGNAL(timeout()), this, SLOT(nextTick()));



    ui->labelOutput->setPixmap(QPixmap::fromImage(getNormalImage(timepoints[currentTime])));
    std::cout << timepoints[currentTime] << std::endl;
    refreshTimer();
}

void  MainWindow::refreshTimer(){
    int duration = currentTime;
    int minseconds = (int) (duration % 60);
    duration /= 60;
    int minminutes = (int) (duration % 60);
    duration /= 60;
    int minhours = (int) (duration % 24);
    ui->timeEdit->setTime(QTime(minhours, minminutes, minseconds));
}

/**************************************************************************************************
 *                              public slots
 * ***********************************************************************************************/
void MainWindow::run(){

    connect(&timer, SIGNAL(timeout()), this, SLOT(nextTick()));
    timer.start(TICKTIME);
}

void MainWindow::Stop(){
    disconnect(&timer, SIGNAL(timeout()), this, SLOT(nextTick()));
}

void MainWindow::readFile(){
    QString fileName = QFileDialog::getOpenFileName(this, tr("Open File"),
                                                    QDir::currentPath());
    std::ifstream data;
    data.open(fileName.toStdString().c_str());

    minTime = 9999999;
    maxTime = 0;

    std::vector<std::string> elems;


    std::string item;
    while (std::getline(data, item, ' ')) {
        if(item.find("green") != std::string::npos){
            item = item.substr(item.find("(") +1);
            std::string traffic, time;
            traffic = item.substr(0, item.find(","));
            item = item.substr(item.find(",")+1);
            time = item.substr(0, item.find(")"));
            if(minTime > std::atoi(time.c_str())){
                minTime = std::atoi(time.c_str()) ;
            }
            if(maxTime < std::atoi(time.c_str())){
                maxTime = std::atoi(time.c_str()) ;
            }

            timepoints[std::atoi(time.c_str())][std::atoi(traffic.c_str())] = true;
        }
    }
    int duration = minTime;
    int minseconds = (int) (duration % 60);
    duration /= 60;
    int minminutes = (int) (duration % 60);
    duration /= 60;
    int minhours = (int) (duration % 24);

     duration = maxTime;
    int maxseconds = (int) (duration % 60);
    duration /= 60;
    int maxminutes = (int) (duration % 60);
    duration /= 60;
    int maxhours = (int) (duration % 24);
    currentTime = minTime;

 //   ui->timeEdit->setTimeRange(QTime(minhours, minminutes, minseconds), QTime(maxhours, maxminutes, maxseconds));
    ui->timeEdit->setTime(QTime(minhours, minminutes, minseconds));

}
