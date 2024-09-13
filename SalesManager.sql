use DEMOLAB5
-- Tạo bảng Warehouse
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- Tạo bảng Store
CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
    Address VARCHAR(200) NOT NULL,
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

-- Tạo bảng Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
    Mail VARCHAR(100) NOT NULL UNIQUE,
    Address VARCHAR(200) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    StoreID INT,
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

-- Tạo bảng Account
CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(100) NOT NULL UNIQUE,
    Authorizations VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CreateDate DATE NOT NULL,
    EmployeeID INT UNIQUE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Tạo bảng Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    RewardPoints INT NOT NULL CHECK (RewardPoints >= 0)
);

-- Tạo bảng Bill
CREATE TABLE Bill (
    IDBill INT PRIMARY KEY,
    Time DATETIME NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Tạo bảng Sale
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY,
    SaleDate DATE NOT NULL,
    SaleEnd DATE NOT NULL,
    ValueBasedSale DECIMAL(10,2) NOT NULL CHECK (ValueBasedSale > 0)
);

-- Tạo bảng ProductCategory
CREATE TABLE ProductCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);



-- Tạo bảng Supplier
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    SupplierPhoneNumber VARCHAR(20) NOT NULL,
    SupplierAddress VARCHAR(200) NOT NULL
);

-- Tạo lại bảng Product với ràng buộc CHECK
CREATE TABLE Product (
    IDProduct INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Amount INT NOT NULL CHECK (Amount > 0),
    ExpirationDate DATE NOT NULL,
    ManufacturingDate DATE NOT NULL,
    CategoryID INT,
    SupplierID INT,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    CONSTRAINT CHK_ManufacturingDate CHECK (ManufacturingDate < ExpirationDate)
);



-- Tạo bảng BillProduct (liên kết giữa Bill và Product)
CREATE TABLE BillProduct (
    IDBill INT,
    IDProduct INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    PRIMARY KEY (IDBill, IDProduct),
    FOREIGN KEY (IDBill) REFERENCES Bill(IDBill),
    FOREIGN KEY (IDProduct) REFERENCES Product(IDProduct)
);

ALTER TABLE Sale
ADD StoreID INT,
FOREIGN KEY (StoreID) REFERENCES Store(StoreID);

-- Thêm khóa ngoại BillID vào bảng Sale
ALTER TABLE Sale
ADD BillID INT,
FOREIGN KEY (BillID) REFERENCES Bill(IDBill);


-- Thêm khóa ngoại EmployeeID vào bảng Bill
ALTER TABLE Bill
ADD EmployeeID INT,
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);