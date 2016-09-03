/*============================================================================
  CMake - Cross Platform Makefile Generator
  Copyright 2000-2010 Kitware, Inc., Insight Software Consortium

  Distributed under the OSI-approved BSD License (the "License");
  see accompanying file Copyright.txt for details.

  This software is distributed WITHOUT ANY WARRANTY; without even the
  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the License for more information.
============================================================================*/
#ifndef cmTargetDepend_h
#define cmTargetDepend_h

#include <cmConfigure.h>

#include "cmStandardIncludes.h"

class cmGeneratorTarget;

/** One edge in the global target dependency graph.
    It may be marked as a 'link' or 'util' edge or both.  */
class cmTargetDepend
{
  cmGeneratorTarget const* Target;

  // The set order depends only on the Target, so we use
  // mutable members to acheive a map with set syntax.
  mutable bool Link;
  mutable bool Util;

public:
  cmTargetDepend(cmGeneratorTarget const* t)
    : Target(t)
    , Link(false)
    , Util(false)
  {
  }
  operator cmGeneratorTarget const*() const { return this->Target; }
  cmGeneratorTarget const* operator->() const { return this->Target; }
  cmGeneratorTarget const& operator*() const { return *this->Target; }
  friend bool operator<(cmTargetDepend const& l, cmTargetDepend const& r)
  {
    return l.Target < r.Target;
  }
  void SetType(bool strong) const
  {
    if (strong) {
      this->Util = true;
    } else {
      this->Link = true;
    }
  }
  bool IsLink() const { return this->Link; }
  bool IsUtil() const { return this->Util; }
};

/** Unordered set of (direct) dependencies of a target. */
class cmTargetDependSet : public std::set<cmTargetDepend>
{
};

#endif
