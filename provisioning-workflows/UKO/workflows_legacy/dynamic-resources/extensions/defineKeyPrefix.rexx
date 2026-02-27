/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required user IDs and groups                           */
/***********************************************************************/

KEY_PREFIX="${instance-KEY_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

Say "Defining key prefix profile" KEY_PREFIX".** "
"RDEF CSFKEYS" KEY_PREFIX".** OWNER("SAF_OWNER") UACC(NONE) ",
    " ICSF(SYMCPACFWRAP(YES),SYMCPACFRET(YES))"
"PERMIT" KEY_PREFIX".**  CLASS(CSFKEYS) ACCESS(CONTROL) ID(ACSPSGRP)"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"
