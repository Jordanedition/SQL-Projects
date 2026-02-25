#Performance Under Pressure
SELECT 
    p.full_name,
    COUNT(pg.Game_ID) AS clutch_games,
    AVG(pg.PLUS_MINUS * 1.0) AS avg_clutch_impact
FROM NBA_PLAYER_GAMES pg
JOIN NBA_PLAYERS p ON pg.Player_ID = p.id
WHERE pg.Game_ID IN (
    SELECT g1.Game_ID
    FROM NBA_GAMES g1
    JOIN NBA_GAMES g2 ON g1.Game_ID = g2.Game_ID 
    WHERE g1.Team_ID <> g2.Team_ID 
    AND (g1.PTS - g2.PTS) BETWEEN -5 AND 5
)
GROUP BY p.full_name
HAVING COUNT(pg.Game_ID) >= 5
ORDER BY avg_clutch_impact DESC;

#Impact Analysis
SELECT 
    p.full_name,
    SUM(pg.MIN) AS total_minutes,
    SUM(pg.PLUS_MINUS) * 48.0 / SUM(pg.MIN) AS impact_per_game
FROM NBA_PLAYER_GAMES pg
JOIN NBA_PLAYERS p ON pg.Player_ID = p.id
GROUP BY p.full_name
HAVING SUM(pg.MIN) > 500
ORDER BY impact_per_game DESC;

#Scoring Range 
SELECT 
    p.full_name,
    AVG(pg.PTS * 1.0) AS avg_pts,
    MAX(pg.PTS) - MIN(pg.PTS) AS scoring_range,
    CASE 
        WHEN (MAX(pg.PTS) - MIN(pg.PTS)) <= 12 THEN 'Consistent Floor'
        WHEN (MAX(pg.PTS) - MIN(pg.PTS)) >= 25 THEN 'High Ceiling / Streaky'
        ELSE 'Standard Rotation'
    END AS player_archetype
FROM NBA_PLAYER_GAMES pg
JOIN NBA_PLAYERS p ON pg.Player_ID = p.id
GROUP BY p.full_name
HAVING COUNT(pg.Game_ID) > 20
ORDER BY scoring_range ASC;
