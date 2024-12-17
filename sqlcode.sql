CREATE OR REPLACE FUNCTION dbo."SPU_TPRISPMDBE"()
RETURNS void
LANGUAGE plpgsql
AS $function$
BEGIN
    -- Bulk update with joins and where conditions
    WITH UpdateData AS (
        SELECT 
            t."bdrId" AS "CODBDR", 
            CONCAT(t."business Entity", '-', t."nature", '-', t."status") AS "CODPRIMROL"
        FROM 
            "dbo"."WK_MAESTRO_TEST" t
        JOIN 
            "dbo"."TSPMDBE" t1 ON t1."CODBDR" = t."bdrId"
        WHERE 
            t1."CODLEVEL" = 'LE'
    )
    UPDATE "dbo"."TSPMDBE" t
    SET 
        "CODPRIMROL" = ud."CODPRIMROL"
    FROM 
        UpdateData ud
    WHERE 
        t."CODBDR" = ud."CODBDR" AND 
        t."CODLEVEL" = 'LE';

    -- Optional: Logging or additional processing can be added here
    RAISE NOTICE 'Bulk update completed successfully';

    RETURN;
END;
$function$;
