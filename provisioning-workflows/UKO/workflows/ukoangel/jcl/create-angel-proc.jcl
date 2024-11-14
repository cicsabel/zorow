//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//COPY1 EXEC PGM=IEBGENER,MEMLIMIT=0M
//SYSUT2 DD DISP=SHR,
//          DSN=${instance-UKO_ZOS_PROCLIB}(${instance-WLP_ANGEL_NAME})
//SYSPRINT DD SYSOUT=*
//SYSIN  DD *
//SYSUT1 DD DATA,DLM='@@'
//${instance-WLP_ANGEL_NAME} PROC PARMS='',COLD=N,
//        NAME='${instance-WLP_ANGEL_NAME}',SAFLOG=N
//*------------------------------------------------------------------
//* UKO Liberty Angel Process
//*------------------------------------------------------------------
//* PARMS   - Angel process name
//* WLP_INSTALL_DIR- The path to the root of WebSphere Liberty Profile
//*           install.
//*           This path is used to find the product code.
//*------------------------------------------------------------------
//* Start the Liberty angel process
//*
//* STDOUT  - Destination for stdout (System.out)
//* STDERR  - Destination for stderr (System.err)
//*
// SET WLPHOME='${instance-WLP_INSTALL_DIR}'
//*
//STEP1   EXEC PGM=BPXBATA2,REGION=0M,TIME=NOLIMIT,
//   PARM='PGM &WLPHOME./lib/native/zos/s390x/bbgzangl COLD=&COLD 
//             NAME=&NAME &PARMS SAFLOG=&SAFLOG'
//STDOUT    DD SYSOUT=*
//STDERR    DD SYSOUT=*
// PEND
//
@@
/*
## Create the STCJOBS member if required
#if(${instance-UKO_STC_JOB_CARD} && $!{instance-UKO_STC_JOB_CARD} != "")
//COPY2 EXEC PGM=IEBGENER,MEMLIMIT=0M
//SYSUT2 DD DISP=SHR,
//          DSN=${instance-UKO_ZOS_STCJOBS}(${instance-WLP_ANGEL_NAME})
//SYSPRINT DD SYSOUT=*
//SYSIN  DD *
//SYSUT1 DD DATA,DLM='@@'
#set($jobcard = "//${instance-WLP_ANGEL_NAME} ")
#set($stc = "${instance-UKO_STC_JOB_CARD}")
## Parse the jobcard passed in looking for ,
#foreach( $parm in $stc.split(","))
#set($temp = "${jobcard}${parm},")
##if over 70 characters then create new line instead
#if($temp.length() > 70)
${jobcard}
#set($temp = "//  ${parm},")
#end
#set($jobcard = $temp)
#end
## Remove the last , if needed
$jobcard.substring(0,$jobcard.lastIndexOf(","))
//*
//* Set proc order and then execute angel
//*
//PROCLIB JCLLIB ORDER=${instance-UKO_ZOS_PROCLIB}
//ANGEL    EXEC ${instance-WLP_ANGEL_NAME}
@@
/*
#end