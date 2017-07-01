#include "beat.h"

using namespace waltz::editor::ScoreComponent;

Beat::Beat(int aParent, int aChild)
    : mParent_(aParent)
    , mChild_(aChild)
{

}

Beat::Beat(const Beat& aOther)
    : mParent_(aOther.mParent_)
    , mChild_(aOther.mChild_)
{
}

Beat& Beat::operator=(const Beat& aOther)
{
    mParent_ = aOther.mParent_;
    mChild_ = aOther.mChild_;
    return (*this);
}

int Beat::childValue() const
{
    return mChild_;
}

int Beat::parentValue() const
{
    return mParent_;
}

Beat Beat::changeChild(int aChild)
{
    return Beat(mParent_, aChild);
}

Beat Beat::changeParent(int aParent)
{
    return Beat(aParent, mChild_);
}

