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
    #define OT_LOG_VAR(var1) LOG_2(QUOTE(state: var1 [%1]: %2), typeName var1, str var1)
#endif

#ifndef OT_EX_RPT_TYPE
    #define OT_EX_RPT_TYPE(var1,var2) ERROR_1(QUOTE(Argument exception - expected var1 but provided %1), typeName var2)
#endif

#ifndef OT_GUARD_ARRAY
    #define OT_GUARD_ARRAY(var1,var2) if !(IS_ARRAY(var1)) exitWith { \
        OT_EX_RPT_TYPE(ARRAY,var1); (var2); \
    }
#endif

#ifndef OT_GUARD_OBJECT
    #define OT_GUARD_OBJECT(var1,var2) if !(IS_OBJECT(var1)) exitWith { \
        OT_EX_RPT_TYPE(OBJECT,var1); OT_LOG_VAR(var1); { var2 }; \
    }
#endif
