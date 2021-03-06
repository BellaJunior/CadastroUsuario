USE [master]
GO
/****** Object:  Database [testeseniorsolution]    Script Date: 10/10/2018 14:22:41 ******/
CREATE DATABASE [testeseniorsolution]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'testeseniorsolution', FILENAME = N'C:\Users\Juliana Bella\testeseniorsolution.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'testeseniorsolution_log', FILENAME = N'C:\Users\Juliana Bella\testeseniorsolution_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [testeseniorsolution] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [testeseniorsolution].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [testeseniorsolution] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [testeseniorsolution] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [testeseniorsolution] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [testeseniorsolution] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [testeseniorsolution] SET ARITHABORT OFF 
GO
ALTER DATABASE [testeseniorsolution] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [testeseniorsolution] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [testeseniorsolution] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [testeseniorsolution] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [testeseniorsolution] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [testeseniorsolution] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [testeseniorsolution] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [testeseniorsolution] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [testeseniorsolution] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [testeseniorsolution] SET  DISABLE_BROKER 
GO
ALTER DATABASE [testeseniorsolution] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [testeseniorsolution] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [testeseniorsolution] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [testeseniorsolution] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [testeseniorsolution] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [testeseniorsolution] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [testeseniorsolution] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [testeseniorsolution] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [testeseniorsolution] SET  MULTI_USER 
GO
ALTER DATABASE [testeseniorsolution] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [testeseniorsolution] SET DB_CHAINING OFF 
GO
ALTER DATABASE [testeseniorsolution] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [testeseniorsolution] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [testeseniorsolution] SET DELAYED_DURABILITY = DISABLED 
GO
USE [testeseniorsolution]
GO
/****** Object:  Table [dbo].[tb_usuario]    Script Date: 10/10/2018 14:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_usuario](
	[cd_id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nm_nome] [varchar](120) NOT NULL,
	[nm_sobrenome] [varchar](120) NOT NULL,
	[nm_email] [varchar](60) NOT NULL,
	[cd_id_detalhe] [int] NOT NULL,
 CONSTRAINT [PK_tb_usuario] PRIMARY KEY CLUSTERED 
(
	[cd_id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_usuario_det]    Script Date: 10/10/2018 14:22:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_usuario_det](
	[cd_id_detalhe] [int] IDENTITY(1,1) NOT NULL,
	[nm_telefone] [varchar](13) NOT NULL,
	[nm_endereco] [varchar](120) NOT NULL,
 CONSTRAINT [PK_tb_usuario_det] PRIMARY KEY CLUSTERED 
(
	[cd_id_detalhe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tb_usuario01]    Script Date: 10/10/2018 14:22:41 ******/
CREATE NONCLUSTERED INDEX [IX_tb_usuario01] ON [dbo].[tb_usuario]
(
	[nm_nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_usuario]  WITH CHECK ADD  CONSTRAINT [FK_tb_usuario_tb_usuario_det] FOREIGN KEY([cd_id_detalhe])
REFERENCES [dbo].[tb_usuario_det] ([cd_id_detalhe])
GO
ALTER TABLE [dbo].[tb_usuario] CHECK CONSTRAINT [FK_tb_usuario_tb_usuario_det]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario', @level2type=N'COLUMN',@level2name=N'cd_id_usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nome do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario', @level2type=N'COLUMN',@level2name=N'nm_nome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sobrenome do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario', @level2type=N'COLUMN',@level2name=N'nm_sobrenome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'E-mail  do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario', @level2type=N'COLUMN',@level2name=N'nm_email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id do detalhe do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario', @level2type=N'COLUMN',@level2name=N'cd_id_detalhe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cadastro de Usuários' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id do Detelahe' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario_det', @level2type=N'COLUMN',@level2name=N'cd_id_detalhe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Telefone do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario_det', @level2type=N'COLUMN',@level2name=N'nm_telefone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Endereço do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario_det', @level2type=N'COLUMN',@level2name=N'nm_endereco'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Detalhe do Usuário' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_usuario_det'
GO
USE [master]
GO
ALTER DATABASE [testeseniorsolution] SET  READ_WRITE 
GO
