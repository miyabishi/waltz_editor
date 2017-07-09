#include <QJsonObject>
#include "parameter.h"

using namespace waltz::editor::Commands;

Parameter::Parameter()
{
}


Parameter::Parameter(const QString& aName,
                     const QJsonValue& aValue)
    : mName_(aName)
    , mValue_(aValue)
{
}

Parameter::Parameter(const Parameter& aOther)
    : mName_(aOther.mName_)
    , mValue_(aOther.mValue_)
{
}

Parameter& Parameter::operator=(const Parameter& aOther)
{
    mValue_ = aOther.mValue_;
    mName_ = aOther.mName_;
    return (*this);
}

QString Parameter::name() const
{
    return mName_;
}

QJsonValue Parameter::value() const
{
    return mValue_;
}

QString Parameter::toString() const
{
    return mValue_.toString();
}

QJsonValue Parameter::toJsonValue() const
{
    QJsonObject jsonObject;
    jsonObject[PARAMETER_KEY_NAME]  = QJsonValue(mName_);
    jsonObject[PARAMETER_KEY_VALUE] = mValue_;
    return QJsonValue(jsonObject);
}
