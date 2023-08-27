WITH HighValueOpportunities AS (
    SELECT OpportunityId, SUM(Amount) AS HighValueSales
    FROM (
        SELECT o.Id AS OpportunityId, o.Amount
        FROM opportunity o
        WHERE o.Amount > 100000  -- Arbitrary threshold for high value sales
    ) AS InnerOpportunities
    GROUP BY OpportunityId
),
AccountOpportunityCount AS (
    SELECT AccountId,
           COUNT(Id) AS OpportunitiesCount
    FROM HighValueOpportunities
    GROUP BY AccountId
)
SELECT a.Name, SUM(o.Amount) AS TotalSales
FROM opportunity o
JOIN account a ON o.AccountId = a.Id
JOIN AccountOpportunityCount ac ON a.Id = ac.AccountId
WHERE ac.OpportunitiesCount > 1 AND o.StageName = 'Closed Won'
GROUP BY a.Name;
