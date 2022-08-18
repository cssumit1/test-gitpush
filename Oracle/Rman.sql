Check RMAN historical backup details
Using the below query you can find old RMAN backup details.

set linesize 500 pagesize 2000
col Hours format 9999.99
col STATUS format a10
select SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm-dd-yyyy hh24:mi:ss') as RMAN_Bkup_start_time,
to_char(END_TIME,'mm-dd-yyyy hh24:mi:ss') as RMAN_Bkup_end_time,
elapsed_seconds/3600 Hours from V$RMAN_BACKUP_JOB_DETAILS
order by session_key;
How To Determine RMAN Backup Size
Using the below query you can find out the RMAN Backup status on SQL prompt.

SELECT TO_CHAR(completion_time, 'YYYY-MON-DD') completion_time, type, round(sum(bytes)/1048576) MB, round(sum(elapsed_seconds)/60) min
FROM
(
SELECT
CASE
  WHEN s.backup_type='L' THEN 'ARCHIVELOG'
  WHEN s.controlfile_included='YES' THEN 'CONTROLFILE'
  WHEN s.backup_type='D' AND s.incremental_level=0 THEN 'LEVEL0'
  WHEN s.backup_type='I' AND s.incremental_level=1 THEN 'LEVEL1'
END type,
TRUNC(s.completion_time) completion_time, p.bytes, s.elapsed_seconds
FROM v$backup_piece p, v$backup_set s
WHERE p.status='A' AND p.recid=s.recid
UNION ALL
SELECT 'DATAFILECOPY' type, TRUNC(completion_time), output_bytes, 0 elapsed_seconds FROM v$backup_copy_details
)
GROUP BY TO_CHAR(completion_time, 'YYYY-MON-DD'), type
ORDER BY 1 ASC,2,3;