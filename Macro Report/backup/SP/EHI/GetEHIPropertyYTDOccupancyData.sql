USE [LIHTC_Reports]
GO
/****** Object:  StoredProcedure [EH].[GetEHIPropertyYTDOccupancyData]    Script Date: 5/11/2018 4:25:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- Sample Call: [EH].[GetEHIPropertyYTDOccupancyData] '07-28-2018'
-- =============================================

ALTER PROCEDURE [EH].[GetEHIPropertyYTDOccupancyData] 
	-- Add the parameters for the stored procedure here
		@date varchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX)

	SET @Sql = 'Select
					 EH_Property__r_EH_Project__r_Project_ID__c as [Project Id],
					 EH_Property__r_EH_Project__r_Name as [Project Name],
					 Date__c as [Date],
					 YTD_Occupied__c as [YTD %]
				From OPENQUERY(salesforce_uat,''
				Select
					 EH_Property__r.EH_Project__r.Project_ID__c,
					 EH_Property__r.EH_Project__r.Name,
					 Date__c,
					 YTD_Occupied__c
				From ENT_EH_Unit_Occupancy__c '')
				Where Date__c <='''+@date+'''
				Order By EH_Property__r_EH_Project__r_Project_ID__c, Date__c  Asc'

	EXEC SP_EXECUTESQL @Sql
	PRINT @Sql
	SET NOCOUNT OFF;
END

