#include <QDebug>
#include <QJsonValue>
#include "parameters.h"

using namespace waltz::editor::Commands;

Parameters::Parameters()
{
}

Parameters::Parameters(const Parameters& aOther)
    : mParameters_(aOther.mParameters_)
{
}

Parameters& Parameters::operator=(const Parameters& aOther)
{
    mParameters_ = aOther.mParameters_;
    return (*this);
}

void Parameters::append(const Parameter &aParameter)
{
    mParameters_[aParameter.name()] = aParameter;
}

QJsonArray Parameters::toJsonArray() const
{
    QJsonArray jsonArray;

    foreach(const Parameter& parameter, mParameters_.values())
    {
        jsonArray.append(parameter.toJsonValue());
    }
    return jsonArray;
}

Parameter Parameters::find(const QString& aParameterName) const
{
    return mParameters_.value(aParameterName, Parameter("",QVariant()));
}
