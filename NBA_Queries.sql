#Top Contributors 
SELECT
    p.full_name,
    COUNT(DISTINCT pg.game_id)   AS games_played,
    ROUND(AVG(pg.pts), 2)        AS avg_points,
    ROUND(AVG(pg.reb), 2)        AS avg_rebounds,
    ROUND(AVG(pg.ast), 2)        AS avg_assists,
    ROUND(AVG(pg.stl), 2)        AS avg_steals,
    ROUND(AVG(pg.blk), 2)        AS avg_blocks,
    ROUND(AVG(pg.min), 2)        AS avg_minutes
FROM nba_player_games pg
JOIN nba_players p
    ON pg.player_id = p.id
WHERE pg.matchup LIKE 'PHX%'
GROUP BY p.full_name
HAVING COUNT(DISTINCT pg.game_id) >= 10
ORDER BY avg_points DESC;

#Points vs Impact
SELECT
    p.full_name,
    COUNT(DISTINCT pg.game_id)     AS games_played,
    ROUND(AVG(pg.pts), 2)          AS avg_points,
    ROUND(AVG(pg.plus_minus), 2)   AS avg_plus_minus,
    ROUND(AVG(pg.reb), 2)          AS avg_rebounds,
    ROUND(AVG(pg.ast), 2)          AS avg_assists,
    CASE
        WHEN AVG(pg.pts) >= 20 
         AND AVG(pg.plus_minus) > 0 THEN 'Elite'
        WHEN AVG(pg.pts) >= 20 
         AND AVG(pg.plus_minus) <= 0 THEN 'High Scorer, Low Impact'
        WHEN AVG(pg.pts) < 20 
         AND AVG(pg.plus_minus) > 0 THEN 'Role Player, Positive Impact'
        ELSE 'Bench'
    END                            AS efficiency_tier
FROM nba_player_games pg
JOIN nba_players p
    ON pg.player_id = p.id
WHERE pg.matchup LIKE 'PHX%'
GROUP BY p.full_name
HAVING COUNT(DISTINCT pg.game_id) >= 10
ORDER BY avg_plus_minus DESC;
