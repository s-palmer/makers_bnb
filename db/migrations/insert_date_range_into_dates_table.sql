INSERT INTO dates(date, available, space_id)
SELECT i::TIMESTAMP, 'TRUE', 1
FROM generate_series(
'2021-10-07 00:00:00'::timestamp,
'2021-10-30 00:00:00',
'1 day') AS t(i);