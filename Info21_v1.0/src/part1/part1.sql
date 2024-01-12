-- ������� �������
DROP TABLE IF EXISTS Peers CASCADE;
DROP TABLE IF EXISTS Tasks CASCADE;
DROP TYPE IF EXISTS Check_status CASCADE;
DROP TABLE IF EXISTS P2P CASCADE;
DROP TABLE IF EXISTS Verter CASCADE;
DROP TABLE IF EXISTS Checks CASCADE;
DROP TABLE IF EXISTS TransferredPoints CASCADE;
DROP TABLE IF EXISTS Friends CASCADE;
DROP TABLE IF EXISTS Recommendations CASCADE;
DROP TABLE IF EXISTS XP CASCADE;
DROP TABLE IF EXISTS TimeTracking CASCADE;

-- �������� ������� Peers
CREATE TABLE IF NOT EXISTS Peers
(
    Nickname VARCHAR PRIMARY KEY NOT NULL,
    Birthday DATE                NOT NULL
);
-- �������� ������� Tasks
CREATE TABLE IF NOT EXISTS Tasks
(
    Title      TEXT   NOT NULL PRIMARY KEY,
    ParentTask TEXT,
    MaxXP      BIGINT NOT NULL,
    FOREIGN KEY (ParentTask) REFERENCES Tasks (Title)
);
-- �������� ������������ "������ ��������"
CREATE TYPE check_status AS ENUM ('Start', 'Success', 'Failure');
-- �������� ������� Checks
CREATE TABLE Checks
(
    ID   SERIAL PRIMARY KEY,
    Peer VARCHAR NOT NULL,
    Task TEXT    NOT NULL,
    Date DATE    NOT NULL,
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname),
    FOREIGN KEY (Task) REFERENCES Tasks (Title)
);
-- �������� ������� P2P
CREATE TABLE P2P
(
    ID           SERIAL PRIMARY KEY,
    "Check"      BIGINT       NOT NULL,
    CheckingPeer VARCHAR      NOT NULL,
    State        check_status NOT NULL,
    Time         TIME         NOT NULL,
    FOREIGN KEY ("Check") REFERENCES Checks (ID),
    FOREIGN KEY (CheckingPeer) REFERENCES Peers (Nickname)
);
-- �������� ������� Verter
CREATE TABLE Verter
(
    ID      SERIAL PRIMARY KEY,
    "Check" BIGINT       NOT NULL,
    State   check_status NOT NULL,
    Time    TIME         NOT NULL,
    FOREIGN KEY ("Check") REFERENCES Checks (ID)
);
-- �������� ������� TransferredPoints
CREATE TABLE TransferredPoints
(
    ID           SERIAL PRIMARY KEY,
    CheckingPeer VARCHAR NOT NULL,
    CheckedPeer  VARCHAR NOT NULL,
    PointsAmount BIGINT  NOT NULL,
    FOREIGN KEY (CheckingPeer) REFERENCES Peers (Nickname),
    FOREIGN KEY (CheckedPeer) REFERENCES Peers (Nickname)
);
-- �������� ������� Friends
CREATE TABLE Friends
(
    ID    SERIAL PRIMARY KEY,
    Peer1 VARCHAR            NOT NULL,
    Peer2 VARCHAR            NOT NULL,
    FOREIGN KEY (Peer1) REFERENCES Peers (Nickname),
    FOREIGN KEY (Peer2) REFERENCES Peers (Nickname)
);
-- �������� ������� Recommendations
CREATE TABLE Recommendations
(
    ID              SERIAL PRIMARY KEY,
    Peer            VARCHAR            NOT NULL,
    RecommendedPeer VARCHAR            NOT NULL,
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname),
    FOREIGN KEY (RecommendedPeer) REFERENCES Peers (Nickname)
);
-- �������� ������� XP
CREATE TABLE XP
(
    ID       SERIAL PRIMARY KEY,
    "Check"  BIGINT             NOT NULL,
    XPAmount BIGINT             NOT NULL,
    FOREIGN KEY ("Check") REFERENCES Checks (ID)
);
-- �������� ������� TimeTracking
CREATE TABLE TimeTracking
(
    ID    SERIAL PRIMARY KEY,
    Peer  VARCHAR            NOT NULL,
    Date  DATE               NOT NULL,
    Time  TIME               NOT NULL,
    State BIGINT             NOT NULL CHECK (State IN (1, 2)),
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname)
);
/* -------------------------- FUNCTION --------------------------- */
-- ������� ��� �������� ����� � ������� ��������
CREATE OR REPLACE FUNCTION set_lowercase_nickname() RETURNS TRIGGER AS
$$
BEGIN
    new.nickname := lower(new.nickname);
    RETURN new;
END;
$$ LANGUAGE plpgsql;
--

CREATE OR REPLACE FUNCTION set_in_transferred_points() RETURNS TRIGGER AS
$$
DECLARE
    peer VARCHAR;
BEGIN
    IF ((SELECT count(*) FROM Peers) > 1) THEN
        FOR peer IN (SELECT Nickname FROM Peers)
            LOOP
                peer := replace(peer, '(', '');
                peer := replace(peer, ')', '');
                IF (peer != new.Nickname
                    AND (SELECT count(*)
                         FROM TransferredPoints
                         WHERE peer = CheckedPeer) = 0) THEN
                    INSERT INTO TransferredPoints
                    VALUES (coalesce((SELECT max(ID) FROM TransferredPoints), 0) + 1,
                            peer,
                            new.Nickname,
                            0);
                    INSERT INTO TransferredPoints
                    VALUES ((SELECT max(ID) FROM TransferredPoints) + 1,
                            new.Nickname,
                            peer,
                            0);
                END IF;
            END LOOP;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
/* -------------------------- TRIGGER ---------------------------- */
-- ������� ��� ������������ set_lowercase_nickname
CREATE TRIGGER trg_set_lowercase_nickname
    BEFORE
        INSERT
        OR
        UPDATE
    ON Peers
    FOR EACH ROW
EXECUTE PROCEDURE set_lowercase_nickname();
CREATE TRIGGER trg_set_in_transferred_points
    AFTER
        INSERT
    ON Peers
    FOR EACH ROW
EXECUTE FUNCTION set_in_transferred_points();
/* ---------------------------- DROP ----------------------------- */
-- set_lowercase_nickname
DROP FUNCTION IF EXISTS set_lowercase_nickname() CASCADE;
DROP TRIGGER IF EXISTS trg_set_lowercase_nickname ON Peers CASCADE;
DROP FUNCTION IF EXISTS set_in_transferred_points() CASCADE;
DROP TRIGGER IF EXISTS trg_set_in_transferred_points ON Peers CASCADE;

-- �������� ��������� ��� ������� ������ � ����� �� �������
CREATE OR REPLACE PROCEDURE export_table_to_csv(
    table_name VARCHAR(255),
    file_path TEXT,
    separator CHAR(1) DEFAULT ','
)
    LANGUAGE plpgsql AS
$$
DECLARE
    sql_query TEXT;
BEGIN
    sql_query := FORMAT(
            'COPY %I TO %L WITH (FORMAT CSV, HEADER, DELIMITER %L)',
            table_name,
            file_path,
            separator
        );
    EXECUTE sql_query;
    RAISE NOTICE 'Data exported to file: %', file_path;
END;
$$;
-- �������� ��������� ��� ������� ������ �� ����� � �������
CREATE OR REPLACE PROCEDURE import_table_from_csv(
    table_name TEXT,
    file_path TEXT,
    separator CHAR(1) DEFAULT ','
)
    LANGUAGE plpgsql AS
$$
DECLARE
    sql_query TEXT;
BEGIN
    sql_query := FORMAT(
            'COPY %I FROM %L WITH (FORMAT CSV, HEADER, DELIMITER %L)',
            table_name,
            file_path,
            separator
        );
    EXECUTE sql_query;
    RAISE NOTICE 'Data imported from file: %', file_path;
END;
$$;