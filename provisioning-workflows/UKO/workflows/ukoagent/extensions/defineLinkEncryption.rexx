/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

AGENT_STC_GROUP="${instance-UKO_AGENT_STC_GROUP}"
PUBLIC_KEY_HASH="${instance-UKO_SERVER_PUBLIC_KEY_HASH}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Diffie-Hellman Link Encryption */
/***********************************************************************/

/* The UKO agent will accept connections by having access to the connecting */
/* client's Backend public key hash in the XFACILIT class resources */
/* Start by defining the generic profiles with UACC(NONE) */

Say "Defining generic profiles for link encryption"
"RDEFINE XFACILIT KMG.WS.* OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE XFACILIT KMG.LG.* OWNER("SAF_OWNER") UACC(NONE)"

#if(${instance-UKO_SERVER_PUBLIC_KEY_HASH} == "*" ) 
/* The following example will allow all clients to connect to this agent. */

Say "Granting access to KMG.WS.* class(XFACILIT) to" AGENT_STC_GROUP
"PERMIT KMG.WS.* CLASS(XFACILIT) ACC(READ) ID("AGENT_STC_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end
Say "Granting access to KMG.LG.* class(XFACILIT) to" AGENT_STC_GROUP
"PERMIT KMG.LG.* CLASS(XFACILIT) ACC(READ) ID("AGENT_STC_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

#end 

/* If you want to limit access to specific clients, you will need the */
/* connecting client's <publicKeyHash>. In the UKO server, you find it */
/* when you click on the question mark in the top right corner. */
/* With the <publicKeyHash>, define the following profiles and */
/* grant access to the agent: */
/* KMG.WS.<publicKeyHash> and KMG.LG.<publicKeyHash>*/

#if(${instance-UKO_SERVER_PUBLIC_KEY_HASH} && ${instance-UKO_SERVER_PUBLIC_KEY_HASH} != "*") 

"RDEFINE XFACILIT KMG.WS."PUBLIC_KEY_HASH" OWNER("SAF_OWNER") UACC(NONE)"
"PERMIT KMG.WS."PUBLIC_KEY_HASH "CLASS(XFACILIT) ACC(READ) ID("AGENT_STC_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

"RDEFINE XFACILIT KMG.LG."PUBLIC_KEY_HASH" OWNER("SAF_OWNER") UACC(NONE)" 
"PERMIT KMG.LG."PUBLIC_KEY_HASH "CLASS(XFACILIT) ACC(READ) ID("AGENT_STC_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

#end

"SETROPTS RACL(XFACILIT) REFRESH"

