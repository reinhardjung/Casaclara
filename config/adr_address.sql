# MySQL
# SELECT table_name,
#        table_schema AS dbname
#   FROM INFORMATION_SCHEMA.TABLES
#   WHERE table_name='adr_address';
# 	
# CREATE TABLE animals (
#      id MEDIUMINT NOT NULL AUTO_INCREMENT,
#      name CHAR(30) NOT NULL,
#      PRIMARY KEY (id)
# );



# MS SQL
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[adr_address]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[adr_address]
GO

CREATE TABLE [adr_address] (
	[Ident] [int] IDENTITY (1, 1) NOT NULL ,
	[Vorname] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL ,
	[Nachname] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL ,
	CONSTRAINT [PK_adr_address] PRIMARY KEY  CLUSTERED 
	(
		[Ident]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

INSERT INTO adr_address (Vorname,Nachname) VALUES ('Reinhard','Jung');
INSERT INTO adr_address (Vorname,Nachname) VALUES ('Clarissa','Jung');
INSERT INTO adr_address (Vorname,Nachname) VALUES ('Frank','Schneider');
INSERT INTO adr_address (Vorname,Nachname) VALUES ('Thorsten','Tatendrang');
GO
