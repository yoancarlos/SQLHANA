-- cleanup
DROP TYPE "T_DATA";
DROP TYPE "T_PARAMS";
DROP TYPE "T_RESULTS_TT";
DROP TYPE "T_SERIES";
DROP TABLE "SIGNATURE";
CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_DROP"('TECH_ANALYSIS', 'P_TT');

DROP TABLE "RESULTS";
DROP TABLE "SERIES";

-- procedure setup
CREATE TYPE "T_DATA" AS TABLE ("ID" INTEGER, "NET" DOUBLE);
CREATE TYPE "T_PARAMS" AS TABLE ("NAME" VARCHAR(60), "INTARGS" INTEGER, "DOUBLEARGS" DOUBLE, "STRINGARGS" VARCHAR(100));
CREATE TYPE "T_RESULTS_TT" AS TABLE ("TREND" INTEGER);
CREATE TYPE "T_SERIES" AS TABLE ("ID" INTEGER, "VALUE" DOUBLE);

CREATE COLUMN TABLE "SIGNATURE" ("POSITION" INTEGER, "SCHEMA_NAME" NVARCHAR(256), "TYPE_NAME" NVARCHAR(256), "PARAMETER_TYPE" VARCHAR(7));
INSERT INTO "SIGNATURE" VALUES (1, 'TECH_ANALYSIS', 'T_DATA', 'IN');
INSERT INTO "SIGNATURE" VALUES (2, 'TECH_ANALYSIS', 'T_PARAMS', 'IN');
INSERT INTO "SIGNATURE" VALUES (3, 'TECH_ANALYSIS', 'T_RESULTS_TT', 'OUT');
INSERT INTO "SIGNATURE" VALUES (4, 'TECH_ANALYSIS', 'T_SERIES', 'OUT');

CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_CREATE"('AFLPAL', 'TRENDTEST', 'TECH_ANALYSIS', 'P_TT', "SIGNATURE");

-- runtime
DROP TABLE "#PARAMS";
CREATE LOCAL TEMPORARY COLUMN TABLE "#PARAMS" LIKE "T_PARAMS";
INSERT INTO "#PARAMS" VALUES ('METHOD', 1, null, null); -- 1: MK test; 2: Difference-sign test
INSERT INTO "#PARAMS" VALUES ('ALPHA', null, 0.05, null); -- Tolerance probability for MK test


--CALL "P_TT" ("V_DATA", "#PARAMS", "RESULTS", "SERIES") WITH OVERVIEW;
