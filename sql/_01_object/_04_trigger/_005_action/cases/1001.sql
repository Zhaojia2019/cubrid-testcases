--[er]Create trigger using false action with rejects

CREATE CLASS DCL1;	
CREATE TRIGGER DCL1	
BEFORE INSERT ON DCL1	
EXECUTE REJECTS;	
	

DROP CLASS DCL1;	
DROP TRIGGER DCL1;
