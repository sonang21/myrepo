package bts.app.model;


public class SqlPlan {
	private int _iId;
	private int _iParentId;
	private String  _sOperation;
	private String  _sObjectName;
	private String  _sObjectType;
	private int _iLastStarts;
	private int _iCardinality;
	private int _iBytes;
	private int _iCost;
	private int _iTime;
	private String  _sPartitionStart;
	private String  _sPartitionStop;
	private int _iPartitionId;
	private int _iLastOutputRows;
	private int _iLastElapsedTime;
	private int _iLastCrBufferGets;
	private int _iLastCuBufferGets;
	private int _iLastDiskReads;
	private int _iLastDiskWrites;
	private int _iEstimatedOptimalSize;
	private int _iEstimatedOnepassSize;
	private int _iLastMemoryUsed;
	private int _iLastTempsegSize;
	private String  _sLastExecution;
	private String  _sQBlockName;
	private String  _sAccessPredicates;
	private String  _sFilterPredicates;
	
	public SqlPlan(int iId, int iParentId, String sOperation) {
		_iId = iId;
		_iParentId = iParentId;
		_sOperation = sOperation;
	}
	
	public int getId() { return _iId; }
	public void setId(int iId) { _iId = iId; }
	
	public int getParentId() { return _iParentId; }
	public void setParentId(int iParentId) { _iParentId = iParentId; }
		
	public String getOperation() { return _sOperation; }
	public void setOperation(String sOperation) { _sOperation = sOperation; }
	//
	public String  getObjectName() { return _sObjectName; }
	public void setObjectName(String sObjectName) { _sObjectName = sObjectName; }
	
	public String  getObjectType() { return _sObjectType; }
	public void setObjectType(String sObjectType) { _sObjectType = sObjectType; }
	
	public int getLastStarts() { return _iLastStarts; }
	public void setLastStarts(int iLastStarts) { _iLastStarts = iLastStarts; }
	
	public int getCardinality() { return _iCardinality; }
	public void setCardinality(int iCardinaliry) { _iCardinality = iCardinaliry; }
	
	public int getBytes() { return _iBytes; }
	public void setBytes(int iBytes) { _iBytes = iBytes; }
	
	public int getCost() { return _iCost; }
	public void setCost(int iCost) { _iCost = iCost; }
	
	public int     getTime             () { return _iTime;             }
	public void    setTime(int iTime)     { _iTime = iTime;            }
	public String  getPartitionStart   () { return _sPartitionStart;   }
	public void    setPartitionStart(String sPartitionStart) { _sPartitionStart = sPartitionStart; }
	public String  getPartitionStop    () { return _sPartitionStop;    }
	public void    setPartitionStop(String sPartitionStop) { _sPartitionStop = sPartitionStop; }
	public int     getPartitionId      () { return _iPartitionId;      }
	public void    setPartitionId(int iPartitionId) { _iParentId = iPartitionId; }
	public int     getLastOutputRows   () { return _iLastOutputRows;   }
	public void    setLastOutputRows(int iLastOutputRows) { _iLastOutputRows = iLastOutputRows; }
	public int     getLastElapsedTime  () { return _iLastElapsedTime;  }
	public void    setLastElapsedTime(int iLastElapsedTime) { _iLastElapsedTime = iLastElapsedTime; }
	public int     getLastCrBufferGets () { return _iLastCrBufferGets; }
	public void    setLastCrBufferGets(int iLastCrBufferGets) { _iLastCrBufferGets = iLastCrBufferGets; }
	public int     getLastCuBufferGets () { return _iLastCuBufferGets; }
	public void    setLastCuBufferGets(int iLastCuBufferGets) { _iLastCuBufferGets = iLastCuBufferGets; } 
	public int     getLastDiskReads    () { return _iLastDiskReads;    }
	public void    setLastDiskReads(int iLastDiskReads) { _iLastDiskReads = iLastDiskReads; }
	public int     getLastDiskWrites   () { return _iLastDiskWrites;   }
	public void    setLastDiskWrites(int iLastDiskWrites) { _iLastDiskWrites = iLastDiskWrites; }
	//
	public int getEstimatedOptimalSize() { return _iEstimatedOptimalSize; }
	public void setEstimatedOptimalSize(int iEstimatedOptimalSize) { _iEstimatedOptimalSize = iEstimatedOptimalSize; }
	
	public int getEstimatedOnepassSize() { return _iEstimatedOnepassSize; }
	public void setEstimatedOnepassSize(int iEstimatedOnepassSize) { _iEstimatedOnepassSize = iEstimatedOnepassSize; }
	
	public int getLastMemoryUsed() { return _iLastMemoryUsed; }
	public void setLastMemoryUsed(int iLastMemoryUsed) { _iLastMemoryUsed = iLastMemoryUsed; }
	
	public int getLastTempsegSize() { return _iLastTempsegSize; }
	public void setLastTempsegSize(int iLastTempsegSize) { _iLastTempsegSize = iLastTempsegSize; }
	
	public String getLastExecution() { return _sLastExecution; }
	public void setLastExecution(String sLastExecution) { _sLastExecution = sLastExecution; }

	public String getQBlockName() { return _sQBlockName; }
	public void setQBlockName(String sQBlockName) { _sQBlockName = sQBlockName; }

	public String getAccessPredicates() { return _sAccessPredicates; }
	public void setAccessPredicates(String sAccessPredicates) { _sAccessPredicates = sAccessPredicates; }

	public String getFilterPredicates() { return _sFilterPredicates; }
	public void setFilterPredicates(String sFilterPredicates) { _sFilterPredicates = sFilterPredicates; }
	
}
