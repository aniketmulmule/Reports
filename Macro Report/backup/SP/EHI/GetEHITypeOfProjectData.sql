USE [LIHTC_Reports]
GO
/****** Object:  StoredProcedure [EH].[GetEHITypeOfProjectData]    Script Date: 5/11/2018 4:26:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- Sample Call: [EH].[GetEHITypeOfProjectData]
-- =============================================

ALTER PROCEDURE [EH].[GetEHITypeOfProjectData] 
	-- Add the parameters for the stored procedure here
	--@year varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX)

	SET @Sql = 'Select
					 Project_ID__c as [Project Id],
					 Name as [Project Name],
					 Type_of_Project__c as [Development],
					 Project_Status__c as [Development Status],
					 Total_Units__c as [Units]			
				From OPENQUERY(salesforce_uat,''
				Select
					 Project_ID__c,
					 Name,
					 Type_of_Project__c,
					 Project_Status__c,
					 Total_Units__c 				 
				From ENT_EH_Project__c
				Where Type_of_Project__c = ''''New Construction'''''')	
				Order By Project_ID__c Asc'

	EXEC SP_EXECUTESQL @Sql
	PRINT @Sql
	SET NOCOUNT OFF;
END


