------------------------ex01------------------------
DROP PROCEDURE IF EXISTS add_peer_review CASCADE;

CREATE OR REPLACE PROCEDURE add_peer_review(
    IN nickname_check_peer VARCHAR,
    IN nickname_in_peer VARCHAR,
    IN task_name VARCHAR,
    IN status check_status,
    IN check_time TIME
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF (status = 'Start') THEN
        IF ((SELECT count(*)
             FROM p2p
                      JOIN checks ON p2p."Check" = checks.id
             WHERE p2p.checkingpeer = nickname_in_peer
               AND checks.peer = nickname_check_peer
               AND checks.task = task_name) = 1) THEN
            RAISE EXCEPTION 'Error: This peer pair has an incomplete check.';
        ELSE
            INSERT INTO checks
            VALUES ((SELECT max(id) FROM checks) + 1,
                    nickname_check_peer,
                    task_name,
                    now());
            INSERT INTO p2p
            VALUES ((SELECT max(id) FROM p2p) + 1,
                    (SELECT max(id) FROM checks),
                    nickname_in_peer,
                    status,
                    check_time);
        END IF;
    ELSE
        INSERT INTO p2p
        VALUES ((SELECT max(id) FROM p2p) + 1,
                (SELECT "Check"
                 FROM p2p
                          JOIN checks ON p2p."Check" = checks.id
                 WHERE p2p.checkingpeer = nickname_in_peer
                   AND checks.task = task_name),
                nickname_in_peer,
                status,
                check_time);
    END IF;
END;
$$;

-- Success
-- CALL add_peer_review('deltajed', 'mikeleil', 'C6_s21_matrix', 'Start', '12:00:00');
-- CALL add_peer_review('deltajed', 'mikeleil', 'C6_s21_matrix', 'Success', '13:00:00');

-- Fail::Error
-- CALL add_peer_review('deltajed', 'mikeleil', 'C6_s21_matrix', 'Start', '12:00:00');


------------------------ex02------------------------
DROP PROCEDURE IF EXISTS add_verter_review CASCADE;

CREATE OR REPLACE PROCEDURE add_verter_review(
    IN nickname_check_peer VARCHAR,
    IN task_name VARCHAR,
    IN status check_status,
    IN check_time TIME
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF (status = 'Start') THEN
        IF ((SELECT max(p2p.time)
             FROM p2p
                      JOIN checks ON p2p."Check" = checks.id
             WHERE checks.peer = nickname_check_peer
               AND checks.task = task_name
               AND p2p.state = 'Success') IS NOT NULL) THEN
            INSERT INTO verter
            VALUES ((SELECT max(id) FROM verter) + 1,
                    (SELECT DISTINCT checks.id
                     FROM p2p
                              JOIN checks ON p2p."Check" = checks.id
                     WHERE checks.peer = nickname_check_peer
                       AND checks.task = task_name
                       AND p2p.state = 'Success'),
                    status,
                    check_time);
        ELSE
            RAISE EXCEPTION 'Error: P2P check for the task is not completed or has a `Failure` status';
        END IF;
    ELSE
        INSERT INTO verter
        VALUES ((SELECT max(id) FROM verter) + 1,
                (SELECT "Check"
                 FROM verter
                 GROUP BY "Check"
                 HAVING count(*) % 2 = 1), status, check_time);
    END IF;
END;
$$;

-- Success
-- CALL add_verter_review('deltajed', 'C6_s21_matrix', 'Start', '22:00:00');

-- Fail::Error
-- CALL add_verter_review('deltajed', 'CPP3_SmartCalc_v2.0', 'Start', '22:00:00');

------------------------ex03------------------------
DROP FUNCTION IF EXISTS fnc_trg_update_transferredpoints() CASCADE;

CREATE OR REPLACE FUNCTION fnc_trg_update_transferredpoints() RETURNS TRIGGER AS
$$
BEGIN
    IF (new.state = 'Start') THEN
        WITH tmp AS (SELECT checks.peer AS peer
                     FROM p2p
                              JOIN checks ON p2p."Check" = checks.id
                     WHERE state = 'Start'
                       AND new."Check" = checks.id)
        UPDATE transferredpoints
        SET pointsamount = pointsamount + 1
        FROM tmp
        WHERE tmp.peer = transferredpoints.checkedpeer
          AND new.checkingpeer = transferredpoints.checkingpeer;
        --         WHERE transferredpoints.checkingpeer = new.checkingpeer
--           AND transferredpoints.checkedpeer = tmp.peer;
    END IF;
    RETURN NULL;
END;
$$
    LANGUAGE plpgsql;

CREATE TRIGGER trg_transferredpoints
    AFTER INSERT
    ON p2p
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_update_transferredpoints();

------------------------ex04------------------------
DROP FUNCTION IF EXISTS fnc_trg_check_correct_xp() CASCADE;

CREATE OR REPLACE FUNCTION fnc_trg_check_correct_xp()
    RETURNS TRIGGER AS
$$
BEGIN
    IF ((SELECT maxxp
         FROM checks
                  JOIN tasks ON checks.task = tasks.title
         WHERE new."Check" = checks.id) < new.xpamount) THEN
        RAISE EXCEPTION 'Error: XP exceeds the maximum value.';
    ELSEIF (SELECT state
            FROM p2p
            WHERE new."Check" = p2p."Check"
              AND p2p.state IN ('Success', 'Failure')) = 'Failure' THEN
        RAISE EXCEPTION 'Error: Failure check at the peer.';
    ELSEIF (SELECT state
            FROM verter
            WHERE new."Check" = verter."Check"
              AND verter.state = 'Failure') = 'Failure' THEN
        RAISE EXCEPTION 'Error: Failure check at the Verter.';
    END IF;
    RETURN (new.id, new."Check", new.xpamount);
END;
$$
    LANGUAGE plpgsql;

CREATE TRIGGER trg_check_correct_xp
    BEFORE INSERT
    ON xp
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_check_correct_xp();

-- Success
INSERT INTO XP ("Check", XPAmount) VALUES (4, 350);

-- Error
-- 1. XP exceeds the maximum value.
INSERT INTO XP ("Check", XPAmount) VALUES (4, 1350);

