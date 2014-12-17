--|#########################################################################
--|# Program: dbverifica.sql
--|#  Author: Gilson Martins (gilson.pmartins@gmail.com | skype: gilson.pmartins)
--|# Version: 1.0
--|#
--|# Description: Return database information
--|# 
--|# History:
--|#   	12/12/2011 - Released version 1.0 as GPL.
--|#	21/06/2012 - Added "DATABASE_PROPERTIES" and head info
--|#  
--|# Usage: @dbverifica
--|# 
--|#########################################################################

SET LINES  500;
SET PAGES 1000;

column PROPERTY_VALUE 	format a40;
column DESCRIPTION 	format a100;

--select * from database_properties;

COLUMN HOST_NAME	FORMAT 	a22;
COLUMN STARTUP_TIME	FORMAT 	a22;
COLUMN CURRENT_TIME	FORMAT	a22;

PROMPT
PROMPT
PROMPT =========================================================================================
PROMPT ==        I N S T A N C E  /  D A T A B A S E   I N F O R M A T I O N
PROMPT =========================================================================================

SELECT INSTANCE_NAME,
	 VERSION, 
	 HOST_NAME, 
	 STATUS, 
	 LOGINS,
	 ARCHIVER,
	 TO_CHAR(STARTUP_TIME, 'DD-MM-RRRR HH24:MI:SS') "STARTUP_TIME",
	 TO_CHAR(SYSDATE, 'DD-MM-RRRR HH24:MI:SS') "CURRENT_TIME"
FROM	 V$INSTANCE;

COLUMN FORCE_LOGGING format a14;

SELECT 	OPEN_MODE,
	PROTECTION_LEVEL,
	FORCE_LOGGING
FROM	V$DATABASE;

PROMPT

PROMPT =========================================================================================
PROMPT ==        B A C K G R O U N D   P R O C E S S E S
PROMPT =========================================================================================


select 	* 
from 	v$bgprocess 
where 	paddr <> '00'
order by name;

PROMPT =========================================================================================
PROMPT
PROMPT
PROMPT ## PARAMETERS ...........................................................................
PROMPT

show parameter db_file_multiblock_read_count;
show parameter cpu_count;
show parameter parallel_threads_per_cpu;

PROMPT
PROMPT .........................................................................................
PROMPT

--|## THE END ##|--