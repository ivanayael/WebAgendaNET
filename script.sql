USE [master]
GO
/****** Object:  Database [Alumnos]    Script Date: 15/10/2018 22:22:59 ******/
CREATE DATABASE [Alumnos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alumnos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Alumnos.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Alumnos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Alumnos_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Alumnos] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Alumnos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Alumnos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Alumnos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Alumnos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Alumnos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Alumnos] SET ARITHABORT OFF 
GO
ALTER DATABASE [Alumnos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Alumnos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Alumnos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Alumnos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Alumnos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Alumnos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Alumnos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Alumnos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Alumnos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Alumnos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Alumnos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Alumnos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Alumnos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Alumnos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Alumnos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Alumnos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Alumnos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Alumnos] SET RECOVERY FULL 
GO
ALTER DATABASE [Alumnos] SET  MULTI_USER 
GO
ALTER DATABASE [Alumnos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Alumnos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Alumnos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Alumnos] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Alumnos] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Alumnos', N'ON'
GO
USE [Alumnos]
GO
/****** Object:  Table [dbo].[alumno]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alumno](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[telefono] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
 CONSTRAINT [PK_alumno] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[clase]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[modalidad] [nvarchar](50) NULL,
	[fecha] [datetime] NULL,
	[horas] [int] NULL,
	[cantidad] [int] NULL,
	[id_alumno] [int] NULL,
 CONSTRAINT [PK_clase] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[clase]  WITH CHECK ADD  CONSTRAINT [FK_clase_alumno] FOREIGN KEY([id_alumno])
REFERENCES [dbo].[alumno] ([id])
GO
ALTER TABLE [dbo].[clase] CHECK CONSTRAINT [FK_clase_alumno]
GO
/****** Object:  StoredProcedure [dbo].[AlumnoCrearOActualizar]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC	[dbo].[AlumnoCrearOActualizar]	
@id int,
@nombre nvarchar(50),
@telefono nvarchar(50),
@email nvarchar(100)
AS 
BEGIN
IF(@id=0)
BEGIN
INSERT INTO [dbo].[alumno]
           ([nombre]
           ,[telefono]
           ,[email])
     VALUES
           (@nombre,@telefono, @email)
END
ELSE
BEGIN
UPDATE [dbo].[alumno] SET [nombre]=@nombre, [telefono]=@telefono, [email] =@email
WHERE id=@id
END
END
GO
/****** Object:  StoredProcedure [dbo].[AlumnoDeletebyID]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AlumnoDeletebyID]
@id int
AS
BEGIN
DELETE FROM [dbo].[alumno] WHERE ID = @id
END


GO
/****** Object:  StoredProcedure [dbo].[AlumnoViewAll]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[AlumnoViewAll]
AS
BEGIN
SELECT [id]
      ,[nombre]
      ,[telefono]
      ,[email]
  FROM [dbo].[alumno]
END


GO
/****** Object:  StoredProcedure [dbo].[AlumnoViewbyID]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[AlumnoViewbyID]
@id int
AS
BEGIN
SELECT * from alumno where ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[ClaseCrearOActualizar]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC	[dbo].[ClaseCrearOActualizar]	
@id int,
@modalidad nvarchar(50),
@fecha datetime,
@horas int,
@cantidad int,
@id_alumno int
AS 
BEGIN
IF(@id=0)
BEGIN
INSERT INTO [dbo].[clase]
           ([modalidad]
           ,[fecha]
           ,[horas]
		   ,[cantidad]
		   ,[id_alumno])
     VALUES
           (@modalidad
		   ,@fecha 
		   ,@horas
		   ,@cantidad
		   ,@id_alumno)
END
ELSE
BEGIN
UPDATE [dbo].[clase] SET [modalidad]=@modalidad, [fecha]=@fecha, [horas] =@horas, [cantidad] =@cantidad,[id_alumno]=@id_alumno
WHERE id=@id
END
END
GO
/****** Object:  StoredProcedure [dbo].[ClaseDeletebyID]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClaseDeletebyID]
@id int
AS
BEGIN
DELETE FROM [dbo].[clase] WHERE ID = @id
END


GO
/****** Object:  StoredProcedure [dbo].[ClaseViewAll]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClaseViewAll]
AS
BEGIN
SELECT dbo.clase.[id]
      ,[modalidad]
      ,[fecha]
      ,[horas]
      ,[cantidad]
      ,dbo.alumno.nombre as alumno
  FROM [dbo].[clase]
  LEFT JOIN [dbo].alumno
  on dbo.clase.id_alumno = 
  dbo.alumno.id 
END
GO
/****** Object:  StoredProcedure [dbo].[ClaseViewbyID]    Script Date: 15/10/2018 22:22:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClaseViewbyID]
@id int
AS
BEGIN
SELECT dbo.clase.[id]
      ,[modalidad]
      ,[fecha]
      ,[horas]
      ,[cantidad]
      ,[id_alumno] 
from clase
where clase.id=@id
END
GO
USE [master]
GO
ALTER DATABASE [Alumnos] SET  READ_WRITE 
GO
