#include "\x\cba\addons\main\script_macros_common.hpp"

#include "exception_macros.hpp"

#ifndef OT_PFUNC
    #define OT_PFUNC(var) _##FUNC(var)
#endif

#ifndef OT_FUNC
    #define OT_FUNC(var) ##FUNC(var)
#endif

#ifndef OT_VALID_LOOT_CONTAINERS
    #define OT_VALID_LOOT_CONTAINERS ["Car","ReammoBox_F","Air","Ship"]
#endif

#ifndef OT_MAX_WAIT_TIME
    #define OT_MAX_WAIT_TIME 120
#endif

#ifndef OT_TARGET_PRECISION_VCLOSE
    #define OT_TARGET_PRECISION_VCLOSE 10
#endif

#ifndef OT_TARGET_PRECISION_CLOSE
    #define OT_TARGET_PRECISION_CLOSE 20
#endif

#ifndef OT_TARGET_PRECISION_SHORT
    #define OT_TARGET_PRECISION_SHORT 100
#endif

#ifndef OT_TARGET_PRECISION_VNEAR
    #define OT_TARGET_PRECISION_VNEAR 200
#endif

#ifndef OT_TARGET_PRECISION_NEAR
    #define OT_TARGET_PRECISION_NEAR 250
#endif
