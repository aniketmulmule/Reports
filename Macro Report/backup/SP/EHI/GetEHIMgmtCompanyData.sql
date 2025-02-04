USE [LIHTC_Reports]
GO
/****** Object:  StoredProcedure [EH].[GetEHIMgmtCompanyData]    Script Date: 5/11/2018 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		
-- Create date: 
-- Description:	for financial income statement
-- Sample Call: [EH].[GetEHIMgmtCompanyData]
-- =============================================

ALTER PROCEDURE [EH].[GetEHIMgmtCompanyData] 
	-- Add the parameters for the stored procedure here
    	--@year VARCHAR(5)
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX)

	SET @Sql = 'Select
					EH_Project__r_Project_Id__c as [Project Id],
					EH_Project__r_Name as [Project Name],
					Account__r_Name as [Mgmt Company]			 					 
				From OPENQUERY(salesforce_uat,''
				Select
					EH_Project__r.Project_Id__c,
					EH_Project__r.Name,
					Account__r.Name
				From ENT_EH_Participant__c
				WHERE Primary__c = true AND Active__c = true AND Account_Role__c =''''Management Agent''''
					 '')'

	EXEC SP_EXECUTESQL @Sql
	PRINT @Sql
	SET NOCOUNT OFF;
END

