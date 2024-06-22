#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int number READ number NOTIFY numberChanged)
    Q_PROPERTY(int min READ min WRITE setMin NOTIFY minChanged)
    Q_PROPERTY(int max READ max WRITE setMax NOTIFY maxChanged)
    Q_PROPERTY(int interval READ interval WRITE setInterval NOTIFY intervalChanged)

public:
    explicit Backend(QObject *parent = nullptr);

    int number() const;
    int min() const;
    int max() const;
    int interval() const;

    Q_INVOKABLE void setMin(int min);
    Q_INVOKABLE void setMax(int max);
    Q_INVOKABLE void setInterval(int interval);

private:
    void generateNumber();

    int m_min;
    int m_max;
    int m_interval;
    int m_number;
    QTimer m_timer;

public slots:
    void timerStart(int interval);

signals:
    void minChanged(int min);
    void maxChanged(int max);
    void intervalChanged(int interval);
    void numberChanged(int number);

};

#endif // BACKEND_H
