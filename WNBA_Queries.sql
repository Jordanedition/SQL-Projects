#Sacramento Monarchs
SELECT 
    player, 
    year, 
    overall_pick, 
    win_shares
FROM wnbadraft w 
WHERE team = 'Sacramento Monarchs'
ORDER BY win_shares DESC;

#Draft Efficency
SELECT 
    overall_pick, 
    AVG(win_shares * 1.0) AS avg_career_value,
    AVG(points * 1.0) AS avg_points_per_game
FROM wnbadraft w 
GROUP BY overall_pick
ORDER BY overall_pick ASC;