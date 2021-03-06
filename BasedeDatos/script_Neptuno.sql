USE [master]
GO
/****** Object:  Database [Neptuno]    Script Date: 01/07/2020 04:40:34 p.m. ******/
CREATE DATABASE [Neptuno]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Neptuno_dat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Neptuno.mdf' , SIZE = 4672KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Neptuno_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Neptuno.ldf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [Neptuno] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Neptuno].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [Neptuno] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Neptuno] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Neptuno] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Neptuno] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Neptuno] SET ARITHABORT OFF 
GO
ALTER DATABASE [Neptuno] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Neptuno] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Neptuno] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Neptuno] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Neptuno] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Neptuno] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Neptuno] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Neptuno] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Neptuno] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Neptuno] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Neptuno] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Neptuno] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Neptuno] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Neptuno] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Neptuno] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Neptuno] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Neptuno] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Neptuno] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Neptuno] SET  MULTI_USER 
GO
ALTER DATABASE [Neptuno] SET PAGE_VERIFY TORN_PAGE_DETECTION  
GO
ALTER DATABASE [Neptuno] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Neptuno] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Neptuno] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Neptuno] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Neptuno', N'ON'
GO
ALTER DATABASE [Neptuno] SET QUERY_STORE = OFF
GO
USE [Neptuno]
GO
/****** Object:  Table [dbo].[Categorías]    Script Date: 01/07/2020 04:40:34 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorías](
	[IdCategoría] [int] IDENTITY(1,1) NOT NULL,
	[NombreCategoría] [nvarchar](15) NOT NULL,
	[Descripción] [ntext] NULL,
 CONSTRAINT [PK_Categorías] PRIMARY KEY CLUSTERED 
(
	[IdCategoría] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[NombreProducto] [nvarchar](40) NOT NULL,
	[IdProveedor] [int] NULL,
	[IdCategoría] [int] NULL,
	[Precio] [money] NULL,
	[Stock] [smallint] NULL,
	[Suspendido] [bit] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[NombreCompañía] [nvarchar](40) NOT NULL,
	[Dirección] [nvarchar](60) NULL,
	[Ciudad] [nvarchar](15) NULL,
	[País] [nvarchar](15) NULL,
	[Teléfono] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ListaProductos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[ListaProductos]
As
  Select P.IdProducto,P.NombreProducto,C.NombreCategoría,
  Pr.NombreCompañía,P.PrecioUnidad
  From Productos P, Proveedores Pr, Categorías C
  Where P.IdProveedor = Pr.IdProveedor And
            P.IdCategoría = C.IdCategoría
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [nvarchar](5) NOT NULL,
	[NombreCompañía] [nvarchar](40) NOT NULL,
	[Dirección] [nvarchar](60) NULL,
	[Ciudad] [nvarchar](15) NULL,
	[País] [nvarchar](15) NULL,
	[Teléfono] [nvarchar](24) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Apellidos] [nvarchar](20) NOT NULL,
	[Nombre] [nvarchar](10) NOT NULL,
	[Cargo] [nvarchar](30) NULL,
	[FechaContratación] [smalldatetime] NULL,
	[Dirección] [nvarchar](60) NULL,
	[Ciudad] [nvarchar](15) NULL,
	[País] [nvarchar](15) NULL,
	[TelDomicilio] [nvarchar](24) NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[IdPedido] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [nvarchar](5) NOT NULL,
	[IdEmpleado] [int] NULL,
	[FechaPedido] [smalldatetime] NULL,
	[FechaEntrega] [smalldatetime] NULL,
	[FechaEnvío] [smalldatetime] NULL,
	[FormaEnvío] [int] NULL,
	[Cargo] [money] NULL,
	[Destinatario] [nvarchar](40) NULL,
	[DirecciónDestinatario] [nvarchar](60) NULL,
	[CiudadDestinatario] [nvarchar](15) NULL,
	[RegiónDestinatario] [nvarchar](15) NULL,
	[CódPostalDestinatario] [nvarchar](10) NULL,
	[PaísDestinatario] [nvarchar](15) NULL,
	[Monto] [money] NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ListadoPedidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ListadoPedidos]
As
   Select P.IdPedido, C.NombreCompañía, E.Apellidos,
   P.FechaPedido, P.Cargo
   From Pedidos P, Clientes C, Empleados E
   Where P.IdCliente = C.IdCliente And
             P.IdEmpleado = E.IdEmpleado

GO
/****** Object:  Table [dbo].[Detalles]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles](
	[IdPedido] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[PrecioUnidad] [money] NOT NULL,
	[Cantidad] [smallint] NOT NULL,
	[Descuento] [real] NOT NULL,
 CONSTRAINT [PK_Detalles de pedidos] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ProductosMasVendidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ProductosMasVendidos]
AS
SELECT     TOP (5)  dbo.Productos.NombreProducto, SUM(dbo.Detalles.Cantidad) AS Total
FROM         dbo.Detalles INNER JOIN
                      dbo.Productos
  ON dbo.Productos.IdProducto = dbo.Detalles.IdProducto
GROUP BY dbo.Productos.NombreProducto
ORDER BY Total DESC
GO
/****** Object:  View [dbo].[vistadeproductos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vistadeproductos]
AS
SELECT     dbo.Productos.IdProducto, dbo.Productos.NombreProducto, dbo.Productos.IdProveedor, dbo.Productos.IdCategoría, dbo.Productos.CantidadPorUnidad, 
                      dbo.Productos.PrecioUnidad, dbo.Productos.UnidadesEnExistencia, dbo.Proveedores.NombreCompañía, dbo.Categorías.NombreCategoría
FROM         dbo.Productos INNER JOIN
                      dbo.Categorías ON dbo.Productos.IdCategoría = dbo.Categorías.IdCategoría INNER JOIN
                      dbo.Proveedores ON dbo.Productos.IdProveedor = dbo.Proveedores.IdProveedor
GO
/****** Object:  View [dbo].[VistaProductos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaProductos]
AS
SELECT     dbo.Productos.IdProducto, dbo.Productos.NombreProducto, dbo.Productos.IdProveedor, dbo.Productos.IdCategoría, dbo.Productos.CantidadPorUnidad, 
                      dbo.Productos.PrecioUnidad, dbo.Productos.UnidadesEnExistencia, dbo.Categorías.NombreCategoría, dbo.Proveedores.NombreCompañía
FROM         dbo.Productos INNER JOIN
                      dbo.Categorías ON dbo.Productos.IdCategoría = dbo.Categorías.IdCategoría INNER JOIN
                      dbo.Proveedores ON dbo.Productos.IdProveedor = dbo.Proveedores.IdProveedor
GO
/****** Object:  View [dbo].[VistaPedidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaPedidos]
AS
SELECT     dbo.Pedidos.IdPedido, dbo.Pedidos.IdCliente, dbo.Pedidos.IdEmpleado, dbo.Pedidos.FechaPedido, dbo.Pedidos.FechaEntrega, 
                      dbo.Clientes.NombreCompañía AS Cliente, dbo.Empleados.Apellidos + ' ' + dbo.Empleados.Nombre AS Vendedor
FROM         dbo.Clientes INNER JOIN
                      dbo.Pedidos ON dbo.Clientes.IdCliente = dbo.Pedidos.IdCliente INNER JOIN
                      dbo.Empleados ON dbo.Pedidos.IdEmpleado = dbo.Empleados.IdEmpleado
GO
/****** Object:  View [dbo].[VistaDetalles]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaDetalles]
AS
SELECT     dbo.Detalles.IdPedido, dbo.Detalles.IdProducto, dbo.Detalles.Cantidad, dbo.Productos.NombreProducto, dbo.Detalles.PrecioUnidad, 
                      dbo.Detalles.PrecioUnidad * dbo.Detalles.Cantidad AS total
FROM         dbo.Detalles INNER JOIN
                      dbo.Productos ON dbo.Detalles.IdProducto = dbo.Productos.IdProducto
GO
/****** Object:  View [dbo].[ConsultaProductos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ConsultaProductos]
AS
SELECT     dbo.Productos.IdProducto, dbo.Productos.NombreProducto, dbo.Productos.IdProveedor, dbo.Productos.IdCategoría, dbo.Productos.CantidadPorUnidad, 
                      dbo.Productos.PrecioUnidad, dbo.Productos.UnidadesEnExistencia AS Stock, dbo.Categorías.NombreCategoría AS Categoria, 
                      dbo.Proveedores.NombreCompañía AS Proveedor
FROM         dbo.Productos INNER JOIN
                      dbo.Categorías ON dbo.Productos.IdCategoría = dbo.Categorías.IdCategoría INNER JOIN
                      dbo.Proveedores ON dbo.Productos.IdProveedor = dbo.Proveedores.IdProveedor
GO
/****** Object:  View [dbo].[VistaLosMasVendidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaLosMasVendidos]
AS
SELECT     TOP (100) PERCENT dbo.Productos.NombreProducto, SUM(dbo.Detalles.Cantidad) AS Total
FROM         dbo.Detalles INNER JOIN
                      dbo.Productos ON dbo.Detalles.IdProducto = dbo.Detalles.IdProducto
GROUP BY dbo.Productos.NombreProducto
ORDER BY Total DESC
GO
SET IDENTITY_INSERT [dbo].[Categorías] ON 

INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (1, N'Bebidas', N'Gaseosas, café, té, cervezas y maltas')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (2, N'Condimentos', N'Salsas dulces y picantes, delicias, comida para untar y aderezos')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (3, N'Repostería', N'Postres, dulces y pan dulce')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (4, N'Lácteos', N'Quesos')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (5, N'Granos/Cereales', N'Pan, galletas, pasta y cereales')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (6, N'Carnes', N'Carnes preparadas')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (7, N'Frutas/Verduras', N'Frutas secas y queso de soja')
INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción]) VALUES (8, N'Pescado/Marisco', N'Pescados, mariscos y algas')
SET IDENTITY_INSERT [dbo].[Categorías] OFF
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ALFKI', N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', N'Alemania', N'030-0074321')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ANATR', N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', N'México', N'(5) 555-4729')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ANTON', N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', N'México', N'(5) 555-3932')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'AROUT', N'Around the Horn', N'120 Hanover Sq.', N'Londres', N'Reino Unido', N'(71) 555-7788')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BERGS', N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', N'Suecia', N'0921-12 34 65')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BLAUS', N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', N'Alemania', N'0621-08460')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BLONP', N'Blondel père et fils', N'24, place Kléber', N'Estrasburgo', N'Francia', N'88.60.15.31')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BOLID', N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', N'España', N'(91) 555 22 82')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BONAP', N'Bon app''', N'12, rue des Bouchers', N'Marsella', N'Francia', N'91.24.45.40')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BOTTM', N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'Canadá', N'(604) 555-4729')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'BSBEV', N'B''s Beverages', N'Fauntleroy Circus', N'Londres', N'Reino Unido', N'(71) 555-1212')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'CACTU', N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', N'Argentina', N'(1) 135-5555')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'CENTC', N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'México D.F.', N'México', N'(5) 555-3392')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'CHOPS', N'Chop-suey Chinese', N'Hauptstr. 29', N'Berna', N'Suiza', N'0452-076545')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'COMMI', N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'Brasil', N'(11) 555-7647')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'CONSH', N'Consolidated Holdings', N'Berkeley Gardens
12  Brewery ', N'Londres', N'Reino Unido', N'(71) 555-2282')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'DRACD', N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', N'Alemania', N'0241-039123')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'DUMON', N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', N'Francia', N'40.67.88.88')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'EASTC', N'Eastern Connection', N'35 King George', N'Londres', N'Reino Unido', N'(71) 555-0297')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ERNSH', N'Ernst Handel', N'Kirchgasse 6', N'Graz', N'Austria', N'7675-3425')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FAMIA', N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'Brasil', N'(11) 555-9857')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FISSA', N'FISSA Fabrica Inter. Salchichas S.A.', N'C/ Moralzarzal, 86', N'Madrid', N'España', N'(91) 555 94 44')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FOLIG', N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', N'Francia', N'20.16.10.16')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FOLKO', N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', N'Suecia', N'0695-34 67 21')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FRANK', N'Frankenversand', N'Berliner Platz 43', N'München', N'Alemania', N'089-0877310')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FRANR', N'France restauration', N'54, rue Royale', N'Nantes', N'Francia', N'40.32.21.21')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FRANS', N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', N'Italia', N'011-4988260')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'FURIB', N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', N'Portugal', N'(1) 354-2534')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'GALED', N'Galería del gastrónomo', N'Rambla de Cataluña, 23', N'Barcelona', N'España', N'(93) 203 4560')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'GODOS', N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', N'España', N'(95) 555 82 82')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'GOURL', N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'Brasil', N'(11) 555-9482')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'GREAL', N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugenia', N'Estados Unidos', N'(503) 555-7555')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'GROSR', N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'Venezuela', N'(2) 283-2951')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'HANAR', N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'Brasil', N'(21) 555-0091')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'HILAA', N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Venezuela', N'(5) 555-1340')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'HUNGC', N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'Estados Unidos', N'(503) 555-6874')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'HUNGO', N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Irlanda', N'2967 542')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ISLAT', N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Reino Unido', N'(198) 555-8888')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'KOENE', N'Königlich Essen', N'Maubelstr. 90', N'Brandenburgo', N'Alemania', N'0555-09876')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LACOR', N'La corne d''abondance', N'67, avenue de l''Europe', N'Versalles', N'Francia', N'30.59.84.10')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LAMAI', N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', N'Francia', N'61.77.61.10')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LAUGB', N'Laughing Bacchus Wine Cellars', N'1900 Oak St.', N'Vancouver', N'Canadá', N'(604) 555-3392')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LAZYK', N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'Estados Unidos', N'(509) 555-7969')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LEHMS', N'Lehmanns Marktstand', N'Magazinweg 7', N'Francfurt', N'Alemania', N'069-0245984')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LETSS', N'Let''s Stop N Shop', N'87 Polk St.
Suite 5', N'San Francisco', N'Estados Unidos', N'(415) 555-5938')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LILAS', N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Venezuela', N'(9) 331-6954')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LINOD', N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Venezuela', N'(8) 34-56-12')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'LONEP', N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'Estados Unidos', N'(503) 555-9573')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'MAGAA', N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', N'Italia', N'035-640230')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'MAISD', N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruselas', N'Bélgica', N'(02) 201 24 67')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'MEREP', N'Mère Paillarde', N'43 rue St. Laurent', N'Montreal', N'Canadá', N'(514) 555-8054')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'MORGK', N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', N'Alemania', N'0342-023176')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'NORTS', N'North/South', N'South House
300 Queensbridge', N'Londres', N'Reino Unido', N'(71) 555-7733')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'OCEAN', N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', N'Argentina', N'(1) 135-5333')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'OLDWO', N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'Estados Unidos', N'(907) 555-7584')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'OTTIK', N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', N'Alemania', N'0221-0644327')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'PARIS', N'Paris spécialités', N'265, boulevard Charonne', N'París', N'Francia', N'(1) 42.34.22.66')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'PERIC', N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', N'México', N'(5) 552-3745')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'PICCO', N'Piccolo und mehr', N'Geislweg 14', N'Salzburgo', N'Austria', N'6562-9722')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'PRINI', N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', N'Portugal', N'(1) 356-5634')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'QUEDE', N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'Brasil', N'(21) 555-4252')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'QUEEN', N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'Brasil', N'(11) 555-1189')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'QUICK', N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', N'Alemania', N'0372-035188')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'RANCH', N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', N'Argentina', N'(1) 123-5555')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'RATTC', N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'Estados Unidos', N'(505) 555-5939')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'REGGC', N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', N'Italia', N'0522-556721')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'RICAR', N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'Brasil', N'(21) 555-3412')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'RICSU', N'Richter Supermarkt', N'Grenzacherweg 237', N'Génova', N'Suiza', N'0897-034214')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'ROMEY', N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', N'España', N'(91) 745 6200')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SANTG', N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', N'Noruega', N'07-98 92 35')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SAVEA', N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'Estados Unidos', N'(208) 555-8097')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SEVES', N'Seven Seas Imports', N'90 Wadhurst Rd.', N'Londres', N'Reino Unido', N'(71) 555-1717')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SIMOB', N'Simons bistro', N'Vinbæltet 34', N'København', N'Dinamarca', N'31 12 34 56')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SPECD', N'Spécialités du monde', N'25, rue Lauriston', N'París', N'Francia', N'(1) 47.55.60.10')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SPLIR', N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'Estados Unidos', N'(307) 555-4680')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'SUPRD', N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', N'Bélgica', N'(071) 23 67 22 20')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'THEBI', N'The Big Cheese', N'89 Jefferson Way
Suite 2', N'Portland', N'Estados Unidos', N'(503) 555-3612')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'THECR', N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'Estados Unidos', N'(406) 555-5834')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'TOMSP', N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', N'Alemania', N'0251-031259')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'TORTU', N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', N'México', N'(5) 555-2933')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'TRADH', N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'Brasil', N'(11) 555-2167')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'TRAIH', N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'Estados Unidos', N'(206) 555-8257')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'VAFFE', N'Vaffeljernet', N'Smagsløget 45', N'Århus', N'Dinamarca', N'86 21 32 43')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'VICTE', N'Victuailles en stock', N'2, rue du Commerce', N'Lion', N'Francia', N'78.32.54.86')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'VINET', N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', N'Francia', N'26.47.15.10')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WANDK', N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', N'Alemania', N'0711-020361')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WARTH', N'Wartian Herkku', N'Torikatu 38', N'Oulu', N'Finlandia', N'981-443655')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WELLI', N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'Brasil', N'(14) 555-8122')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WHITC', N'White Clover Markets', N'305 - 14th Ave. S.
Suite 3B', N'Seattle', N'Estados Unidos', N'(206) 555-4112')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WILMK', N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', N'Finlandia', N'90-224 8858')
INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono]) VALUES (N'WOLZA', N'Wolski  Zajazd', N'ul. Filtrowa 68', N'Warszawa', N'Polonia', N'(26) 642-7012')
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10248, 11, 14.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10248, 42, 9.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10248, 72, 34.8000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10249, 14, 18.6000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10249, 51, 42.4000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10250, 41, 7.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10250, 51, 42.4000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10250, 65, 16.8000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10251, 22, 16.8000, 6, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10251, 57, 15.6000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10251, 65, 16.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10252, 20, 64.8000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10252, 33, 2.0000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10252, 60, 27.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10253, 31, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10253, 39, 14.4000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10253, 49, 16.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10254, 24, 3.6000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10254, 55, 19.2000, 21, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10254, 74, 8.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10255, 2, 15.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10255, 16, 13.9000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10255, 36, 15.2000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10255, 59, 44.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10256, 53, 26.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10256, 77, 10.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10257, 27, 35.1000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10257, 39, 14.4000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10257, 77, 10.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10258, 2, 15.2000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10258, 5, 17.0000, 65, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10258, 32, 25.6000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10259, 21, 8.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10259, 37, 20.8000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10260, 41, 7.7000, 16, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10260, 57, 15.6000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10260, 62, 39.4000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10260, 70, 12.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10261, 21, 8.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10261, 35, 14.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10262, 5, 17.0000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10262, 7, 24.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10262, 56, 30.4000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10263, 16, 13.9000, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10263, 24, 3.6000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10263, 30, 20.7000, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10263, 74, 8.0000, 36, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10264, 2, 15.2000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10264, 41, 7.7000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10265, 17, 31.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10265, 70, 12.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10266, 12, 30.4000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10267, 40, 14.7000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10267, 59, 44.0000, 70, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10267, 76, 14.4000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10268, 29, 99.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10268, 72, 27.8000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10269, 33, 2.0000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10269, 72, 27.8000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10270, 36, 15.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10270, 43, 36.8000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10271, 33, 2.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10272, 20, 64.8000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10272, 31, 10.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10272, 72, 27.8000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10273, 10, 24.8000, 24, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10273, 31, 10.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10273, 33, 2.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10273, 40, 14.7000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10273, 76, 14.4000, 33, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10274, 71, 17.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10274, 72, 27.8000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10275, 24, 3.6000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10275, 59, 44.0000, 6, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10276, 10, 24.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10276, 13, 4.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10277, 28, 36.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10277, 62, 39.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10278, 44, 15.5000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10278, 59, 44.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10278, 63, 35.1000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10278, 73, 12.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10279, 17, 31.2000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10280, 24, 3.6000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10280, 55, 19.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10280, 75, 6.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10281, 19, 7.3000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10281, 24, 3.6000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10281, 35, 14.4000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10282, 30, 20.7000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10282, 57, 15.6000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10283, 15, 12.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10283, 19, 7.3000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10283, 60, 27.2000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10283, 72, 27.8000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10284, 27, 35.1000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10284, 44, 15.5000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10284, 60, 27.2000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10284, 67, 11.2000, 5, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10285, 1, 14.4000, 45, 0.2)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10285, 40, 14.7000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10285, 53, 26.2000, 36, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10286, 35, 14.4000, 100, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10286, 62, 39.4000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10287, 16, 13.9000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10287, 34, 11.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10287, 46, 9.6000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10288, 54, 5.9000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10288, 68, 10.0000, 3, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10289, 3, 8.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10289, 64, 26.6000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10290, 5, 17.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10290, 29, 99.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10290, 49, 16.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10290, 77, 10.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10291, 13, 4.8000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10291, 44, 15.5000, 24, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10291, 51, 42.4000, 2, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10292, 20, 64.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10293, 18, 50.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10293, 24, 3.6000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10293, 63, 35.1000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10293, 75, 6.2000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10294, 1, 14.4000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10294, 17, 31.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10294, 43, 36.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10294, 60, 27.2000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10294, 75, 6.2000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10295, 56, 30.4000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10296, 11, 16.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10296, 16, 13.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10296, 69, 28.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10297, 39, 14.4000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10297, 72, 27.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10298, 2, 15.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10298, 36, 15.2000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10298, 59, 44.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10298, 62, 39.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10299, 19, 7.3000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10299, 70, 12.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10300, 66, 13.6000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10300, 68, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10301, 40, 14.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10301, 56, 30.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10302, 17, 31.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10302, 28, 36.4000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10302, 43, 36.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10303, 40, 14.7000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10303, 65, 16.8000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10303, 68, 10.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10304, 49, 16.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10304, 59, 44.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10304, 71, 17.2000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10305, 18, 50.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10305, 29, 99.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10305, 39, 14.4000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10306, 30, 20.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10306, 53, 26.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10306, 54, 5.9000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10307, 62, 39.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10307, 68, 10.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10308, 69, 28.8000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10308, 70, 12.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10309, 4, 17.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10309, 6, 20.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10309, 42, 11.2000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10309, 43, 36.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10309, 71, 17.2000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10310, 16, 13.9000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10310, 62, 39.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10311, 42, 11.2000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10311, 69, 28.8000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10312, 28, 36.4000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10312, 43, 36.8000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10312, 53, 26.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10312, 75, 6.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10313, 36, 15.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10314, 32, 25.6000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10314, 58, 10.6000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10314, 62, 39.4000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10315, 34, 11.2000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10315, 70, 12.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10316, 41, 7.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10316, 62, 39.4000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10317, 1, 14.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10318, 41, 7.7000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10318, 76, 14.4000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10319, 17, 31.2000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10319, 28, 36.4000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10319, 76, 14.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10320, 71, 17.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10321, 35, 14.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10322, 52, 5.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10323, 15, 12.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10323, 25, 11.2000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10323, 39, 14.4000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10324, 16, 13.9000, 21, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10324, 35, 14.4000, 70, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10324, 46, 9.6000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10324, 59, 44.0000, 40, 0.15)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10324, 63, 35.1000, 80, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10325, 6, 20.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10325, 13, 4.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10325, 14, 18.6000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10325, 31, 10.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10325, 72, 27.8000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10326, 4, 17.6000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10326, 57, 15.6000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10326, 75, 6.2000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10327, 2, 15.2000, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10327, 11, 16.8000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10327, 30, 20.7000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10327, 58, 10.6000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10328, 59, 44.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10328, 65, 16.8000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10328, 68, 10.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10329, 19, 7.3000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10329, 30, 20.7000, 8, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10329, 38, 210.8000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10329, 56, 30.4000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10330, 26, 24.9000, 50, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10330, 72, 27.8000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10331, 54, 5.9000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10332, 18, 50.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10332, 42, 11.2000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10332, 47, 7.6000, 16, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10333, 14, 18.6000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10333, 21, 8.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10333, 71, 17.2000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10334, 52, 5.6000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10334, 68, 10.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10335, 2, 15.2000, 7, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10335, 31, 10.0000, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10335, 32, 25.6000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10335, 51, 42.4000, 48, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10336, 4, 17.6000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10337, 23, 7.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10337, 26, 24.9000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10337, 36, 15.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10337, 37, 20.8000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10337, 72, 27.8000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10338, 17, 31.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10338, 30, 20.7000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10339, 4, 17.6000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10339, 17, 31.2000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10339, 62, 39.4000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10340, 18, 50.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10340, 41, 7.7000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10340, 43, 36.8000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10341, 33, 2.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10341, 59, 44.0000, 9, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10342, 2, 15.2000, 24, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10342, 31, 10.0000, 56, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10342, 36, 15.2000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10342, 55, 19.2000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10343, 64, 26.6000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10343, 68, 10.0000, 4, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10343, 76, 14.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10344, 4, 17.6000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10344, 8, 32.0000, 70, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10345, 8, 32.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10345, 19, 7.3000, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10345, 42, 11.2000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10346, 17, 31.2000, 36, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10346, 56, 30.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10347, 25, 11.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10347, 39, 14.4000, 50, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10347, 40, 14.7000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10347, 75, 6.2000, 6, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10348, 1, 14.4000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10348, 23, 7.2000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10349, 54, 5.9000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10350, 50, 13.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10350, 69, 28.8000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10351, 38, 210.8000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10351, 41, 7.7000, 13, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10351, 44, 15.5000, 77, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10351, 65, 16.8000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10352, 24, 3.6000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10352, 54, 5.9000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10353, 11, 16.8000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10353, 38, 210.8000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10354, 1, 14.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10354, 29, 99.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10355, 24, 3.6000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10355, 57, 15.6000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10356, 31, 10.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10356, 55, 19.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10356, 69, 28.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10357, 10, 24.8000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10357, 26, 24.9000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10357, 60, 27.2000, 8, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10358, 24, 3.6000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10358, 34, 11.2000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10358, 36, 15.2000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10359, 16, 13.9000, 56, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10359, 31, 10.0000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10359, 60, 27.2000, 80, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10360, 28, 36.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10360, 29, 99.0000, 35, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10360, 38, 210.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10360, 49, 16.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10360, 54, 5.9000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10361, 39, 14.4000, 54, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10361, 60, 27.2000, 55, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10362, 25, 11.2000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10362, 51, 42.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10362, 54, 5.9000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10363, 31, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10363, 75, 6.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10363, 76, 14.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10364, 69, 28.8000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10364, 71, 17.2000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10365, 11, 16.8000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10366, 65, 16.8000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10366, 77, 10.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10367, 34, 11.2000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10367, 54, 5.9000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10367, 65, 16.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10367, 77, 10.4000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10368, 21, 8.0000, 5, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10368, 28, 36.4000, 13, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10368, 57, 15.6000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10368, 64, 26.6000, 35, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10369, 29, 99.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10369, 56, 30.4000, 18, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10370, 1, 14.4000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10370, 64, 26.6000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10370, 74, 8.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10371, 36, 15.2000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10372, 20, 64.8000, 12, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10372, 38, 210.8000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10372, 60, 27.2000, 70, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10372, 72, 27.8000, 42, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10373, 58, 10.6000, 80, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10373, 71, 17.2000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10374, 31, 10.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10374, 58, 10.6000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10375, 14, 18.6000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10375, 54, 5.9000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10376, 31, 10.0000, 42, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10377, 28, 36.4000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10377, 39, 14.4000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10378, 71, 17.2000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10379, 41, 7.7000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10379, 63, 35.1000, 16, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10379, 65, 16.8000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10380, 30, 20.7000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10380, 53, 26.2000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10380, 60, 27.2000, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10380, 70, 12.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10381, 74, 8.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10382, 5, 17.0000, 32, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10382, 18, 50.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10382, 29, 99.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10382, 33, 2.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10382, 74, 8.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10383, 13, 4.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10383, 50, 13.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10383, 56, 30.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10384, 20, 64.8000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10384, 60, 27.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10385, 7, 24.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10385, 60, 27.2000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10385, 68, 10.0000, 8, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10386, 24, 3.6000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10386, 34, 11.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10387, 24, 3.6000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10387, 28, 36.4000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10387, 59, 44.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10387, 71, 17.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10388, 45, 7.6000, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10388, 52, 5.6000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10388, 53, 26.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10389, 10, 24.8000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10389, 55, 19.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10389, 62, 39.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10389, 70, 12.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10390, 31, 10.0000, 60, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10390, 35, 14.4000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10390, 46, 9.6000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10390, 72, 27.8000, 24, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10391, 13, 4.8000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10392, 69, 28.8000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10393, 2, 15.2000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10393, 14, 18.6000, 42, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10393, 25, 11.2000, 7, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10393, 26, 24.9000, 70, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10393, 31, 10.0000, 32, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10394, 13, 4.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10394, 62, 39.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10395, 46, 9.6000, 28, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10395, 53, 26.2000, 70, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10395, 69, 28.8000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10396, 23, 7.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10396, 71, 17.2000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10396, 72, 27.8000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10397, 21, 8.0000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10397, 51, 42.4000, 18, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10398, 35, 14.4000, 30, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10398, 55, 19.2000, 120, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10399, 68, 10.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10399, 71, 17.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10399, 76, 14.4000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10399, 77, 10.4000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10400, 29, 99.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10400, 35, 14.4000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10400, 49, 16.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10401, 30, 20.7000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10401, 56, 30.4000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10401, 65, 16.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10401, 71, 17.2000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10402, 23, 7.2000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10402, 63, 35.1000, 65, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10403, 16, 13.9000, 21, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10403, 48, 10.2000, 70, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10404, 26, 24.9000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10404, 42, 11.2000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10404, 49, 16.0000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10405, 3, 8.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10406, 1, 14.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10406, 21, 8.0000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10406, 28, 36.4000, 42, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10406, 36, 15.2000, 5, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10406, 40, 14.7000, 2, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10407, 11, 16.8000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10407, 69, 28.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10407, 71, 17.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10408, 37, 20.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10408, 54, 5.9000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10408, 62, 39.4000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10409, 14, 18.6000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10409, 21, 8.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10410, 33, 2.0000, 49, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10410, 59, 44.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10411, 41, 7.7000, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10411, 44, 15.5000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10411, 59, 44.0000, 9, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10412, 14, 18.6000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10413, 1, 14.4000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10413, 62, 39.4000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10413, 76, 14.4000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10414, 19, 7.3000, 18, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10414, 33, 2.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10415, 17, 31.2000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10415, 33, 2.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10416, 19, 7.3000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10416, 53, 26.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10416, 57, 15.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10417, 38, 210.8000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10417, 46, 9.6000, 2, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10417, 68, 10.0000, 36, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10417, 77, 10.4000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10418, 2, 15.2000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10418, 47, 7.6000, 55, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10418, 61, 22.8000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10418, 74, 8.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10419, 60, 27.2000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10419, 69, 28.8000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10420, 9, 77.6000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10420, 13, 4.8000, 2, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10420, 70, 12.0000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10420, 73, 12.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10421, 19, 7.3000, 4, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10421, 26, 24.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10421, 53, 26.2000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10421, 77, 10.4000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10422, 26, 24.9000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10423, 31, 10.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10423, 59, 44.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10424, 35, 14.4000, 60, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10424, 38, 210.8000, 49, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10424, 68, 10.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10425, 55, 19.2000, 10, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10425, 76, 14.4000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10426, 56, 30.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10426, 64, 26.6000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10427, 14, 18.6000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10428, 46, 9.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10429, 50, 13.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10429, 63, 35.1000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10430, 17, 31.2000, 45, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10430, 21, 8.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10430, 56, 30.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10430, 59, 44.0000, 70, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10431, 17, 31.2000, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10431, 40, 14.7000, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10431, 47, 7.6000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10432, 26, 24.9000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10432, 54, 5.9000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10433, 56, 30.4000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10434, 11, 16.8000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10434, 76, 14.4000, 18, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10435, 2, 15.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10435, 22, 16.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10435, 72, 27.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10436, 46, 9.6000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10436, 56, 30.4000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10436, 64, 26.6000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10436, 75, 6.2000, 24, 0.1)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10437, 53, 26.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10438, 19, 7.3000, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10438, 34, 11.2000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10438, 57, 15.6000, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10439, 12, 30.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10439, 16, 13.9000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10439, 64, 26.6000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10439, 74, 8.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10440, 2, 15.2000, 45, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10440, 16, 13.9000, 49, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10440, 29, 99.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10440, 61, 22.8000, 90, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10441, 27, 35.1000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10442, 11, 16.8000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10442, 54, 5.9000, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10442, 66, 13.6000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10443, 11, 16.8000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10443, 28, 36.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10444, 17, 31.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10444, 26, 24.9000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10444, 35, 14.4000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10444, 41, 7.7000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10445, 39, 14.4000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10445, 54, 5.9000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10446, 19, 7.3000, 12, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10446, 24, 3.6000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10446, 31, 10.0000, 3, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10446, 52, 5.6000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10447, 19, 7.3000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10447, 65, 16.8000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10447, 71, 17.2000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10448, 26, 24.9000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10448, 40, 14.7000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10449, 10, 24.8000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10449, 52, 5.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10449, 62, 39.4000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10450, 10, 24.8000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10450, 54, 5.9000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10451, 55, 19.2000, 120, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10451, 64, 26.6000, 35, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10451, 65, 16.8000, 28, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10451, 77, 10.4000, 55, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10452, 28, 36.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10452, 44, 15.5000, 100, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10453, 48, 10.2000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10453, 70, 12.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10454, 16, 13.9000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10454, 33, 2.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10454, 46, 9.6000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10455, 39, 14.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10455, 53, 26.2000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10455, 61, 22.8000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10455, 71, 17.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10456, 21, 8.0000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10456, 49, 16.0000, 21, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10457, 59, 44.0000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10458, 26, 24.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10458, 28, 36.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10458, 43, 36.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10458, 56, 30.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10458, 71, 17.2000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10459, 7, 24.0000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10459, 46, 9.6000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10459, 72, 27.8000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10460, 68, 10.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10460, 75, 6.2000, 4, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10461, 21, 8.0000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10461, 30, 20.7000, 28, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10461, 55, 19.2000, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10462, 13, 4.8000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10462, 23, 7.2000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10463, 19, 7.3000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10463, 42, 11.2000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10464, 4, 17.6000, 16, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10464, 43, 36.8000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10464, 56, 30.4000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10464, 60, 27.2000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10465, 24, 3.6000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10465, 29, 99.0000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10465, 40, 14.7000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10465, 45, 7.6000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10465, 50, 13.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10466, 11, 16.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10466, 46, 9.6000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10467, 24, 3.6000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10467, 25, 11.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10468, 30, 20.7000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10468, 43, 36.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10469, 2, 15.2000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10469, 16, 13.9000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10469, 44, 15.5000, 2, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10470, 18, 50.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10470, 23, 7.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10470, 64, 26.6000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10471, 7, 24.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10471, 56, 30.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10472, 24, 3.6000, 80, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10472, 51, 42.4000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10473, 33, 2.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10473, 71, 17.2000, 12, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10474, 14, 18.6000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10474, 28, 36.4000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10474, 40, 14.7000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10474, 75, 6.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10475, 31, 10.0000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10475, 66, 13.6000, 60, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10475, 76, 14.4000, 42, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10476, 55, 19.2000, 2, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10476, 70, 12.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10477, 1, 14.4000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10477, 21, 8.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10477, 39, 14.4000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10478, 10, 24.8000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10479, 38, 210.8000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10479, 53, 26.2000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10479, 59, 44.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10479, 64, 26.6000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10480, 47, 7.6000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10480, 59, 44.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10481, 49, 16.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10481, 60, 27.2000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10482, 40, 14.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10483, 34, 11.2000, 35, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10483, 77, 10.4000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10484, 21, 8.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10484, 40, 14.7000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10484, 51, 42.4000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10485, 2, 15.2000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10485, 3, 8.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10485, 55, 19.2000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10485, 70, 12.0000, 60, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10486, 11, 16.8000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10486, 51, 42.4000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10486, 74, 8.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10487, 19, 7.3000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10487, 26, 24.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10487, 54, 5.9000, 24, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10488, 59, 44.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10488, 73, 12.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10489, 11, 16.8000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10489, 16, 13.9000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10490, 59, 44.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10490, 68, 10.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10490, 75, 6.2000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10491, 44, 15.5000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10491, 77, 10.4000, 7, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10492, 25, 11.2000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10492, 42, 11.2000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10493, 65, 16.8000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10493, 66, 13.6000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10493, 69, 28.8000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10494, 56, 30.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10495, 23, 7.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10495, 41, 7.7000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10495, 77, 10.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10496, 31, 10.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10497, 56, 30.4000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10497, 72, 27.8000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10497, 77, 10.4000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10498, 24, 4.5000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10498, 40, 18.4000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10498, 42, 14.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10499, 28, 45.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10499, 49, 20.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10500, 15, 15.5000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10500, 28, 45.6000, 8, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10501, 54, 7.4500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10502, 45, 9.5000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10502, 53, 32.8000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10502, 67, 14.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10503, 14, 23.2500, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10503, 65, 21.0500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10504, 2, 19.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10504, 21, 10.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10504, 53, 32.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10504, 61, 28.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10505, 62, 49.3000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10506, 25, 14.0000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10506, 70, 15.0000, 14, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10507, 43, 46.0000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10507, 48, 12.7500, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10508, 13, 6.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10508, 39, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10509, 28, 45.6000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10510, 29, 123.7900, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10510, 75, 7.7500, 36, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10511, 4, 22.0000, 50, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10511, 7, 30.0000, 50, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10511, 8, 40.0000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10512, 24, 4.5000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10512, 46, 12.0000, 9, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10512, 47, 9.5000, 6, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10512, 60, 34.0000, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10513, 21, 10.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10513, 32, 32.0000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10513, 61, 28.5000, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10514, 20, 81.0000, 39, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10514, 28, 45.6000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10514, 56, 38.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10514, 65, 21.0500, 39, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10514, 75, 7.7500, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10515, 9, 97.0000, 16, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10515, 16, 17.4500, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10515, 27, 43.9000, 120, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10515, 33, 2.5000, 16, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10515, 60, 34.0000, 84, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10516, 18, 62.5000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10516, 41, 9.6500, 80, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10516, 42, 14.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10517, 52, 7.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10517, 59, 55.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10517, 70, 15.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10518, 24, 4.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10518, 38, 263.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10518, 44, 19.4500, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10519, 10, 31.0000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10519, 56, 38.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10519, 60, 34.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10520, 24, 4.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10520, 53, 32.8000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10521, 35, 18.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10521, 41, 9.6500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10521, 68, 12.5000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10522, 1, 18.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10522, 8, 40.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10522, 30, 25.8900, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10522, 40, 18.4000, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10523, 17, 39.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10523, 20, 81.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10523, 37, 26.0000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10523, 41, 9.6500, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10524, 10, 31.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10524, 30, 25.8900, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10524, 43, 46.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10524, 54, 7.4500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10525, 36, 19.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10525, 40, 18.4000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10526, 1, 18.0000, 8, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10526, 13, 6.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10526, 56, 38.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10527, 4, 22.0000, 50, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10527, 36, 19.0000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10528, 11, 21.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10528, 33, 2.5000, 8, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10528, 72, 34.8000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10529, 55, 24.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10529, 68, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10529, 69, 36.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10530, 17, 39.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10530, 43, 46.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10530, 61, 28.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10530, 76, 18.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10531, 59, 55.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10532, 30, 25.8900, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10532, 66, 17.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10533, 4, 22.0000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10533, 72, 34.8000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10533, 73, 15.0000, 24, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10534, 30, 25.8900, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10534, 40, 18.4000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10534, 54, 7.4500, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10535, 11, 21.0000, 50, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10535, 40, 18.4000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10535, 57, 19.5000, 5, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10535, 59, 55.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10536, 12, 38.0000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10536, 31, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10536, 33, 2.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10536, 60, 34.0000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10537, 31, 12.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10537, 51, 53.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10537, 58, 13.2500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10537, 72, 34.8000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10537, 73, 15.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10538, 70, 15.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10538, 72, 34.8000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10539, 13, 6.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10539, 21, 10.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10539, 33, 2.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10539, 49, 20.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10540, 3, 10.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10540, 26, 31.2300, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10540, 38, 263.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10540, 68, 12.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10541, 24, 4.5000, 35, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10541, 38, 263.5000, 4, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10541, 65, 21.0500, 36, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10541, 71, 21.5000, 9, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10542, 11, 21.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10542, 54, 7.4500, 24, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10543, 12, 38.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10543, 23, 9.0000, 70, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10544, 28, 45.6000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10544, 67, 14.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10545, 11, 21.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10546, 7, 30.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10546, 35, 18.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10546, 62, 49.3000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10547, 32, 32.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10547, 36, 19.0000, 60, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10548, 34, 14.0000, 10, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10548, 41, 9.6500, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10549, 31, 12.5000, 55, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10549, 45, 9.5000, 100, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10549, 51, 53.0000, 48, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10550, 17, 39.0000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10550, 19, 9.2000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10550, 21, 10.0000, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10550, 61, 28.5000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10551, 16, 17.4500, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10551, 35, 18.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10551, 44, 19.4500, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10552, 69, 36.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10552, 75, 7.7500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10553, 11, 21.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10553, 16, 17.4500, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10553, 22, 21.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10553, 31, 12.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10553, 35, 18.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10554, 16, 17.4500, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10554, 23, 9.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10554, 62, 49.3000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10554, 77, 13.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10555, 14, 23.2500, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10555, 19, 9.2000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10555, 24, 4.5000, 18, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10555, 51, 53.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10555, 56, 38.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10556, 72, 34.8000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10557, 64, 33.2500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10557, 75, 7.7500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10558, 47, 9.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10558, 51, 53.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10558, 52, 7.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10558, 53, 32.8000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10558, 73, 15.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10559, 41, 9.6500, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10559, 55, 24.0000, 18, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10560, 30, 25.8900, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10560, 62, 49.3000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10561, 44, 19.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10561, 51, 53.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10562, 33, 2.5000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10562, 62, 49.3000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10563, 36, 19.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10563, 52, 7.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10564, 17, 39.0000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10564, 31, 12.5000, 6, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10564, 55, 24.0000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10565, 24, 4.5000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10565, 64, 33.2500, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10566, 11, 21.0000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10566, 18, 62.5000, 18, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10566, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10567, 31, 12.5000, 60, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10567, 51, 53.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10567, 59, 55.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10568, 10, 31.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10569, 31, 12.5000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10569, 76, 18.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10570, 11, 21.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10570, 56, 38.0000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10571, 14, 23.2500, 11, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10571, 42, 14.0000, 28, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10572, 16, 17.4500, 12, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10572, 32, 32.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10572, 40, 18.4000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10572, 75, 7.7500, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10573, 17, 39.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10573, 34, 14.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10573, 53, 32.8000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10574, 33, 2.5000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10574, 40, 18.4000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10574, 62, 49.3000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10574, 64, 33.2500, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10575, 59, 55.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10575, 63, 43.9000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10575, 72, 34.8000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10575, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10576, 1, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10576, 31, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10576, 44, 19.4500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10577, 39, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10577, 75, 7.7500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10577, 77, 13.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10578, 35, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10578, 57, 19.5000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10579, 15, 15.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10579, 75, 7.7500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10580, 14, 23.2500, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10580, 41, 9.6500, 9, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10580, 65, 21.0500, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10581, 75, 7.7500, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10582, 57, 19.5000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10582, 76, 18.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10583, 29, 123.7900, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10583, 60, 34.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10583, 69, 36.0000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10584, 31, 12.5000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10585, 47, 9.5000, 15, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10586, 52, 7.0000, 4, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10587, 26, 31.2300, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10587, 35, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10587, 77, 13.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10588, 18, 62.5000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10588, 42, 14.0000, 100, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10589, 35, 18.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10590, 1, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10590, 77, 13.0000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10591, 3, 10.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10591, 7, 30.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10591, 54, 7.4500, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10592, 15, 15.5000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10592, 26, 31.2300, 5, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10593, 20, 81.0000, 21, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10593, 69, 36.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10593, 76, 18.0000, 4, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10594, 52, 7.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10594, 58, 13.2500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10595, 35, 18.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10595, 61, 28.5000, 120, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10595, 69, 36.0000, 65, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10596, 56, 38.0000, 5, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10596, 63, 43.9000, 24, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10596, 75, 7.7500, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10597, 24, 4.5000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10597, 57, 19.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10597, 65, 21.0500, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10598, 27, 43.9000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10598, 71, 21.5000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10599, 62, 49.3000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10600, 54, 7.4500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10600, 73, 15.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10601, 13, 6.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10601, 59, 55.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10602, 77, 13.0000, 5, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10603, 22, 21.0000, 48, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10603, 49, 20.0000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10604, 48, 12.7500, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10604, 76, 18.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10605, 16, 17.4500, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10605, 59, 55.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10605, 60, 34.0000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10605, 71, 21.5000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10606, 4, 22.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10606, 55, 24.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10606, 62, 49.3000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10607, 7, 30.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10607, 17, 39.0000, 100, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10607, 33, 2.5000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10607, 40, 18.4000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10607, 72, 34.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10608, 56, 38.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10609, 1, 18.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10609, 10, 31.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10609, 21, 10.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10610, 36, 19.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10611, 1, 18.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10611, 2, 19.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10611, 60, 34.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10612, 10, 31.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10612, 36, 19.0000, 55, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10612, 49, 20.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10612, 60, 34.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10612, 76, 18.0000, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10613, 13, 6.0000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10613, 75, 7.7500, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10614, 11, 21.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10614, 21, 10.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10614, 39, 18.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10615, 55, 24.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10616, 38, 263.5000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10616, 56, 38.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10616, 70, 15.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10616, 71, 21.5000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10617, 59, 55.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10618, 6, 25.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10618, 56, 38.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10618, 68, 12.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10619, 21, 10.0000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10619, 22, 21.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10620, 24, 4.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10620, 52, 7.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10621, 19, 9.2000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10621, 23, 9.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10621, 70, 15.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10621, 71, 21.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10622, 2, 19.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10622, 68, 12.5000, 18, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10623, 14, 23.2500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10623, 19, 9.2000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10623, 21, 10.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10623, 24, 4.5000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10623, 35, 18.0000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10624, 28, 45.6000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10624, 29, 123.7900, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10624, 44, 19.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10625, 14, 23.2500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10625, 42, 14.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10625, 60, 34.0000, 10, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10626, 53, 32.8000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10626, 60, 34.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10626, 71, 21.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10627, 62, 49.3000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10627, 73, 15.0000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10628, 1, 18.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10629, 29, 123.7900, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10629, 64, 33.2500, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10630, 55, 24.0000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10630, 76, 18.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10631, 75, 7.7500, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10632, 2, 19.0000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10632, 33, 2.5000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10633, 12, 38.0000, 36, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10633, 13, 6.0000, 13, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10633, 26, 31.2300, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10633, 62, 49.3000, 80, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10634, 7, 30.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10634, 18, 62.5000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10634, 51, 53.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10634, 75, 7.7500, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10635, 4, 22.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10635, 5, 21.3500, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10635, 22, 21.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10636, 4, 22.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10636, 58, 13.2500, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10637, 11, 21.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10637, 50, 16.2500, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10637, 56, 38.0000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10638, 45, 9.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10638, 65, 21.0500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10638, 72, 34.8000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10639, 18, 62.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10640, 69, 36.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10640, 70, 15.0000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10641, 2, 19.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10641, 40, 18.4000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10642, 21, 10.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10642, 61, 28.5000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10643, 28, 45.6000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10643, 39, 18.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10643, 46, 12.0000, 2, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10644, 18, 62.5000, 4, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10644, 43, 46.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10644, 46, 12.0000, 21, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10645, 18, 62.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10645, 36, 19.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10646, 1, 18.0000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10646, 10, 31.0000, 18, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10646, 71, 21.5000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10646, 77, 13.0000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10647, 19, 9.2000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10647, 39, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10648, 22, 21.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10648, 24, 4.5000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10649, 28, 45.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10649, 72, 34.8000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10650, 30, 25.8900, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10650, 53, 32.8000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10650, 54, 7.4500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10651, 19, 9.2000, 12, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10651, 22, 21.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10652, 30, 25.8900, 2, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10652, 42, 14.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10653, 16, 17.4500, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10653, 60, 34.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10654, 4, 22.0000, 12, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10654, 39, 18.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10654, 54, 7.4500, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10655, 41, 9.6500, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10656, 14, 23.2500, 3, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10656, 44, 19.4500, 28, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10656, 47, 9.5000, 6, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 15, 15.5000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 41, 9.6500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 46, 12.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 47, 9.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 56, 38.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10657, 60, 34.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10658, 21, 10.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10658, 40, 18.4000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10658, 60, 34.0000, 55, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10658, 77, 13.0000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10659, 31, 12.5000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10659, 40, 18.4000, 24, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10659, 70, 15.0000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10660, 20, 81.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10661, 39, 18.0000, 3, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10661, 58, 13.2500, 49, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10662, 68, 12.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10663, 40, 18.4000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10663, 42, 14.0000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10663, 51, 53.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10664, 10, 31.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10664, 56, 38.0000, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10664, 65, 21.0500, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10665, 51, 53.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10665, 59, 55.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10665, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10666, 29, 123.7900, 36, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10666, 65, 21.0500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10667, 69, 36.0000, 45, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10667, 71, 21.5000, 14, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10668, 31, 12.5000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10668, 55, 24.0000, 4, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10668, 64, 33.2500, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10669, 36, 19.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10670, 23, 9.0000, 32, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10670, 46, 12.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10670, 67, 14.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10670, 73, 15.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10670, 75, 7.7500, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10671, 16, 17.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10671, 62, 49.3000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10671, 65, 21.0500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10672, 38, 263.5000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10672, 71, 21.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10673, 16, 17.4500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10673, 42, 14.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10673, 43, 46.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10674, 23, 9.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10675, 14, 23.2500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10675, 53, 32.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10675, 58, 13.2500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10676, 10, 31.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10676, 19, 9.2000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10676, 44, 19.4500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10677, 26, 31.2300, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10677, 33, 2.5000, 8, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10678, 12, 38.0000, 100, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10678, 33, 2.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10678, 41, 9.6500, 120, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10678, 54, 7.4500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10679, 59, 55.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10680, 16, 17.4500, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10680, 31, 12.5000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10680, 42, 14.0000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10681, 19, 9.2000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10681, 21, 10.0000, 12, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10681, 64, 33.2500, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10682, 33, 2.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10682, 66, 17.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10682, 75, 7.7500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10683, 52, 7.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10684, 40, 18.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10684, 47, 9.5000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10684, 60, 34.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10685, 10, 31.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10685, 41, 9.6500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10685, 47, 9.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10686, 17, 39.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10686, 26, 31.2300, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10687, 9, 97.0000, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10687, 29, 123.7900, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10687, 36, 19.0000, 6, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10688, 10, 31.0000, 18, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10688, 28, 45.6000, 60, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10688, 34, 14.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10689, 1, 18.0000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10690, 56, 38.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10690, 77, 13.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10691, 1, 18.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10691, 29, 123.7900, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10691, 43, 46.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10691, 44, 19.4500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10691, 62, 49.3000, 48, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10692, 63, 43.9000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10693, 9, 97.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10693, 54, 7.4500, 60, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10693, 69, 36.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10693, 73, 15.0000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10694, 7, 30.0000, 90, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10694, 59, 55.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10694, 70, 15.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10695, 8, 40.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10695, 12, 38.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10695, 24, 4.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10696, 17, 39.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10696, 46, 12.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10697, 19, 9.2000, 7, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10697, 35, 18.0000, 9, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10697, 58, 13.2500, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10697, 70, 15.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10698, 11, 21.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10698, 17, 39.0000, 8, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10698, 29, 123.7900, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10698, 65, 21.0500, 65, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10698, 70, 15.0000, 8, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10699, 47, 9.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10700, 1, 18.0000, 5, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10700, 34, 14.0000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10700, 68, 12.5000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10700, 71, 21.5000, 60, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10701, 59, 55.0000, 42, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10701, 71, 21.5000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10701, 76, 18.0000, 35, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10702, 3, 10.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10702, 76, 18.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10703, 2, 19.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10703, 59, 55.0000, 35, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10703, 73, 15.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10704, 4, 22.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10704, 24, 4.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10704, 48, 12.7500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10705, 31, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10705, 32, 32.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10706, 16, 17.4500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10706, 43, 46.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10706, 59, 55.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10707, 55, 24.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10707, 57, 19.5000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10707, 70, 15.0000, 28, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10708, 5, 21.3500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10708, 36, 19.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10709, 8, 40.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10709, 51, 53.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10709, 60, 34.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10710, 19, 9.2000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10710, 47, 9.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10711, 19, 9.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10711, 41, 9.6500, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10711, 53, 32.8000, 120, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10712, 53, 32.8000, 3, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10712, 56, 38.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10713, 10, 31.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10713, 26, 31.2300, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10713, 45, 9.5000, 110, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10713, 46, 12.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10714, 2, 19.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10714, 17, 39.0000, 27, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10714, 47, 9.5000, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10714, 56, 38.0000, 18, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10714, 58, 13.2500, 12, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10715, 10, 31.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10715, 71, 21.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10716, 21, 10.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10716, 51, 53.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10716, 61, 28.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10717, 21, 10.0000, 32, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10717, 54, 7.4500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10717, 69, 36.0000, 25, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10718, 12, 38.0000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10718, 16, 17.4500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10718, 36, 19.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10718, 62, 49.3000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10719, 18, 62.5000, 12, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10719, 30, 25.8900, 3, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10719, 54, 7.4500, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10720, 35, 18.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10720, 71, 21.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10721, 44, 19.4500, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10722, 2, 19.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10722, 31, 12.5000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10722, 68, 12.5000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10722, 75, 7.7500, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10723, 26, 31.2300, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10724, 10, 31.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10724, 61, 28.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10725, 41, 9.6500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10725, 52, 7.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10725, 55, 24.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10726, 4, 22.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10726, 11, 21.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10727, 17, 39.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10727, 56, 38.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10727, 59, 55.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10728, 30, 25.8900, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10728, 40, 18.4000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10728, 55, 24.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10728, 60, 34.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10729, 1, 18.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10729, 21, 10.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10729, 50, 16.2500, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10730, 16, 17.4500, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10730, 31, 12.5000, 3, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10730, 65, 21.0500, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10731, 21, 10.0000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10731, 51, 53.0000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10732, 76, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10733, 14, 23.2500, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10733, 28, 45.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10733, 52, 7.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10734, 6, 25.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10734, 30, 25.8900, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10734, 76, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10735, 61, 28.5000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10735, 77, 13.0000, 2, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10736, 65, 21.0500, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10736, 75, 7.7500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10737, 13, 6.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10737, 41, 9.6500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10738, 16, 17.4500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10739, 36, 19.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10739, 52, 7.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10740, 28, 45.6000, 5, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10740, 35, 18.0000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10740, 45, 9.5000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10740, 56, 38.0000, 14, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10741, 2, 19.0000, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10742, 3, 10.0000, 20, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10742, 60, 34.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10742, 72, 34.8000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10743, 46, 12.0000, 28, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10744, 40, 18.4000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10745, 18, 62.5000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10745, 44, 19.4500, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10745, 59, 55.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10745, 72, 34.8000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10746, 13, 6.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10746, 42, 14.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10746, 62, 49.3000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10746, 69, 36.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10747, 31, 12.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10747, 41, 9.6500, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10747, 63, 43.9000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10747, 69, 36.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10748, 23, 9.0000, 44, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10748, 40, 18.4000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10748, 56, 38.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10749, 56, 38.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10749, 59, 55.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10749, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10750, 14, 23.2500, 5, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10750, 45, 9.5000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10750, 59, 55.0000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10751, 26, 31.2300, 12, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10751, 30, 25.8900, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10751, 50, 16.2500, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10751, 73, 15.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10752, 1, 18.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10752, 69, 36.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10753, 45, 9.5000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10753, 74, 10.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10754, 40, 18.4000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10755, 47, 9.5000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10755, 56, 38.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10755, 57, 19.5000, 14, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10755, 69, 36.0000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10756, 18, 62.5000, 21, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10756, 36, 19.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10756, 68, 12.5000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10756, 69, 36.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10757, 34, 14.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10757, 59, 55.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10757, 62, 49.3000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10757, 64, 33.2500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10758, 26, 31.2300, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10758, 52, 7.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10758, 70, 15.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10759, 32, 32.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10760, 25, 14.0000, 12, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10760, 27, 43.9000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10760, 43, 46.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10761, 25, 14.0000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10761, 75, 7.7500, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10762, 39, 18.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10762, 47, 9.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10762, 51, 53.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10762, 56, 38.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10763, 21, 10.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10763, 22, 21.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10763, 24, 4.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10764, 3, 10.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10764, 39, 18.0000, 130, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10765, 65, 21.0500, 80, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10766, 2, 19.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10766, 7, 30.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10766, 68, 12.5000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10767, 42, 14.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10768, 22, 21.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10768, 31, 12.5000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10768, 60, 34.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10768, 71, 21.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10769, 41, 9.6500, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10769, 52, 7.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10769, 61, 28.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10769, 62, 49.3000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10770, 11, 21.0000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10771, 71, 21.5000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10772, 29, 123.7900, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10772, 59, 55.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10773, 17, 39.0000, 33, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10773, 31, 12.5000, 70, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10773, 75, 7.7500, 7, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10774, 31, 12.5000, 2, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10774, 66, 17.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10775, 10, 31.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10775, 67, 14.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10776, 31, 12.5000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10776, 42, 14.0000, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10776, 45, 9.5000, 27, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10776, 51, 53.0000, 120, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10777, 42, 14.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10778, 41, 9.6500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10779, 16, 17.4500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10779, 62, 49.3000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10780, 70, 15.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10780, 77, 13.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10781, 54, 7.4500, 3, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10781, 56, 38.0000, 20, 0.2)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10781, 74, 10.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10782, 31, 12.5000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10783, 31, 12.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10783, 38, 263.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10784, 36, 19.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10784, 39, 18.0000, 2, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10784, 72, 34.8000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10785, 10, 31.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10785, 75, 7.7500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10786, 8, 40.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10786, 30, 25.8900, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10786, 75, 7.7500, 42, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10787, 2, 19.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10787, 29, 123.7900, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10788, 19, 9.2000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10788, 75, 7.7500, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10789, 18, 62.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10789, 35, 18.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10789, 63, 43.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10789, 68, 12.5000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10790, 7, 30.0000, 3, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10790, 56, 38.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10791, 29, 123.7900, 14, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10791, 41, 9.6500, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10792, 2, 19.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10792, 54, 7.4500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10792, 68, 12.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10793, 41, 9.6500, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10793, 52, 7.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10794, 14, 23.2500, 15, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10794, 54, 7.4500, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10795, 16, 17.4500, 65, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10795, 17, 39.0000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10796, 26, 31.2300, 21, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10796, 44, 19.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10796, 64, 33.2500, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10796, 69, 36.0000, 24, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10797, 11, 21.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10798, 62, 49.3000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10798, 72, 34.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10799, 13, 6.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10799, 24, 4.5000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10799, 59, 55.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10800, 11, 21.0000, 50, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10800, 51, 53.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10800, 54, 7.4500, 7, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10801, 17, 39.0000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10801, 29, 123.7900, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10802, 30, 25.8900, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10802, 51, 53.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10802, 55, 24.0000, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10802, 62, 49.3000, 5, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10803, 19, 9.2000, 24, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10803, 25, 14.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10803, 59, 55.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10804, 10, 31.0000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10804, 28, 45.6000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10804, 49, 20.0000, 4, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10805, 34, 14.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10805, 38, 263.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10806, 2, 19.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10806, 65, 21.0500, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10806, 74, 10.0000, 15, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10807, 40, 18.4000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10808, 56, 38.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10808, 76, 18.0000, 50, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10809, 52, 7.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10810, 13, 6.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10810, 25, 14.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10810, 70, 15.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10811, 19, 9.2000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10811, 23, 9.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10811, 40, 18.4000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10812, 31, 12.5000, 16, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10812, 72, 34.8000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10812, 77, 13.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10813, 2, 19.0000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10813, 46, 12.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10814, 41, 9.6500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10814, 43, 46.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10814, 48, 12.7500, 8, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10814, 61, 28.5000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10815, 33, 2.5000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10816, 38, 263.5000, 30, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10816, 62, 49.3000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10817, 26, 31.2300, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10817, 38, 263.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10817, 40, 18.4000, 60, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10817, 62, 49.3000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10818, 32, 32.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10818, 41, 9.6500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10819, 43, 46.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10819, 75, 7.7500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10820, 56, 38.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10821, 35, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10821, 51, 53.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10822, 62, 49.3000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10822, 70, 15.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10823, 11, 21.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10823, 57, 19.5000, 15, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10823, 59, 55.0000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10823, 77, 13.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10824, 41, 9.6500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10824, 70, 15.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10825, 26, 31.2300, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10825, 53, 32.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10826, 31, 12.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10826, 57, 19.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10827, 10, 31.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10827, 39, 18.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10828, 20, 81.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10828, 38, 263.5000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10829, 2, 19.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10829, 8, 40.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10829, 13, 6.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10829, 60, 34.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10830, 6, 25.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10830, 39, 18.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10830, 60, 34.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10830, 68, 12.5000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10831, 19, 9.2000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10831, 35, 18.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10831, 38, 263.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10831, 43, 46.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10832, 13, 6.0000, 3, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10832, 25, 14.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10832, 44, 19.4500, 16, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10832, 64, 33.2500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10833, 7, 30.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10833, 31, 12.5000, 9, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10833, 53, 32.8000, 9, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10834, 29, 123.7900, 8, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10834, 30, 25.8900, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10835, 59, 55.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10835, 77, 13.0000, 2, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10836, 22, 21.0000, 52, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10836, 35, 18.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10836, 57, 19.5000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10836, 60, 34.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10836, 64, 33.2500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10837, 13, 6.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10837, 40, 18.4000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10837, 47, 9.5000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10837, 76, 18.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10838, 1, 18.0000, 4, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10838, 18, 62.5000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10838, 36, 19.0000, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10839, 58, 13.2500, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10839, 72, 34.8000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10840, 25, 14.0000, 6, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10840, 39, 18.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10841, 10, 31.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10841, 56, 38.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10841, 59, 55.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10841, 77, 13.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10842, 11, 21.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10842, 43, 46.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10842, 68, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10842, 70, 15.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10843, 51, 53.0000, 4, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10844, 22, 21.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10845, 23, 9.0000, 70, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10845, 35, 18.0000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10845, 42, 14.0000, 42, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10845, 58, 13.2500, 60, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10845, 64, 33.2500, 48, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10846, 4, 22.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10846, 70, 15.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10846, 74, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 1, 18.0000, 80, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 19, 9.2000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 37, 26.0000, 60, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 45, 9.5000, 36, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 60, 34.0000, 45, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10847, 71, 21.5000, 55, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10848, 5, 21.3500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10848, 9, 97.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10849, 3, 10.0000, 49, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10849, 26, 31.2300, 18, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10850, 25, 14.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10850, 33, 2.5000, 4, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10850, 70, 15.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10851, 2, 19.0000, 5, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10851, 25, 14.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10851, 57, 19.5000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10851, 59, 55.0000, 42, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10852, 2, 19.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10852, 17, 39.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10852, 62, 49.3000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10853, 18, 62.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10854, 10, 31.0000, 100, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10854, 13, 6.0000, 65, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10855, 16, 17.4500, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10855, 31, 12.5000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10855, 56, 38.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10855, 65, 21.0500, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10856, 2, 19.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10856, 42, 14.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10857, 3, 10.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10857, 26, 31.2300, 35, 0.25)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10857, 29, 123.7900, 10, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10858, 7, 30.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10858, 27, 43.9000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10858, 70, 15.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10859, 24, 4.5000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10859, 54, 7.4500, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10859, 64, 33.2500, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10860, 51, 53.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10860, 76, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10861, 17, 39.0000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10861, 18, 62.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10861, 21, 10.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10861, 33, 2.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10861, 62, 49.3000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10862, 11, 21.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10862, 52, 7.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10863, 1, 18.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10863, 58, 13.2500, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10864, 35, 18.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10864, 67, 14.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10865, 38, 263.5000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10865, 39, 18.0000, 80, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10866, 2, 19.0000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10866, 24, 4.5000, 6, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10866, 30, 25.8900, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10867, 53, 32.8000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10868, 26, 31.2300, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10868, 35, 18.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10868, 49, 20.0000, 42, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10869, 1, 18.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10869, 11, 21.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10869, 23, 9.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10869, 68, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10870, 35, 18.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10870, 51, 53.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10871, 6, 25.0000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10871, 16, 17.4500, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10871, 17, 39.0000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10872, 55, 24.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10872, 62, 49.3000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10872, 64, 33.2500, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10872, 65, 21.0500, 21, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10873, 21, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10873, 28, 45.6000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10874, 10, 31.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10875, 19, 9.2000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10875, 47, 9.5000, 21, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10875, 49, 20.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10876, 46, 12.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10876, 64, 33.2500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10877, 16, 17.4500, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10877, 18, 62.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10878, 20, 81.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10879, 40, 18.4000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10879, 65, 21.0500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10879, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10880, 23, 9.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10880, 61, 28.5000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10880, 70, 15.0000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10881, 73, 15.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10882, 42, 14.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10882, 49, 20.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10882, 54, 7.4500, 32, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10883, 24, 4.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10884, 21, 10.0000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10884, 56, 38.0000, 21, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10884, 65, 21.0500, 12, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10885, 2, 19.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10885, 24, 4.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10885, 70, 15.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10885, 77, 13.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10886, 10, 31.0000, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10886, 31, 12.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10886, 77, 13.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10887, 25, 14.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10888, 2, 19.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10888, 68, 12.5000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10889, 11, 21.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10889, 38, 263.5000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10890, 17, 39.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10890, 34, 14.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10890, 41, 9.6500, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10891, 30, 25.8900, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10892, 59, 55.0000, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10893, 8, 40.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10893, 24, 4.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10893, 29, 123.7900, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10893, 30, 25.8900, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10893, 36, 19.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10894, 13, 6.0000, 28, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10894, 69, 36.0000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10894, 75, 7.7500, 120, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10895, 24, 4.5000, 110, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10895, 39, 18.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10895, 40, 18.4000, 91, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10895, 60, 34.0000, 100, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10896, 45, 9.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10896, 56, 38.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10897, 29, 123.7900, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10897, 30, 25.8900, 36, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10898, 13, 6.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10899, 39, 18.0000, 8, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10900, 70, 15.0000, 3, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10901, 41, 9.6500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10901, 71, 21.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10902, 55, 24.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10902, 62, 49.3000, 6, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10903, 13, 6.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10903, 65, 21.0500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10903, 68, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10904, 58, 13.2500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10904, 62, 49.3000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10905, 1, 18.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10906, 61, 28.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10907, 75, 7.7500, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10908, 7, 30.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10908, 52, 7.0000, 14, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10909, 7, 30.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10909, 16, 17.4500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10909, 41, 9.6500, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10910, 19, 9.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10910, 49, 20.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10910, 61, 28.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10911, 1, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10911, 17, 39.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10911, 67, 14.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10912, 11, 21.0000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10912, 29, 123.7900, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10913, 4, 22.0000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10913, 33, 2.5000, 40, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10913, 58, 13.2500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10914, 71, 21.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10915, 17, 39.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10915, 33, 2.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10915, 54, 7.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10916, 16, 17.4500, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10916, 32, 32.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10916, 57, 19.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10917, 30, 25.8900, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10917, 60, 34.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10918, 1, 18.0000, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10918, 60, 34.0000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10919, 16, 17.4500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10919, 25, 14.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10919, 40, 18.4000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10920, 50, 16.2500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10921, 35, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10921, 63, 43.9000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10922, 17, 39.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10922, 24, 4.5000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10923, 42, 14.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10923, 43, 46.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10923, 67, 14.0000, 24, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10924, 10, 31.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10924, 28, 45.6000, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10924, 75, 7.7500, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10925, 36, 19.0000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10925, 52, 7.0000, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10926, 11, 21.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10926, 13, 6.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10926, 19, 9.2000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10926, 72, 34.8000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10927, 20, 81.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10927, 52, 7.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10927, 76, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10928, 47, 9.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10928, 76, 18.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10929, 21, 10.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10929, 75, 7.7500, 49, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10929, 77, 13.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10930, 21, 10.0000, 36, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10930, 27, 43.9000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10930, 55, 24.0000, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10930, 58, 13.2500, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10931, 13, 6.0000, 42, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10931, 57, 19.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10932, 16, 17.4500, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10932, 62, 49.3000, 14, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10932, 72, 34.8000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10932, 75, 7.7500, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10933, 53, 32.8000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10933, 61, 28.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10934, 6, 25.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10935, 1, 18.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10935, 18, 62.5000, 4, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10935, 23, 9.0000, 8, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10936, 36, 19.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10937, 28, 45.6000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10937, 34, 14.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10938, 13, 6.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10938, 43, 46.0000, 24, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10938, 60, 34.0000, 49, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10938, 71, 21.5000, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10939, 2, 19.0000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10939, 67, 14.0000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10940, 7, 30.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10940, 13, 6.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10941, 31, 12.5000, 44, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10941, 62, 49.3000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10941, 68, 12.5000, 80, 0.25)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10941, 72, 34.8000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10942, 49, 20.0000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10943, 13, 6.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10943, 22, 21.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10943, 46, 12.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10944, 11, 21.0000, 5, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10944, 44, 19.4500, 18, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10944, 56, 38.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10945, 13, 6.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10945, 31, 12.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10946, 10, 31.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10946, 24, 4.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10946, 77, 13.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10947, 59, 55.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10948, 50, 16.2500, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10948, 51, 53.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10948, 55, 24.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10949, 6, 25.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10949, 10, 31.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10949, 17, 39.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10949, 62, 49.3000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10950, 4, 22.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10951, 33, 2.5000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10951, 41, 9.6500, 6, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10951, 75, 7.7500, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10952, 6, 25.0000, 16, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10952, 28, 45.6000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10953, 20, 81.0000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10953, 31, 12.5000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10954, 16, 17.4500, 28, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10954, 31, 12.5000, 25, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10954, 45, 9.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10954, 60, 34.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10955, 75, 7.7500, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10956, 21, 10.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10956, 47, 9.5000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10956, 51, 53.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10957, 30, 25.8900, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10957, 35, 18.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10957, 64, 33.2500, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10958, 5, 21.3500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10958, 7, 30.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10958, 72, 34.8000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10959, 75, 7.7500, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10960, 24, 4.5000, 10, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10960, 41, 9.6500, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10961, 52, 7.0000, 6, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10961, 76, 18.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10962, 7, 30.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10962, 13, 6.0000, 77, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10962, 53, 32.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10962, 69, 36.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10962, 76, 18.0000, 44, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10963, 60, 34.0000, 2, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10964, 18, 62.5000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10964, 38, 263.5000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10964, 69, 36.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10965, 51, 53.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10966, 37, 26.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10966, 56, 38.0000, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10966, 62, 49.3000, 12, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10967, 19, 9.2000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10967, 49, 20.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10968, 12, 38.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10968, 24, 4.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10968, 64, 33.2500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10969, 46, 12.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10970, 52, 7.0000, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10971, 29, 123.7900, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10972, 17, 39.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10972, 33, 2.5000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10973, 26, 31.2300, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10973, 41, 9.6500, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10973, 75, 7.7500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10974, 63, 43.9000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10975, 8, 40.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10975, 75, 7.7500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10976, 28, 45.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10977, 39, 18.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10977, 47, 9.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10977, 51, 53.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10977, 63, 43.9000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10978, 8, 40.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10978, 21, 10.0000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10978, 40, 18.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10978, 44, 19.4500, 6, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 7, 30.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 12, 38.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 24, 4.5000, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 27, 43.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 31, 12.5000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10979, 63, 43.9000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10980, 75, 7.7500, 40, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10981, 38, 263.5000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10982, 7, 30.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10982, 43, 46.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10983, 13, 6.0000, 84, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10983, 57, 19.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10984, 16, 17.4500, 55, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10984, 24, 4.5000, 20, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10984, 36, 19.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10985, 16, 17.4500, 36, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10985, 18, 62.5000, 8, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10985, 32, 32.0000, 35, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10986, 11, 21.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10986, 20, 81.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10986, 76, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10986, 77, 13.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10987, 7, 30.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10987, 43, 46.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10987, 72, 34.8000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10988, 7, 30.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10988, 62, 49.3000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10989, 6, 25.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10989, 11, 21.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10989, 41, 9.6500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10990, 21, 10.0000, 65, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10990, 34, 14.0000, 60, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10990, 55, 24.0000, 65, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10990, 61, 28.5000, 66, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10991, 2, 19.0000, 50, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10991, 70, 15.0000, 20, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10991, 76, 18.0000, 90, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10992, 72, 34.8000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10993, 29, 123.7900, 50, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10993, 41, 9.6500, 35, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10994, 59, 55.0000, 18, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10995, 51, 53.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10995, 60, 34.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10996, 42, 14.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10997, 32, 32.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10997, 46, 12.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10997, 52, 7.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10998, 24, 4.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10998, 61, 28.5000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10998, 74, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10998, 75, 7.7500, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10999, 41, 9.6500, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10999, 51, 53.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (10999, 77, 13.0000, 21, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11000, 4, 22.0000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11000, 24, 4.5000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11000, 77, 13.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11001, 7, 30.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11001, 22, 21.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11001, 46, 12.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11001, 55, 24.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11002, 13, 6.0000, 56, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11002, 35, 18.0000, 15, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11002, 42, 14.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11002, 55, 24.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11003, 1, 18.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11003, 40, 18.4000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11003, 52, 7.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11004, 26, 31.2300, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11004, 76, 18.0000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11005, 1, 18.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11005, 59, 55.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11006, 1, 18.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11006, 29, 123.7900, 2, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11007, 8, 40.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11007, 29, 123.7900, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11007, 42, 14.0000, 14, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11008, 28, 45.6000, 70, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11008, 34, 14.0000, 90, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11008, 71, 21.5000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11009, 24, 4.5000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11009, 36, 19.0000, 18, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11009, 60, 34.0000, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11010, 7, 30.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11010, 24, 4.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11011, 58, 13.2500, 40, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11011, 71, 21.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11012, 19, 9.2000, 50, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11012, 60, 34.0000, 36, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11012, 71, 21.5000, 60, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11013, 23, 9.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11013, 42, 14.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11013, 45, 9.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11013, 68, 12.5000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11014, 41, 9.6500, 28, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11015, 30, 25.8900, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11015, 77, 13.0000, 18, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11016, 31, 12.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11016, 36, 19.0000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11017, 3, 10.0000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11017, 59, 55.0000, 110, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11017, 70, 15.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11018, 12, 38.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11018, 18, 62.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11018, 56, 38.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11019, 46, 12.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11019, 49, 20.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11020, 10, 31.0000, 24, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11021, 2, 19.0000, 11, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11021, 20, 81.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11021, 26, 31.2300, 63, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11021, 51, 53.0000, 44, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11021, 72, 34.8000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11022, 19, 9.2000, 35, 0)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11022, 69, 36.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11023, 7, 30.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11023, 43, 46.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11024, 26, 31.2300, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11024, 33, 2.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11024, 65, 21.0500, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11024, 71, 21.5000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11025, 1, 18.0000, 10, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11025, 13, 6.0000, 20, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11026, 18, 62.5000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11026, 51, 53.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11027, 24, 4.5000, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11027, 62, 49.3000, 21, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11028, 55, 24.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11028, 59, 55.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11029, 56, 38.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11029, 63, 43.9000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11030, 2, 19.0000, 100, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11030, 5, 21.3500, 70, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11030, 29, 123.7900, 60, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11030, 59, 55.0000, 100, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11031, 1, 18.0000, 45, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11031, 13, 6.0000, 80, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11031, 24, 4.5000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11031, 64, 33.2500, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11031, 71, 21.5000, 16, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11032, 36, 19.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11032, 38, 263.5000, 25, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11032, 59, 55.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11033, 53, 32.8000, 70, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11033, 69, 36.0000, 36, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11034, 21, 10.0000, 15, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11034, 44, 19.4500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11034, 61, 28.5000, 6, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11035, 1, 18.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11035, 35, 18.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11035, 42, 14.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11035, 54, 7.4500, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11036, 13, 6.0000, 7, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11036, 59, 55.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11037, 70, 15.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11038, 40, 18.4000, 5, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11038, 52, 7.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11038, 71, 21.5000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11039, 28, 45.6000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11039, 35, 18.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11039, 49, 20.0000, 60, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11039, 57, 19.5000, 28, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11040, 21, 10.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11041, 2, 19.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11041, 63, 43.9000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11042, 44, 19.4500, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11042, 61, 28.5000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11043, 11, 21.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11044, 62, 49.3000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11045, 33, 2.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11045, 51, 53.0000, 24, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11046, 12, 38.0000, 20, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11046, 32, 32.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11046, 35, 18.0000, 18, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11047, 1, 18.0000, 25, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11047, 5, 21.3500, 30, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11048, 68, 12.5000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11049, 2, 19.0000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11049, 12, 38.0000, 4, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11050, 76, 18.0000, 50, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11051, 24, 4.5000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11052, 43, 46.0000, 30, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11052, 61, 28.5000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11053, 18, 62.5000, 35, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11053, 32, 32.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11053, 64, 33.2500, 25, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11054, 33, 2.5000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11054, 67, 14.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11055, 24, 4.5000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11055, 25, 14.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11055, 51, 53.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11055, 57, 19.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11056, 7, 30.0000, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11056, 55, 24.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11056, 60, 34.0000, 50, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11057, 70, 15.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11058, 21, 10.0000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11058, 60, 34.0000, 21, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11058, 61, 28.5000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11059, 13, 6.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11059, 17, 39.0000, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11059, 60, 34.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11060, 60, 34.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11060, 77, 13.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11061, 60, 34.0000, 15, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11062, 53, 32.8000, 10, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11062, 70, 15.0000, 12, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11063, 34, 14.0000, 30, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11063, 40, 18.4000, 40, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11063, 41, 9.6500, 30, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11064, 17, 39.0000, 77, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11064, 41, 9.6500, 12, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11064, 53, 32.8000, 25, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11064, 55, 24.0000, 4, 0.1)
GO
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11064, 68, 12.5000, 55, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11065, 30, 25.8900, 4, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11065, 54, 7.4500, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11066, 16, 17.4500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11066, 19, 9.2000, 42, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11066, 34, 14.0000, 35, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11067, 41, 9.6500, 9, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11068, 28, 45.6000, 8, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11068, 43, 46.0000, 36, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11068, 77, 13.0000, 28, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11069, 39, 18.0000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11070, 1, 18.0000, 40, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11070, 2, 19.0000, 20, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11070, 16, 17.4500, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11070, 31, 12.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11071, 7, 30.0000, 15, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11071, 13, 6.0000, 10, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11072, 2, 19.0000, 8, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11072, 41, 9.6500, 40, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11072, 50, 16.2500, 22, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11072, 64, 33.2500, 130, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11073, 11, 21.0000, 10, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11073, 24, 4.5000, 20, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11074, 16, 17.4500, 14, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11075, 2, 19.0000, 10, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11075, 46, 12.0000, 30, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11075, 76, 18.0000, 2, 0.15)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11076, 6, 25.0000, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11076, 14, 23.2500, 20, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11076, 19, 9.2000, 10, 0.25)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 2, 19.0000, 24, 0.2)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 3, 10.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 4, 22.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 6, 25.0000, 1, 0.02)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 7, 30.0000, 1, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 8, 40.0000, 2, 0.1)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 10, 31.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 12, 38.0000, 2, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 13, 6.0000, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 14, 23.2500, 1, 0.03)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 16, 17.4500, 2, 0.03)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 20, 81.0000, 1, 0.04)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 23, 9.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 32, 32.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 39, 18.0000, 2, 0.05)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 41, 9.6500, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 46, 12.0000, 3, 0.02)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 52, 7.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 55, 24.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 60, 34.0000, 2, 0.06)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 64, 33.2500, 2, 0.03)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 66, 17.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 73, 15.0000, 2, 0.01)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 75, 7.7500, 4, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11077, 77, 13.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11078, 1, 18.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11079, 12, 38.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11079, 21, 10.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11079, 39, 18.0000, 5, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11079, 48, 12.7500, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11079, 51, 53.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11080, 24, 4.5000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11080, 74, 10.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11081, 12, 38.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11081, 37, 26.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11081, 57, 19.5000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11082, 27, 43.9000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11082, 40, 18.4000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11083, 45, 9.5000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11083, 46, 12.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11083, 52, 7.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11083, 60, 34.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11084, 28, 45.6000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11084, 43, 46.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11084, 72, 34.8000, 3, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11085, 2, 19.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11085, 4, 22.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11085, 9, 97.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11086, 9, 97.0000, 2, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11086, 34, 14.0000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11086, 63, 43.9000, 1, 0)
INSERT [dbo].[Detalles] ([IdPedido], [IdProducto], [PrecioUnidad], [Cantidad], [Descuento]) VALUES (11086, 72, 34.8000, 1, 0)
SET IDENTITY_INSERT [dbo].[Empleados] ON 

INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (1, N'Davolio', N'Luisa', N'Representante de ventas', CAST(N'1992-05-01T00:00:00' AS SmallDateTime), N'507 - 20th Ave. E.
Apt. 2A', N'Seattle', N'EE.UU.', N'(206) 555-9857')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (2, N'Fuller', N'Andrew', N'Vicepresidente comercial', CAST(N'1992-08-14T00:00:00' AS SmallDateTime), N'908 W. Capital Way', N'Tacoma', N'EE.UU.', N'(206) 555-9482')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (3, N'Leverling', N'Janet', N'Representante de ventas', CAST(N'1992-04-01T00:00:00' AS SmallDateTime), N'722 Moss Bay Blvd.', N'Kirkland', N'EE.UU.', N'(206) 555-3412')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (4, N'Peacock', N'Margaret', N'Representante de ventas', CAST(N'1993-05-03T00:00:00' AS SmallDateTime), N'4110 Old Redmond Rd.', N'Redmond', N'EE.UU.', N'(206) 555-8122')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (5, N'Buchanan', N'Steven', N'Gerente de ventas', CAST(N'1993-10-17T00:00:00' AS SmallDateTime), N'14 Garrett Hill', N'Londres', N'Reino Unido', N'(71) 555-4848')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (6, N'Suyama', N'Michael', N'Representante de ventas', CAST(N'1993-10-17T00:00:00' AS SmallDateTime), N'Coventry House
Miner Rd.', N'Londres', N'Reino Unido', N'(71) 555-7773')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (7, N'King', N'Robert', N'Representante de ventas', CAST(N'1994-01-02T00:00:00' AS SmallDateTime), N'Edgeham Hollow
Winchester Way', N'Londres', N'Reino Unido', N'(71) 555-5598')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (8, N'Callahan', N'Laura', N'Coordinador ventas interno', CAST(N'1994-03-05T00:00:00' AS SmallDateTime), N'4726 - 11th Ave. N.E.', N'Seattle', N'EE.UU.', N'(206) 555-1189')
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [FechaContratación], [Dirección], [Ciudad], [País], [TelDomicilio]) VALUES (9, N'Dodsworth', N'Anne', N'Representante de ventas', CAST(N'1994-11-15T00:00:00' AS SmallDateTime), N'7 Houndstooth Rd.', N'Londres', N'Reino Unido', N'(71) 555-4444')
SET IDENTITY_INSERT [dbo].[Empleados] OFF
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10248, N'WILMK', 5, CAST(N'1996-07-04T00:00:00' AS SmallDateTime), CAST(N'1996-08-01T00:00:00' AS SmallDateTime), CAST(N'1996-07-16T00:00:00' AS SmallDateTime), 3, 32.3800, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', 350.0000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10249, N'TOMSP', 6, CAST(N'1996-07-05T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), CAST(N'1996-07-10T00:00:00' AS SmallDateTime), 1, 11.6100, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10250, N'HANAR', 4, CAST(N'1996-07-08T00:00:00' AS SmallDateTime), CAST(N'1996-08-05T00:00:00' AS SmallDateTime), CAST(N'1996-07-12T00:00:00' AS SmallDateTime), 2, 65.8300, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10251, N'VICTE', 3, CAST(N'1996-07-08T00:00:00' AS SmallDateTime), CAST(N'1996-08-05T00:00:00' AS SmallDateTime), CAST(N'1996-07-15T00:00:00' AS SmallDateTime), 1, 41.3400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10252, N'SUPRD', 4, CAST(N'1996-07-09T00:00:00' AS SmallDateTime), CAST(N'1996-08-06T00:00:00' AS SmallDateTime), CAST(N'1996-07-11T00:00:00' AS SmallDateTime), 2, 51.3000, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10253, N'HANAR', 3, CAST(N'1996-07-10T00:00:00' AS SmallDateTime), CAST(N'1996-07-24T00:00:00' AS SmallDateTime), CAST(N'1996-07-16T00:00:00' AS SmallDateTime), 2, 58.1700, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10254, N'CHOPS', 5, CAST(N'1996-07-11T00:00:00' AS SmallDateTime), CAST(N'1996-08-08T00:00:00' AS SmallDateTime), CAST(N'1996-07-23T00:00:00' AS SmallDateTime), 2, 22.9800, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10255, N'RICSU', 9, CAST(N'1996-07-12T00:00:00' AS SmallDateTime), CAST(N'1996-08-09T00:00:00' AS SmallDateTime), CAST(N'1996-07-15T00:00:00' AS SmallDateTime), 3, 148.3300, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10256, N'WELLI', 3, CAST(N'1996-07-15T00:00:00' AS SmallDateTime), CAST(N'1996-08-12T00:00:00' AS SmallDateTime), CAST(N'1996-07-17T00:00:00' AS SmallDateTime), 2, 13.9700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10257, N'HILAA', 4, CAST(N'1996-07-16T00:00:00' AS SmallDateTime), CAST(N'1996-08-13T00:00:00' AS SmallDateTime), CAST(N'1996-07-22T00:00:00' AS SmallDateTime), 3, 81.9100, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10258, N'ERNSH', 1, CAST(N'1996-07-17T00:00:00' AS SmallDateTime), CAST(N'1996-08-14T00:00:00' AS SmallDateTime), CAST(N'1996-07-23T00:00:00' AS SmallDateTime), 1, 140.5100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10259, N'CENTC', 4, CAST(N'1996-07-18T00:00:00' AS SmallDateTime), CAST(N'1996-08-15T00:00:00' AS SmallDateTime), CAST(N'1996-07-25T00:00:00' AS SmallDateTime), 3, 3.2500, N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'México D.F.', NULL, N'05022', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10260, N'OTTIK', 4, CAST(N'1996-07-19T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), CAST(N'1996-07-29T00:00:00' AS SmallDateTime), 1, 55.0900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10261, N'QUEDE', 4, CAST(N'1996-07-19T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), CAST(N'1996-07-30T00:00:00' AS SmallDateTime), 2, 3.0500, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10262, N'RATTC', 8, CAST(N'1996-07-22T00:00:00' AS SmallDateTime), CAST(N'1996-08-19T00:00:00' AS SmallDateTime), CAST(N'1996-07-25T00:00:00' AS SmallDateTime), 3, 48.2900, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10263, N'ERNSH', 9, CAST(N'1996-07-23T00:00:00' AS SmallDateTime), CAST(N'1996-08-20T00:00:00' AS SmallDateTime), CAST(N'1996-07-31T00:00:00' AS SmallDateTime), 3, 146.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10264, N'FOLKO', 6, CAST(N'1996-07-24T00:00:00' AS SmallDateTime), CAST(N'1996-08-21T00:00:00' AS SmallDateTime), CAST(N'1996-08-23T00:00:00' AS SmallDateTime), 3, 3.6700, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10265, N'BLONP', 2, CAST(N'1996-07-25T00:00:00' AS SmallDateTime), CAST(N'1996-08-22T00:00:00' AS SmallDateTime), CAST(N'1996-08-12T00:00:00' AS SmallDateTime), 1, 55.2800, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10266, N'WARTH', 3, CAST(N'1996-07-26T00:00:00' AS SmallDateTime), CAST(N'1996-09-06T00:00:00' AS SmallDateTime), CAST(N'1996-07-31T00:00:00' AS SmallDateTime), 3, 25.7300, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10267, N'FRANK', 4, CAST(N'1996-07-29T00:00:00' AS SmallDateTime), CAST(N'1996-08-26T00:00:00' AS SmallDateTime), CAST(N'1996-08-06T00:00:00' AS SmallDateTime), 1, 208.5800, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10268, N'GROSR', 8, CAST(N'1996-07-30T00:00:00' AS SmallDateTime), CAST(N'1996-08-27T00:00:00' AS SmallDateTime), CAST(N'1996-08-02T00:00:00' AS SmallDateTime), 3, 66.2900, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10269, N'WHITC', 5, CAST(N'1996-07-31T00:00:00' AS SmallDateTime), CAST(N'1996-08-14T00:00:00' AS SmallDateTime), CAST(N'1996-08-09T00:00:00' AS SmallDateTime), 1, 4.5600, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10270, N'WARTH', 1, CAST(N'1996-08-01T00:00:00' AS SmallDateTime), CAST(N'1996-08-29T00:00:00' AS SmallDateTime), CAST(N'1996-08-02T00:00:00' AS SmallDateTime), 1, 136.5400, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10271, N'SPLIR', 6, CAST(N'1996-08-01T00:00:00' AS SmallDateTime), CAST(N'1996-08-29T00:00:00' AS SmallDateTime), CAST(N'1996-08-30T00:00:00' AS SmallDateTime), 2, 4.5400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10272, N'RATTC', 6, CAST(N'1996-08-02T00:00:00' AS SmallDateTime), CAST(N'1996-08-30T00:00:00' AS SmallDateTime), CAST(N'1996-08-06T00:00:00' AS SmallDateTime), 2, 98.0300, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10273, N'QUICK', 3, CAST(N'1996-08-05T00:00:00' AS SmallDateTime), CAST(N'1996-09-02T00:00:00' AS SmallDateTime), CAST(N'1996-08-12T00:00:00' AS SmallDateTime), 3, 76.0700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10274, N'VINET', 6, CAST(N'1996-08-06T00:00:00' AS SmallDateTime), CAST(N'1996-09-03T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), 1, 6.0100, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10275, N'MAGAA', 1, CAST(N'1996-08-07T00:00:00' AS SmallDateTime), CAST(N'1996-09-04T00:00:00' AS SmallDateTime), CAST(N'1996-08-09T00:00:00' AS SmallDateTime), 1, 26.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10276, N'TORTU', 8, CAST(N'1996-08-08T00:00:00' AS SmallDateTime), CAST(N'1996-08-22T00:00:00' AS SmallDateTime), CAST(N'1996-08-14T00:00:00' AS SmallDateTime), 3, 13.8400, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10277, N'MORGK', 2, CAST(N'1996-08-09T00:00:00' AS SmallDateTime), CAST(N'1996-09-06T00:00:00' AS SmallDateTime), CAST(N'1996-08-13T00:00:00' AS SmallDateTime), 3, 125.7700, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10278, N'BERGS', 8, CAST(N'1996-08-12T00:00:00' AS SmallDateTime), CAST(N'1996-09-09T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), 2, 92.6900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10279, N'LEHMS', 8, CAST(N'1996-08-13T00:00:00' AS SmallDateTime), CAST(N'1996-09-10T00:00:00' AS SmallDateTime), CAST(N'1996-08-16T00:00:00' AS SmallDateTime), 2, 25.8300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10280, N'BERGS', 2, CAST(N'1996-08-14T00:00:00' AS SmallDateTime), CAST(N'1996-09-11T00:00:00' AS SmallDateTime), CAST(N'1996-09-12T00:00:00' AS SmallDateTime), 1, 8.9800, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10281, N'ROMEY', 4, CAST(N'1996-08-14T00:00:00' AS SmallDateTime), CAST(N'1996-08-28T00:00:00' AS SmallDateTime), CAST(N'1996-08-21T00:00:00' AS SmallDateTime), 1, 2.9400, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10282, N'ROMEY', 4, CAST(N'1996-08-15T00:00:00' AS SmallDateTime), CAST(N'1996-09-12T00:00:00' AS SmallDateTime), CAST(N'1996-08-21T00:00:00' AS SmallDateTime), 1, 12.6900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10283, N'LILAS', 3, CAST(N'1996-08-16T00:00:00' AS SmallDateTime), CAST(N'1996-09-13T00:00:00' AS SmallDateTime), CAST(N'1996-08-23T00:00:00' AS SmallDateTime), 3, 84.8100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10284, N'LEHMS', 4, CAST(N'1996-08-19T00:00:00' AS SmallDateTime), CAST(N'1996-09-16T00:00:00' AS SmallDateTime), CAST(N'1996-08-27T00:00:00' AS SmallDateTime), 1, 76.5600, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10285, N'QUICK', 1, CAST(N'1996-08-20T00:00:00' AS SmallDateTime), CAST(N'1996-09-17T00:00:00' AS SmallDateTime), CAST(N'1996-08-26T00:00:00' AS SmallDateTime), 2, 76.8300, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10286, N'QUICK', 8, CAST(N'1996-08-21T00:00:00' AS SmallDateTime), CAST(N'1996-09-18T00:00:00' AS SmallDateTime), CAST(N'1996-08-30T00:00:00' AS SmallDateTime), 3, 229.2400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10287, N'RICAR', 8, CAST(N'1996-08-22T00:00:00' AS SmallDateTime), CAST(N'1996-09-19T00:00:00' AS SmallDateTime), CAST(N'1996-08-28T00:00:00' AS SmallDateTime), 3, 12.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10288, N'REGGC', 4, CAST(N'1996-08-23T00:00:00' AS SmallDateTime), CAST(N'1996-09-20T00:00:00' AS SmallDateTime), CAST(N'1996-09-03T00:00:00' AS SmallDateTime), 1, 7.4500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10289, N'BSBEV', 7, CAST(N'1996-08-26T00:00:00' AS SmallDateTime), CAST(N'1996-09-23T00:00:00' AS SmallDateTime), CAST(N'1996-08-28T00:00:00' AS SmallDateTime), 3, 22.7700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10290, N'COMMI', 8, CAST(N'1996-08-27T00:00:00' AS SmallDateTime), CAST(N'1996-09-24T00:00:00' AS SmallDateTime), CAST(N'1996-09-03T00:00:00' AS SmallDateTime), 1, 79.7000, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'SP', N'05432-043', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10291, N'QUEDE', 6, CAST(N'1996-08-27T00:00:00' AS SmallDateTime), CAST(N'1996-09-24T00:00:00' AS SmallDateTime), CAST(N'1996-09-04T00:00:00' AS SmallDateTime), 2, 6.4000, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10292, N'TRADH', 1, CAST(N'1996-08-28T00:00:00' AS SmallDateTime), CAST(N'1996-09-25T00:00:00' AS SmallDateTime), CAST(N'1996-09-02T00:00:00' AS SmallDateTime), 2, 1.3500, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10293, N'TORTU', 1, CAST(N'1996-08-29T00:00:00' AS SmallDateTime), CAST(N'1996-09-26T00:00:00' AS SmallDateTime), CAST(N'1996-09-11T00:00:00' AS SmallDateTime), 3, 21.1800, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10294, N'RATTC', 4, CAST(N'1996-08-30T00:00:00' AS SmallDateTime), CAST(N'1996-09-27T00:00:00' AS SmallDateTime), CAST(N'1996-09-05T00:00:00' AS SmallDateTime), 2, 147.2600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10295, N'VINET', 2, CAST(N'1996-09-02T00:00:00' AS SmallDateTime), CAST(N'1996-09-30T00:00:00' AS SmallDateTime), CAST(N'1996-09-10T00:00:00' AS SmallDateTime), 2, 1.1500, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10296, N'LILAS', 6, CAST(N'1996-09-03T00:00:00' AS SmallDateTime), CAST(N'1996-10-01T00:00:00' AS SmallDateTime), CAST(N'1996-09-11T00:00:00' AS SmallDateTime), 1, 0.1200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10297, N'BLONP', 5, CAST(N'1996-09-04T00:00:00' AS SmallDateTime), CAST(N'1996-10-16T00:00:00' AS SmallDateTime), CAST(N'1996-09-10T00:00:00' AS SmallDateTime), 2, 5.7400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10298, N'HUNGO', 6, CAST(N'1996-09-05T00:00:00' AS SmallDateTime), CAST(N'1996-10-03T00:00:00' AS SmallDateTime), CAST(N'1996-09-11T00:00:00' AS SmallDateTime), 2, 168.2200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10299, N'RICAR', 4, CAST(N'1996-09-06T00:00:00' AS SmallDateTime), CAST(N'1996-10-04T00:00:00' AS SmallDateTime), CAST(N'1996-09-13T00:00:00' AS SmallDateTime), 2, 29.7600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10300, N'MAGAA', 2, CAST(N'1996-09-09T00:00:00' AS SmallDateTime), CAST(N'1996-10-07T00:00:00' AS SmallDateTime), CAST(N'1996-09-18T00:00:00' AS SmallDateTime), 2, 17.6800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10301, N'WANDK', 8, CAST(N'1996-09-09T00:00:00' AS SmallDateTime), CAST(N'1996-10-07T00:00:00' AS SmallDateTime), CAST(N'1996-09-17T00:00:00' AS SmallDateTime), 2, 45.0800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10302, N'SUPRD', 4, CAST(N'1996-09-10T00:00:00' AS SmallDateTime), CAST(N'1996-10-08T00:00:00' AS SmallDateTime), CAST(N'1996-10-09T00:00:00' AS SmallDateTime), 2, 6.2700, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10303, N'GODOS', 7, CAST(N'1996-09-11T00:00:00' AS SmallDateTime), CAST(N'1996-10-09T00:00:00' AS SmallDateTime), CAST(N'1996-09-18T00:00:00' AS SmallDateTime), 2, 107.8300, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10304, N'TORTU', 1, CAST(N'1996-09-12T00:00:00' AS SmallDateTime), CAST(N'1996-10-10T00:00:00' AS SmallDateTime), CAST(N'1996-09-17T00:00:00' AS SmallDateTime), 2, 63.7900, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10305, N'OLDWO', 8, CAST(N'1996-09-13T00:00:00' AS SmallDateTime), CAST(N'1996-10-11T00:00:00' AS SmallDateTime), CAST(N'1996-10-09T00:00:00' AS SmallDateTime), 3, 257.6200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10306, N'ROMEY', 1, CAST(N'1996-09-16T00:00:00' AS SmallDateTime), CAST(N'1996-10-14T00:00:00' AS SmallDateTime), CAST(N'1996-09-23T00:00:00' AS SmallDateTime), 3, 7.5600, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10307, N'LONEP', 2, CAST(N'1996-09-17T00:00:00' AS SmallDateTime), CAST(N'1996-10-15T00:00:00' AS SmallDateTime), CAST(N'1996-09-25T00:00:00' AS SmallDateTime), 2, 0.5600, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10308, N'ANATR', 7, CAST(N'1996-09-18T00:00:00' AS SmallDateTime), CAST(N'1996-10-16T00:00:00' AS SmallDateTime), CAST(N'1996-09-24T00:00:00' AS SmallDateTime), 3, 1.6100, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10309, N'HUNGO', 3, CAST(N'1996-09-19T00:00:00' AS SmallDateTime), CAST(N'1996-10-17T00:00:00' AS SmallDateTime), CAST(N'1996-10-23T00:00:00' AS SmallDateTime), 1, 47.3000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10310, N'THEBI', 8, CAST(N'1996-09-20T00:00:00' AS SmallDateTime), CAST(N'1996-10-18T00:00:00' AS SmallDateTime), CAST(N'1996-09-27T00:00:00' AS SmallDateTime), 2, 17.5200, N'The Big Cheese', N'89 Jefferson Way
Suite 2', N'Portland', N'OR', N'97201', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10311, N'DUMON', 1, CAST(N'1996-09-20T00:00:00' AS SmallDateTime), CAST(N'1996-10-04T00:00:00' AS SmallDateTime), CAST(N'1996-09-26T00:00:00' AS SmallDateTime), 3, 24.6900, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10312, N'WANDK', 2, CAST(N'1996-09-23T00:00:00' AS SmallDateTime), CAST(N'1996-10-21T00:00:00' AS SmallDateTime), CAST(N'1996-10-03T00:00:00' AS SmallDateTime), 2, 40.2600, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10313, N'QUICK', 2, CAST(N'1996-09-24T00:00:00' AS SmallDateTime), CAST(N'1996-10-22T00:00:00' AS SmallDateTime), CAST(N'1996-10-04T00:00:00' AS SmallDateTime), 2, 1.9600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10314, N'RATTC', 1, CAST(N'1996-09-25T00:00:00' AS SmallDateTime), CAST(N'1996-10-23T00:00:00' AS SmallDateTime), CAST(N'1996-10-04T00:00:00' AS SmallDateTime), 2, 74.1600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10315, N'ISLAT', 4, CAST(N'1996-09-26T00:00:00' AS SmallDateTime), CAST(N'1996-10-24T00:00:00' AS SmallDateTime), CAST(N'1996-10-03T00:00:00' AS SmallDateTime), 2, 41.7600, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10316, N'RATTC', 1, CAST(N'1996-09-27T00:00:00' AS SmallDateTime), CAST(N'1996-10-25T00:00:00' AS SmallDateTime), CAST(N'1996-10-08T00:00:00' AS SmallDateTime), 3, 150.1500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10317, N'LONEP', 6, CAST(N'1996-09-30T00:00:00' AS SmallDateTime), CAST(N'1996-10-28T00:00:00' AS SmallDateTime), CAST(N'1996-10-10T00:00:00' AS SmallDateTime), 1, 12.6900, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10318, N'ISLAT', 8, CAST(N'1996-10-01T00:00:00' AS SmallDateTime), CAST(N'1996-10-29T00:00:00' AS SmallDateTime), CAST(N'1996-10-04T00:00:00' AS SmallDateTime), 2, 4.7300, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10319, N'TORTU', 7, CAST(N'1996-10-02T00:00:00' AS SmallDateTime), CAST(N'1996-10-30T00:00:00' AS SmallDateTime), CAST(N'1996-10-11T00:00:00' AS SmallDateTime), 3, 64.5000, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10320, N'WARTH', 5, CAST(N'1996-10-03T00:00:00' AS SmallDateTime), CAST(N'1996-10-17T00:00:00' AS SmallDateTime), CAST(N'1996-10-18T00:00:00' AS SmallDateTime), 3, 34.5700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10321, N'ISLAT', 3, CAST(N'1996-10-03T00:00:00' AS SmallDateTime), CAST(N'1996-10-31T00:00:00' AS SmallDateTime), CAST(N'1996-10-11T00:00:00' AS SmallDateTime), 2, 3.4300, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10322, N'PERIC', 7, CAST(N'1996-10-04T00:00:00' AS SmallDateTime), CAST(N'1996-11-01T00:00:00' AS SmallDateTime), CAST(N'1996-10-23T00:00:00' AS SmallDateTime), 3, 0.4000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10323, N'KOENE', 4, CAST(N'1996-10-07T00:00:00' AS SmallDateTime), CAST(N'1996-11-04T00:00:00' AS SmallDateTime), CAST(N'1996-10-14T00:00:00' AS SmallDateTime), 1, 4.8800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10324, N'SAVEA', 9, CAST(N'1996-10-08T00:00:00' AS SmallDateTime), CAST(N'1996-11-05T00:00:00' AS SmallDateTime), CAST(N'1996-10-10T00:00:00' AS SmallDateTime), 1, 214.2700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10325, N'KOENE', 1, CAST(N'1996-10-09T00:00:00' AS SmallDateTime), CAST(N'1996-10-23T00:00:00' AS SmallDateTime), CAST(N'1996-10-14T00:00:00' AS SmallDateTime), 3, 64.8600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10326, N'BOLID', 4, CAST(N'1996-10-10T00:00:00' AS SmallDateTime), CAST(N'1996-11-07T00:00:00' AS SmallDateTime), CAST(N'1996-10-14T00:00:00' AS SmallDateTime), 2, 77.9200, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10327, N'FOLKO', 2, CAST(N'1996-10-11T00:00:00' AS SmallDateTime), CAST(N'1996-11-08T00:00:00' AS SmallDateTime), CAST(N'1996-10-14T00:00:00' AS SmallDateTime), 1, 63.3600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10328, N'FURIB', 4, CAST(N'1996-10-14T00:00:00' AS SmallDateTime), CAST(N'1996-11-11T00:00:00' AS SmallDateTime), CAST(N'1996-10-17T00:00:00' AS SmallDateTime), 3, 87.0300, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10329, N'SPLIR', 4, CAST(N'1996-10-15T00:00:00' AS SmallDateTime), CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1996-10-23T00:00:00' AS SmallDateTime), 2, 191.6700, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10330, N'LILAS', 3, CAST(N'1996-10-16T00:00:00' AS SmallDateTime), CAST(N'1996-11-13T00:00:00' AS SmallDateTime), CAST(N'1996-10-28T00:00:00' AS SmallDateTime), 1, 12.7500, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10331, N'BONAP', 9, CAST(N'1996-10-16T00:00:00' AS SmallDateTime), CAST(N'1996-11-27T00:00:00' AS SmallDateTime), CAST(N'1996-10-21T00:00:00' AS SmallDateTime), 1, 10.1900, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10332, N'MEREP', 3, CAST(N'1996-10-17T00:00:00' AS SmallDateTime), CAST(N'1996-11-28T00:00:00' AS SmallDateTime), CAST(N'1996-10-21T00:00:00' AS SmallDateTime), 2, 52.8400, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10333, N'WARTH', 5, CAST(N'1996-10-18T00:00:00' AS SmallDateTime), CAST(N'1996-11-15T00:00:00' AS SmallDateTime), CAST(N'1996-10-25T00:00:00' AS SmallDateTime), 3, 0.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10334, N'VICTE', 8, CAST(N'1996-10-21T00:00:00' AS SmallDateTime), CAST(N'1996-11-18T00:00:00' AS SmallDateTime), CAST(N'1996-10-28T00:00:00' AS SmallDateTime), 2, 8.5600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10335, N'HUNGO', 7, CAST(N'1996-10-22T00:00:00' AS SmallDateTime), CAST(N'1996-11-19T00:00:00' AS SmallDateTime), CAST(N'1996-10-24T00:00:00' AS SmallDateTime), 2, 42.1100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10336, N'PRINI', 7, CAST(N'1996-10-23T00:00:00' AS SmallDateTime), CAST(N'1996-11-20T00:00:00' AS SmallDateTime), CAST(N'1996-10-25T00:00:00' AS SmallDateTime), 2, 15.5100, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10337, N'FRANK', 4, CAST(N'1996-10-24T00:00:00' AS SmallDateTime), CAST(N'1996-11-21T00:00:00' AS SmallDateTime), CAST(N'1996-10-29T00:00:00' AS SmallDateTime), 3, 108.2600, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10338, N'OLDWO', 4, CAST(N'1996-10-25T00:00:00' AS SmallDateTime), CAST(N'1996-11-22T00:00:00' AS SmallDateTime), CAST(N'1996-10-29T00:00:00' AS SmallDateTime), 3, 84.2100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10339, N'MEREP', 2, CAST(N'1996-10-28T00:00:00' AS SmallDateTime), CAST(N'1996-11-25T00:00:00' AS SmallDateTime), CAST(N'1996-11-04T00:00:00' AS SmallDateTime), 2, 15.6600, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10340, N'BONAP', 1, CAST(N'1996-10-29T00:00:00' AS SmallDateTime), CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1996-11-08T00:00:00' AS SmallDateTime), 3, 166.3100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10341, N'SIMOB', 7, CAST(N'1996-10-29T00:00:00' AS SmallDateTime), CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1996-11-05T00:00:00' AS SmallDateTime), 3, 26.7800, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10342, N'FRANK', 4, CAST(N'1996-10-30T00:00:00' AS SmallDateTime), CAST(N'1996-11-13T00:00:00' AS SmallDateTime), CAST(N'1996-11-04T00:00:00' AS SmallDateTime), 2, 54.8300, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10343, N'LEHMS', 4, CAST(N'1996-10-31T00:00:00' AS SmallDateTime), CAST(N'1996-11-28T00:00:00' AS SmallDateTime), CAST(N'1996-11-06T00:00:00' AS SmallDateTime), 1, 110.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10344, N'WHITC', 4, CAST(N'1996-11-01T00:00:00' AS SmallDateTime), CAST(N'1996-11-29T00:00:00' AS SmallDateTime), CAST(N'1996-11-05T00:00:00' AS SmallDateTime), 2, 23.2900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10345, N'QUICK', 2, CAST(N'1996-11-04T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), CAST(N'1996-11-11T00:00:00' AS SmallDateTime), 2, 249.0600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10346, N'RATTC', 3, CAST(N'1996-11-05T00:00:00' AS SmallDateTime), CAST(N'1996-12-17T00:00:00' AS SmallDateTime), CAST(N'1996-11-08T00:00:00' AS SmallDateTime), 3, 142.0800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10347, N'FAMIA', 4, CAST(N'1996-11-06T00:00:00' AS SmallDateTime), CAST(N'1996-12-04T00:00:00' AS SmallDateTime), CAST(N'1996-11-08T00:00:00' AS SmallDateTime), 3, 3.1000, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10348, N'WANDK', 4, CAST(N'1996-11-07T00:00:00' AS SmallDateTime), CAST(N'1996-12-05T00:00:00' AS SmallDateTime), CAST(N'1996-11-15T00:00:00' AS SmallDateTime), 2, 0.7800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10349, N'SPLIR', 7, CAST(N'1996-11-08T00:00:00' AS SmallDateTime), CAST(N'1996-12-06T00:00:00' AS SmallDateTime), CAST(N'1996-11-15T00:00:00' AS SmallDateTime), 1, 8.6300, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10350, N'LAMAI', 6, CAST(N'1996-11-11T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), CAST(N'1996-12-03T00:00:00' AS SmallDateTime), 2, 64.1900, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10351, N'ERNSH', 1, CAST(N'1996-11-11T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), CAST(N'1996-11-20T00:00:00' AS SmallDateTime), 1, 162.3300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10352, N'FURIB', 3, CAST(N'1996-11-12T00:00:00' AS SmallDateTime), CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1996-11-18T00:00:00' AS SmallDateTime), 3, 1.3000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10353, N'PICCO', 7, CAST(N'1996-11-13T00:00:00' AS SmallDateTime), CAST(N'1996-12-11T00:00:00' AS SmallDateTime), CAST(N'1996-11-25T00:00:00' AS SmallDateTime), 3, 360.6300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10354, N'PERIC', 8, CAST(N'1996-11-14T00:00:00' AS SmallDateTime), CAST(N'1996-12-12T00:00:00' AS SmallDateTime), CAST(N'1996-11-20T00:00:00' AS SmallDateTime), 3, 53.8000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10355, N'AROUT', 6, CAST(N'1996-11-15T00:00:00' AS SmallDateTime), CAST(N'1996-12-13T00:00:00' AS SmallDateTime), CAST(N'1996-11-20T00:00:00' AS SmallDateTime), 1, 41.9500, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10356, N'WANDK', 6, CAST(N'1996-11-18T00:00:00' AS SmallDateTime), CAST(N'1996-12-16T00:00:00' AS SmallDateTime), CAST(N'1996-11-27T00:00:00' AS SmallDateTime), 2, 36.7100, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10357, N'LILAS', 1, CAST(N'1996-11-19T00:00:00' AS SmallDateTime), CAST(N'1996-12-17T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), 3, 34.8800, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10358, N'LAMAI', 5, CAST(N'1996-11-20T00:00:00' AS SmallDateTime), CAST(N'1996-12-18T00:00:00' AS SmallDateTime), CAST(N'1996-11-27T00:00:00' AS SmallDateTime), 1, 19.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10359, N'SEVES', 5, CAST(N'1996-11-21T00:00:00' AS SmallDateTime), CAST(N'1996-12-19T00:00:00' AS SmallDateTime), CAST(N'1996-11-26T00:00:00' AS SmallDateTime), 3, 288.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10360, N'BLONP', 4, CAST(N'1996-11-22T00:00:00' AS SmallDateTime), CAST(N'1996-12-20T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), 3, 131.7000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10361, N'QUICK', 1, CAST(N'1996-11-22T00:00:00' AS SmallDateTime), CAST(N'1996-12-20T00:00:00' AS SmallDateTime), CAST(N'1996-12-03T00:00:00' AS SmallDateTime), 2, 183.1700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10362, N'BONAP', 3, CAST(N'1996-11-25T00:00:00' AS SmallDateTime), CAST(N'1996-12-23T00:00:00' AS SmallDateTime), CAST(N'1996-11-28T00:00:00' AS SmallDateTime), 1, 96.0400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10363, N'DRACD', 4, CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1996-12-24T00:00:00' AS SmallDateTime), CAST(N'1996-12-04T00:00:00' AS SmallDateTime), 3, 30.5400, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10364, N'EASTC', 1, CAST(N'1996-11-26T00:00:00' AS SmallDateTime), CAST(N'1997-01-07T00:00:00' AS SmallDateTime), CAST(N'1996-12-04T00:00:00' AS SmallDateTime), 1, 71.9700, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10365, N'ANTON', 3, CAST(N'1996-11-27T00:00:00' AS SmallDateTime), CAST(N'1996-12-25T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), 2, 22.0000, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10366, N'GALED', 8, CAST(N'1996-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-01-09T00:00:00' AS SmallDateTime), CAST(N'1996-12-30T00:00:00' AS SmallDateTime), 2, 10.1400, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10367, N'VAFFE', 7, CAST(N'1996-11-28T00:00:00' AS SmallDateTime), CAST(N'1996-12-26T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), 3, 13.5500, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10368, N'ERNSH', 2, CAST(N'1996-11-29T00:00:00' AS SmallDateTime), CAST(N'1996-12-27T00:00:00' AS SmallDateTime), CAST(N'1996-12-02T00:00:00' AS SmallDateTime), 2, 101.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10369, N'SPLIR', 8, CAST(N'1996-12-02T00:00:00' AS SmallDateTime), CAST(N'1996-12-30T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), 2, 195.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10370, N'CHOPS', 6, CAST(N'1996-12-03T00:00:00' AS SmallDateTime), CAST(N'1996-12-31T00:00:00' AS SmallDateTime), CAST(N'1996-12-27T00:00:00' AS SmallDateTime), 2, 1.1700, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10371, N'LAMAI', 1, CAST(N'1996-12-03T00:00:00' AS SmallDateTime), CAST(N'1996-12-31T00:00:00' AS SmallDateTime), CAST(N'1996-12-24T00:00:00' AS SmallDateTime), 1, 0.4500, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10372, N'QUEEN', 5, CAST(N'1996-12-04T00:00:00' AS SmallDateTime), CAST(N'1997-01-01T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), 2, 890.7800, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10373, N'HUNGO', 4, CAST(N'1996-12-05T00:00:00' AS SmallDateTime), CAST(N'1997-01-02T00:00:00' AS SmallDateTime), CAST(N'1996-12-11T00:00:00' AS SmallDateTime), 3, 124.1200, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10374, N'WOLZA', 1, CAST(N'1996-12-05T00:00:00' AS SmallDateTime), CAST(N'1997-01-02T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), 3, 3.9400, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10375, N'HUNGC', 3, CAST(N'1996-12-06T00:00:00' AS SmallDateTime), CAST(N'1997-01-03T00:00:00' AS SmallDateTime), CAST(N'1996-12-09T00:00:00' AS SmallDateTime), 2, 20.1200, N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'OR', N'97827', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10376, N'MEREP', 1, CAST(N'1996-12-09T00:00:00' AS SmallDateTime), CAST(N'1997-01-06T00:00:00' AS SmallDateTime), CAST(N'1996-12-13T00:00:00' AS SmallDateTime), 2, 20.3900, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10377, N'SEVES', 1, CAST(N'1996-12-09T00:00:00' AS SmallDateTime), CAST(N'1997-01-06T00:00:00' AS SmallDateTime), CAST(N'1996-12-13T00:00:00' AS SmallDateTime), 3, 22.2100, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10378, N'FOLKO', 5, CAST(N'1996-12-10T00:00:00' AS SmallDateTime), CAST(N'1997-01-07T00:00:00' AS SmallDateTime), CAST(N'1996-12-19T00:00:00' AS SmallDateTime), 3, 5.4400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10379, N'QUEDE', 2, CAST(N'1996-12-11T00:00:00' AS SmallDateTime), CAST(N'1997-01-08T00:00:00' AS SmallDateTime), CAST(N'1996-12-13T00:00:00' AS SmallDateTime), 1, 45.0300, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10380, N'HUNGO', 8, CAST(N'1996-12-12T00:00:00' AS SmallDateTime), CAST(N'1997-01-09T00:00:00' AS SmallDateTime), CAST(N'1997-01-16T00:00:00' AS SmallDateTime), 3, 35.0300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10381, N'LILAS', 3, CAST(N'1996-12-12T00:00:00' AS SmallDateTime), CAST(N'1997-01-09T00:00:00' AS SmallDateTime), CAST(N'1996-12-13T00:00:00' AS SmallDateTime), 3, 7.9900, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10382, N'ERNSH', 4, CAST(N'1996-12-13T00:00:00' AS SmallDateTime), CAST(N'1997-01-10T00:00:00' AS SmallDateTime), CAST(N'1996-12-16T00:00:00' AS SmallDateTime), 1, 94.7700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10383, N'AROUT', 8, CAST(N'1996-12-16T00:00:00' AS SmallDateTime), CAST(N'1997-01-13T00:00:00' AS SmallDateTime), CAST(N'1996-12-18T00:00:00' AS SmallDateTime), 3, 34.2400, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10384, N'BERGS', 3, CAST(N'1996-12-16T00:00:00' AS SmallDateTime), CAST(N'1997-01-13T00:00:00' AS SmallDateTime), CAST(N'1996-12-20T00:00:00' AS SmallDateTime), 3, 168.6400, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10385, N'SPLIR', 1, CAST(N'1996-12-17T00:00:00' AS SmallDateTime), CAST(N'1997-01-14T00:00:00' AS SmallDateTime), CAST(N'1996-12-23T00:00:00' AS SmallDateTime), 2, 30.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10386, N'FAMIA', 9, CAST(N'1996-12-18T00:00:00' AS SmallDateTime), CAST(N'1997-01-01T00:00:00' AS SmallDateTime), CAST(N'1996-12-25T00:00:00' AS SmallDateTime), 3, 13.9900, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10387, N'SANTG', 1, CAST(N'1996-12-18T00:00:00' AS SmallDateTime), CAST(N'1997-01-15T00:00:00' AS SmallDateTime), CAST(N'1996-12-20T00:00:00' AS SmallDateTime), 2, 93.6300, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10388, N'SEVES', 2, CAST(N'1996-12-19T00:00:00' AS SmallDateTime), CAST(N'1997-01-16T00:00:00' AS SmallDateTime), CAST(N'1996-12-20T00:00:00' AS SmallDateTime), 1, 34.8600, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10389, N'BOTTM', 4, CAST(N'1996-12-20T00:00:00' AS SmallDateTime), CAST(N'1997-01-17T00:00:00' AS SmallDateTime), CAST(N'1996-12-24T00:00:00' AS SmallDateTime), 2, 47.4200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10390, N'ERNSH', 6, CAST(N'1996-12-23T00:00:00' AS SmallDateTime), CAST(N'1997-01-20T00:00:00' AS SmallDateTime), CAST(N'1996-12-26T00:00:00' AS SmallDateTime), 1, 126.3800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10391, N'DRACD', 3, CAST(N'1996-12-23T00:00:00' AS SmallDateTime), CAST(N'1997-01-20T00:00:00' AS SmallDateTime), CAST(N'1996-12-31T00:00:00' AS SmallDateTime), 3, 5.4500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10392, N'PICCO', 2, CAST(N'1996-12-24T00:00:00' AS SmallDateTime), CAST(N'1997-01-21T00:00:00' AS SmallDateTime), CAST(N'1997-01-01T00:00:00' AS SmallDateTime), 3, 122.4600, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10393, N'SAVEA', 1, CAST(N'1996-12-25T00:00:00' AS SmallDateTime), CAST(N'1997-01-22T00:00:00' AS SmallDateTime), CAST(N'1997-01-03T00:00:00' AS SmallDateTime), 3, 126.5600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10394, N'HUNGC', 1, CAST(N'1996-12-25T00:00:00' AS SmallDateTime), CAST(N'1997-01-22T00:00:00' AS SmallDateTime), CAST(N'1997-01-03T00:00:00' AS SmallDateTime), 3, 30.3400, N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'OR', N'97827', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10395, N'HILAA', 6, CAST(N'1996-12-26T00:00:00' AS SmallDateTime), CAST(N'1997-01-23T00:00:00' AS SmallDateTime), CAST(N'1997-01-03T00:00:00' AS SmallDateTime), 1, 184.4100, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10396, N'FRANK', 1, CAST(N'1996-12-27T00:00:00' AS SmallDateTime), CAST(N'1997-01-10T00:00:00' AS SmallDateTime), CAST(N'1997-01-06T00:00:00' AS SmallDateTime), 3, 135.3500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10397, N'PRINI', 5, CAST(N'1996-12-27T00:00:00' AS SmallDateTime), CAST(N'1997-01-24T00:00:00' AS SmallDateTime), CAST(N'1997-01-02T00:00:00' AS SmallDateTime), 1, 60.2600, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10398, N'SAVEA', 2, CAST(N'1996-12-30T00:00:00' AS SmallDateTime), CAST(N'1997-01-27T00:00:00' AS SmallDateTime), CAST(N'1997-01-09T00:00:00' AS SmallDateTime), 3, 89.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10399, N'VAFFE', 8, CAST(N'1996-12-31T00:00:00' AS SmallDateTime), CAST(N'1997-01-14T00:00:00' AS SmallDateTime), CAST(N'1997-01-08T00:00:00' AS SmallDateTime), 3, 27.3600, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10400, N'EASTC', 1, CAST(N'1997-01-01T00:00:00' AS SmallDateTime), CAST(N'1997-01-29T00:00:00' AS SmallDateTime), CAST(N'1997-01-16T00:00:00' AS SmallDateTime), 3, 83.9300, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10401, N'RATTC', 1, CAST(N'1997-01-01T00:00:00' AS SmallDateTime), CAST(N'1997-01-29T00:00:00' AS SmallDateTime), CAST(N'1997-01-10T00:00:00' AS SmallDateTime), 1, 12.5100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10402, N'ERNSH', 8, CAST(N'1997-01-02T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-01-10T00:00:00' AS SmallDateTime), 2, 67.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10403, N'ERNSH', 4, CAST(N'1997-01-03T00:00:00' AS SmallDateTime), CAST(N'1997-01-31T00:00:00' AS SmallDateTime), CAST(N'1997-01-09T00:00:00' AS SmallDateTime), 3, 73.7900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10404, N'MAGAA', 2, CAST(N'1997-01-03T00:00:00' AS SmallDateTime), CAST(N'1997-01-31T00:00:00' AS SmallDateTime), CAST(N'1997-01-08T00:00:00' AS SmallDateTime), 1, 155.9700, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10405, N'LINOD', 1, CAST(N'1997-01-06T00:00:00' AS SmallDateTime), CAST(N'1997-02-03T00:00:00' AS SmallDateTime), CAST(N'1997-01-22T00:00:00' AS SmallDateTime), 1, 34.8200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10406, N'QUEEN', 7, CAST(N'1997-01-07T00:00:00' AS SmallDateTime), CAST(N'1997-02-18T00:00:00' AS SmallDateTime), CAST(N'1997-01-13T00:00:00' AS SmallDateTime), 1, 108.0400, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10407, N'OTTIK', 2, CAST(N'1997-01-07T00:00:00' AS SmallDateTime), CAST(N'1997-02-04T00:00:00' AS SmallDateTime), CAST(N'1997-01-30T00:00:00' AS SmallDateTime), 2, 91.4800, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10408, N'FOLIG', 8, CAST(N'1997-01-08T00:00:00' AS SmallDateTime), CAST(N'1997-02-05T00:00:00' AS SmallDateTime), CAST(N'1997-01-14T00:00:00' AS SmallDateTime), 1, 11.2600, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10409, N'OCEAN', 3, CAST(N'1997-01-09T00:00:00' AS SmallDateTime), CAST(N'1997-02-06T00:00:00' AS SmallDateTime), CAST(N'1997-01-14T00:00:00' AS SmallDateTime), 1, 29.8300, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10410, N'BOTTM', 3, CAST(N'1997-01-10T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), CAST(N'1997-01-15T00:00:00' AS SmallDateTime), 3, 2.4000, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10411, N'BOTTM', 9, CAST(N'1997-01-10T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), CAST(N'1997-01-21T00:00:00' AS SmallDateTime), 3, 23.6500, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10412, N'WARTH', 8, CAST(N'1997-01-13T00:00:00' AS SmallDateTime), CAST(N'1997-02-10T00:00:00' AS SmallDateTime), CAST(N'1997-01-15T00:00:00' AS SmallDateTime), 2, 3.7700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10413, N'LAMAI', 3, CAST(N'1997-01-14T00:00:00' AS SmallDateTime), CAST(N'1997-02-11T00:00:00' AS SmallDateTime), CAST(N'1997-01-16T00:00:00' AS SmallDateTime), 2, 95.6600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10414, N'FAMIA', 2, CAST(N'1997-01-14T00:00:00' AS SmallDateTime), CAST(N'1997-02-11T00:00:00' AS SmallDateTime), CAST(N'1997-01-17T00:00:00' AS SmallDateTime), 3, 21.4800, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10415, N'HUNGC', 3, CAST(N'1997-01-15T00:00:00' AS SmallDateTime), CAST(N'1997-02-12T00:00:00' AS SmallDateTime), CAST(N'1997-01-24T00:00:00' AS SmallDateTime), 1, 0.2000, N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'OR', N'97827', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10416, N'WARTH', 8, CAST(N'1997-01-16T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-01-27T00:00:00' AS SmallDateTime), 3, 22.7200, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10417, N'SIMOB', 4, CAST(N'1997-01-16T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-01-28T00:00:00' AS SmallDateTime), 3, 70.2900, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10418, N'QUICK', 4, CAST(N'1997-01-17T00:00:00' AS SmallDateTime), CAST(N'1997-02-14T00:00:00' AS SmallDateTime), CAST(N'1997-01-24T00:00:00' AS SmallDateTime), 1, 17.5500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10419, N'RICSU', 4, CAST(N'1997-01-20T00:00:00' AS SmallDateTime), CAST(N'1997-02-17T00:00:00' AS SmallDateTime), CAST(N'1997-01-30T00:00:00' AS SmallDateTime), 2, 137.3500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10420, N'WELLI', 3, CAST(N'1997-01-21T00:00:00' AS SmallDateTime), CAST(N'1997-02-18T00:00:00' AS SmallDateTime), CAST(N'1997-01-27T00:00:00' AS SmallDateTime), 1, 44.1200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10421, N'QUEDE', 8, CAST(N'1997-01-21T00:00:00' AS SmallDateTime), CAST(N'1997-03-04T00:00:00' AS SmallDateTime), CAST(N'1997-01-27T00:00:00' AS SmallDateTime), 1, 99.2300, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10422, N'FRANS', 2, CAST(N'1997-01-22T00:00:00' AS SmallDateTime), CAST(N'1997-02-19T00:00:00' AS SmallDateTime), CAST(N'1997-01-31T00:00:00' AS SmallDateTime), 1, 3.0200, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10423, N'GOURL', 6, CAST(N'1997-01-23T00:00:00' AS SmallDateTime), CAST(N'1997-02-06T00:00:00' AS SmallDateTime), CAST(N'1997-02-24T00:00:00' AS SmallDateTime), 3, 24.5000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10424, N'MEREP', 7, CAST(N'1997-01-23T00:00:00' AS SmallDateTime), CAST(N'1997-02-20T00:00:00' AS SmallDateTime), CAST(N'1997-01-27T00:00:00' AS SmallDateTime), 2, 370.6100, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10425, N'LAMAI', 6, CAST(N'1997-01-24T00:00:00' AS SmallDateTime), CAST(N'1997-02-21T00:00:00' AS SmallDateTime), CAST(N'1997-02-14T00:00:00' AS SmallDateTime), 2, 7.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10426, N'GALED', 4, CAST(N'1997-01-27T00:00:00' AS SmallDateTime), CAST(N'1997-02-24T00:00:00' AS SmallDateTime), CAST(N'1997-02-06T00:00:00' AS SmallDateTime), 1, 18.6900, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10427, N'PICCO', 4, CAST(N'1997-01-27T00:00:00' AS SmallDateTime), CAST(N'1997-02-24T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), 2, 31.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10428, N'REGGC', 7, CAST(N'1997-01-28T00:00:00' AS SmallDateTime), CAST(N'1997-02-25T00:00:00' AS SmallDateTime), CAST(N'1997-02-04T00:00:00' AS SmallDateTime), 1, 11.0900, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10429, N'HUNGO', 3, CAST(N'1997-01-29T00:00:00' AS SmallDateTime), CAST(N'1997-03-12T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), 2, 56.6300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10430, N'ERNSH', 4, CAST(N'1997-01-30T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-02-03T00:00:00' AS SmallDateTime), 1, 458.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10431, N'BOTTM', 4, CAST(N'1997-01-30T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), 2, 44.1700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10432, N'SPLIR', 3, CAST(N'1997-01-31T00:00:00' AS SmallDateTime), CAST(N'1997-02-14T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), 2, 4.3400, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10433, N'PRINI', 3, CAST(N'1997-02-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-04T00:00:00' AS SmallDateTime), 3, 73.8300, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10434, N'FOLKO', 3, CAST(N'1997-02-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), CAST(N'1997-02-13T00:00:00' AS SmallDateTime), 2, 17.9200, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10435, N'CONSH', 8, CAST(N'1997-02-04T00:00:00' AS SmallDateTime), CAST(N'1997-03-18T00:00:00' AS SmallDateTime), CAST(N'1997-02-07T00:00:00' AS SmallDateTime), 2, 9.2100, N'Consolidated Holdings', N'Berkeley Gardens
12  Brewery ', N'London', NULL, N'WX1 6LT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10436, N'BLONP', 3, CAST(N'1997-02-05T00:00:00' AS SmallDateTime), CAST(N'1997-03-05T00:00:00' AS SmallDateTime), CAST(N'1997-02-11T00:00:00' AS SmallDateTime), 2, 156.6600, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10437, N'WARTH', 8, CAST(N'1997-02-05T00:00:00' AS SmallDateTime), CAST(N'1997-03-05T00:00:00' AS SmallDateTime), CAST(N'1997-02-12T00:00:00' AS SmallDateTime), 1, 19.9700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10438, N'TOMSP', 3, CAST(N'1997-02-06T00:00:00' AS SmallDateTime), CAST(N'1997-03-06T00:00:00' AS SmallDateTime), CAST(N'1997-02-14T00:00:00' AS SmallDateTime), 2, 8.2400, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10439, N'MEREP', 6, CAST(N'1997-02-07T00:00:00' AS SmallDateTime), CAST(N'1997-03-07T00:00:00' AS SmallDateTime), CAST(N'1997-02-10T00:00:00' AS SmallDateTime), 3, 4.0700, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10440, N'SAVEA', 4, CAST(N'1997-02-10T00:00:00' AS SmallDateTime), CAST(N'1997-03-10T00:00:00' AS SmallDateTime), CAST(N'1997-02-28T00:00:00' AS SmallDateTime), 2, 86.5300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10441, N'OLDWO', 3, CAST(N'1997-02-10T00:00:00' AS SmallDateTime), CAST(N'1997-03-24T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), 2, 73.0200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10442, N'ERNSH', 3, CAST(N'1997-02-11T00:00:00' AS SmallDateTime), CAST(N'1997-03-11T00:00:00' AS SmallDateTime), CAST(N'1997-02-18T00:00:00' AS SmallDateTime), 2, 47.9400, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10443, N'REGGC', 8, CAST(N'1997-02-12T00:00:00' AS SmallDateTime), CAST(N'1997-03-12T00:00:00' AS SmallDateTime), CAST(N'1997-02-14T00:00:00' AS SmallDateTime), 1, 13.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10444, N'BERGS', 3, CAST(N'1997-02-12T00:00:00' AS SmallDateTime), CAST(N'1997-03-12T00:00:00' AS SmallDateTime), CAST(N'1997-02-21T00:00:00' AS SmallDateTime), 3, 3.5000, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10445, N'BERGS', 3, CAST(N'1997-02-13T00:00:00' AS SmallDateTime), CAST(N'1997-03-13T00:00:00' AS SmallDateTime), CAST(N'1997-02-20T00:00:00' AS SmallDateTime), 1, 9.3000, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10446, N'TOMSP', 6, CAST(N'1997-02-14T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), CAST(N'1997-02-19T00:00:00' AS SmallDateTime), 1, 14.6800, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10447, N'RICAR', 4, CAST(N'1997-02-14T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), CAST(N'1997-03-07T00:00:00' AS SmallDateTime), 2, 68.6600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10448, N'RANCH', 4, CAST(N'1997-02-17T00:00:00' AS SmallDateTime), CAST(N'1997-03-17T00:00:00' AS SmallDateTime), CAST(N'1997-02-24T00:00:00' AS SmallDateTime), 2, 38.8200, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10449, N'BLONP', 3, CAST(N'1997-02-18T00:00:00' AS SmallDateTime), CAST(N'1997-03-18T00:00:00' AS SmallDateTime), CAST(N'1997-02-27T00:00:00' AS SmallDateTime), 2, 53.3000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10450, N'VICTE', 8, CAST(N'1997-02-19T00:00:00' AS SmallDateTime), CAST(N'1997-03-19T00:00:00' AS SmallDateTime), CAST(N'1997-03-11T00:00:00' AS SmallDateTime), 2, 7.2300, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10451, N'QUICK', 4, CAST(N'1997-02-19T00:00:00' AS SmallDateTime), CAST(N'1997-03-05T00:00:00' AS SmallDateTime), CAST(N'1997-03-12T00:00:00' AS SmallDateTime), 3, 189.0900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10452, N'SAVEA', 8, CAST(N'1997-02-20T00:00:00' AS SmallDateTime), CAST(N'1997-03-20T00:00:00' AS SmallDateTime), CAST(N'1997-02-26T00:00:00' AS SmallDateTime), 1, 140.2600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10453, N'AROUT', 1, CAST(N'1997-02-21T00:00:00' AS SmallDateTime), CAST(N'1997-03-21T00:00:00' AS SmallDateTime), CAST(N'1997-02-26T00:00:00' AS SmallDateTime), 2, 25.3600, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10454, N'LAMAI', 4, CAST(N'1997-02-21T00:00:00' AS SmallDateTime), CAST(N'1997-03-21T00:00:00' AS SmallDateTime), CAST(N'1997-02-25T00:00:00' AS SmallDateTime), 3, 2.7400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10455, N'WARTH', 8, CAST(N'1997-02-24T00:00:00' AS SmallDateTime), CAST(N'1997-04-07T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), 2, 180.4500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10456, N'KOENE', 8, CAST(N'1997-02-25T00:00:00' AS SmallDateTime), CAST(N'1997-04-08T00:00:00' AS SmallDateTime), CAST(N'1997-02-28T00:00:00' AS SmallDateTime), 2, 8.1200, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10457, N'KOENE', 2, CAST(N'1997-02-25T00:00:00' AS SmallDateTime), CAST(N'1997-03-25T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), 1, 11.5700, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10458, N'SUPRD', 7, CAST(N'1997-02-26T00:00:00' AS SmallDateTime), CAST(N'1997-03-26T00:00:00' AS SmallDateTime), CAST(N'1997-03-04T00:00:00' AS SmallDateTime), 3, 147.0600, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10459, N'VICTE', 4, CAST(N'1997-02-27T00:00:00' AS SmallDateTime), CAST(N'1997-03-27T00:00:00' AS SmallDateTime), CAST(N'1997-02-28T00:00:00' AS SmallDateTime), 2, 25.0900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10460, N'FOLKO', 8, CAST(N'1997-02-28T00:00:00' AS SmallDateTime), CAST(N'1997-03-28T00:00:00' AS SmallDateTime), CAST(N'1997-03-03T00:00:00' AS SmallDateTime), 1, 16.2700, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10461, N'LILAS', 1, CAST(N'1997-02-28T00:00:00' AS SmallDateTime), CAST(N'1997-03-28T00:00:00' AS SmallDateTime), CAST(N'1997-03-05T00:00:00' AS SmallDateTime), 3, 148.6100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10462, N'CONSH', 2, CAST(N'1997-03-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-31T00:00:00' AS SmallDateTime), CAST(N'1997-03-18T00:00:00' AS SmallDateTime), 1, 6.1700, N'Consolidated Holdings', N'Berkeley Gardens
12  Brewery ', N'London', NULL, N'WX1 6LT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10463, N'SUPRD', 5, CAST(N'1997-03-04T00:00:00' AS SmallDateTime), CAST(N'1997-04-01T00:00:00' AS SmallDateTime), CAST(N'1997-03-06T00:00:00' AS SmallDateTime), 3, 14.7800, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10464, N'FURIB', 4, CAST(N'1997-03-04T00:00:00' AS SmallDateTime), CAST(N'1997-04-01T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), 2, 89.0000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10465, N'VAFFE', 1, CAST(N'1997-03-05T00:00:00' AS SmallDateTime), CAST(N'1997-04-02T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), 3, 145.0400, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10466, N'COMMI', 4, CAST(N'1997-03-06T00:00:00' AS SmallDateTime), CAST(N'1997-04-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-13T00:00:00' AS SmallDateTime), 1, 11.9300, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'SP', N'05432-043', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10467, N'MAGAA', 8, CAST(N'1997-03-06T00:00:00' AS SmallDateTime), CAST(N'1997-04-03T00:00:00' AS SmallDateTime), CAST(N'1997-03-11T00:00:00' AS SmallDateTime), 2, 4.9300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10468, N'KOENE', 3, CAST(N'1997-03-07T00:00:00' AS SmallDateTime), CAST(N'1997-04-04T00:00:00' AS SmallDateTime), CAST(N'1997-03-12T00:00:00' AS SmallDateTime), 3, 44.1200, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10469, N'WHITC', 1, CAST(N'1997-03-10T00:00:00' AS SmallDateTime), CAST(N'1997-04-07T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), 1, 60.1800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10470, N'BONAP', 4, CAST(N'1997-03-11T00:00:00' AS SmallDateTime), CAST(N'1997-04-08T00:00:00' AS SmallDateTime), CAST(N'1997-03-14T00:00:00' AS SmallDateTime), 2, 64.5600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10471, N'BSBEV', 2, CAST(N'1997-03-11T00:00:00' AS SmallDateTime), CAST(N'1997-04-08T00:00:00' AS SmallDateTime), CAST(N'1997-03-18T00:00:00' AS SmallDateTime), 3, 45.5900, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10472, N'SEVES', 8, CAST(N'1997-03-12T00:00:00' AS SmallDateTime), CAST(N'1997-04-09T00:00:00' AS SmallDateTime), CAST(N'1997-03-19T00:00:00' AS SmallDateTime), 1, 4.2000, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10473, N'ISLAT', 1, CAST(N'1997-03-13T00:00:00' AS SmallDateTime), CAST(N'1997-03-27T00:00:00' AS SmallDateTime), CAST(N'1997-03-21T00:00:00' AS SmallDateTime), 3, 16.3700, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10474, N'PERIC', 5, CAST(N'1997-03-13T00:00:00' AS SmallDateTime), CAST(N'1997-04-10T00:00:00' AS SmallDateTime), CAST(N'1997-03-21T00:00:00' AS SmallDateTime), 2, 83.4900, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10475, N'SUPRD', 9, CAST(N'1997-03-14T00:00:00' AS SmallDateTime), CAST(N'1997-04-11T00:00:00' AS SmallDateTime), CAST(N'1997-04-04T00:00:00' AS SmallDateTime), 1, 68.5200, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10476, N'HILAA', 8, CAST(N'1997-03-17T00:00:00' AS SmallDateTime), CAST(N'1997-04-14T00:00:00' AS SmallDateTime), CAST(N'1997-03-24T00:00:00' AS SmallDateTime), 3, 4.4100, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10477, N'PRINI', 5, CAST(N'1997-03-17T00:00:00' AS SmallDateTime), CAST(N'1997-04-14T00:00:00' AS SmallDateTime), CAST(N'1997-03-25T00:00:00' AS SmallDateTime), 2, 13.0200, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10478, N'VICTE', 2, CAST(N'1997-03-18T00:00:00' AS SmallDateTime), CAST(N'1997-04-01T00:00:00' AS SmallDateTime), CAST(N'1997-03-26T00:00:00' AS SmallDateTime), 3, 4.8100, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10479, N'RATTC', 3, CAST(N'1997-03-19T00:00:00' AS SmallDateTime), CAST(N'1997-04-16T00:00:00' AS SmallDateTime), CAST(N'1997-03-21T00:00:00' AS SmallDateTime), 3, 708.9500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10480, N'FOLIG', 6, CAST(N'1997-03-20T00:00:00' AS SmallDateTime), CAST(N'1997-04-17T00:00:00' AS SmallDateTime), CAST(N'1997-03-24T00:00:00' AS SmallDateTime), 2, 1.3500, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10481, N'RICAR', 8, CAST(N'1997-03-20T00:00:00' AS SmallDateTime), CAST(N'1997-04-17T00:00:00' AS SmallDateTime), CAST(N'1997-03-25T00:00:00' AS SmallDateTime), 2, 64.3300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10482, N'LAZYK', 1, CAST(N'1997-03-21T00:00:00' AS SmallDateTime), CAST(N'1997-04-18T00:00:00' AS SmallDateTime), CAST(N'1997-04-10T00:00:00' AS SmallDateTime), 3, 7.4800, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10483, N'WHITC', 7, CAST(N'1997-03-24T00:00:00' AS SmallDateTime), CAST(N'1997-04-21T00:00:00' AS SmallDateTime), CAST(N'1997-04-25T00:00:00' AS SmallDateTime), 2, 15.2800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10484, N'BSBEV', 3, CAST(N'1997-03-24T00:00:00' AS SmallDateTime), CAST(N'1997-04-21T00:00:00' AS SmallDateTime), CAST(N'1997-04-01T00:00:00' AS SmallDateTime), 3, 6.8800, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10485, N'LINOD', 4, CAST(N'1997-03-25T00:00:00' AS SmallDateTime), CAST(N'1997-04-08T00:00:00' AS SmallDateTime), CAST(N'1997-03-31T00:00:00' AS SmallDateTime), 2, 64.4500, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10486, N'HILAA', 1, CAST(N'1997-03-26T00:00:00' AS SmallDateTime), CAST(N'1997-04-23T00:00:00' AS SmallDateTime), CAST(N'1997-04-02T00:00:00' AS SmallDateTime), 2, 30.5300, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10487, N'QUEEN', 2, CAST(N'1997-03-26T00:00:00' AS SmallDateTime), CAST(N'1997-04-23T00:00:00' AS SmallDateTime), CAST(N'1997-03-28T00:00:00' AS SmallDateTime), 2, 71.0700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10488, N'FRANK', 8, CAST(N'1997-03-27T00:00:00' AS SmallDateTime), CAST(N'1997-04-24T00:00:00' AS SmallDateTime), CAST(N'1997-04-02T00:00:00' AS SmallDateTime), 2, 4.9300, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10489, N'PICCO', 6, CAST(N'1997-03-28T00:00:00' AS SmallDateTime), CAST(N'1997-04-25T00:00:00' AS SmallDateTime), CAST(N'1997-04-09T00:00:00' AS SmallDateTime), 2, 5.2900, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10490, N'HILAA', 7, CAST(N'1997-03-31T00:00:00' AS SmallDateTime), CAST(N'1997-04-28T00:00:00' AS SmallDateTime), CAST(N'1997-04-03T00:00:00' AS SmallDateTime), 2, 210.1900, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10491, N'FURIB', 8, CAST(N'1997-03-31T00:00:00' AS SmallDateTime), CAST(N'1997-04-28T00:00:00' AS SmallDateTime), CAST(N'1997-04-08T00:00:00' AS SmallDateTime), 3, 16.9600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10492, N'BOTTM', 3, CAST(N'1997-04-01T00:00:00' AS SmallDateTime), CAST(N'1997-04-29T00:00:00' AS SmallDateTime), CAST(N'1997-04-11T00:00:00' AS SmallDateTime), 1, 62.8900, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10493, N'LAMAI', 4, CAST(N'1997-04-02T00:00:00' AS SmallDateTime), CAST(N'1997-04-30T00:00:00' AS SmallDateTime), CAST(N'1997-04-10T00:00:00' AS SmallDateTime), 3, 10.6400, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10494, N'COMMI', 4, CAST(N'1997-04-02T00:00:00' AS SmallDateTime), CAST(N'1997-04-30T00:00:00' AS SmallDateTime), CAST(N'1997-04-09T00:00:00' AS SmallDateTime), 2, 65.9900, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'SP', N'05432-043', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10495, N'LAUGB', 3, CAST(N'1997-04-03T00:00:00' AS SmallDateTime), CAST(N'1997-05-01T00:00:00' AS SmallDateTime), CAST(N'1997-04-11T00:00:00' AS SmallDateTime), 3, 4.6500, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10496, N'TRADH', 7, CAST(N'1997-04-04T00:00:00' AS SmallDateTime), CAST(N'1997-05-02T00:00:00' AS SmallDateTime), CAST(N'1997-04-07T00:00:00' AS SmallDateTime), 2, 46.7700, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10497, N'LEHMS', 7, CAST(N'1997-04-04T00:00:00' AS SmallDateTime), CAST(N'1997-05-02T00:00:00' AS SmallDateTime), CAST(N'1997-04-07T00:00:00' AS SmallDateTime), 1, 36.2100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10498, N'HILAA', 8, CAST(N'1997-04-07T00:00:00' AS SmallDateTime), CAST(N'1997-05-05T00:00:00' AS SmallDateTime), CAST(N'1997-04-11T00:00:00' AS SmallDateTime), 2, 29.7500, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10499, N'LILAS', 4, CAST(N'1997-04-08T00:00:00' AS SmallDateTime), CAST(N'1997-05-06T00:00:00' AS SmallDateTime), CAST(N'1997-04-16T00:00:00' AS SmallDateTime), 2, 102.0200, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10500, N'LAMAI', 6, CAST(N'1997-04-09T00:00:00' AS SmallDateTime), CAST(N'1997-05-07T00:00:00' AS SmallDateTime), CAST(N'1997-04-17T00:00:00' AS SmallDateTime), 1, 42.6800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10501, N'BLAUS', 9, CAST(N'1997-04-09T00:00:00' AS SmallDateTime), CAST(N'1997-05-07T00:00:00' AS SmallDateTime), CAST(N'1997-04-16T00:00:00' AS SmallDateTime), 3, 8.8500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10502, N'PERIC', 2, CAST(N'1997-04-10T00:00:00' AS SmallDateTime), CAST(N'1997-05-08T00:00:00' AS SmallDateTime), CAST(N'1997-04-29T00:00:00' AS SmallDateTime), 1, 69.3200, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10503, N'HUNGO', 6, CAST(N'1997-04-11T00:00:00' AS SmallDateTime), CAST(N'1997-05-09T00:00:00' AS SmallDateTime), CAST(N'1997-04-16T00:00:00' AS SmallDateTime), 2, 16.7400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10504, N'WHITC', 4, CAST(N'1997-04-11T00:00:00' AS SmallDateTime), CAST(N'1997-05-09T00:00:00' AS SmallDateTime), CAST(N'1997-04-18T00:00:00' AS SmallDateTime), 3, 59.1300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10505, N'MEREP', 3, CAST(N'1997-04-14T00:00:00' AS SmallDateTime), CAST(N'1997-05-12T00:00:00' AS SmallDateTime), CAST(N'1997-04-21T00:00:00' AS SmallDateTime), 3, 7.1300, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10506, N'KOENE', 9, CAST(N'1997-04-15T00:00:00' AS SmallDateTime), CAST(N'1997-05-13T00:00:00' AS SmallDateTime), CAST(N'1997-05-02T00:00:00' AS SmallDateTime), 2, 21.1900, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10507, N'ANTON', 7, CAST(N'1997-04-15T00:00:00' AS SmallDateTime), CAST(N'1997-05-13T00:00:00' AS SmallDateTime), CAST(N'1997-04-22T00:00:00' AS SmallDateTime), 1, 47.4500, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10508, N'OTTIK', 1, CAST(N'1997-04-16T00:00:00' AS SmallDateTime), CAST(N'1997-05-14T00:00:00' AS SmallDateTime), CAST(N'1997-05-13T00:00:00' AS SmallDateTime), 2, 4.9900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10509, N'BLAUS', 4, CAST(N'1997-04-17T00:00:00' AS SmallDateTime), CAST(N'1997-05-15T00:00:00' AS SmallDateTime), CAST(N'1997-04-29T00:00:00' AS SmallDateTime), 1, 0.1500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10510, N'SAVEA', 6, CAST(N'1997-04-18T00:00:00' AS SmallDateTime), CAST(N'1997-05-16T00:00:00' AS SmallDateTime), CAST(N'1997-04-28T00:00:00' AS SmallDateTime), 3, 367.6300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10511, N'BONAP', 4, CAST(N'1997-04-18T00:00:00' AS SmallDateTime), CAST(N'1997-05-16T00:00:00' AS SmallDateTime), CAST(N'1997-04-21T00:00:00' AS SmallDateTime), 3, 350.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10512, N'FAMIA', 7, CAST(N'1997-04-21T00:00:00' AS SmallDateTime), CAST(N'1997-05-19T00:00:00' AS SmallDateTime), CAST(N'1997-04-24T00:00:00' AS SmallDateTime), 2, 3.5300, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10513, N'WANDK', 7, CAST(N'1997-04-22T00:00:00' AS SmallDateTime), CAST(N'1997-06-03T00:00:00' AS SmallDateTime), CAST(N'1997-04-28T00:00:00' AS SmallDateTime), 1, 105.6500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10514, N'ERNSH', 3, CAST(N'1997-04-22T00:00:00' AS SmallDateTime), CAST(N'1997-05-20T00:00:00' AS SmallDateTime), CAST(N'1997-05-16T00:00:00' AS SmallDateTime), 2, 789.9500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10515, N'QUICK', 2, CAST(N'1997-04-23T00:00:00' AS SmallDateTime), CAST(N'1997-05-07T00:00:00' AS SmallDateTime), CAST(N'1997-05-23T00:00:00' AS SmallDateTime), 1, 204.4700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10516, N'HUNGO', 2, CAST(N'1997-04-24T00:00:00' AS SmallDateTime), CAST(N'1997-05-22T00:00:00' AS SmallDateTime), CAST(N'1997-05-01T00:00:00' AS SmallDateTime), 3, 62.7800, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10517, N'NORTS', 3, CAST(N'1997-04-24T00:00:00' AS SmallDateTime), CAST(N'1997-05-22T00:00:00' AS SmallDateTime), CAST(N'1997-04-29T00:00:00' AS SmallDateTime), 3, 32.0700, N'North/South', N'South House
300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10518, N'TORTU', 4, CAST(N'1997-04-25T00:00:00' AS SmallDateTime), CAST(N'1997-05-09T00:00:00' AS SmallDateTime), CAST(N'1997-05-05T00:00:00' AS SmallDateTime), 2, 218.1500, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10519, N'CHOPS', 6, CAST(N'1997-04-28T00:00:00' AS SmallDateTime), CAST(N'1997-05-26T00:00:00' AS SmallDateTime), CAST(N'1997-05-01T00:00:00' AS SmallDateTime), 3, 91.7600, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10520, N'SANTG', 7, CAST(N'1997-04-29T00:00:00' AS SmallDateTime), CAST(N'1997-05-27T00:00:00' AS SmallDateTime), CAST(N'1997-05-01T00:00:00' AS SmallDateTime), 1, 13.3700, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10521, N'CACTU', 8, CAST(N'1997-04-29T00:00:00' AS SmallDateTime), CAST(N'1997-05-27T00:00:00' AS SmallDateTime), CAST(N'1997-05-02T00:00:00' AS SmallDateTime), 2, 17.2200, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10522, N'LEHMS', 4, CAST(N'1997-04-30T00:00:00' AS SmallDateTime), CAST(N'1997-05-28T00:00:00' AS SmallDateTime), CAST(N'1997-05-06T00:00:00' AS SmallDateTime), 1, 45.3300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10523, N'SEVES', 7, CAST(N'1997-05-01T00:00:00' AS SmallDateTime), CAST(N'1997-05-29T00:00:00' AS SmallDateTime), CAST(N'1997-05-30T00:00:00' AS SmallDateTime), 2, 77.6300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10524, N'BERGS', 1, CAST(N'1997-05-01T00:00:00' AS SmallDateTime), CAST(N'1997-05-29T00:00:00' AS SmallDateTime), CAST(N'1997-05-07T00:00:00' AS SmallDateTime), 2, 244.7900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10525, N'BONAP', 1, CAST(N'1997-05-02T00:00:00' AS SmallDateTime), CAST(N'1997-05-30T00:00:00' AS SmallDateTime), CAST(N'1997-05-23T00:00:00' AS SmallDateTime), 2, 11.0600, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10526, N'WARTH', 4, CAST(N'1997-05-05T00:00:00' AS SmallDateTime), CAST(N'1997-06-02T00:00:00' AS SmallDateTime), CAST(N'1997-05-15T00:00:00' AS SmallDateTime), 2, 58.5900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10527, N'QUICK', 7, CAST(N'1997-05-05T00:00:00' AS SmallDateTime), CAST(N'1997-06-02T00:00:00' AS SmallDateTime), CAST(N'1997-05-07T00:00:00' AS SmallDateTime), 1, 41.9000, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10528, N'GREAL', 6, CAST(N'1997-05-06T00:00:00' AS SmallDateTime), CAST(N'1997-05-20T00:00:00' AS SmallDateTime), CAST(N'1997-05-09T00:00:00' AS SmallDateTime), 2, 3.3500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10529, N'MAISD', 5, CAST(N'1997-05-07T00:00:00' AS SmallDateTime), CAST(N'1997-06-04T00:00:00' AS SmallDateTime), CAST(N'1997-05-09T00:00:00' AS SmallDateTime), 2, 66.6900, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10530, N'PICCO', 3, CAST(N'1997-05-08T00:00:00' AS SmallDateTime), CAST(N'1997-06-05T00:00:00' AS SmallDateTime), CAST(N'1997-05-12T00:00:00' AS SmallDateTime), 2, 339.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10531, N'OCEAN', 7, CAST(N'1997-05-08T00:00:00' AS SmallDateTime), CAST(N'1997-06-05T00:00:00' AS SmallDateTime), CAST(N'1997-05-19T00:00:00' AS SmallDateTime), 1, 8.1200, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10532, N'EASTC', 7, CAST(N'1997-05-09T00:00:00' AS SmallDateTime), CAST(N'1997-06-06T00:00:00' AS SmallDateTime), CAST(N'1997-05-12T00:00:00' AS SmallDateTime), 3, 74.4600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10533, N'FOLKO', 8, CAST(N'1997-05-12T00:00:00' AS SmallDateTime), CAST(N'1997-06-09T00:00:00' AS SmallDateTime), CAST(N'1997-05-22T00:00:00' AS SmallDateTime), 1, 188.0400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10534, N'LEHMS', 8, CAST(N'1997-05-12T00:00:00' AS SmallDateTime), CAST(N'1997-06-09T00:00:00' AS SmallDateTime), CAST(N'1997-05-14T00:00:00' AS SmallDateTime), 2, 27.9400, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10535, N'ANTON', 4, CAST(N'1997-05-13T00:00:00' AS SmallDateTime), CAST(N'1997-06-10T00:00:00' AS SmallDateTime), CAST(N'1997-05-21T00:00:00' AS SmallDateTime), 1, 15.6400, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10536, N'LEHMS', 3, CAST(N'1997-05-14T00:00:00' AS SmallDateTime), CAST(N'1997-06-11T00:00:00' AS SmallDateTime), CAST(N'1997-06-06T00:00:00' AS SmallDateTime), 2, 58.8800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10537, N'RICSU', 1, CAST(N'1997-05-14T00:00:00' AS SmallDateTime), CAST(N'1997-05-28T00:00:00' AS SmallDateTime), CAST(N'1997-05-19T00:00:00' AS SmallDateTime), 1, 78.8500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10538, N'BSBEV', 9, CAST(N'1997-05-15T00:00:00' AS SmallDateTime), CAST(N'1997-06-12T00:00:00' AS SmallDateTime), CAST(N'1997-05-16T00:00:00' AS SmallDateTime), 3, 4.8700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10539, N'BSBEV', 6, CAST(N'1997-05-16T00:00:00' AS SmallDateTime), CAST(N'1997-06-13T00:00:00' AS SmallDateTime), CAST(N'1997-05-23T00:00:00' AS SmallDateTime), 3, 12.3600, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10540, N'QUICK', 3, CAST(N'1997-05-19T00:00:00' AS SmallDateTime), CAST(N'1997-06-16T00:00:00' AS SmallDateTime), CAST(N'1997-06-13T00:00:00' AS SmallDateTime), 3, 1007.6400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10541, N'HANAR', 2, CAST(N'1997-05-19T00:00:00' AS SmallDateTime), CAST(N'1997-06-16T00:00:00' AS SmallDateTime), CAST(N'1997-05-29T00:00:00' AS SmallDateTime), 1, 68.6500, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10542, N'KOENE', 1, CAST(N'1997-05-20T00:00:00' AS SmallDateTime), CAST(N'1997-06-17T00:00:00' AS SmallDateTime), CAST(N'1997-05-26T00:00:00' AS SmallDateTime), 3, 10.9500, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10543, N'LILAS', 8, CAST(N'1997-05-21T00:00:00' AS SmallDateTime), CAST(N'1997-06-18T00:00:00' AS SmallDateTime), CAST(N'1997-05-23T00:00:00' AS SmallDateTime), 2, 48.1700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10544, N'LONEP', 4, CAST(N'1997-05-21T00:00:00' AS SmallDateTime), CAST(N'1997-06-18T00:00:00' AS SmallDateTime), CAST(N'1997-05-30T00:00:00' AS SmallDateTime), 1, 24.9100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10545, N'LAZYK', 8, CAST(N'1997-05-22T00:00:00' AS SmallDateTime), CAST(N'1997-06-19T00:00:00' AS SmallDateTime), CAST(N'1997-06-26T00:00:00' AS SmallDateTime), 2, 11.9200, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10546, N'VICTE', 1, CAST(N'1997-05-23T00:00:00' AS SmallDateTime), CAST(N'1997-06-20T00:00:00' AS SmallDateTime), CAST(N'1997-05-27T00:00:00' AS SmallDateTime), 3, 194.7200, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10547, N'SEVES', 3, CAST(N'1997-05-23T00:00:00' AS SmallDateTime), CAST(N'1997-06-20T00:00:00' AS SmallDateTime), CAST(N'1997-06-02T00:00:00' AS SmallDateTime), 2, 178.4300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10548, N'TOMSP', 3, CAST(N'1997-05-26T00:00:00' AS SmallDateTime), CAST(N'1997-06-23T00:00:00' AS SmallDateTime), CAST(N'1997-06-02T00:00:00' AS SmallDateTime), 2, 1.4300, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10549, N'QUICK', 5, CAST(N'1997-05-27T00:00:00' AS SmallDateTime), CAST(N'1997-06-10T00:00:00' AS SmallDateTime), CAST(N'1997-05-30T00:00:00' AS SmallDateTime), 1, 171.2400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10550, N'GODOS', 7, CAST(N'1997-05-28T00:00:00' AS SmallDateTime), CAST(N'1997-06-25T00:00:00' AS SmallDateTime), CAST(N'1997-06-06T00:00:00' AS SmallDateTime), 3, 4.3200, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10551, N'FURIB', 4, CAST(N'1997-05-28T00:00:00' AS SmallDateTime), CAST(N'1997-07-09T00:00:00' AS SmallDateTime), CAST(N'1997-06-06T00:00:00' AS SmallDateTime), 3, 72.9500, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10552, N'HILAA', 2, CAST(N'1997-05-29T00:00:00' AS SmallDateTime), CAST(N'1997-06-26T00:00:00' AS SmallDateTime), CAST(N'1997-06-05T00:00:00' AS SmallDateTime), 1, 83.2200, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10553, N'WARTH', 2, CAST(N'1997-05-30T00:00:00' AS SmallDateTime), CAST(N'1997-06-27T00:00:00' AS SmallDateTime), CAST(N'1997-06-03T00:00:00' AS SmallDateTime), 2, 149.4900, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10554, N'OTTIK', 4, CAST(N'1997-05-30T00:00:00' AS SmallDateTime), CAST(N'1997-06-27T00:00:00' AS SmallDateTime), CAST(N'1997-06-05T00:00:00' AS SmallDateTime), 3, 120.9700, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10555, N'SAVEA', 6, CAST(N'1997-06-02T00:00:00' AS SmallDateTime), CAST(N'1997-06-30T00:00:00' AS SmallDateTime), CAST(N'1997-06-04T00:00:00' AS SmallDateTime), 3, 252.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10556, N'SIMOB', 2, CAST(N'1997-06-03T00:00:00' AS SmallDateTime), CAST(N'1997-07-15T00:00:00' AS SmallDateTime), CAST(N'1997-06-13T00:00:00' AS SmallDateTime), 1, 9.8000, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10557, N'LEHMS', 9, CAST(N'1997-06-03T00:00:00' AS SmallDateTime), CAST(N'1997-06-17T00:00:00' AS SmallDateTime), CAST(N'1997-06-06T00:00:00' AS SmallDateTime), 2, 96.7200, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10558, N'AROUT', 1, CAST(N'1997-06-04T00:00:00' AS SmallDateTime), CAST(N'1997-07-02T00:00:00' AS SmallDateTime), CAST(N'1997-06-10T00:00:00' AS SmallDateTime), 2, 72.9700, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10559, N'BLONP', 6, CAST(N'1997-06-05T00:00:00' AS SmallDateTime), CAST(N'1997-07-03T00:00:00' AS SmallDateTime), CAST(N'1997-06-13T00:00:00' AS SmallDateTime), 1, 8.0500, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10560, N'FRANK', 8, CAST(N'1997-06-06T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), CAST(N'1997-06-09T00:00:00' AS SmallDateTime), 1, 36.6500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10561, N'FOLKO', 2, CAST(N'1997-06-06T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), CAST(N'1997-06-09T00:00:00' AS SmallDateTime), 2, 242.2100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10562, N'REGGC', 1, CAST(N'1997-06-09T00:00:00' AS SmallDateTime), CAST(N'1997-07-07T00:00:00' AS SmallDateTime), CAST(N'1997-06-12T00:00:00' AS SmallDateTime), 1, 22.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10563, N'RICAR', 2, CAST(N'1997-06-10T00:00:00' AS SmallDateTime), CAST(N'1997-07-22T00:00:00' AS SmallDateTime), CAST(N'1997-06-24T00:00:00' AS SmallDateTime), 2, 60.4300, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10564, N'RATTC', 4, CAST(N'1997-06-10T00:00:00' AS SmallDateTime), CAST(N'1997-07-08T00:00:00' AS SmallDateTime), CAST(N'1997-06-16T00:00:00' AS SmallDateTime), 3, 13.7500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10565, N'MEREP', 8, CAST(N'1997-06-11T00:00:00' AS SmallDateTime), CAST(N'1997-07-09T00:00:00' AS SmallDateTime), CAST(N'1997-06-18T00:00:00' AS SmallDateTime), 2, 7.1500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10566, N'BLONP', 9, CAST(N'1997-06-12T00:00:00' AS SmallDateTime), CAST(N'1997-07-10T00:00:00' AS SmallDateTime), CAST(N'1997-06-18T00:00:00' AS SmallDateTime), 1, 88.4000, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10567, N'HUNGO', 1, CAST(N'1997-06-12T00:00:00' AS SmallDateTime), CAST(N'1997-07-10T00:00:00' AS SmallDateTime), CAST(N'1997-06-17T00:00:00' AS SmallDateTime), 1, 33.9700, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10568, N'GALED', 3, CAST(N'1997-06-13T00:00:00' AS SmallDateTime), CAST(N'1997-07-11T00:00:00' AS SmallDateTime), CAST(N'1997-07-09T00:00:00' AS SmallDateTime), 3, 6.5400, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10569, N'RATTC', 5, CAST(N'1997-06-16T00:00:00' AS SmallDateTime), CAST(N'1997-07-14T00:00:00' AS SmallDateTime), CAST(N'1997-07-11T00:00:00' AS SmallDateTime), 1, 58.9800, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10570, N'MEREP', 3, CAST(N'1997-06-17T00:00:00' AS SmallDateTime), CAST(N'1997-07-15T00:00:00' AS SmallDateTime), CAST(N'1997-06-19T00:00:00' AS SmallDateTime), 3, 188.9900, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10571, N'ERNSH', 8, CAST(N'1997-06-17T00:00:00' AS SmallDateTime), CAST(N'1997-07-29T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), 3, 26.0600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10572, N'BERGS', 3, CAST(N'1997-06-18T00:00:00' AS SmallDateTime), CAST(N'1997-07-16T00:00:00' AS SmallDateTime), CAST(N'1997-06-25T00:00:00' AS SmallDateTime), 2, 116.4300, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10573, N'ANTON', 7, CAST(N'1997-06-19T00:00:00' AS SmallDateTime), CAST(N'1997-07-17T00:00:00' AS SmallDateTime), CAST(N'1997-06-20T00:00:00' AS SmallDateTime), 3, 84.8400, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10574, N'TRAIH', 4, CAST(N'1997-06-19T00:00:00' AS SmallDateTime), CAST(N'1997-07-17T00:00:00' AS SmallDateTime), CAST(N'1997-06-30T00:00:00' AS SmallDateTime), 2, 37.6000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10575, N'MORGK', 5, CAST(N'1997-06-20T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), CAST(N'1997-06-30T00:00:00' AS SmallDateTime), 1, 127.3400, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10576, N'TORTU', 3, CAST(N'1997-06-23T00:00:00' AS SmallDateTime), CAST(N'1997-07-07T00:00:00' AS SmallDateTime), CAST(N'1997-06-30T00:00:00' AS SmallDateTime), 3, 18.5600, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10577, N'TRAIH', 9, CAST(N'1997-06-23T00:00:00' AS SmallDateTime), CAST(N'1997-08-04T00:00:00' AS SmallDateTime), CAST(N'1997-06-30T00:00:00' AS SmallDateTime), 2, 25.4100, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10578, N'BSBEV', 4, CAST(N'1997-06-24T00:00:00' AS SmallDateTime), CAST(N'1997-07-22T00:00:00' AS SmallDateTime), CAST(N'1997-07-25T00:00:00' AS SmallDateTime), 3, 29.6000, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10579, N'LETSS', 1, CAST(N'1997-06-25T00:00:00' AS SmallDateTime), CAST(N'1997-07-23T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), 2, 13.7300, N'Let''s Stop N Shop', N'87 Polk St.
Suite 5', N'San Francisco', N'CA', N'94117', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10580, N'OTTIK', 4, CAST(N'1997-06-26T00:00:00' AS SmallDateTime), CAST(N'1997-07-24T00:00:00' AS SmallDateTime), CAST(N'1997-07-01T00:00:00' AS SmallDateTime), 3, 75.8900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10581, N'FAMIA', 3, CAST(N'1997-06-26T00:00:00' AS SmallDateTime), CAST(N'1997-07-24T00:00:00' AS SmallDateTime), CAST(N'1997-07-02T00:00:00' AS SmallDateTime), 1, 3.0100, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10582, N'BLAUS', 3, CAST(N'1997-06-27T00:00:00' AS SmallDateTime), CAST(N'1997-07-25T00:00:00' AS SmallDateTime), CAST(N'1997-07-14T00:00:00' AS SmallDateTime), 2, 27.7100, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10583, N'WARTH', 2, CAST(N'1997-06-30T00:00:00' AS SmallDateTime), CAST(N'1997-07-28T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), 2, 7.2800, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10584, N'BLONP', 4, CAST(N'1997-06-30T00:00:00' AS SmallDateTime), CAST(N'1997-07-28T00:00:00' AS SmallDateTime), CAST(N'1997-07-04T00:00:00' AS SmallDateTime), 1, 59.1400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10585, N'WELLI', 7, CAST(N'1997-07-01T00:00:00' AS SmallDateTime), CAST(N'1997-07-29T00:00:00' AS SmallDateTime), CAST(N'1997-07-10T00:00:00' AS SmallDateTime), 1, 13.4100, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10586, N'REGGC', 9, CAST(N'1997-07-02T00:00:00' AS SmallDateTime), CAST(N'1997-07-30T00:00:00' AS SmallDateTime), CAST(N'1997-07-09T00:00:00' AS SmallDateTime), 1, 0.4800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10587, N'QUEDE', 1, CAST(N'1997-07-02T00:00:00' AS SmallDateTime), CAST(N'1997-07-30T00:00:00' AS SmallDateTime), CAST(N'1997-07-09T00:00:00' AS SmallDateTime), 1, 62.5200, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10588, N'QUICK', 2, CAST(N'1997-07-03T00:00:00' AS SmallDateTime), CAST(N'1997-07-31T00:00:00' AS SmallDateTime), CAST(N'1997-07-10T00:00:00' AS SmallDateTime), 3, 194.6700, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10589, N'GREAL', 8, CAST(N'1997-07-04T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), CAST(N'1997-07-14T00:00:00' AS SmallDateTime), 2, 4.4200, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10590, N'MEREP', 4, CAST(N'1997-07-07T00:00:00' AS SmallDateTime), CAST(N'1997-08-04T00:00:00' AS SmallDateTime), CAST(N'1997-07-14T00:00:00' AS SmallDateTime), 3, 44.7700, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10591, N'VAFFE', 1, CAST(N'1997-07-07T00:00:00' AS SmallDateTime), CAST(N'1997-07-21T00:00:00' AS SmallDateTime), CAST(N'1997-07-16T00:00:00' AS SmallDateTime), 1, 55.9200, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10592, N'LEHMS', 3, CAST(N'1997-07-08T00:00:00' AS SmallDateTime), CAST(N'1997-08-05T00:00:00' AS SmallDateTime), CAST(N'1997-07-16T00:00:00' AS SmallDateTime), 1, 32.1000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10593, N'LEHMS', 7, CAST(N'1997-07-09T00:00:00' AS SmallDateTime), CAST(N'1997-08-06T00:00:00' AS SmallDateTime), CAST(N'1997-08-13T00:00:00' AS SmallDateTime), 2, 174.2000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10594, N'OLDWO', 3, CAST(N'1997-07-09T00:00:00' AS SmallDateTime), CAST(N'1997-08-06T00:00:00' AS SmallDateTime), CAST(N'1997-07-16T00:00:00' AS SmallDateTime), 2, 5.2400, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10595, N'ERNSH', 2, CAST(N'1997-07-10T00:00:00' AS SmallDateTime), CAST(N'1997-08-07T00:00:00' AS SmallDateTime), CAST(N'1997-07-14T00:00:00' AS SmallDateTime), 1, 96.7800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10596, N'WHITC', 8, CAST(N'1997-07-11T00:00:00' AS SmallDateTime), CAST(N'1997-08-08T00:00:00' AS SmallDateTime), CAST(N'1997-08-12T00:00:00' AS SmallDateTime), 1, 16.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10597, N'PICCO', 7, CAST(N'1997-07-11T00:00:00' AS SmallDateTime), CAST(N'1997-08-08T00:00:00' AS SmallDateTime), CAST(N'1997-07-18T00:00:00' AS SmallDateTime), 3, 35.1200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10598, N'RATTC', 1, CAST(N'1997-07-14T00:00:00' AS SmallDateTime), CAST(N'1997-08-11T00:00:00' AS SmallDateTime), CAST(N'1997-07-18T00:00:00' AS SmallDateTime), 3, 44.4200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10599, N'BSBEV', 6, CAST(N'1997-07-15T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), CAST(N'1997-07-21T00:00:00' AS SmallDateTime), 3, 29.9800, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10600, N'HUNGC', 4, CAST(N'1997-07-16T00:00:00' AS SmallDateTime), CAST(N'1997-08-13T00:00:00' AS SmallDateTime), CAST(N'1997-07-21T00:00:00' AS SmallDateTime), 1, 45.1300, N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'OR', N'97827', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10601, N'HILAA', 7, CAST(N'1997-07-16T00:00:00' AS SmallDateTime), CAST(N'1997-08-27T00:00:00' AS SmallDateTime), CAST(N'1997-07-22T00:00:00' AS SmallDateTime), 1, 58.3000, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10602, N'VAFFE', 8, CAST(N'1997-07-17T00:00:00' AS SmallDateTime), CAST(N'1997-08-14T00:00:00' AS SmallDateTime), CAST(N'1997-07-22T00:00:00' AS SmallDateTime), 2, 2.9200, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10603, N'SAVEA', 8, CAST(N'1997-07-18T00:00:00' AS SmallDateTime), CAST(N'1997-08-15T00:00:00' AS SmallDateTime), CAST(N'1997-08-08T00:00:00' AS SmallDateTime), 2, 48.7700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10604, N'FURIB', 1, CAST(N'1997-07-18T00:00:00' AS SmallDateTime), CAST(N'1997-08-15T00:00:00' AS SmallDateTime), CAST(N'1997-07-29T00:00:00' AS SmallDateTime), 1, 7.4600, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10605, N'MEREP', 1, CAST(N'1997-07-21T00:00:00' AS SmallDateTime), CAST(N'1997-08-18T00:00:00' AS SmallDateTime), CAST(N'1997-07-29T00:00:00' AS SmallDateTime), 2, 379.1300, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10606, N'TRADH', 4, CAST(N'1997-07-22T00:00:00' AS SmallDateTime), CAST(N'1997-08-19T00:00:00' AS SmallDateTime), CAST(N'1997-07-31T00:00:00' AS SmallDateTime), 3, 79.4000, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10607, N'SAVEA', 5, CAST(N'1997-07-22T00:00:00' AS SmallDateTime), CAST(N'1997-08-19T00:00:00' AS SmallDateTime), CAST(N'1997-07-25T00:00:00' AS SmallDateTime), 1, 200.2400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10608, N'TOMSP', 4, CAST(N'1997-07-23T00:00:00' AS SmallDateTime), CAST(N'1997-08-20T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), 2, 27.7900, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10609, N'DUMON', 7, CAST(N'1997-07-24T00:00:00' AS SmallDateTime), CAST(N'1997-08-21T00:00:00' AS SmallDateTime), CAST(N'1997-07-30T00:00:00' AS SmallDateTime), 2, 1.8500, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10610, N'LAMAI', 8, CAST(N'1997-07-25T00:00:00' AS SmallDateTime), CAST(N'1997-08-22T00:00:00' AS SmallDateTime), CAST(N'1997-08-06T00:00:00' AS SmallDateTime), 1, 26.7800, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10611, N'WOLZA', 6, CAST(N'1997-07-25T00:00:00' AS SmallDateTime), CAST(N'1997-08-22T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), 2, 80.6500, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10612, N'SAVEA', 1, CAST(N'1997-07-28T00:00:00' AS SmallDateTime), CAST(N'1997-08-25T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), 2, 544.0800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10613, N'HILAA', 4, CAST(N'1997-07-29T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), 2, 8.1100, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10614, N'BLAUS', 8, CAST(N'1997-07-29T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), CAST(N'1997-08-01T00:00:00' AS SmallDateTime), 3, 1.9300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10615, N'WILMK', 2, CAST(N'1997-07-30T00:00:00' AS SmallDateTime), CAST(N'1997-08-27T00:00:00' AS SmallDateTime), CAST(N'1997-08-06T00:00:00' AS SmallDateTime), 3, 0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10616, N'GREAL', 1, CAST(N'1997-07-31T00:00:00' AS SmallDateTime), CAST(N'1997-08-28T00:00:00' AS SmallDateTime), CAST(N'1997-08-05T00:00:00' AS SmallDateTime), 2, 116.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10617, N'GREAL', 4, CAST(N'1997-07-31T00:00:00' AS SmallDateTime), CAST(N'1997-08-28T00:00:00' AS SmallDateTime), CAST(N'1997-08-04T00:00:00' AS SmallDateTime), 2, 18.5300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10618, N'MEREP', 1, CAST(N'1997-08-01T00:00:00' AS SmallDateTime), CAST(N'1997-09-12T00:00:00' AS SmallDateTime), CAST(N'1997-08-08T00:00:00' AS SmallDateTime), 1, 154.6800, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10619, N'MEREP', 3, CAST(N'1997-08-04T00:00:00' AS SmallDateTime), CAST(N'1997-09-01T00:00:00' AS SmallDateTime), CAST(N'1997-08-07T00:00:00' AS SmallDateTime), 3, 91.0500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10620, N'LAUGB', 2, CAST(N'1997-08-05T00:00:00' AS SmallDateTime), CAST(N'1997-09-02T00:00:00' AS SmallDateTime), CAST(N'1997-08-14T00:00:00' AS SmallDateTime), 3, 0.9400, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10621, N'ISLAT', 4, CAST(N'1997-08-05T00:00:00' AS SmallDateTime), CAST(N'1997-09-02T00:00:00' AS SmallDateTime), CAST(N'1997-08-11T00:00:00' AS SmallDateTime), 2, 23.7300, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10622, N'RICAR', 4, CAST(N'1997-08-06T00:00:00' AS SmallDateTime), CAST(N'1997-09-03T00:00:00' AS SmallDateTime), CAST(N'1997-08-11T00:00:00' AS SmallDateTime), 3, 50.9700, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10623, N'FRANK', 8, CAST(N'1997-08-07T00:00:00' AS SmallDateTime), CAST(N'1997-09-04T00:00:00' AS SmallDateTime), CAST(N'1997-08-12T00:00:00' AS SmallDateTime), 2, 97.1800, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10624, N'THECR', 4, CAST(N'1997-08-07T00:00:00' AS SmallDateTime), CAST(N'1997-09-04T00:00:00' AS SmallDateTime), CAST(N'1997-08-19T00:00:00' AS SmallDateTime), 2, 94.8000, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10625, N'ANATR', 3, CAST(N'1997-08-08T00:00:00' AS SmallDateTime), CAST(N'1997-09-05T00:00:00' AS SmallDateTime), CAST(N'1997-08-14T00:00:00' AS SmallDateTime), 1, 43.9000, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10626, N'BERGS', 1, CAST(N'1997-08-11T00:00:00' AS SmallDateTime), CAST(N'1997-09-08T00:00:00' AS SmallDateTime), CAST(N'1997-08-20T00:00:00' AS SmallDateTime), 2, 138.6900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10627, N'SAVEA', 8, CAST(N'1997-08-11T00:00:00' AS SmallDateTime), CAST(N'1997-09-22T00:00:00' AS SmallDateTime), CAST(N'1997-08-21T00:00:00' AS SmallDateTime), 3, 107.4600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10628, N'BLONP', 4, CAST(N'1997-08-12T00:00:00' AS SmallDateTime), CAST(N'1997-09-09T00:00:00' AS SmallDateTime), CAST(N'1997-08-20T00:00:00' AS SmallDateTime), 3, 30.3600, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10629, N'GODOS', 4, CAST(N'1997-08-12T00:00:00' AS SmallDateTime), CAST(N'1997-09-09T00:00:00' AS SmallDateTime), CAST(N'1997-08-20T00:00:00' AS SmallDateTime), 3, 85.4600, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10630, N'KOENE', 1, CAST(N'1997-08-13T00:00:00' AS SmallDateTime), CAST(N'1997-09-10T00:00:00' AS SmallDateTime), CAST(N'1997-08-19T00:00:00' AS SmallDateTime), 2, 32.3500, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10631, N'LAMAI', 8, CAST(N'1997-08-14T00:00:00' AS SmallDateTime), CAST(N'1997-09-11T00:00:00' AS SmallDateTime), CAST(N'1997-08-15T00:00:00' AS SmallDateTime), 1, 0.8700, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10632, N'WANDK', 8, CAST(N'1997-08-14T00:00:00' AS SmallDateTime), CAST(N'1997-09-11T00:00:00' AS SmallDateTime), CAST(N'1997-08-19T00:00:00' AS SmallDateTime), 1, 41.3800, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10633, N'ERNSH', 7, CAST(N'1997-08-15T00:00:00' AS SmallDateTime), CAST(N'1997-09-12T00:00:00' AS SmallDateTime), CAST(N'1997-08-18T00:00:00' AS SmallDateTime), 3, 477.9000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10634, N'FOLIG', 4, CAST(N'1997-08-15T00:00:00' AS SmallDateTime), CAST(N'1997-09-12T00:00:00' AS SmallDateTime), CAST(N'1997-08-21T00:00:00' AS SmallDateTime), 3, 487.3800, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10635, N'MAGAA', 8, CAST(N'1997-08-18T00:00:00' AS SmallDateTime), CAST(N'1997-09-15T00:00:00' AS SmallDateTime), CAST(N'1997-08-21T00:00:00' AS SmallDateTime), 3, 47.4600, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10636, N'WARTH', 4, CAST(N'1997-08-19T00:00:00' AS SmallDateTime), CAST(N'1997-09-16T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), 1, 1.1500, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10637, N'QUEEN', 6, CAST(N'1997-08-19T00:00:00' AS SmallDateTime), CAST(N'1997-09-16T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), 1, 201.2900, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10638, N'LINOD', 3, CAST(N'1997-08-20T00:00:00' AS SmallDateTime), CAST(N'1997-09-17T00:00:00' AS SmallDateTime), CAST(N'1997-09-01T00:00:00' AS SmallDateTime), 1, 158.4400, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10639, N'SANTG', 7, CAST(N'1997-08-20T00:00:00' AS SmallDateTime), CAST(N'1997-09-17T00:00:00' AS SmallDateTime), CAST(N'1997-08-27T00:00:00' AS SmallDateTime), 3, 38.6400, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10640, N'WANDK', 4, CAST(N'1997-08-21T00:00:00' AS SmallDateTime), CAST(N'1997-09-18T00:00:00' AS SmallDateTime), CAST(N'1997-08-28T00:00:00' AS SmallDateTime), 1, 23.5500, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10641, N'HILAA', 4, CAST(N'1997-08-22T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), CAST(N'1997-08-26T00:00:00' AS SmallDateTime), 2, 179.6100, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10642, N'SIMOB', 7, CAST(N'1997-08-22T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), CAST(N'1997-09-05T00:00:00' AS SmallDateTime), 3, 41.8900, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10643, N'ALFKI', 6, CAST(N'1997-08-25T00:00:00' AS SmallDateTime), CAST(N'1997-09-22T00:00:00' AS SmallDateTime), CAST(N'1997-09-02T00:00:00' AS SmallDateTime), 2, 29.4600, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10644, N'WELLI', 3, CAST(N'1997-08-25T00:00:00' AS SmallDateTime), CAST(N'1997-09-22T00:00:00' AS SmallDateTime), CAST(N'1997-09-01T00:00:00' AS SmallDateTime), 2, 0.1400, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10645, N'HANAR', 4, CAST(N'1997-08-26T00:00:00' AS SmallDateTime), CAST(N'1997-09-23T00:00:00' AS SmallDateTime), CAST(N'1997-09-02T00:00:00' AS SmallDateTime), 1, 12.4100, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10646, N'HUNGO', 9, CAST(N'1997-08-27T00:00:00' AS SmallDateTime), CAST(N'1997-10-08T00:00:00' AS SmallDateTime), CAST(N'1997-09-03T00:00:00' AS SmallDateTime), 3, 142.3300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10647, N'QUEDE', 4, CAST(N'1997-08-27T00:00:00' AS SmallDateTime), CAST(N'1997-09-10T00:00:00' AS SmallDateTime), CAST(N'1997-09-03T00:00:00' AS SmallDateTime), 2, 45.5400, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10648, N'RICAR', 5, CAST(N'1997-08-28T00:00:00' AS SmallDateTime), CAST(N'1997-10-09T00:00:00' AS SmallDateTime), CAST(N'1997-09-09T00:00:00' AS SmallDateTime), 2, 14.2500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10649, N'MAISD', 5, CAST(N'1997-08-28T00:00:00' AS SmallDateTime), CAST(N'1997-09-25T00:00:00' AS SmallDateTime), CAST(N'1997-08-29T00:00:00' AS SmallDateTime), 3, 6.2000, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10650, N'FAMIA', 5, CAST(N'1997-08-29T00:00:00' AS SmallDateTime), CAST(N'1997-09-26T00:00:00' AS SmallDateTime), CAST(N'1997-09-03T00:00:00' AS SmallDateTime), 3, 176.8100, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10651, N'WANDK', 8, CAST(N'1997-09-01T00:00:00' AS SmallDateTime), CAST(N'1997-09-29T00:00:00' AS SmallDateTime), CAST(N'1997-09-11T00:00:00' AS SmallDateTime), 2, 20.6000, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10652, N'GOURL', 4, CAST(N'1997-09-01T00:00:00' AS SmallDateTime), CAST(N'1997-09-29T00:00:00' AS SmallDateTime), CAST(N'1997-09-08T00:00:00' AS SmallDateTime), 2, 7.1400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10653, N'FRANK', 1, CAST(N'1997-09-02T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), 1, 93.2500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10654, N'BERGS', 5, CAST(N'1997-09-02T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), CAST(N'1997-09-11T00:00:00' AS SmallDateTime), 1, 55.2600, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10655, N'REGGC', 1, CAST(N'1997-09-03T00:00:00' AS SmallDateTime), CAST(N'1997-10-01T00:00:00' AS SmallDateTime), CAST(N'1997-09-11T00:00:00' AS SmallDateTime), 2, 4.4100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10656, N'GREAL', 6, CAST(N'1997-09-04T00:00:00' AS SmallDateTime), CAST(N'1997-10-02T00:00:00' AS SmallDateTime), CAST(N'1997-09-10T00:00:00' AS SmallDateTime), 1, 57.1500, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10657, N'SAVEA', 2, CAST(N'1997-09-04T00:00:00' AS SmallDateTime), CAST(N'1997-10-02T00:00:00' AS SmallDateTime), CAST(N'1997-09-15T00:00:00' AS SmallDateTime), 2, 352.6900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10658, N'QUICK', 4, CAST(N'1997-09-05T00:00:00' AS SmallDateTime), CAST(N'1997-10-03T00:00:00' AS SmallDateTime), CAST(N'1997-09-08T00:00:00' AS SmallDateTime), 1, 364.1500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10659, N'QUEEN', 7, CAST(N'1997-09-05T00:00:00' AS SmallDateTime), CAST(N'1997-10-03T00:00:00' AS SmallDateTime), CAST(N'1997-09-10T00:00:00' AS SmallDateTime), 2, 105.8100, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10660, N'HUNGC', 8, CAST(N'1997-09-08T00:00:00' AS SmallDateTime), CAST(N'1997-10-06T00:00:00' AS SmallDateTime), CAST(N'1997-10-15T00:00:00' AS SmallDateTime), 1, 111.2900, N'Hungry Coyote Import Store', N'City Center Plaza
516 Main St.', N'Elgin', N'OR', N'97827', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10661, N'HUNGO', 7, CAST(N'1997-09-09T00:00:00' AS SmallDateTime), CAST(N'1997-10-07T00:00:00' AS SmallDateTime), CAST(N'1997-09-15T00:00:00' AS SmallDateTime), 3, 17.5500, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10662, N'LONEP', 3, CAST(N'1997-09-09T00:00:00' AS SmallDateTime), CAST(N'1997-10-07T00:00:00' AS SmallDateTime), CAST(N'1997-09-18T00:00:00' AS SmallDateTime), 2, 1.2800, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10663, N'BONAP', 2, CAST(N'1997-09-10T00:00:00' AS SmallDateTime), CAST(N'1997-09-24T00:00:00' AS SmallDateTime), CAST(N'1997-10-03T00:00:00' AS SmallDateTime), 2, 113.1500, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10664, N'FURIB', 1, CAST(N'1997-09-10T00:00:00' AS SmallDateTime), CAST(N'1997-10-08T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), 3, 1.2700, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10665, N'LONEP', 1, CAST(N'1997-09-11T00:00:00' AS SmallDateTime), CAST(N'1997-10-09T00:00:00' AS SmallDateTime), CAST(N'1997-09-17T00:00:00' AS SmallDateTime), 2, 26.3100, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10666, N'RICSU', 7, CAST(N'1997-09-12T00:00:00' AS SmallDateTime), CAST(N'1997-10-10T00:00:00' AS SmallDateTime), CAST(N'1997-09-22T00:00:00' AS SmallDateTime), 2, 232.4200, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10667, N'ERNSH', 7, CAST(N'1997-09-12T00:00:00' AS SmallDateTime), CAST(N'1997-10-10T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), 1, 78.0900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10668, N'WANDK', 1, CAST(N'1997-09-15T00:00:00' AS SmallDateTime), CAST(N'1997-10-13T00:00:00' AS SmallDateTime), CAST(N'1997-09-23T00:00:00' AS SmallDateTime), 2, 47.2200, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10669, N'SIMOB', 2, CAST(N'1997-09-15T00:00:00' AS SmallDateTime), CAST(N'1997-10-13T00:00:00' AS SmallDateTime), CAST(N'1997-09-22T00:00:00' AS SmallDateTime), 1, 24.3900, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10670, N'FRANK', 4, CAST(N'1997-09-16T00:00:00' AS SmallDateTime), CAST(N'1997-10-14T00:00:00' AS SmallDateTime), CAST(N'1997-09-18T00:00:00' AS SmallDateTime), 1, 203.4800, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10671, N'FRANR', 1, CAST(N'1997-09-17T00:00:00' AS SmallDateTime), CAST(N'1997-10-15T00:00:00' AS SmallDateTime), CAST(N'1997-09-24T00:00:00' AS SmallDateTime), 1, 30.3400, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10672, N'BERGS', 9, CAST(N'1997-09-17T00:00:00' AS SmallDateTime), CAST(N'1997-10-01T00:00:00' AS SmallDateTime), CAST(N'1997-09-26T00:00:00' AS SmallDateTime), 2, 95.7500, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10673, N'WILMK', 2, CAST(N'1997-09-18T00:00:00' AS SmallDateTime), CAST(N'1997-10-16T00:00:00' AS SmallDateTime), CAST(N'1997-09-19T00:00:00' AS SmallDateTime), 1, 22.7600, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10674, N'ISLAT', 4, CAST(N'1997-09-18T00:00:00' AS SmallDateTime), CAST(N'1997-10-16T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), 2, 0.9000, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10675, N'FRANK', 5, CAST(N'1997-09-19T00:00:00' AS SmallDateTime), CAST(N'1997-10-17T00:00:00' AS SmallDateTime), CAST(N'1997-09-23T00:00:00' AS SmallDateTime), 2, 31.8500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10676, N'TORTU', 2, CAST(N'1997-09-22T00:00:00' AS SmallDateTime), CAST(N'1997-10-20T00:00:00' AS SmallDateTime), CAST(N'1997-09-29T00:00:00' AS SmallDateTime), 2, 2.0100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10677, N'ANTON', 1, CAST(N'1997-09-22T00:00:00' AS SmallDateTime), CAST(N'1997-10-20T00:00:00' AS SmallDateTime), CAST(N'1997-09-26T00:00:00' AS SmallDateTime), 3, 4.0300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10678, N'SAVEA', 7, CAST(N'1997-09-23T00:00:00' AS SmallDateTime), CAST(N'1997-10-21T00:00:00' AS SmallDateTime), CAST(N'1997-10-16T00:00:00' AS SmallDateTime), 3, 388.9800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10679, N'BLONP', 8, CAST(N'1997-09-23T00:00:00' AS SmallDateTime), CAST(N'1997-10-21T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), 3, 27.9400, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10680, N'OLDWO', 1, CAST(N'1997-09-24T00:00:00' AS SmallDateTime), CAST(N'1997-10-22T00:00:00' AS SmallDateTime), CAST(N'1997-09-26T00:00:00' AS SmallDateTime), 1, 26.6100, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10681, N'GREAL', 3, CAST(N'1997-09-25T00:00:00' AS SmallDateTime), CAST(N'1997-10-23T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), 3, 76.1300, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10682, N'ANTON', 3, CAST(N'1997-09-25T00:00:00' AS SmallDateTime), CAST(N'1997-10-23T00:00:00' AS SmallDateTime), CAST(N'1997-10-01T00:00:00' AS SmallDateTime), 2, 36.1300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10683, N'DUMON', 2, CAST(N'1997-09-26T00:00:00' AS SmallDateTime), CAST(N'1997-10-24T00:00:00' AS SmallDateTime), CAST(N'1997-10-01T00:00:00' AS SmallDateTime), 1, 4.4000, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10684, N'OTTIK', 3, CAST(N'1997-09-26T00:00:00' AS SmallDateTime), CAST(N'1997-10-24T00:00:00' AS SmallDateTime), CAST(N'1997-09-30T00:00:00' AS SmallDateTime), 1, 145.6300, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10685, N'GOURL', 4, CAST(N'1997-09-29T00:00:00' AS SmallDateTime), CAST(N'1997-10-13T00:00:00' AS SmallDateTime), CAST(N'1997-10-03T00:00:00' AS SmallDateTime), 2, 33.7500, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10686, N'PICCO', 2, CAST(N'1997-09-30T00:00:00' AS SmallDateTime), CAST(N'1997-10-28T00:00:00' AS SmallDateTime), CAST(N'1997-10-08T00:00:00' AS SmallDateTime), 1, 96.5000, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10687, N'HUNGO', 9, CAST(N'1997-09-30T00:00:00' AS SmallDateTime), CAST(N'1997-10-28T00:00:00' AS SmallDateTime), CAST(N'1997-10-30T00:00:00' AS SmallDateTime), 2, 296.4300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10688, N'VAFFE', 4, CAST(N'1997-10-01T00:00:00' AS SmallDateTime), CAST(N'1997-10-15T00:00:00' AS SmallDateTime), CAST(N'1997-10-07T00:00:00' AS SmallDateTime), 2, 299.0900, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10689, N'BERGS', 1, CAST(N'1997-10-01T00:00:00' AS SmallDateTime), CAST(N'1997-10-29T00:00:00' AS SmallDateTime), CAST(N'1997-10-07T00:00:00' AS SmallDateTime), 2, 13.4200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10690, N'HANAR', 1, CAST(N'1997-10-02T00:00:00' AS SmallDateTime), CAST(N'1997-10-30T00:00:00' AS SmallDateTime), CAST(N'1997-10-03T00:00:00' AS SmallDateTime), 1, 15.8000, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10691, N'QUICK', 2, CAST(N'1997-10-03T00:00:00' AS SmallDateTime), CAST(N'1997-11-14T00:00:00' AS SmallDateTime), CAST(N'1997-10-22T00:00:00' AS SmallDateTime), 2, 810.0500, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10692, N'ALFKI', 4, CAST(N'1997-10-03T00:00:00' AS SmallDateTime), CAST(N'1997-10-31T00:00:00' AS SmallDateTime), CAST(N'1997-10-13T00:00:00' AS SmallDateTime), 2, 61.0200, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10693, N'WHITC', 3, CAST(N'1997-10-06T00:00:00' AS SmallDateTime), CAST(N'1997-10-20T00:00:00' AS SmallDateTime), CAST(N'1997-10-10T00:00:00' AS SmallDateTime), 3, 139.3400, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10694, N'QUICK', 8, CAST(N'1997-10-06T00:00:00' AS SmallDateTime), CAST(N'1997-11-03T00:00:00' AS SmallDateTime), CAST(N'1997-10-09T00:00:00' AS SmallDateTime), 3, 398.3600, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10695, N'WILMK', 7, CAST(N'1997-10-07T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), CAST(N'1997-10-14T00:00:00' AS SmallDateTime), 1, 16.7200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10696, N'WHITC', 8, CAST(N'1997-10-08T00:00:00' AS SmallDateTime), CAST(N'1997-11-19T00:00:00' AS SmallDateTime), CAST(N'1997-10-14T00:00:00' AS SmallDateTime), 3, 102.5500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10697, N'LINOD', 3, CAST(N'1997-10-08T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), CAST(N'1997-10-14T00:00:00' AS SmallDateTime), 1, 45.5200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10698, N'ERNSH', 4, CAST(N'1997-10-09T00:00:00' AS SmallDateTime), CAST(N'1997-11-06T00:00:00' AS SmallDateTime), CAST(N'1997-10-17T00:00:00' AS SmallDateTime), 1, 272.4700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10699, N'MORGK', 3, CAST(N'1997-10-09T00:00:00' AS SmallDateTime), CAST(N'1997-11-06T00:00:00' AS SmallDateTime), CAST(N'1997-10-13T00:00:00' AS SmallDateTime), 3, 0.5800, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10700, N'SAVEA', 3, CAST(N'1997-10-10T00:00:00' AS SmallDateTime), CAST(N'1997-11-07T00:00:00' AS SmallDateTime), CAST(N'1997-10-16T00:00:00' AS SmallDateTime), 1, 65.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10701, N'HUNGO', 6, CAST(N'1997-10-13T00:00:00' AS SmallDateTime), CAST(N'1997-10-27T00:00:00' AS SmallDateTime), CAST(N'1997-10-15T00:00:00' AS SmallDateTime), 3, 220.3100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10702, N'ALFKI', 4, CAST(N'1997-10-13T00:00:00' AS SmallDateTime), CAST(N'1997-11-24T00:00:00' AS SmallDateTime), CAST(N'1997-10-21T00:00:00' AS SmallDateTime), 1, 23.9400, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10703, N'FOLKO', 6, CAST(N'1997-10-14T00:00:00' AS SmallDateTime), CAST(N'1997-11-11T00:00:00' AS SmallDateTime), CAST(N'1997-10-20T00:00:00' AS SmallDateTime), 2, 152.3000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10704, N'QUEEN', 6, CAST(N'1997-10-14T00:00:00' AS SmallDateTime), CAST(N'1997-11-11T00:00:00' AS SmallDateTime), CAST(N'1997-11-07T00:00:00' AS SmallDateTime), 1, 4.7800, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10705, N'HILAA', 9, CAST(N'1997-10-15T00:00:00' AS SmallDateTime), CAST(N'1997-11-12T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), 2, 3.5200, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10706, N'OLDWO', 8, CAST(N'1997-10-16T00:00:00' AS SmallDateTime), CAST(N'1997-11-13T00:00:00' AS SmallDateTime), CAST(N'1997-10-21T00:00:00' AS SmallDateTime), 3, 135.6300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10707, N'AROUT', 4, CAST(N'1997-10-16T00:00:00' AS SmallDateTime), CAST(N'1997-10-30T00:00:00' AS SmallDateTime), CAST(N'1997-10-23T00:00:00' AS SmallDateTime), 3, 21.7400, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10708, N'THEBI', 6, CAST(N'1997-10-17T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), 2, 2.9600, N'The Big Cheese', N'89 Jefferson Way
Suite 2', N'Portland', N'OR', N'97201', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10709, N'GOURL', 1, CAST(N'1997-10-17T00:00:00' AS SmallDateTime), CAST(N'1997-11-14T00:00:00' AS SmallDateTime), CAST(N'1997-11-20T00:00:00' AS SmallDateTime), 3, 210.8000, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10710, N'FRANS', 1, CAST(N'1997-10-20T00:00:00' AS SmallDateTime), CAST(N'1997-11-17T00:00:00' AS SmallDateTime), CAST(N'1997-10-23T00:00:00' AS SmallDateTime), 1, 4.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10711, N'SAVEA', 5, CAST(N'1997-10-21T00:00:00' AS SmallDateTime), CAST(N'1997-12-02T00:00:00' AS SmallDateTime), CAST(N'1997-10-29T00:00:00' AS SmallDateTime), 2, 52.4100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10712, N'HUNGO', 3, CAST(N'1997-10-21T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), CAST(N'1997-10-31T00:00:00' AS SmallDateTime), 1, 89.9300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10713, N'SAVEA', 1, CAST(N'1997-10-22T00:00:00' AS SmallDateTime), CAST(N'1997-11-19T00:00:00' AS SmallDateTime), CAST(N'1997-10-24T00:00:00' AS SmallDateTime), 1, 167.0500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10714, N'SAVEA', 5, CAST(N'1997-10-22T00:00:00' AS SmallDateTime), CAST(N'1997-11-19T00:00:00' AS SmallDateTime), CAST(N'1997-10-27T00:00:00' AS SmallDateTime), 3, 24.4900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10715, N'BONAP', 3, CAST(N'1997-10-23T00:00:00' AS SmallDateTime), CAST(N'1997-11-06T00:00:00' AS SmallDateTime), CAST(N'1997-10-29T00:00:00' AS SmallDateTime), 1, 63.2000, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10716, N'RANCH', 4, CAST(N'1997-10-24T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), CAST(N'1997-10-27T00:00:00' AS SmallDateTime), 2, 22.5700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10717, N'FRANK', 1, CAST(N'1997-10-24T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), CAST(N'1997-10-29T00:00:00' AS SmallDateTime), 2, 59.2500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10718, N'KOENE', 1, CAST(N'1997-10-27T00:00:00' AS SmallDateTime), CAST(N'1997-11-24T00:00:00' AS SmallDateTime), CAST(N'1997-10-29T00:00:00' AS SmallDateTime), 3, 170.8800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10719, N'LETSS', 8, CAST(N'1997-10-27T00:00:00' AS SmallDateTime), CAST(N'1997-11-24T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), 2, 51.4400, N'Let''s Stop N Shop', N'87 Polk St.
Suite 5', N'San Francisco', N'CA', N'94117', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10720, N'QUEDE', 8, CAST(N'1997-10-28T00:00:00' AS SmallDateTime), CAST(N'1997-11-11T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), 2, 9.5300, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10721, N'QUICK', 5, CAST(N'1997-10-29T00:00:00' AS SmallDateTime), CAST(N'1997-11-26T00:00:00' AS SmallDateTime), CAST(N'1997-10-31T00:00:00' AS SmallDateTime), 3, 48.9200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10722, N'SAVEA', 8, CAST(N'1997-10-29T00:00:00' AS SmallDateTime), CAST(N'1997-12-10T00:00:00' AS SmallDateTime), CAST(N'1997-11-04T00:00:00' AS SmallDateTime), 1, 74.5800, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10723, N'WHITC', 3, CAST(N'1997-10-30T00:00:00' AS SmallDateTime), CAST(N'1997-11-27T00:00:00' AS SmallDateTime), CAST(N'1997-11-25T00:00:00' AS SmallDateTime), 1, 21.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10724, N'MEREP', 8, CAST(N'1997-10-30T00:00:00' AS SmallDateTime), CAST(N'1997-12-11T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), 2, 57.7500, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10725, N'FAMIA', 4, CAST(N'1997-10-31T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-11-05T00:00:00' AS SmallDateTime), 3, 10.8300, N'Familia Arquibaldo', N'Rua Orós, 92', N'São Paulo', N'SP', N'05442-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10726, N'EASTC', 4, CAST(N'1997-11-03T00:00:00' AS SmallDateTime), CAST(N'1997-11-17T00:00:00' AS SmallDateTime), CAST(N'1997-12-05T00:00:00' AS SmallDateTime), 1, 16.5600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10727, N'REGGC', 2, CAST(N'1997-11-03T00:00:00' AS SmallDateTime), CAST(N'1997-12-01T00:00:00' AS SmallDateTime), CAST(N'1997-12-05T00:00:00' AS SmallDateTime), 1, 89.9000, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10728, N'QUEEN', 4, CAST(N'1997-11-04T00:00:00' AS SmallDateTime), CAST(N'1997-12-02T00:00:00' AS SmallDateTime), CAST(N'1997-11-11T00:00:00' AS SmallDateTime), 2, 58.3300, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10729, N'LINOD', 8, CAST(N'1997-11-04T00:00:00' AS SmallDateTime), CAST(N'1997-12-16T00:00:00' AS SmallDateTime), CAST(N'1997-11-14T00:00:00' AS SmallDateTime), 3, 141.0600, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10730, N'BONAP', 5, CAST(N'1997-11-05T00:00:00' AS SmallDateTime), CAST(N'1997-12-03T00:00:00' AS SmallDateTime), CAST(N'1997-11-14T00:00:00' AS SmallDateTime), 1, 20.1200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10731, N'CHOPS', 7, CAST(N'1997-11-06T00:00:00' AS SmallDateTime), CAST(N'1997-12-04T00:00:00' AS SmallDateTime), CAST(N'1997-11-14T00:00:00' AS SmallDateTime), 1, 96.6500, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10732, N'BONAP', 3, CAST(N'1997-11-06T00:00:00' AS SmallDateTime), CAST(N'1997-12-04T00:00:00' AS SmallDateTime), CAST(N'1997-11-07T00:00:00' AS SmallDateTime), 1, 16.9700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10733, N'BERGS', 1, CAST(N'1997-11-07T00:00:00' AS SmallDateTime), CAST(N'1997-12-05T00:00:00' AS SmallDateTime), CAST(N'1997-11-10T00:00:00' AS SmallDateTime), 3, 110.1100, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10734, N'GOURL', 2, CAST(N'1997-11-07T00:00:00' AS SmallDateTime), CAST(N'1997-12-05T00:00:00' AS SmallDateTime), CAST(N'1997-11-12T00:00:00' AS SmallDateTime), 3, 1.6300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10735, N'LETSS', 6, CAST(N'1997-11-10T00:00:00' AS SmallDateTime), CAST(N'1997-12-08T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), 2, 45.9700, N'Let''s Stop N Shop', N'87 Polk St.
Suite 5', N'San Francisco', N'CA', N'94117', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10736, N'HUNGO', 9, CAST(N'1997-11-11T00:00:00' AS SmallDateTime), CAST(N'1997-12-09T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), 2, 44.1000, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10737, N'VINET', 2, CAST(N'1997-11-11T00:00:00' AS SmallDateTime), CAST(N'1997-12-09T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), 2, 7.7900, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10738, N'SPECD', 2, CAST(N'1997-11-12T00:00:00' AS SmallDateTime), CAST(N'1997-12-10T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), 1, 2.9100, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10739, N'VINET', 3, CAST(N'1997-11-12T00:00:00' AS SmallDateTime), CAST(N'1997-12-10T00:00:00' AS SmallDateTime), CAST(N'1997-11-17T00:00:00' AS SmallDateTime), 3, 11.0800, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10740, N'WHITC', 4, CAST(N'1997-11-13T00:00:00' AS SmallDateTime), CAST(N'1997-12-11T00:00:00' AS SmallDateTime), CAST(N'1997-11-25T00:00:00' AS SmallDateTime), 2, 81.8800, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10741, N'BERGS', 4, CAST(N'1997-11-14T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), 3, 10.9600, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10742, N'BOTTM', 3, CAST(N'1997-11-14T00:00:00' AS SmallDateTime), CAST(N'1997-12-12T00:00:00' AS SmallDateTime), CAST(N'1997-11-18T00:00:00' AS SmallDateTime), 3, 243.7300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10743, N'AROUT', 1, CAST(N'1997-11-17T00:00:00' AS SmallDateTime), CAST(N'1997-12-15T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), 2, 23.7200, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10744, N'VAFFE', 6, CAST(N'1997-11-17T00:00:00' AS SmallDateTime), CAST(N'1997-12-15T00:00:00' AS SmallDateTime), CAST(N'1997-11-24T00:00:00' AS SmallDateTime), 1, 69.1900, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10745, N'QUICK', 9, CAST(N'1997-11-18T00:00:00' AS SmallDateTime), CAST(N'1997-12-16T00:00:00' AS SmallDateTime), CAST(N'1997-11-27T00:00:00' AS SmallDateTime), 1, 3.5200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10746, N'CHOPS', 1, CAST(N'1997-11-19T00:00:00' AS SmallDateTime), CAST(N'1997-12-17T00:00:00' AS SmallDateTime), CAST(N'1997-11-21T00:00:00' AS SmallDateTime), 3, 31.4300, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10747, N'PICCO', 6, CAST(N'1997-11-19T00:00:00' AS SmallDateTime), CAST(N'1997-12-17T00:00:00' AS SmallDateTime), CAST(N'1997-11-26T00:00:00' AS SmallDateTime), 1, 117.3300, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10748, N'SAVEA', 3, CAST(N'1997-11-20T00:00:00' AS SmallDateTime), CAST(N'1997-12-18T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), 1, 232.5500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10749, N'ISLAT', 4, CAST(N'1997-11-20T00:00:00' AS SmallDateTime), CAST(N'1997-12-18T00:00:00' AS SmallDateTime), CAST(N'1997-12-19T00:00:00' AS SmallDateTime), 2, 61.5300, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10750, N'WARTH', 9, CAST(N'1997-11-21T00:00:00' AS SmallDateTime), CAST(N'1997-12-19T00:00:00' AS SmallDateTime), CAST(N'1997-11-24T00:00:00' AS SmallDateTime), 1, 79.3000, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10751, N'RICSU', 3, CAST(N'1997-11-24T00:00:00' AS SmallDateTime), CAST(N'1997-12-22T00:00:00' AS SmallDateTime), CAST(N'1997-12-03T00:00:00' AS SmallDateTime), 3, 130.7900, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10752, N'NORTS', 2, CAST(N'1997-11-24T00:00:00' AS SmallDateTime), CAST(N'1997-12-22T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), 3, 1.3900, N'North/South', N'South House
300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10753, N'FRANS', 3, CAST(N'1997-11-25T00:00:00' AS SmallDateTime), CAST(N'1997-12-23T00:00:00' AS SmallDateTime), CAST(N'1997-11-27T00:00:00' AS SmallDateTime), 1, 7.7000, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10754, N'MAGAA', 6, CAST(N'1997-11-25T00:00:00' AS SmallDateTime), CAST(N'1997-12-23T00:00:00' AS SmallDateTime), CAST(N'1997-11-27T00:00:00' AS SmallDateTime), 3, 2.3800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10755, N'BONAP', 4, CAST(N'1997-11-26T00:00:00' AS SmallDateTime), CAST(N'1997-12-24T00:00:00' AS SmallDateTime), CAST(N'1997-11-28T00:00:00' AS SmallDateTime), 2, 16.7100, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10756, N'SPLIR', 8, CAST(N'1997-11-27T00:00:00' AS SmallDateTime), CAST(N'1997-12-25T00:00:00' AS SmallDateTime), CAST(N'1997-12-02T00:00:00' AS SmallDateTime), 2, 73.2100, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10757, N'SAVEA', 6, CAST(N'1997-11-27T00:00:00' AS SmallDateTime), CAST(N'1997-12-25T00:00:00' AS SmallDateTime), CAST(N'1997-12-15T00:00:00' AS SmallDateTime), 1, 8.1900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10758, N'RICSU', 3, CAST(N'1997-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-12-26T00:00:00' AS SmallDateTime), CAST(N'1997-12-04T00:00:00' AS SmallDateTime), 3, 138.1700, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10759, N'ANATR', 3, CAST(N'1997-11-28T00:00:00' AS SmallDateTime), CAST(N'1997-12-26T00:00:00' AS SmallDateTime), CAST(N'1997-12-12T00:00:00' AS SmallDateTime), 3, 11.9900, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10760, N'MAISD', 4, CAST(N'1997-12-01T00:00:00' AS SmallDateTime), CAST(N'1997-12-29T00:00:00' AS SmallDateTime), CAST(N'1997-12-10T00:00:00' AS SmallDateTime), 1, 155.6400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10761, N'RATTC', 5, CAST(N'1997-12-02T00:00:00' AS SmallDateTime), CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1997-12-08T00:00:00' AS SmallDateTime), 2, 18.6600, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10762, N'FOLKO', 3, CAST(N'1997-12-02T00:00:00' AS SmallDateTime), CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1997-12-09T00:00:00' AS SmallDateTime), 1, 328.7400, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10763, N'FOLIG', 3, CAST(N'1997-12-03T00:00:00' AS SmallDateTime), CAST(N'1997-12-31T00:00:00' AS SmallDateTime), CAST(N'1997-12-08T00:00:00' AS SmallDateTime), 3, 37.3500, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10764, N'ERNSH', 6, CAST(N'1997-12-03T00:00:00' AS SmallDateTime), CAST(N'1997-12-31T00:00:00' AS SmallDateTime), CAST(N'1997-12-08T00:00:00' AS SmallDateTime), 3, 145.4500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10765, N'QUICK', 3, CAST(N'1997-12-04T00:00:00' AS SmallDateTime), CAST(N'1998-01-01T00:00:00' AS SmallDateTime), CAST(N'1997-12-09T00:00:00' AS SmallDateTime), 3, 42.7400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10766, N'OTTIK', 4, CAST(N'1997-12-05T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), CAST(N'1997-12-09T00:00:00' AS SmallDateTime), 1, 157.5500, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10767, N'SUPRD', 4, CAST(N'1997-12-05T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), CAST(N'1997-12-15T00:00:00' AS SmallDateTime), 3, 1.5900, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10768, N'AROUT', 3, CAST(N'1997-12-08T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), CAST(N'1997-12-15T00:00:00' AS SmallDateTime), 2, 146.3200, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10769, N'VAFFE', 3, CAST(N'1997-12-08T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), CAST(N'1997-12-12T00:00:00' AS SmallDateTime), 1, 65.0600, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10770, N'HANAR', 8, CAST(N'1997-12-09T00:00:00' AS SmallDateTime), CAST(N'1998-01-06T00:00:00' AS SmallDateTime), CAST(N'1997-12-17T00:00:00' AS SmallDateTime), 3, 5.3200, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10771, N'ERNSH', 9, CAST(N'1997-12-10T00:00:00' AS SmallDateTime), CAST(N'1998-01-07T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), 2, 11.1900, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10772, N'LEHMS', 3, CAST(N'1997-12-10T00:00:00' AS SmallDateTime), CAST(N'1998-01-07T00:00:00' AS SmallDateTime), CAST(N'1997-12-19T00:00:00' AS SmallDateTime), 2, 91.2800, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10773, N'ERNSH', 1, CAST(N'1997-12-11T00:00:00' AS SmallDateTime), CAST(N'1998-01-08T00:00:00' AS SmallDateTime), CAST(N'1997-12-16T00:00:00' AS SmallDateTime), 3, 96.4300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10774, N'FOLKO', 4, CAST(N'1997-12-11T00:00:00' AS SmallDateTime), CAST(N'1997-12-25T00:00:00' AS SmallDateTime), CAST(N'1997-12-12T00:00:00' AS SmallDateTime), 1, 48.2000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10775, N'THECR', 7, CAST(N'1997-12-12T00:00:00' AS SmallDateTime), CAST(N'1998-01-09T00:00:00' AS SmallDateTime), CAST(N'1997-12-26T00:00:00' AS SmallDateTime), 1, 20.2500, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10776, N'ERNSH', 1, CAST(N'1997-12-15T00:00:00' AS SmallDateTime), CAST(N'1998-01-12T00:00:00' AS SmallDateTime), CAST(N'1997-12-18T00:00:00' AS SmallDateTime), 3, 351.5300, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10777, N'GOURL', 7, CAST(N'1997-12-15T00:00:00' AS SmallDateTime), CAST(N'1997-12-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), 2, 3.0100, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10778, N'BERGS', 3, CAST(N'1997-12-16T00:00:00' AS SmallDateTime), CAST(N'1998-01-13T00:00:00' AS SmallDateTime), CAST(N'1997-12-24T00:00:00' AS SmallDateTime), 1, 6.7900, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10779, N'MORGK', 3, CAST(N'1997-12-16T00:00:00' AS SmallDateTime), CAST(N'1998-01-13T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), 2, 58.1300, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10780, N'LILAS', 2, CAST(N'1997-12-16T00:00:00' AS SmallDateTime), CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1997-12-25T00:00:00' AS SmallDateTime), 1, 42.1300, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10781, N'WARTH', 2, CAST(N'1997-12-17T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), CAST(N'1997-12-19T00:00:00' AS SmallDateTime), 3, 73.1600, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10782, N'CACTU', 9, CAST(N'1997-12-17T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), CAST(N'1997-12-22T00:00:00' AS SmallDateTime), 3, 1.1000, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10783, N'HANAR', 4, CAST(N'1997-12-18T00:00:00' AS SmallDateTime), CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1997-12-19T00:00:00' AS SmallDateTime), 2, 124.9800, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10784, N'MAGAA', 4, CAST(N'1997-12-18T00:00:00' AS SmallDateTime), CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1997-12-22T00:00:00' AS SmallDateTime), 3, 70.0900, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10785, N'GROSR', 1, CAST(N'1997-12-18T00:00:00' AS SmallDateTime), CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1997-12-24T00:00:00' AS SmallDateTime), 3, 1.5100, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10786, N'QUEEN', 8, CAST(N'1997-12-19T00:00:00' AS SmallDateTime), CAST(N'1998-01-16T00:00:00' AS SmallDateTime), CAST(N'1997-12-23T00:00:00' AS SmallDateTime), 1, 110.8700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10787, N'LAMAI', 2, CAST(N'1997-12-19T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), CAST(N'1997-12-26T00:00:00' AS SmallDateTime), 1, 249.9300, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10788, N'QUICK', 1, CAST(N'1997-12-22T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), 2, 42.7000, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10789, N'FOLIG', 1, CAST(N'1997-12-22T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1997-12-31T00:00:00' AS SmallDateTime), 2, 100.6000, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10790, N'GOURL', 6, CAST(N'1997-12-22T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1997-12-26T00:00:00' AS SmallDateTime), 1, 28.2300, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10791, N'FRANK', 6, CAST(N'1997-12-23T00:00:00' AS SmallDateTime), CAST(N'1998-01-20T00:00:00' AS SmallDateTime), CAST(N'1998-01-01T00:00:00' AS SmallDateTime), 2, 16.8500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10792, N'WOLZA', 1, CAST(N'1997-12-23T00:00:00' AS SmallDateTime), CAST(N'1998-01-20T00:00:00' AS SmallDateTime), CAST(N'1997-12-31T00:00:00' AS SmallDateTime), 3, 23.7900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10793, N'AROUT', 3, CAST(N'1997-12-24T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-01-08T00:00:00' AS SmallDateTime), 3, 4.5200, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10794, N'QUEDE', 6, CAST(N'1997-12-24T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), 1, 21.4900, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10795, N'ERNSH', 8, CAST(N'1997-12-24T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-01-20T00:00:00' AS SmallDateTime), 2, 126.6600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10796, N'HILAA', 3, CAST(N'1997-12-25T00:00:00' AS SmallDateTime), CAST(N'1998-01-22T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), 1, 26.5200, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10797, N'DRACD', 7, CAST(N'1997-12-25T00:00:00' AS SmallDateTime), CAST(N'1998-01-22T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), 2, 33.3500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10798, N'ISLAT', 2, CAST(N'1997-12-26T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), 1, 2.3300, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10799, N'KOENE', 9, CAST(N'1997-12-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), 3, 30.7600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10800, N'SEVES', 1, CAST(N'1997-12-26T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), 3, 137.4400, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10801, N'BOLID', 4, CAST(N'1997-12-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-26T00:00:00' AS SmallDateTime), CAST(N'1997-12-31T00:00:00' AS SmallDateTime), 2, 97.0900, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10802, N'SIMOB', 4, CAST(N'1997-12-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-26T00:00:00' AS SmallDateTime), CAST(N'1998-01-02T00:00:00' AS SmallDateTime), 2, 257.2600, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10803, N'WELLI', 4, CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-01-06T00:00:00' AS SmallDateTime), 1, 55.2300, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10804, N'SEVES', 6, CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-01-07T00:00:00' AS SmallDateTime), 2, 27.3300, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10805, N'THEBI', 2, CAST(N'1997-12-30T00:00:00' AS SmallDateTime), CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-01-09T00:00:00' AS SmallDateTime), 3, 237.3400, N'The Big Cheese', N'89 Jefferson Way
Suite 2', N'Portland', N'OR', N'97201', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10806, N'VICTE', 3, CAST(N'1997-12-31T00:00:00' AS SmallDateTime), CAST(N'1998-01-28T00:00:00' AS SmallDateTime), CAST(N'1998-01-05T00:00:00' AS SmallDateTime), 2, 22.1100, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10807, N'FRANS', 4, CAST(N'1997-12-31T00:00:00' AS SmallDateTime), CAST(N'1998-01-28T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 1, 1.3600, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10808, N'OLDWO', 2, CAST(N'1998-01-01T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-09T00:00:00' AS SmallDateTime), 3, 45.5300, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10809, N'WELLI', 7, CAST(N'1998-01-01T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-07T00:00:00' AS SmallDateTime), 1, 4.8700, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10810, N'LAUGB', 2, CAST(N'1998-01-01T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-01-07T00:00:00' AS SmallDateTime), 3, 4.3300, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10811, N'LINOD', 8, CAST(N'1998-01-02T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), CAST(N'1998-01-08T00:00:00' AS SmallDateTime), 1, 31.2200, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10812, N'REGGC', 5, CAST(N'1998-01-02T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), CAST(N'1998-01-12T00:00:00' AS SmallDateTime), 1, 59.7800, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10813, N'RICAR', 1, CAST(N'1998-01-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-01-09T00:00:00' AS SmallDateTime), 1, 47.3800, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10814, N'VICTE', 3, CAST(N'1998-01-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), 3, 130.9400, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10815, N'SAVEA', 2, CAST(N'1998-01-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), 3, 14.6200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10816, N'GREAL', 4, CAST(N'1998-01-06T00:00:00' AS SmallDateTime), CAST(N'1998-02-03T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), 2, 719.7800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10817, N'KOENE', 3, CAST(N'1998-01-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-20T00:00:00' AS SmallDateTime), CAST(N'1998-01-13T00:00:00' AS SmallDateTime), 2, 306.0700, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10818, N'MAGAA', 7, CAST(N'1998-01-07T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-01-12T00:00:00' AS SmallDateTime), 3, 65.4800, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10819, N'CACTU', 2, CAST(N'1998-01-07T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-01-16T00:00:00' AS SmallDateTime), 3, 19.7600, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10820, N'RATTC', 3, CAST(N'1998-01-07T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-01-13T00:00:00' AS SmallDateTime), 2, 37.5200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10821, N'SPLIR', 1, CAST(N'1998-01-08T00:00:00' AS SmallDateTime), CAST(N'1998-02-05T00:00:00' AS SmallDateTime), CAST(N'1998-01-15T00:00:00' AS SmallDateTime), 1, 36.6800, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10822, N'TRAIH', 6, CAST(N'1998-01-08T00:00:00' AS SmallDateTime), CAST(N'1998-02-05T00:00:00' AS SmallDateTime), CAST(N'1998-01-16T00:00:00' AS SmallDateTime), 3, 7.0000, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10823, N'LILAS', 5, CAST(N'1998-01-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-13T00:00:00' AS SmallDateTime), 2, 163.9700, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10824, N'FOLKO', 8, CAST(N'1998-01-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 1, 1.2300, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10825, N'DRACD', 1, CAST(N'1998-01-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-14T00:00:00' AS SmallDateTime), 1, 79.2500, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10826, N'BLONP', 6, CAST(N'1998-01-12T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), 1, 7.0900, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10827, N'BONAP', 1, CAST(N'1998-01-12T00:00:00' AS SmallDateTime), CAST(N'1998-01-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), 2, 63.5400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10828, N'RANCH', 9, CAST(N'1998-01-13T00:00:00' AS SmallDateTime), CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), 1, 90.8500, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10829, N'ISLAT', 9, CAST(N'1998-01-13T00:00:00' AS SmallDateTime), CAST(N'1998-02-10T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 1, 154.7200, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10830, N'TRADH', 4, CAST(N'1998-01-13T00:00:00' AS SmallDateTime), CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), 2, 81.8300, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10831, N'SANTG', 3, CAST(N'1998-01-14T00:00:00' AS SmallDateTime), CAST(N'1998-02-11T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 2, 72.1900, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10832, N'LAMAI', 2, CAST(N'1998-01-14T00:00:00' AS SmallDateTime), CAST(N'1998-02-11T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), 2, 43.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10833, N'OTTIK', 6, CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 2, 71.4900, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10834, N'TRADH', 1, CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-01-19T00:00:00' AS SmallDateTime), 3, 29.7800, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10835, N'ALFKI', 1, CAST(N'1998-01-15T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), 3, 69.5300, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10836, N'ERNSH', 7, CAST(N'1998-01-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-13T00:00:00' AS SmallDateTime), CAST(N'1998-01-21T00:00:00' AS SmallDateTime), 1, 411.8800, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10837, N'BERGS', 9, CAST(N'1998-01-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-13T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 3, 13.3200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10838, N'LINOD', 3, CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 3, 59.2800, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10839, N'TRADH', 3, CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-01-22T00:00:00' AS SmallDateTime), 3, 35.4300, N'Tradição Hipermercados', N'Av. Inês de Castro, 414', N'São Paulo', N'SP', N'05634-030', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10840, N'LINOD', 4, CAST(N'1998-01-19T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-02-16T00:00:00' AS SmallDateTime), 2, 2.7100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10841, N'SUPRD', 5, CAST(N'1998-01-20T00:00:00' AS SmallDateTime), CAST(N'1998-02-17T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), 2, 424.3000, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10842, N'TORTU', 1, CAST(N'1998-01-20T00:00:00' AS SmallDateTime), CAST(N'1998-02-17T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), 3, 54.4200, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10843, N'VICTE', 4, CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), CAST(N'1998-01-26T00:00:00' AS SmallDateTime), 2, 9.2600, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10844, N'PICCO', 8, CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), CAST(N'1998-01-26T00:00:00' AS SmallDateTime), 2, 25.2200, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10845, N'QUICK', 8, CAST(N'1998-01-21T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 1, 212.9800, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10846, N'SUPRD', 2, CAST(N'1998-01-22T00:00:00' AS SmallDateTime), CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-01-23T00:00:00' AS SmallDateTime), 3, 56.4600, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10847, N'SAVEA', 4, CAST(N'1998-01-22T00:00:00' AS SmallDateTime), CAST(N'1998-02-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-10T00:00:00' AS SmallDateTime), 3, 487.5700, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10848, N'CONSH', 7, CAST(N'1998-01-23T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), CAST(N'1998-01-29T00:00:00' AS SmallDateTime), 2, 38.2400, N'Consolidated Holdings', N'Berkeley Gardens
12  Brewery ', N'London', NULL, N'WX1 6LT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10849, N'KOENE', 9, CAST(N'1998-01-23T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 2, 0.5600, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10850, N'VICTE', 1, CAST(N'1998-01-23T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 1, 49.1900, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10851, N'RICAR', 5, CAST(N'1998-01-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-23T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), 1, 160.5500, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10852, N'RATTC', 8, CAST(N'1998-01-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), CAST(N'1998-01-30T00:00:00' AS SmallDateTime), 1, 174.0500, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10853, N'BLAUS', 9, CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-02-03T00:00:00' AS SmallDateTime), 2, 53.8300, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10854, N'ERNSH', 3, CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-02-05T00:00:00' AS SmallDateTime), 2, 100.2200, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10855, N'OLDWO', 3, CAST(N'1998-01-27T00:00:00' AS SmallDateTime), CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), 1, 170.9700, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10856, N'ANTON', 3, CAST(N'1998-01-28T00:00:00' AS SmallDateTime), CAST(N'1998-02-25T00:00:00' AS SmallDateTime), CAST(N'1998-02-10T00:00:00' AS SmallDateTime), 2, 58.4300, N'Antonio Moreno Taquería', N'Mataderos  2312', N'México D.F.', NULL, N'05023', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10857, N'BERGS', 8, CAST(N'1998-01-28T00:00:00' AS SmallDateTime), CAST(N'1998-02-25T00:00:00' AS SmallDateTime), CAST(N'1998-02-06T00:00:00' AS SmallDateTime), 2, 188.8500, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10858, N'LACOR', 2, CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-03T00:00:00' AS SmallDateTime), 1, 52.5100, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10859, N'FRANK', 1, CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), 2, 76.1000, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10860, N'FRANR', 3, CAST(N'1998-01-29T00:00:00' AS SmallDateTime), CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-02-04T00:00:00' AS SmallDateTime), 3, 19.2600, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10861, N'WHITC', 4, CAST(N'1998-01-30T00:00:00' AS SmallDateTime), CAST(N'1998-02-27T00:00:00' AS SmallDateTime), CAST(N'1998-02-17T00:00:00' AS SmallDateTime), 2, 14.9300, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10862, N'LEHMS', 8, CAST(N'1998-01-30T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-02-02T00:00:00' AS SmallDateTime), 2, 53.2300, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10863, N'HILAA', 4, CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-02-17T00:00:00' AS SmallDateTime), 2, 30.2600, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10864, N'AROUT', 4, CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), 2, 3.0400, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10865, N'QUICK', 2, CAST(N'1998-02-02T00:00:00' AS SmallDateTime), CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), 1, 348.1400, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10866, N'BERGS', 5, CAST(N'1998-02-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-03T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), 1, 109.1100, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10867, N'LONEP', 6, CAST(N'1998-02-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-02-11T00:00:00' AS SmallDateTime), 1, 1.9300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10868, N'QUEEN', 7, CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-02-23T00:00:00' AS SmallDateTime), 2, 191.2700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10869, N'SEVES', 5, CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), 1, 143.2800, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10870, N'WHITC', 5, CAST(N'1998-02-04T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-02-13T00:00:00' AS SmallDateTime), 3, 12.0400, N'White Clover Markets', N'305 - 14th Ave. S.
Suite 3B', N'Seattle', N'WA', N'98128', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10871, N'BONAP', 9, CAST(N'1998-02-05T00:00:00' AS SmallDateTime), CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-10T00:00:00' AS SmallDateTime), 2, 112.2700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10872, N'GODOS', 5, CAST(N'1998-02-05T00:00:00' AS SmallDateTime), CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), 2, 175.3200, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10873, N'WILMK', 4, CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-02-09T00:00:00' AS SmallDateTime), 1, 0.8200, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10874, N'GODOS', 5, CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-02-11T00:00:00' AS SmallDateTime), 2, 19.5800, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10875, N'BERGS', 4, CAST(N'1998-02-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-03T00:00:00' AS SmallDateTime), 2, 32.3700, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10876, N'BONAP', 7, CAST(N'1998-02-09T00:00:00' AS SmallDateTime), CAST(N'1998-03-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), 3, 60.4200, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10877, N'RICAR', 1, CAST(N'1998-02-09T00:00:00' AS SmallDateTime), CAST(N'1998-03-09T00:00:00' AS SmallDateTime), CAST(N'1998-02-19T00:00:00' AS SmallDateTime), 1, 38.0600, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10878, N'QUICK', 4, CAST(N'1998-02-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-10T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), 1, 46.6900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10879, N'WILMK', 3, CAST(N'1998-02-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-10T00:00:00' AS SmallDateTime), CAST(N'1998-02-12T00:00:00' AS SmallDateTime), 3, 8.5000, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10880, N'FOLKO', 7, CAST(N'1998-02-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), 1, 88.0100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10881, N'CACTU', 4, CAST(N'1998-02-11T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), 1, 2.8400, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10882, N'SAVEA', 4, CAST(N'1998-02-11T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), 3, 23.1000, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10883, N'LONEP', 8, CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), 3, 0.5300, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10884, N'LETSS', 4, CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-02-13T00:00:00' AS SmallDateTime), 2, 90.9700, N'Let''s Stop N Shop', N'87 Polk St.
Suite 5', N'San Francisco', N'CA', N'94117', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10885, N'SUPRD', 6, CAST(N'1998-02-12T00:00:00' AS SmallDateTime), CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), 3, 5.6400, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10886, N'HANAR', 1, CAST(N'1998-02-13T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), 1, 4.9900, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10887, N'GALED', 8, CAST(N'1998-02-13T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-02-16T00:00:00' AS SmallDateTime), 3, 1.2500, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10888, N'GODOS', 1, CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-23T00:00:00' AS SmallDateTime), 2, 51.8700, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10889, N'RATTC', 9, CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-23T00:00:00' AS SmallDateTime), 3, 280.6100, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10890, N'DUMON', 7, CAST(N'1998-02-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-02-18T00:00:00' AS SmallDateTime), 1, 32.7600, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10891, N'LEHMS', 7, CAST(N'1998-02-17T00:00:00' AS SmallDateTime), CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-02-19T00:00:00' AS SmallDateTime), 2, 20.3700, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10892, N'MAISD', 4, CAST(N'1998-02-17T00:00:00' AS SmallDateTime), CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-02-19T00:00:00' AS SmallDateTime), 2, 120.2700, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10893, N'KOENE', 9, CAST(N'1998-02-18T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), 2, 77.7800, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10894, N'SAVEA', 1, CAST(N'1998-02-18T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-02-20T00:00:00' AS SmallDateTime), 1, 116.1300, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10895, N'ERNSH', 3, CAST(N'1998-02-18T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-02-23T00:00:00' AS SmallDateTime), 1, 162.7500, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10896, N'MAISD', 7, CAST(N'1998-02-19T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-02-27T00:00:00' AS SmallDateTime), 3, 32.4500, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10897, N'HUNGO', 3, CAST(N'1998-02-19T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-02-25T00:00:00' AS SmallDateTime), 2, 603.5400, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10898, N'OCEAN', 4, CAST(N'1998-02-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), 2, 1.2700, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10899, N'LILAS', 5, CAST(N'1998-02-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-02-26T00:00:00' AS SmallDateTime), 3, 1.2100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10900, N'WELLI', 1, CAST(N'1998-02-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), 2, 1.6600, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10901, N'HILAA', 4, CAST(N'1998-02-23T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), CAST(N'1998-02-26T00:00:00' AS SmallDateTime), 1, 62.0900, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10902, N'FOLKO', 1, CAST(N'1998-02-23T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), CAST(N'1998-03-03T00:00:00' AS SmallDateTime), 1, 44.1500, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10903, N'HANAR', 3, CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), 3, 36.7100, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10904, N'WHITC', 3, CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-02-27T00:00:00' AS SmallDateTime), 3, 162.9500, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10905, N'WELLI', 9, CAST(N'1998-02-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), 2, 13.7200, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10906, N'WOLZA', 4, CAST(N'1998-02-25T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-03-03T00:00:00' AS SmallDateTime), 3, 26.2900, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10907, N'SPECD', 6, CAST(N'1998-02-25T00:00:00' AS SmallDateTime), CAST(N'1998-03-25T00:00:00' AS SmallDateTime), CAST(N'1998-02-27T00:00:00' AS SmallDateTime), 3, 9.1900, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10908, N'REGGC', 4, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-06T00:00:00' AS SmallDateTime), 2, 32.9600, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10909, N'SANTG', 1, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-10T00:00:00' AS SmallDateTime), 2, 53.0500, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10910, N'WILMK', 1, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), 3, 38.1100, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10911, N'GODOS', 3, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-05T00:00:00' AS SmallDateTime), 1, 38.1900, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10912, N'HUNGO', 2, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 2, 580.9100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10913, N'QUEEN', 4, CAST(N'1998-02-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), 1, 33.0500, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10914, N'QUEEN', 6, CAST(N'1998-02-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), 1, 21.1900, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10915, N'TORTU', 2, CAST(N'1998-02-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-02T00:00:00' AS SmallDateTime), 2, 3.5100, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10916, N'RANCH', 1, CAST(N'1998-02-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-09T00:00:00' AS SmallDateTime), 2, 63.7700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10917, N'ROMEY', 4, CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), 2, 8.2900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10918, N'BOTTM', 3, CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), 3, 48.8300, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10919, N'LINOD', 2, CAST(N'1998-03-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-03-04T00:00:00' AS SmallDateTime), 2, 19.8000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10920, N'AROUT', 4, CAST(N'1998-03-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-31T00:00:00' AS SmallDateTime), CAST(N'1998-03-09T00:00:00' AS SmallDateTime), 2, 29.6100, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10921, N'VAFFE', 1, CAST(N'1998-03-03T00:00:00' AS SmallDateTime), CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-03-09T00:00:00' AS SmallDateTime), 1, 176.4800, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10922, N'HANAR', 5, CAST(N'1998-03-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-31T00:00:00' AS SmallDateTime), CAST(N'1998-03-05T00:00:00' AS SmallDateTime), 3, 62.7400, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10923, N'LAMAI', 7, CAST(N'1998-03-03T00:00:00' AS SmallDateTime), CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), 3, 68.2600, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10924, N'BERGS', 3, CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 2, 151.5200, N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10925, N'HANAR', 3, CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), 1, 2.2700, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10926, N'ANATR', 4, CAST(N'1998-03-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-03-11T00:00:00' AS SmallDateTime), 3, 39.9200, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10927, N'LACOR', 4, CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 1, 19.7900, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10928, N'GALED', 1, CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 1, 1.3600, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10929, N'FRANK', 6, CAST(N'1998-03-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-03-12T00:00:00' AS SmallDateTime), 1, 33.9300, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10930, N'SUPRD', 4, CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 3, 15.5500, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10931, N'RICSU', 4, CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), 2, 13.6000, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10932, N'BONAP', 8, CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), 1, 134.6400, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10933, N'ISLAT', 6, CAST(N'1998-03-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), 3, 54.1500, N'Island Trading', N'Garden House
Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10934, N'LEHMS', 3, CAST(N'1998-03-09T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-12T00:00:00' AS SmallDateTime), 3, 32.0100, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10935, N'WELLI', 4, CAST(N'1998-03-09T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 3, 47.5900, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10936, N'GREAL', 3, CAST(N'1998-03-09T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 2, 33.6800, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10937, N'CACTU', 7, CAST(N'1998-03-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), 3, 31.5100, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10938, N'QUICK', 3, CAST(N'1998-03-10T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), 2, 31.8900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10939, N'MAGAA', 2, CAST(N'1998-03-10T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), 2, 76.3300, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10940, N'BONAP', 8, CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), 3, 19.7700, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10941, N'SAVEA', 7, CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), 2, 400.8100, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10942, N'REGGC', 9, CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 3, 17.9500, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10943, N'BSBEV', 4, CAST(N'1998-03-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), 2, 2.1700, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10944, N'BOTTM', 6, CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-03-13T00:00:00' AS SmallDateTime), 3, 52.9200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10945, N'MORGK', 4, CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-03-18T00:00:00' AS SmallDateTime), 1, 10.2200, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10946, N'VAFFE', 1, CAST(N'1998-03-12T00:00:00' AS SmallDateTime), CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), 2, 27.2000, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10947, N'BSBEV', 3, CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-16T00:00:00' AS SmallDateTime), 2, 3.2600, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10948, N'GODOS', 3, CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-19T00:00:00' AS SmallDateTime), 3, 23.3900, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10949, N'BOTTM', 2, CAST(N'1998-03-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-03-17T00:00:00' AS SmallDateTime), 3, 74.4400, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10950, N'MAGAA', 1, CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-04-13T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), 2, 2.5000, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bérgamo', NULL, N'24100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10951, N'RICSU', 9, CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), 2, 30.8500, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10952, N'ALFKI', 1, CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), 1, 40.4200, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10953, N'AROUT', 9, CAST(N'1998-03-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-03-25T00:00:00' AS SmallDateTime), 2, 23.7200, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10954, N'LINOD', 5, CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), 1, 27.9100, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10955, N'FOLKO', 8, CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), 2, 3.2600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10956, N'BLAUS', 6, CAST(N'1998-03-17T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-03-20T00:00:00' AS SmallDateTime), 2, 44.6500, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10957, N'HILAA', 8, CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-04-15T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), 3, 105.3600, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10958, N'OCEAN', 7, CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-04-15T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), 2, 49.5600, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10959, N'GOURL', 6, CAST(N'1998-03-18T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), 2, 4.9800, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10960, N'HILAA', 3, CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 1, 2.0800, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10961, N'QUEEN', 8, CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), 1, 104.4700, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10962, N'QUICK', 8, CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-23T00:00:00' AS SmallDateTime), 2, 275.7900, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10963, N'FURIB', 9, CAST(N'1998-03-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), 3, 2.7000, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10964, N'SPECD', 3, CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-03-24T00:00:00' AS SmallDateTime), 2, 87.3800, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10965, N'OLDWO', 6, CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), 3, 144.3800, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10966, N'CHOPS', 4, CAST(N'1998-03-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 1, 27.1900, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10967, N'TOMSP', 2, CAST(N'1998-03-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), 2, 62.2200, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10968, N'ERNSH', 1, CAST(N'1998-03-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-01T00:00:00' AS SmallDateTime), 3, 74.6000, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10969, N'COMMI', 1, CAST(N'1998-03-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-03-30T00:00:00' AS SmallDateTime), 2, 0.2100, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'SP', N'05432-043', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10970, N'BOLID', 9, CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 1, 16.1600, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10971, N'FRANR', 2, CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), 2, 121.8200, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10972, N'LACOR', 4, CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-03-26T00:00:00' AS SmallDateTime), 2, 0.0200, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10973, N'LACOR', 6, CAST(N'1998-03-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), 2, 15.1700, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10974, N'SPLIR', 3, CAST(N'1998-03-25T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), 3, 12.9600, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10975, N'BOTTM', 1, CAST(N'1998-03-25T00:00:00' AS SmallDateTime), CAST(N'1998-04-22T00:00:00' AS SmallDateTime), CAST(N'1998-03-27T00:00:00' AS SmallDateTime), 3, 32.2700, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10976, N'HILAA', 1, CAST(N'1998-03-25T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), 1, 37.9700, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10977, N'FOLKO', 8, CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 3, 208.5000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10978, N'MAISD', 9, CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), 2, 32.8200, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10979, N'ERNSH', 8, CAST(N'1998-03-26T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-03-31T00:00:00' AS SmallDateTime), 2, 353.0700, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10980, N'FOLKO', 4, CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-08T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), 1, 1.2600, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10981, N'HANAR', 1, CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), 2, 193.3700, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10982, N'BOTTM', 2, CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 1, 14.0100, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10983, N'SAVEA', 2, CAST(N'1998-03-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), 2, 657.5400, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10984, N'SAVEA', 1, CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), 3, 211.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10985, N'HUNGO', 2, CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), 1, 91.5100, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10986, N'OCEAN', 8, CAST(N'1998-03-30T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), 2, 217.8600, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585
Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10987, N'EASTC', 8, CAST(N'1998-03-31T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), 1, 185.4800, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10988, N'RATTC', 3, CAST(N'1998-03-31T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 2, 61.1400, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10989, N'QUEDE', 2, CAST(N'1998-03-31T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-04-02T00:00:00' AS SmallDateTime), 1, 34.7600, N'Que Delícia', N'Rua da Panificadora, 12', N'Río de Janeiro', N'RJ', N'02389-673', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10990, N'ERNSH', 2, CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-05-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), 3, 117.6100, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10991, N'QUICK', 1, CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-04-07T00:00:00' AS SmallDateTime), 1, 38.5100, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10992, N'THEBI', 1, CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-04-03T00:00:00' AS SmallDateTime), 3, 4.2700, N'The Big Cheese', N'89 Jefferson Way
Suite 2', N'Portland', N'OR', N'97201', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10993, N'FOLKO', 7, CAST(N'1998-04-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 3, 8.8100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10994, N'VAFFE', 2, CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-04-09T00:00:00' AS SmallDateTime), 3, 65.5300, N'Vaffeljernet', N'Smagsløget 45', N'Århus', NULL, N'8200', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10995, N'PERIC', 1, CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-04-06T00:00:00' AS SmallDateTime), 3, 46.0000, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10996, N'QUICK', 4, CAST(N'1998-04-02T00:00:00' AS SmallDateTime), CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 2, 1.1200, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10997, N'LILAS', 8, CAST(N'1998-04-03T00:00:00' AS SmallDateTime), CAST(N'1998-05-15T00:00:00' AS SmallDateTime), CAST(N'1998-04-13T00:00:00' AS SmallDateTime), 2, 73.9100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10998, N'WOLZA', 8, CAST(N'1998-04-03T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), 2, 20.3100, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (10999, N'OTTIK', 6, CAST(N'1998-04-03T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 2, 96.3500, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11000, N'RATTC', 2, CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-14T00:00:00' AS SmallDateTime), 3, 55.1200, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11001, N'FOLKO', 2, CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-14T00:00:00' AS SmallDateTime), 2, 197.3000, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11002, N'SAVEA', 4, CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), 1, 141.1600, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11003, N'THECR', 3, CAST(N'1998-04-06T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-04-08T00:00:00' AS SmallDateTime), 3, 14.9100, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11004, N'MAISD', 3, CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), 1, 44.8400, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11005, N'WILMK', 2, CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 1, 0.7500, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11006, N'GREAL', 3, CAST(N'1998-04-07T00:00:00' AS SmallDateTime), CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-04-15T00:00:00' AS SmallDateTime), 2, 25.1900, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11007, N'PRINI', 8, CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-13T00:00:00' AS SmallDateTime), 2, 202.2400, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11008, N'ERNSH', 7, CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), NULL, 3, 79.4600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11009, N'GODOS', 2, CAST(N'1998-04-08T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 1, 59.1100, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11010, N'REGGC', 2, CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-05-07T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), 2, 28.7100, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11011, N'ALFKI', 3, CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-05-07T00:00:00' AS SmallDateTime), CAST(N'1998-04-13T00:00:00' AS SmallDateTime), 1, 1.2100, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlín', NULL, N'12209', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11012, N'FRANK', 1, CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-04-17T00:00:00' AS SmallDateTime), 3, 242.9500, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11013, N'ROMEY', 2, CAST(N'1998-04-09T00:00:00' AS SmallDateTime), CAST(N'1998-05-07T00:00:00' AS SmallDateTime), CAST(N'1998-04-10T00:00:00' AS SmallDateTime), 1, 32.9900, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11014, N'LINOD', 2, CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-05-08T00:00:00' AS SmallDateTime), CAST(N'1998-04-15T00:00:00' AS SmallDateTime), 3, 23.6000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11015, N'SANTG', 2, CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), 2, 4.6200, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Noruega', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11016, N'AROUT', 9, CAST(N'1998-04-10T00:00:00' AS SmallDateTime), CAST(N'1998-05-08T00:00:00' AS SmallDateTime), CAST(N'1998-04-13T00:00:00' AS SmallDateTime), 2, 33.8000, N'Around the Horn', N'Brook Farm
Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11017, N'ERNSH', 9, CAST(N'1998-04-13T00:00:00' AS SmallDateTime), CAST(N'1998-05-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), 2, 754.2600, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11018, N'LONEP', 4, CAST(N'1998-04-13T00:00:00' AS SmallDateTime), CAST(N'1998-05-11T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), 2, 11.6500, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11019, N'RANCH', 6, CAST(N'1998-04-13T00:00:00' AS SmallDateTime), CAST(N'1998-05-11T00:00:00' AS SmallDateTime), NULL, 3, 3.1700, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11020, N'OTTIK', 2, CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-05-12T00:00:00' AS SmallDateTime), CAST(N'1998-04-16T00:00:00' AS SmallDateTime), 2, 43.3000, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11021, N'QUICK', 3, CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-05-12T00:00:00' AS SmallDateTime), CAST(N'1998-04-21T00:00:00' AS SmallDateTime), 1, 297.1800, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11022, N'HANAR', 9, CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-05-12T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), 2, 6.2700, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11023, N'BSBEV', 1, CAST(N'1998-04-14T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 2, 123.8300, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11024, N'EASTC', 4, CAST(N'1998-04-15T00:00:00' AS SmallDateTime), CAST(N'1998-05-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), 1, 74.3600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11025, N'WARTH', 6, CAST(N'1998-04-15T00:00:00' AS SmallDateTime), CAST(N'1998-05-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 3, 29.1700, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finlandia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11026, N'FRANS', 4, CAST(N'1998-04-15T00:00:00' AS SmallDateTime), CAST(N'1998-05-13T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), 1, 47.0900, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11027, N'BOTTM', 1, CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-05-14T00:00:00' AS SmallDateTime), CAST(N'1998-04-20T00:00:00' AS SmallDateTime), 1, 52.5200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11028, N'KOENE', 2, CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-05-14T00:00:00' AS SmallDateTime), CAST(N'1998-04-22T00:00:00' AS SmallDateTime), 1, 29.5900, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11029, N'CHOPS', 4, CAST(N'1998-04-16T00:00:00' AS SmallDateTime), CAST(N'1998-05-14T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), 1, 47.8400, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11030, N'SAVEA', 7, CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-05-15T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), 2, 830.7500, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11031, N'SAVEA', 6, CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-05-15T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 2, 227.2200, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11032, N'WHITC', 2, CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-05-15T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), 3, 606.1900, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11033, N'RICSU', 7, CAST(N'1998-04-17T00:00:00' AS SmallDateTime), CAST(N'1998-05-15T00:00:00' AS SmallDateTime), CAST(N'1998-04-23T00:00:00' AS SmallDateTime), 3, 84.7400, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11034, N'OLDWO', 8, CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-06-01T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), 1, 40.3200, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11035, N'SUPRD', 2, CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-05-18T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 2, 0.1700, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11036, N'DRACD', 8, CAST(N'1998-04-20T00:00:00' AS SmallDateTime), CAST(N'1998-05-18T00:00:00' AS SmallDateTime), CAST(N'1998-04-22T00:00:00' AS SmallDateTime), 3, 149.4700, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11037, N'GODOS', 7, CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-05-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-27T00:00:00' AS SmallDateTime), 1, 3.2000, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'España', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11038, N'SUPRD', 1, CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-05-19T00:00:00' AS SmallDateTime), CAST(N'1998-04-30T00:00:00' AS SmallDateTime), 2, 29.5900, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Bélgica', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11039, N'LINOD', 1, CAST(N'1998-04-21T00:00:00' AS SmallDateTime), CAST(N'1998-05-19T00:00:00' AS SmallDateTime), NULL, 2, 65.0000, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11040, N'GREAL', 4, CAST(N'1998-04-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-20T00:00:00' AS SmallDateTime), NULL, 3, 18.8400, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11041, N'CHOPS', 3, CAST(N'1998-04-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-28T00:00:00' AS SmallDateTime), 2, 48.2200, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11042, N'COMMI', 2, CAST(N'1998-04-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 1, 29.9900, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'São Paulo', N'SP', N'05432-043', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11043, N'SPECD', 5, CAST(N'1998-04-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-20T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), 2, 8.8000, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11044, N'WOLZA', 4, CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-05-21T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 1, 8.7200, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Polonia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11045, N'BOTTM', 6, CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-05-21T00:00:00' AS SmallDateTime), NULL, 2, 70.5800, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11046, N'WANDK', 8, CAST(N'1998-04-23T00:00:00' AS SmallDateTime), CAST(N'1998-05-21T00:00:00' AS SmallDateTime), CAST(N'1998-04-24T00:00:00' AS SmallDateTime), 2, 71.6400, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Alemania', NULL)
GO
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11047, N'EASTC', 7, CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-05-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 3, 46.6200, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11048, N'BOTTM', 7, CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-05-22T00:00:00' AS SmallDateTime), CAST(N'1998-04-30T00:00:00' AS SmallDateTime), 3, 24.1200, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canadá', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11049, N'GOURL', 3, CAST(N'1998-04-24T00:00:00' AS SmallDateTime), CAST(N'1998-05-22T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), 1, 8.3400, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11050, N'FOLKO', 8, CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-25T00:00:00' AS SmallDateTime), CAST(N'1998-05-05T00:00:00' AS SmallDateTime), 2, 59.4100, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Suecia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11051, N'LAMAI', 7, CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-25T00:00:00' AS SmallDateTime), NULL, 3, 2.7900, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11052, N'HANAR', 3, CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-25T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 1, 67.2600, N'Hanari Carnes', N'Rua do Paço, 67', N'Río de Janeiro', N'RJ', N'05454-876', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11053, N'PICCO', 2, CAST(N'1998-04-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-25T00:00:00' AS SmallDateTime), CAST(N'1998-04-29T00:00:00' AS SmallDateTime), 2, 53.0500, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11054, N'CACTU', 8, CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-05-26T00:00:00' AS SmallDateTime), NULL, 1, 0.3300, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11055, N'HILAA', 7, CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-05-26T00:00:00' AS SmallDateTime), CAST(N'1998-05-05T00:00:00' AS SmallDateTime), 2, 120.9200, N'HILARIÓN-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11056, N'EASTC', 8, CAST(N'1998-04-28T00:00:00' AS SmallDateTime), CAST(N'1998-05-12T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 2, 278.9600, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11057, N'NORTS', 3, CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-05-27T00:00:00' AS SmallDateTime), CAST(N'1998-05-01T00:00:00' AS SmallDateTime), 3, 4.1300, N'North/South', N'South House
300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'Reino Unido', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11058, N'BLAUS', 9, CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-05-27T00:00:00' AS SmallDateTime), NULL, 3, 31.1400, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11059, N'RICAR', 2, CAST(N'1998-04-29T00:00:00' AS SmallDateTime), CAST(N'1998-06-10T00:00:00' AS SmallDateTime), NULL, 2, 85.8000, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Río de Janeiro', N'RJ', N'02389-890', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11060, N'FRANS', 2, CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-05-28T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), 2, 10.9800, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11061, N'GREAL', 4, CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-06-11T00:00:00' AS SmallDateTime), NULL, 3, 14.0100, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11062, N'REGGC', 4, CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-05-28T00:00:00' AS SmallDateTime), NULL, 2, 29.9300, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11063, N'HUNGO', 3, CAST(N'1998-04-30T00:00:00' AS SmallDateTime), CAST(N'1998-05-28T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), 2, 81.7300, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Irlanda', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11064, N'SAVEA', 1, CAST(N'1998-05-01T00:00:00' AS SmallDateTime), CAST(N'1998-05-29T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), 1, 30.0900, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11065, N'LILAS', 8, CAST(N'1998-05-01T00:00:00' AS SmallDateTime), CAST(N'1998-05-29T00:00:00' AS SmallDateTime), NULL, 1, 12.9100, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11066, N'WHITC', 7, CAST(N'1998-05-01T00:00:00' AS SmallDateTime), CAST(N'1998-05-29T00:00:00' AS SmallDateTime), CAST(N'1998-05-04T00:00:00' AS SmallDateTime), 2, 44.7200, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11067, N'DRACD', 1, CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-05-18T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), 2, 7.9800, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11068, N'QUEEN', 8, CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-06-01T00:00:00' AS SmallDateTime), NULL, 2, 81.7500, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'São Paulo', N'SP', N'05487-020', N'Brasil', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11069, N'TORTU', 1, CAST(N'1998-05-04T00:00:00' AS SmallDateTime), CAST(N'1998-06-01T00:00:00' AS SmallDateTime), CAST(N'1998-05-06T00:00:00' AS SmallDateTime), 2, 15.6700, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11070, N'LEHMS', 2, CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-06-02T00:00:00' AS SmallDateTime), NULL, 1, 136.0000, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M. ', NULL, N'60528', N'Alemania', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11071, N'LILAS', 1, CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-06-02T00:00:00' AS SmallDateTime), NULL, 1, 0.9300, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11072, N'ERNSH', 4, CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-06-02T00:00:00' AS SmallDateTime), NULL, 2, 258.6400, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11073, N'PERIC', 2, CAST(N'1998-05-05T00:00:00' AS SmallDateTime), CAST(N'1998-06-02T00:00:00' AS SmallDateTime), NULL, 2, 24.9500, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'México', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11074, N'SIMOB', 7, CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-06-03T00:00:00' AS SmallDateTime), NULL, 2, 18.4400, N'Simons bistro', N'Vinbæltet 34', N'København', NULL, N'1734', N'Dinamarca', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11075, N'RICSU', 8, CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-06-03T00:00:00' AS SmallDateTime), NULL, 2, 6.1900, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Suiza', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11076, N'BONAP', 4, CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-06-03T00:00:00' AS SmallDateTime), NULL, 2, 38.2800, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'Francia', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11077, N'RATTC', 1, CAST(N'1998-05-06T00:00:00' AS SmallDateTime), CAST(N'1998-06-03T00:00:00' AS SmallDateTime), NULL, 2, 8.5300, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'Estados Unidos', NULL)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11078, N'ANTON', 1, CAST(N'2017-11-12T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100.0000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11079, N'ALFKI', 1, CAST(N'2017-12-11T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 213.7500)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11080, N'BSBEV', 1, CAST(N'2017-12-11T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 228.2500)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11081, N'FURIB', 1, CAST(N'2017-12-11T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 311.7500)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11082, N'ALFKI', 7, CAST(N'2017-12-11T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 62.3000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11083, N'BOLID', 1, CAST(N'2017-12-15T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 81.5000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11084, N'ALFKI', 7, CAST(N'2017-12-15T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 241.6000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11085, N'BOTTM', 1, CAST(N'2017-12-15T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 138.0000)
INSERT [dbo].[Pedidos] ([IdPedido], [IdCliente], [IdEmpleado], [FechaPedido], [FechaEntrega], [FechaEnvío], [FormaEnvío], [Cargo], [Destinatario], [DirecciónDestinatario], [CiudadDestinatario], [RegiónDestinatario], [CódPostalDestinatario], [PaísDestinatario], [Monto]) VALUES (11086, N'WANDK', 7, CAST(N'2017-12-15T00:00:00' AS SmallDateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 286.7000)
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (1, N'Té Dharamsala', 1, 1, 18.0000, 34, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (2, N'Cerveza tibetana Barley', 1, 1, 19.0000, 16, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (3, N'Sirope de regaliz', 1, 2, 10.0000, 13, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (4, N'Especias Cajun del chef Anton', 2, 2, 22.0000, 52, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (5, N'Mezcla Gumbo del chef Anton', 2, 2, 21.3500, 50, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (6, N'Mermelada de grosellas de la abuela', 3, 2, 25.0000, 120, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (7, N'Peras secas orgánicas del tío Bob', 3, 7, 30.0000, 15, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (8, N'Salsa de arándanos Northwoods', 3, 2, 40.0000, 6, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (9, N'Buey Mishi Kobe', 4, 6, 97.0000, 26, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (10, N'Pez espada', 4, 8, 31.0000, 31, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (11, N'Queso Cabrales', 5, 4, 21.0000, 22, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (12, N'Queso Manchego La Pastora', 5, 4, 38.0000, 84, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (13, N'Algas Konbu', 6, 8, 6.0000, 24, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (14, N'Cuajada de judías', 6, 7, 23.2500, 35, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (15, N'Salsa de soja baja en sodio', 6, 2, 15.5000, 39, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (16, N'Postre de merengue Pavlova', 7, 3, 17.4500, 29, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (17, N'Cordero Alice Springs', 7, 6, 39.0000, 0, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (18, N'Langostinos tigre Carnarvon', 7, 8, 62.5000, 42, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (19, N'Pastas de té de chocolate', 8, 3, 9.2000, 25, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (20, N'Mermelada de Sir Rodney''s', 8, 3, 81.0000, 40, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (21, N'Bollos de Sir Rodney''s', 8, 3, 10.0000, 1, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (22, N'Pan de centeno crujiente estilo Gustaf''s', 9, 5, 21.0000, 104, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (23, N'Pan fino', 9, 5, 9.0000, 61, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (24, N'Refresco Guaraná Fantástica', 10, 1, 4.5000, 19, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (25, N'Crema de chocolate y nueces NuNuCa', 11, 3, 14.0000, 76, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (26, N'Ositos de goma Gumbär', 11, 3, 31.2300, 15, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (27, N'Chocolate Schoggi', 11, 3, 43.9000, 48, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (28, N'Col fermentada Rössle', 12, 7, 45.6000, 24, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (29, N'Salchicha Thüringer', 12, 6, 123.7900, 40, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (30, N'Arenque blanco del noroeste', 13, 8, 25.8900, 10, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (31, N'Queso gorgonzola Telino', 14, 4, 12.5000, 39, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (32, N'Queso Mascarpone Fabioli', 14, 4, 32.0000, 9, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (33, N'Queso de cabra', 15, 4, 2.5000, 112, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (34, N'Cerveza Sasquatch', 16, 1, 14.0000, 110, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (35, N'Cerveza negra Steeleye', 16, 1, 18.0000, 20, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (36, N'Escabeche de arenque', 17, 8, 19.0000, 112, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (37, N'Salmón ahumado Gravad', 17, 8, 26.0000, 10, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (38, N'Vino Côte de Blaye', 18, 1, 263.5000, 17, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (39, N'Licor verde Chartreuse', 18, 1, 18.0000, 64, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (40, N'Carne de cangrejo de Boston', 19, 8, 18.4000, 122, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (41, N'Crema de almejas estilo Nueva Inglaterra', 19, 8, 9.6500, 85, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (42, N'Tallarines de Singapur', 20, 5, 14.0000, 26, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (43, N'Café de Malasia', 20, 1, 46.0000, 16, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (44, N'Azúcar negra Malacca', 20, 2, 19.4500, 27, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (45, N'Arenque ahumado', 21, 8, 9.5000, 2, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (46, N'Arenque salado', 21, 8, 12.0000, 94, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (47, N'Galletas Zaanse', 22, 3, 9.5000, 36, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (48, N'Chocolate holandés', 22, 3, 12.7500, 14, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (49, N'Regaliz', 23, 3, 20.0000, 10, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (50, N'Chocolate blanco', 23, 3, 16.2500, 65, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (51, N'Manzanas secas Manjimup', 24, 7, 53.0000, 19, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (52, N'Cereales para Filo', 24, 5, 7.0000, 37, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (53, N'Empanada de carne', 24, 6, 32.8000, 60, 1)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (54, N'Empanada de cerdo', 25, 6, 7.4500, 21, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (55, N'Paté chino', 25, 6, 24.0000, 115, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (56, N'Gnocchi de la abuela Alicia', 26, 5, 38.0000, 21, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (57, N'Raviolis Angelo', 26, 5, 19.5000, 35, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (58, N'Caracoles de Borgoña', 27, 8, 13.2500, 62, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (59, N'Raclet de queso Courdavault', 28, 4, 55.0000, 79, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (60, N'Camembert Pierrot', 28, 4, 34.0000, 18, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (61, N'Sirope de arce', 29, 2, 28.5000, 113, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (62, N'Tarta de azúcar', 29, 3, 49.3000, 17, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (63, N'Sandwich de vegetales', 7, 2, 43.9000, 23, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (64, N'Bollos de pan de Wimmer', 12, 5, 33.2500, 22, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (65, N'Salsa de pimiento picante de Luisiana', 2, 2, 21.0500, 76, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (66, N'Especias picantes de Luisiana', 2, 2, 17.0000, 4, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (67, N'Cerveza Laughing Lumberjack', 16, 1, 14.0000, 52, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (68, N'Barras de pan de Escocia', 8, 3, 12.5000, 6, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (69, N'Queso Gudbrandsdals', 15, 4, 36.0000, 26, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (70, N'Cerveza Outback', 7, 1, 15.0000, 15, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (71, N'Crema de queso Fløtemys', 15, 4, 21.5000, 26, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (72, N'Queso Mozzarella Giovanni', 14, 4, 34.8000, 10, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (73, N'Caviar rojo', 17, 8, 15.0000, 101, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (74, N'Queso de soja Longlife', 4, 7, 10.0000, 3, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (75, N'Cerveza Klosterbier Rhönbräu', 12, 1, 7.7500, 125, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (76, N'Licor Cloudberry', 23, 1, 18.0000, 57, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (77, N'Salsa verde original Frankfurter', 12, 2, 13.0000, 32, 0)
INSERT [dbo].[Productos] ([IdProducto], [NombreProducto], [IdProveedor], [IdCategoría], [Precio], [Stock], [Suspendido]) VALUES (80, N'galletas de soda', 3, 5, 12.0000, 10, 1)
SET IDENTITY_INSERT [dbo].[Productos] OFF
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (1, N'Exotic Liquids', N'49 Gilbert St.', N'Londres', N'Reino Unido', N'(171) 555-2222', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (2, N'New Orleans Cajun Delights', N'P.O. Box 78934', N'New Orleans', N'Estados Unidos', N'(100) 555-4822', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (3, N'Grandma Kelly''s Homestead', N'707 Oxford Rd.', N'Ann Arbor', N'Estados Unidos', N'(313) 555-5735', N'(313) 555-3349')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (4, N'Tokyo Traders', N'9-8 Sekimai
Musashino-shi', N'Tokyo', N'Japón', N'(03) 3555-5011', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (5, N'Cooperativa de Quesos ''Las Cabras''', N'Calle del Rosal 4', N'Oviedo', N'España', N'(98) 598 76 54', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (6, N'Mayumi''s', N'92 Setsuko
Chuo-ku', N'Osaka', N'Japón', N'(06) 431-7877', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (7, N'Pavlova, Ltd.', N'74 Rose St.
Moonie Ponds', N'Melbourne', N'Australia', N'(03) 444-2343', N'(03) 444-6588')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (8, N'Specialty Biscuits, Ltd.', N'29 King''s Way', N'Manchester', N'Reino Unido', N'(161) 555-4448', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (9, N'PB Knäckebröd AB', N'Kaloadagatan 13', N'Göteborg', N'Suecia', N'031-987 65 43', N'031-987 65 91')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (10, N'Refrescos Americanas LTDA', N'Av. das Americanas 12.890', N'São Paulo', N'Brasil', N'(11) 555 4640', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (11, N'Heli Süßwaren GmbH & Co. KG', N'Tiergartenstraße 5', N'Berlín', N'Alemania', N'(010) 9984510', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (12, N'Plutzer Lebensmittelgroßmärkte AG', N'Bogenallee 51', N'Frankfurt', N'Alemania', N'(069) 992755', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (13, N'Nord-Ost-Fisch Handelsgesellschaft mbH', N'Frahmredder 112a', N'Cuxhaven', N'Alemania', N'(04721) 8713', N'(04721) 8714')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (14, N'Formaggi Fortini s.r.l.', N'Viale Dante, 75', N'Ravenna', N'Italia', N'(0544) 60323', N'(0544) 60603')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (15, N'Norske Meierier', N'Hatlevegen 5', N'Sandvika', N'Noruega', N'(0)2-953010', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (16, N'Bigfoot Breweries', N'3400 - 8th Avenue
Suite 210', N'Bend', N'Estados Unidos', N'(503) 555-9931', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (17, N'Svensk Sjöföda AB', N'Brovallavägen 231', N'Stockholm', N'Suecia', N'08-123 45 67', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (18, N'Aux joyeux ecclésiastiques', N'203, Rue des Francs-Bourgeois', N'París', N'Francia', N'(1) 03.83.00.68', N'(1) 03.83.00.62')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (19, N'New England Seafood Cannery', N'Order Processing Dept.
2100 Paul Revere Blvd.', N'Boston', N'Estados Unidos', N'(617) 555-3267', N'(617) 555-3389')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (20, N'Leka Trading', N'471 Serangoon Loop, Suite #402', N'Singapore', N'Singapur', N'555-8787', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (21, N'Lyngbysild', N'Lyngbysild
Fiskebakken 10', N'Lyngby', N'Dinamarca', N'43844108', N'43844115')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (22, N'Zaanse Snoepfabriek', N'Verkoop
Rijnweg 22', N'Zaandam', N'Holanda', N'(12345) 1212', N'(12345) 1210')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (23, N'Karkki Oy', N'Valtakatu 12', N'Lappeenranta', N'Finlandia', N'(953) 10956', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (24, N'G''day, Mate', N'170 Prince Edward Parade
Hunter''s Hill', N'Sydney', N'Australia', N'(02) 555-5914', N'(02) 555-4873')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (25, N'Ma Maison', N'2960 Rue St. Laurent', N'Montréal', N'Canadá', N'(514) 555-9022', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (26, N'Pasta Buttini s.r.l.', N'Via dei Gelsomini, 153', N'Salerno', N'Italia', N'(089) 6547665', N'(089) 6547667')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (27, N'Escargots Nouveaux', N'22, rue H. Voiron', N'Montceau', N'Francia', N'85.57.00.07', NULL)
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (28, N'Gai pâturage', N'Bat. B
3, rue des Alpes', N'Annecy', N'Francia', N'38.76.98.06', N'38.76.98.58')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreCompañía], [Dirección], [Ciudad], [País], [Teléfono], [Fax]) VALUES (29, N'Forêts d''érables', N'148 rue Chasseur', N'Ste-Hyacinthe', N'Canadá', N'(514) 555-2955', N'(514) 555-2921')
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDXAPE]    Script Date: 01/07/2020 04:40:35 p.m. ******/
CREATE NONCLUSTERED INDEX [IDXAPE] ON [dbo].[Empleados]
(
	[Apellidos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Detalles]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Pedidos] FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedidos] ([IdPedido])
GO
ALTER TABLE [dbo].[Detalles] CHECK CONSTRAINT [FK_Detalles_Pedidos]
GO
ALTER TABLE [dbo].[Detalles]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Productos] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[Detalles] CHECK CONSTRAINT [FK_Detalles_Productos]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Clientes]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Empleados] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleados] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Empleados]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorías] FOREIGN KEY([IdCategoría])
REFERENCES [dbo].[Categorías] ([IdCategoría])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorías]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Proveedores]
GO
/****** Object:  StoredProcedure [dbo].[LosMasVendidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LosMasVendidos]
(
 @Categoria tinyint,
 @Cantidad int
)
AS
if @Categoria is Null
	select top(@Cantidad) NombreProducto,sum(Cantidad)as Total
	from Detalles
	inner join Productos on Detalles.IdProducto=Detalles.IdProducto
	group by NombreProducto order by Total desc
else
    select top(@Cantidad) NombreProducto,sum(Cantidad)as Total
	from Detalles
	inner join Productos on Detalles.IdProducto=Detalles.IdProducto
	where Idcategoría=@Categoria
	group by NombreProducto order by Total desc
GO
/****** Object:  StoredProcedure [dbo].[ProductosAgotados]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductosAgotados]
(@Categoria int)
As
if @categoria is null 
   begin
		Select * from VistaProductos
        Where UnidadesEnExistencia=0
    End
else
     Begin
			Select * from VistaProductos
			Where idCategoría=@categoria and UnidadesEnExistencia=0
	 End

	
GO
/****** Object:  StoredProcedure [dbo].[ResumenVentasSP]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResumenVentasSP]
(@FechaInicial  Datetime,@Fechafinal Datetime)
As
Select FechaPedido,Sum(cantidad*precioUnidad) as Total
From Detalles
inner join Pedidos on Detalles.idpedido=pedidos.idpedido
Where  Fechapedido Between @Fechainicial And @Fechafinal
group by FechaPedido




GO
/****** Object:  StoredProcedure [dbo].[ResumenVentasSP1]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResumenVentasSP1]
	(@FechaInicial DateTime,@FechaFinal DateTime)
AS
	Select Sum(Cantidad*PrecioUnidad)as Total
	From Detalles inner join Pedidos
	on Detalles.IdPedido=Pedidos.IdPedido
	where FechaPedido Between @FechaInicial and @FechaFinal
	
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizaPer]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_ActualizaPer]
@IdPer Char(3), @Ape VarChar(35),
@Nom VarChar(30), @Sue Numeric(8,2),
@Fingre DateTime
As
   Update Personal Set Ape=@Ape,Nom=@Nom,
              Sue=@Sue,Fingre=@Fingre
   Where IdPer=@IdPer
GO
/****** Object:  StoredProcedure [dbo].[sp_addEmpleado]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_addEmpleado](
 @Apellidos nvarchar(20),
@Nombre nvarchar(10),
@Cargo nvarchar(30),
@FechaContratación smalldatetime,
@Dirección nvarchar(60),
@Ciudad nvarchar(15),
@País nvarchar(15),
@TelDomicilio nvarchar(24))
as
begin
INSERT INTO Empleados
           ([Apellidos]
           ,[Nombre]
           ,[Cargo]
           ,[FechaContratación]
           ,[Dirección]
           ,[Ciudad]
           ,[País]
           ,[TelDomicilio])
     VALUES
           (@Apellidos,
			@Nombre,
           @Cargo,
           @FechaContratación,
           @Dirección,
           @Ciudad,
           @País,
           @TelDomicilio)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GeneraPer]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_GeneraPer]
@codigo Char(3) OutPut
As
  Declare @N Int,@Cod VarChar(5)
  Select @N = Max(Convert(Int,Right(Idper,2))) From Personal
  Select @Cod = Right(Replicate('0',4) + LTrim(Str(@N+1)),2)
  Set @codigo = 'P' + @Cod
Return
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertaPer]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_InsertaPer]
@IdPer Char(3), @Ape VarChar(35),
@Nom VarChar(30), @Sue Numeric(8,2),
@Fingre DateTime
As
   Insert Personal Values
    (@IdPer,@Ape,@Nom,@Sue,@Fingre)
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaPedidos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_ListaPedidos]
As
   Select P.IdPedido, C.NombreCompañía, E.Apellidos,
   P.FechaPedido, P.Cargo
   From Pedidos P, Clientes C, Empleados E
   Where P.IdCliente = C.IdCliente And
             P.IdEmpleado = E.IdEmpleado

GO
/****** Object:  StoredProcedure [dbo].[sp_ListaPer]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_ListaPer]
As
  Select * from Personal
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaProd]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_ListaProd]
@Nomcat VarChar(25)
As
   Select * from ListaProductos
   Where NombreCategoría=@Nomcat

GO
/****** Object:  StoredProcedure [dbo].[sp_ListaProductos]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_ListaProductos]
As 
      Select P.IdProducto,P.NombreProducto,C.NombreCategoría,
	Pr.NombreCompañía,P.PrecioUnidad
	From Productos P, Proveedores Pr, Categorías C
	Where P.IdProveedor = Pr.IdProveedor And
	          P.IdCategoría = C.IdCategoría

GO
/****** Object:  StoredProcedure [dbo].[sp_ListarEmpleado]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ListarEmpleado]
as
begin
select IdEmpleado,Apellidos,Nombre,Cargo,FechaContratación,Dirección,Ciudad,País,TelDomicilio from Empleados
end
GO
/****** Object:  StoredProcedure [dbo].[sp_PedidosEmple]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_PedidosEmple]
@Ape VarChar(45)
As 
   Select * from ListadoPedidos
   Where Apellidos=@Ape

GO
/****** Object:  StoredProcedure [dbo].[sp_PedidosFechas]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_PedidosFechas]
@fec1 DateTime, @fec2 DateTime
As
    Select * from ListadoPedidos Where
    FechaPedido Between @fec1 And @fec2

GO
/****** Object:  StoredProcedure [dbo].[usp_actualiza_stock]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_actualiza_stock]	
	@IdProducto int,
	@Cantidad int
AS
update productos set Stock=Stock-@Cantidad
where IdProducto=@IdProducto
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Categoria_Listar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Categoria_Listar]
	
AS
	SELECT IdCategoría,NombreCategoría
	FROM Categorías
	ORDER BY 2
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Clientes_X_Pais]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Clientes_X_Pais]
	@Pais varchar(20)
	
AS
	SELECT * from Clientes
	where País=@Pais
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Empleado_valida]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Empleado_valida]
	@Nombre varchar(10),
	@Apellido varchar(20)
AS
	SELECT IdEmpleado,Nombre,Apellidos From Empleados
	WHERE Nombre=@Nombre and Apellidos=@Apellido
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Actualizar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Actualizar]
@Nombre varchar(40),
@IdProveedor int,
@IdCategoria int,
@Precio money,
@Stock smallint,
@IdProducto int 
AS
update productos
 set NombreProducto=@Nombre,
 IdProveedor=@IdProveedor,
 IdCategoría=@IdCategoria,
 Precio=@Precio,
 Stock=@Stock
 where IdProducto=@IdProducto
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Adicionar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Adicionar]
@Nombre varchar(40),
@IdProveedor int,
@IdCategoria int,
@Precio money,
@Stock smallint,
@IdProducto int output
AS
insert into productos(NombreProducto,IdProveedor,IdCategoría,Precio,Stock,Suspendido)
values(@Nombre,@IdProveedor,@IdCategoria,@Precio,@Stock,0)	
SET @IdProducto=@@IDENTITY
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Buscar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Buscar]
	@IdProducto int
AS
	SELECT * from Productos	
	WHERE IdProducto=@IdProducto
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Eliminar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Eliminar]
@IdProducto int 
AS
delete from productos 
 where IdProducto=@IdProducto
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Listar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Listar]
	
AS
	SELECT * from Productos	

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Listar_Por_Categoria]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Listar_Por_Categoria]
 @IdCategoria int	
AS
	SELECT * from Productos
	WHERE IdCategoría=@IdCategoria

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Producto_Listar_Por_Nombre]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Producto_Listar_Por_Nombre]
 @Nombre varchar(40)	
AS
	SELECT * from Productos
	WHERE NombreProducto LIKE @Nombre+'%'

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_Proveedor_Listar]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Proveedor_Listar]
	
AS
	SELECT IdProveedor,NombreCompañía FROM Proveedores ORDER BY 2
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_registra_detalle]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_registra_detalle]
	@IdVenta int,
	@IdProducto int,
	@Precio money,
	@Cantidad int
AS
insert into Detalles(IdPedido,IdProducto,PrecioUnidad,Cantidad,Descuento)
 values(@IdVenta,@IdProducto,@Precio,@Cantidad,0)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[usp_registra_venta]    Script Date: 01/07/2020 04:40:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_registra_venta]
	@IdCliente char(5),
	@IdEmpleado int,
	@Fecha datetime,
	@Monto money
AS
insert  into pedidos(idcliente,idempleado,FechaPedido,Monto)
 values(@IdCliente,@IdEmpleado,@Fecha,@Monto)	
RETURN 0
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[25] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Productos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Categorías"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Proveedores"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ConsultaProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ConsultaProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Productos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "Categorías"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Proveedores"
            Begin Extent = 
               Top = 6
               Left = 492
               Bottom = 114
               Right = 681
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vistadeproductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vistadeproductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detalles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Productos"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaDetalles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaDetalles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detalles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Productos"
            Begin Extent = 
               Top = 6
               Left = 281
               Bottom = 114
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaLosMasVendidos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaLosMasVendidos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Clientes"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pedidos"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Empleados"
            Begin Extent = 
               Top = 6
               Left = 492
               Bottom = 114
               Right = 681
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaPedidos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaPedidos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Productos"
            Begin Extent = 
               Top = 70
               Left = 480
               Bottom = 178
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Categorías"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 114
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Proveedores"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaProductos'
GO
USE [master]
GO
ALTER DATABASE [Neptuno] SET  READ_WRITE 
GO
