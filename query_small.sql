SELECT COUNT(*) as weekly_active_users
FROM users
WHERE DATEDIFF('day', last_active, CURRENT_TIMESTAMP) < 7
