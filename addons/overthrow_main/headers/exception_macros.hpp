/*
 * Header: exception_macros.hpp
 *
 * Description:
 *     Included as standard header in the main script component header.
 *
 * Author:
 *     Mal
 *
 * Arguments:
 *     n/a
 *
 * Returns:
 *     n/a
 *
 * Examples:
 *     Use as a standard header
 *     #include "exception_macros.hpp"
 *
 * Ref:
 *     @see https://community.bistudio.com/wiki/PreProcessor_Commands
 *     @see https://github.com/CBATeam/CBA_A3/wiki/Error-handling
 */

// @todo requires a more standard framework

#ifndef OT_LOG_VAR
    #define OT_LOG_VAR(var1) LOG_2(QUOTE(Dump - var1 [%1]: %2), typeName var1, str var1)
#endif

#ifndef OT_EX_RPT_TYPE
    #define OT_EX_RPT_TYPE(var1,var2) ERROR_1(QUOTE(Runtime Exception - expected var1 but provided %1), typeName var2)
#endif

#ifndef OT_GUARD_ARRAY
    #define OT_GUARD_ARRAY(var1,var2) if !(IS_ARRAY(var1)) exitWith { \
        OT_EX_RPT_TYPE(ARRAY,var1); (var2); \
    };
#endif

#ifndef OT_GUARD_OBJECT
    #define OT_GUARD_OBJECT(var1,var2) if !(IS_OBJECT(var1)) exitWith { \
        OT_EX_RPT_TYPE(OBJECT,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif

#ifndef OT_GUARD_BOOL
    #define OT_GUARD_BOOL(var1,var2) if !(IS_BOOL(var1)) exitWith { \
        OT_EX_RPT_TYPE(BOOL,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif

#ifndef OT_GUARD_SCALAR
    #define OT_GUARD_SCALAR(var1,var2) if !(IS_SCALAR(var1)) exitWith { \
        OT_EX_RPT_TYPE(SCALAR,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif

// @todo better error message needed for floats
#ifndef OT_GUARD_INTEGER
    #define OT_GUARD_INTEGER(var1,var2) if !(IS_INTEGER(var1)) exitWith { \
        OT_EX_RPT_TYPE(SCALAR,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif

#ifndef OT_GUARD_CODE
    #define OT_GUARD_CODE(var1,var2) if !(IS_CODE(var1)) exitWith { \
        OT_EX_RPT_TYPE(CODE,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif

#ifndef OT_GUARD_STRING
    #define OT_GUARD_STRING(var1,var2) if !(IS_STRING(var1)) exitWith { \
        OT_EX_RPT_TYPE(STRING,var1); OT_LOG_VAR(var1); (var2); \
    };
#endif
