# 🏀Project Overview

This project leverages a relational database of NBA game logs to extract actionable insights regarding player value, team performance, and winning indicators. This analysis uses SQL to identify winning factors that correlate most strongly with team success and player efficiency.

🛠️ **Data Architecture**

The analysis is built on four relational tables, allowing for complex joins between team identity, player biographical data, and individual game performances:

**NBA_GAMES:** Team-level outcomes and shooting stats.

**NBA_PLAYER_GAMES:** Game performance data for every player per game.

**NBA_PLAYERS:** Player directory (Active/Inactive status).

**NBA_TEAMS:** League-wide team data

📈 **Analytical Deep Dives**

**Performance Under Pressure Business Case:** Which players should a team target for end-of-game scenarios?

This query isolates Clutch Games and analyzes player impact and efficiency specifically within those high-stakes windows.

**Impact Analysis Business Case:** Identifying players whose impact is hidden by low minutes.

This query normalizes impact to a standard 48-minute game to find rotation players with elite efficiency.

**Scoring Range Business Case**

Developed a Player Archetype framework using scoring variance (Max-Min) to assist in roster risk assessment and rotation reliability analysis.
