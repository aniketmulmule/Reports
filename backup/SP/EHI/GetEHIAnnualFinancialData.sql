USE [LIHTC_Reports]
GO
/****** Object:  StoredProcedure [EH].[GetEHIAnnualFinancialData]    Script Date: 5/11/2018 4:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- Sample Call: [EH].[GetEHIAnnualFinancialData] 2017
-- =============================================

ALTER PROCEDURE [EH].[GetEHIAnnualFinancialData] 
	-- Add the parameters for the stored procedure here
		@year VARCHAR(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX)

	SET @Sql = 'Select
					 EH_Financial_Statement__r_EH_Project__r_Project_ID__c as [Project Id],
					 EH_Financial_Statement__r_EH_Project__r_Name as [Project Name],
					 EH_Financial_Statement__r_EH_Project__r_Type_of_Project__c as [Development],
					 EH_Financial_Statement__r_EH_Project__r_Total_Units__c as [Units],
					 EH_Financial_Statement__r_EH_Project__r_Project_Status__c as [Project Status],
					 EH_Financial_Statement__r_Statement_Year__c as [Statement Year],
					 EH_Financial_Statement__r_Period__c as [Period],
					 EH_Financial_Statement__r_RecordType_Name as [Record Type],					 					
					 EH_Chart_Of_Account__r_Name as COA,
					 EH_Financial_Statement__r_Type__c as Type,					 					 
					 Account_Number__c as [Account No.],
					 Amount__c as Amount,
					 EH_Financial_Statement__r_Total_Revenue__c as [Total Revenue],
					 EH_Financial_Statement__r_Total_Administrative__c as [Total Admmin],
					 EH_Financial_Statement__r_Total_Utilities__c as [Total Utilities],
					 EH_Financial_Statement__r_Total_Repairs_Maintenance__c as [Total R&M]
				From OPENQUERY(salesforce_uat,''
				Select
					 EH_Financial_Statement__r.EH_Project__r.Project_ID__c,
					 EH_Financial_Statement__r.EH_Project__r.Name,
					 EH_Financial_Statement__r.EH_Project__r.Type_of_Project__c,
					 EH_Financial_Statement__r.EH_Project__r.Total_Units__c,
					 EH_Financial_Statement__r.EH_Project__r.Project_Status__c,
					 EH_Financial_Statement__r.Statement_Year__c,					 
					 EH_Financial_Statement__r.Period__c,
					 EH_Financial_Statement__r.RecordType.Name,					 
					 EH_Chart_Of_Account__r.Name,	
					 EH_Financial_Statement__r.Type__c,				 					 
					 Account_Number__c,
					 Amount__c,
					 EH_Financial_Statement__r.Total_Revenue__c,
					 EH_Financial_Statement__r.Total_Administrative__c,
					 EH_Financial_Statement__r.Total_Utilities__c,
					 EH_Financial_Statement__r.Total_Repairs_Maintenance__c		
				From ENT_EH_Financial_Statement_Item__c'')	
				Where EH_Financial_Statement__r_Period__c =''Annual'' And Amount__c IS NOT NULL		
				And EH_Financial_Statement__r_Statement_Year__c = '''+@year+''' 
				Order By EH_Financial_Statement__r_EH_Project__r_Project_ID__c Asc'

	EXEC SP_EXECUTESQL @Sql
	PRINT @Sql
	SET NOCOUNT OFF;
END

