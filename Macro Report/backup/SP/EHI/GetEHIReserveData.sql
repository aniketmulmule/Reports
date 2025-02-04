USE [LIHTC_Reports]
GO
/****** Object:  StoredProcedure [EH].[GetEHIReserveData]    Script Date: 5/11/2018 4:26:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	for financial income statement
-- Sample Call: [EH].[GetEHIReserveData] 2018,'Q3' 
-- =============================================

ALTER PROCEDURE [EH].[GetEHIReserveData] 
	-- Add the parameters for the stored procedure here
    	@year VARCHAR(5)
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX)

	SET @Sql = 'Select
					 EH_Development__r_Name as [Project Name],
					 Req_Ann_Repl_Res_Deposit__c as [Amount],
					 Year__c as [Year]
				From OPENQUERY(salesforce_uat,''
				Select
					 EH_Development__r.Name,
					 Req_Ann_Repl_Res_Deposit__c,
					 Year__c
				From ENT_EH_Reserves__c
					 Where Year__c = ''''' + @year + ''''''')'

	EXEC SP_EXECUTESQL @Sql
	PRINT @Sql
	SET NOCOUNT OFF;
END
