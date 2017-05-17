/*
 * Header: script_component.hpp
 *
 * Description:
 *     Included as standard header in each component and function script.
 *     Provides useful preprocessor definitions. Note that preprocessor
 *     commands are case-sensitive. Shamelessly plagiarized from CBA_A3
 *     as a best practice.
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
 *     #include "script_component.hpp"
 *
 * Ref:
 *     @see https://community.bistudio.com/wiki/PreProcessor_Commands
 *     @see https://github.com/CBATeam/CBA_A3/wiki/Error-handling
 */

// must define prior to script_mod.hpp
#define COMPONENT main

#include "script_mod.hpp"

// Top of script_component.hpp
// Ensure that any FULL and NORMAL setting from the individual files are undefined and MINIMAL is set.
#ifdef DEBUG_MODE_FULL
    #undef DEBUG_MODE_FULL
#endif

#ifdef DEBUG_MODE_NORMAL
    #undef DEBUG_MODE_NORMAL
#endif

#ifndef DEBUG_MODE_MINIMAL
    #define DEBUG_MODE_MINIMAL
#endif

#define DEBUG_SYNCHRONOUS

#include "headers\script_macros.hpp"
