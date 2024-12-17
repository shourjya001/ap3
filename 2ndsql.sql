CREATE OR REPLACE FUNCTION dbo."SPU_TPRISPMDBE_1"()
RETURNS TABLE (rows_updated INTEGER)
LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows INTEGER;
BEGIN
    -- Bulk update with performance tracking and efficient join
    WITH UpdateData AS (
        SELECT 
            t."bdrId" AS "CODBDR", 
            t."sensitivityRank" AS "ACTIONCODE"
        FROM 
            "dbo"."WK_MAESTRO_TEST_4" t
        JOIN 
            "dbo"."TSPMDBE" t1 ON t1."CODBDR" = t."bdrId"
        WHERE 
            t1."CODLEVEL" = 'LE'
    )
    UPDATE "dbo"."TSPMDBE" t
    SET 
        "ACTIONCODE" = ud."ACTIONCODE"
    FROM 
        UpdateData ud
    WHERE 
        t."CODBDR" = ud."CODBDR" AND 
        t."CODLEVEL" = 'LE'
    RETURNING 1;

    GET DIAGNOSTICS total_rows = ROW_COUNT;

    -- Optional: Add logging or additional processing
    RAISE NOTICE 'Total rows updated: %', total_rows;

    RETURN QUERY 
    SELECT total_rows;
END;
$function$;
