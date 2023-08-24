CREATE TABLE
  "faceit_master" AS
SELECT
  t1."lifetime_Average_Headshots" AS "lifetime_average_headshot_percentage_for_kills",
  t1."lifetime_Win_Rate" AS "lifetime_win_rate",
  t1."lifetime_Matches" AS "lifetime_games_played",
  t1."lifetime_Average_K_D_Ratio" AS "lifetime_kd_ratio",
  t2."player_user_id" AS "player_id",
  t2."player_nickname" AS "player_name",
  t2."player_country" AS "country",
  t2."player_skill_level" AS "skill_level",
  t2."played" AS "season_games_played",
  t2."win_rate" AS "season_win_rate",
  t2."position" AS "rank",
  t3."games_csgo_faceit_elo" AS "elo"
FROM
  "players_master_general" AS t1
  JOIN "master_leaderboard" AS t2 ON t1."player_id"=t2."player_user_id"
  JOIN "players_master_elo" AS t3 ON t1."player_id"=t3."player_id";

ALTER TABLE "faceit_master"
ADD COLUMN "win_rate_difference" STRING,
"country_codes" STRING;

UPDATE "faceit_master"
SET
  "country_codes"="country",
  "country"=UPPER("country");

UPDATE "faceit_master"
SET
  "country_codes"=LOWER("country_codes"),
  "lifetime_win_rate"="lifetime_win_rate"/100;

UPDATE "faceit_master"
SET
  "lifetime_average_headshot_percentage_for_kills"="lifetime_average_headshot_percentage_for_kills"/100,
  "win_rate_difference"="season_win_rate"-"lifetime_win_rate";

UPDATE "faceit_master"
SET
  "country"="country_code"."Name"
FROM
  "country_code"
WHERE
  "faceit_master"."country"="country_code"."Code";

ALTER TABLE "faceit_master"
ADD COLUMN "elo_filter" STRING,
"lifetime_win_rate_filter" STRING,
"season_win_rate_filter" STRING,
"lifetime_games_played_filter" STRING,
"season_games_played_filter" STRING,
"lifetime_kd_ratio_filter" STRING,
"lifetime_average_headshot_percentage_for_kills_filter" STRING,
"rank_filter" STRING;

UPDATE "faceit_master"
SET
  "elo_filter"=CASE
    WHEN "elo"<=1000 THEN '1,000 and below'
    WHEN "elo"<=2000 THEN '1,001 to 2,000'
    WHEN "elo"<=3000 THEN '2,001 to 3000'
    WHEN "elo"<=4000 THEN '3,001 to 4000'
    WHEN "elo"<=5000 THEN '4,001 to 5000'
    WHEN "elo"<=6000 THEN '5,001 to 6000'
    ELSE '6,000 and above'
  END,
  "season_win_rate_filter"=CASE
    WHEN "season_win_rate"<=0.50 THEN '50% and below'
    WHEN "season_win_rate"<=0.60 THEN '51% to 60%'
    WHEN "season_win_rate"<=0.70 THEN '61% to 70%'
    WHEN "season_win_rate"<=0.80 THEN '71% to 80%'
    WHEN "season_win_rate"<=0.90 THEN '81% to 90%'
    ELSE '90% and above'
  END,
  "lifetime_win_rate_filter"=CASE
    WHEN "lifetime_win_rate"<=0.50 THEN '50% and below'
    WHEN "lifetime_win_rate"<=0.60 THEN '51% to 60%'
    WHEN "lifetime_win_rate"<=0.70 THEN '61% to 70%'
    WHEN "lifetime_win_rate"<=0.80 THEN '71% to 80%'
    WHEN "lifetime_win_rate"<=0.90 THEN '81% to 90%'
    ELSE '90% and above'
  END,
  "lifetime_games_played_filter"=CASE
    WHEN "lifetime_games_played"<=1000 THEN '1,000 and below'
    WHEN "lifetime_games_played"<=2000 THEN '1,001 to 2,000'
    WHEN "lifetime_games_played"<=3000 THEN '2,001 to 3,000'
    WHEN "lifetime_games_played"<=4000 THEN '3,001 to 4,000'
    WHEN "lifetime_games_played"<=5000 THEN '4,001 to 5,000'
    WHEN "lifetime_games_played"<=6000 THEN '5,001 to 6,000'
    WHEN "lifetime_games_played"<=7000 THEN '6,001 to 7,000'
    WHEN "lifetime_games_played"<=8000 THEN '7,001 to 8,000'
    WHEN "lifetime_games_played"<=9000 THEN '8,001 to 9,000'
    WHEN "lifetime_games_played"<=10000 THEN '9,001 to 10,000'
    ELSE '10,000 and above'
  END,
  "season_games_played_filter"=CASE
    WHEN "season_games_played"<=100 THEN '100 and below'
    WHEN "lifetime_games_played"<=150 THEN '101 to 150'
    WHEN "lifetime_games_played"<=200 THEN '151 to 200'
    WHEN "lifetime_games_played"<=250 THEN '201 to 250'
    WHEN "lifetime_games_played"<=300 THEN '251 to 300'
    WHEN "lifetime_games_played"<=400 THEN '301 to 400'
    WHEN "lifetime_games_played"<=500 THEN '401 to 500'
    ELSE '500 and above'
  END,
  "lifetime_kd_ratio_filter"=CASE
    WHEN "lifetime_kd_ratio"<=1.00 THEN '1.00 and below'
    WHEN "lifetime_kd_ratio"<=1.25 THEN '1.01 to 1.25'
    WHEN "lifetime_kd_ratio"<=1.25 THEN '1.26 to 1.50'
    WHEN "lifetime_kd_ratio"<=1.75 THEN '1.51 to 1.75'
    ELSE '1.75 and above'
  END,
  "lifetime_average_headshot_percentage_for_kills_filter"=CASE
    WHEN "lifetime_average_headshot_percentage_for_kills"<=0.50 THEN '50% and below'
    WHEN "lifetime_average_headshot_percentage_for_kills"<=0.60 THEN '51% to 60%'
    WHEN "lifetime_average_headshot_percentage_for_kills"<=0.70 THEN '61% to 70%'
    WHEN "lifetime_average_headshot_percentage_for_kills"<=0.80 THEN '71% to 80%'
    WHEN "lifetime_average_headshot_percentage_for_kills"<=0.90 THEN '81% to 90%'
    ELSE '90% and above'
  END,
  "rank_filter"=CASE
    WHEN "rank"<=100 THEN '1 to 100'
    WHEN "rank"<=250 THEN '101 to 250'
    WHEN "rank"<=500 THEN '251 to 500'
    WHEN "rank"<=750 THEN '501 to 750'
    ELSE '751 to 1,000'
  END;
