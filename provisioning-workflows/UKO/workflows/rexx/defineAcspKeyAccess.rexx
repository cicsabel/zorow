/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

CLIENT_GROUP="${instance-CLIENT_ACCESS_GROUP}"
SAF_OWNER="${instance-SAF_OWNER}"

/* Optional section for defining key access profiles for the different */
/* test scripts: allverbs, loadtest, sunshinetest, threadtest */
Say "Defining ** key profile for allverbs test"
"RDEF CSFKEYS ** UACC(NONE) OWNER("SAF_OWNER") "

/* When you run the allverbs test, it will check for CONTROL on ** */
Say "granting access to ** key profile for allverbs test"
"PERMIT ** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"

Say "Defining key profiles for sunshine test"
"RDEF CSFKEYS DKMSEMT.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS ACSP.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS BELH.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS CRSA.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS CDF.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS EMVTXAPI.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CSFKEYS JCCA.** UACC(NONE) OWNER("SAF_OWNER") "

Say "Granting access to key profiles for sunshine test"
"PERMIT DKMSEMT.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT ACSP.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT BELH.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT CRSA.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT CDF.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT EMVTXAPI.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT JCCA.** CLASS(CSFKEYS) ACCESS(CONTROL) ID("CLIENT_GROUP")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"

Say "Defining key profiles in the CRYPTOZ class"
"RDEF CRYPTOZ SO.** UACC(NONE) OWNER("SAF_OWNER") "
"RDEF CRYPTOZ USER.** UACC(NONE) OWNER("SAF_OWNER") "

Say "Granting access to sunshine test key rpofiles in CRYPTOZ class"
"PERMIT SO.** CLASS(CRYPTOZ) ACCESS(CONTROL) ID("CLIENT_GROUP")"
"PERMIT USER.** CLASS(CRYPTOZ) ACCESS(UPDATE) ID("CLIENT_GROUP")"

Say "Refreshing CRYPTOZ"
"SETROPTS RACLIST(CRYPTOZ) REFRESH"
