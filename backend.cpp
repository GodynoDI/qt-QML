#include "backend.h"

Backend::Backend(QObject *parent): QObject(parent){
    connect(&m_timer, &QTimer::timeout, this, &Backend::generateNumber);
}

int Backend::number() const{
    return m_number;
}

int Backend::min() const{
    return m_min;
}

void Backend::setMin(int min){
    if (m_min != min) {
        m_min = min;
        emit minChanged(m_min);
    }
}

int Backend::max() const{
    return m_max;
}

void Backend::setMax(int max){
    if (m_max != max) {
        m_max = max;
        emit maxChanged(m_max);
    }
}

int Backend::interval() const{
    return m_interval;
}

void Backend::setInterval(int interval){
    if (m_interval != interval) {
        m_interval = interval;
        emit intervalChanged(m_interval);
    }
}

void Backend::timerStart(int interval){
    setInterval(interval);
    m_timer.start(m_interval);
}

void Backend::generateNumber(){
    m_number = QRandomGenerator::global()->bounded(m_min, m_max + 1);
    emit numberChanged(m_number);
}
