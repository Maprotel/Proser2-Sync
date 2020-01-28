DISPLAY & DASHBOARD

PLANNED AGENTS

SELECT JSON_EXTRACT(inv_agent_time_json, '$.schedule.id') as schedule, count(*) FROM proser_drc_los_cortijos.InvAgent 
where 
	inv_agent_status = 'A'
AND
JSON_EXTRACT(inv_agent_time_json, '$.schedule.id') IS NOT NULL
group by schedule

/***********************************************/

CRUD AGENTS

Queue assigne not showing
