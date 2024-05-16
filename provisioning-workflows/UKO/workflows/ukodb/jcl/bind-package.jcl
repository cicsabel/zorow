//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//BINDPACK EXEC PGM=IKJEFT01,REGION=4096K
// EXPORT SYMLIST=*
// SET DBSQLID=${instance-DB_CURRENT_SQLID}
// SET DBPACK=${instance-DB_AGENT_PACKAGE}
//STEPLIB   DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD
//SYSTSPRT  DD SYSOUT=*,DCB=BLKSIZE=121
//SYSPRINT  DD SYSOUT=*
//SYSUDUMP  DD SYSOUT=*
//DBRMLIB   DD DISP=SHR,DSN=${instance-UKO_AGENT_DBRMLIB}
//SYSTSIN   DD *,SYMBOLS=(JCLONLY)
  DSN SYSTEM(${instance-DB_JCC_SSID})

*** BASE TABLES
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGPTRAN) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0005) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0211) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0300) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0209) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    DYNAMICRULES(BIND) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)

*** THIS BIND CAN BE REMOVED IF USING &DB2-QUALIFIER IN KMGPARM
***   BIND PACKAGE(&DBPACK)        -
***    MEMBER(KMGPQIBM) -
***    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
***    ENCODING(EBCDIC) -
***    OWNER(&DBSQLID) ISOLATION(CS)

*** OPTIONAL PACKAGE FOR RSA RKG FEATURE #305
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0207) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)

*** OPTIONAL PACKAGE FOR UKDS2=>UKDS7 MIGRATION TABLE
***   BIND PACKAGE(&DBPACK)        -
***    MEMBER(KMGP0301) -
***    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
***    ENCODING(EBCDIC) -
***    OWNER(&DBSQLID) ISOLATION(CS)

*** ADDITONAL BIND NEEDED FOR LEGACY TABLES:
*** UKDS1,2,3,4,6 RKL/SSL
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0004) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0203) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0205) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0206) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0208) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0210) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0213) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0215) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0216) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)
   BIND PACKAGE(&DBPACK)        -
    MEMBER(KMGP0217) -
    ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) -
    ENCODING(EBCDIC) -
    OWNER(&DBSQLID) ISOLATION(CS)

  END