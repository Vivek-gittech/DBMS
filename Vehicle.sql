CREATE DATABASE TB
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    CTU_Address VARCHAR(255)
);
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    VehicleNumber VARCHAR(25),
    Model VARCHAR(50),
    Veh_Year INT,
    VehicleType VARCHAR(50),
    VehicleCompany VARCHAR(50),
    VehicleName VARCHAR(50),
    DateAdded DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Mechanics (
    MechanicID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    HireDate DATETIME DEFAULT GETDATE()
);
CREATE TABLE Services_History (
	ServiceHistoryID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT,
    ServiceName VARCHAR(100),
    Price DECIMAL(10, 2),
    DurationMinutes INT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    ServiceHistoryID INT,
    PaymentDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
	FOREIGN KEY (ServiceHistoryID) REFERENCES Services_History(ServiceHistoryID)
);
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    DateAdded DATETIME DEFAULT GETDATE()
);
CREATE TABLE ServiceItems (
    ServiceHistoryID INT,
    ItemID INT,
    Quantity INT,
    TotalCost DECIMAL(10, 2),
    PRIMARY KEY (ItemID),
    FOREIGN KEY (ServiceHistoryID) REFERENCES Services_History(ServiceHistoryID),
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID)
);
------INSERT THE DATA------
--1.
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, CTU_Address)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '1234567890', '123 Main St, Cityville'),
    ('Jane', 'Smith', 'janesmith@example.com', '0987654321', '456 Oak St, Townsville'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '1122334455', '789 Pine St, Villageville'),
    ('Bob', 'Brown', 'bobbrown@example.com', '2233445566', '321 Maple St, Metrocity'),
    ('Charlie', 'Davis', 'charliedavis@example.com', '3344556677', '654 Birch St, Smalltown');
--2.
INSERT INTO Vehicles (CustomerID, VehicleNumber, Model, Veh_Year, VehicleType, VehicleCompany, VehicleName)
VALUES
    (1, 'GJ03LP1234', 'ABC', 2020, 'Car', 'Toyota', 'Fortuner'),
    (2, 'MH12XY5678', 'XYZ', 2021, 'Car', 'Honda', 'Civic'),
    (3, 'KA03ZP2345', 'ModelX', 2022, 'Car', 'Tesla', 'Model X'),
    (4, 'UP14AB9876', 'YZ', 2023, 'Motorcycle', 'Harley-Davidson', 'Street 750'),
    (5, 'DL10JK3456', 'GTR', 2023, 'Car', 'Nissan', 'GT-R');
--3.
INSERT INTO Mechanics (FirstName, LastName, PhoneNumber, Email)
VALUES 
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com');
--4.
INSERT INTO Services_History (ServiceHistoryID,ServiceName, Price, DurationMinutes)
VALUES (1,'Oil Change',180.00,25);
--5.
INSERT INTO Payments (ServiceHistoryID,AmountPaid, PaymentMethod)
VALUES 
    (1,50.00, 'Cash');
--6.
INSERT INTO Inventory (ItemName, Quantity, UnitPrice)
VALUES 
    ('Oil Filter', 100, 10.00);
--7.
INSERT INTO ServiceItems (ServiceHistoryID, ItemID, Quantity, TotalCost)
VALUES 
    (1, 1, 1, 10.00);

SELECT * FROM Customers
SELECT * FROM Vehicles
SELECT * FROM Mechanics
SELECT * FROM Services_History
SELECT * FROM Payments
SELECT * FROM Inventory
SELECT * FROM ServiceItems


-------CREATE THE STORE PROCEDURE-------
--1.
CREATE PROCEDURE InsertCustomer
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @PhoneNumber VARCHAR(20),
    @CTU_Address VARCHAR(255)
AS
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, CTU_Address)
    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @CTU_Address)
END;
EXEC InsertCustomer 
    @FirstName = 'John', 
    @LastName = 'Doe', 
    @Email = 'johndoe@example.com', 
    @PhoneNumber = '123-456-7890', 
    @CTU_Address = '123 Main St, SomeCity, SomeState, 12345'
--2.
CREATE PROCEDURE UpdateVehicle
    @VehicleID INT,
    @CustomerID INT,
    @VehicleNumber VARCHAR(25),
    @Model VARCHAR(50),
    @Veh_Year INT,
    @VehicleType VARCHAR(50),
    @VehicleCompany VARCHAR(50),
    @VehicleName VARCHAR(50)
AS
BEGIN
    UPDATE Vehicles
    SET 
        CustomerID = @CustomerID,
        VehicleNumber = @VehicleNumber,
        Model = @Model,
        Veh_Year = @Veh_Year,
        VehicleType = @VehicleType,
        VehicleCompany = @VehicleCompany,
        VehicleName = @VehicleName
    WHERE VehicleID = @VehicleID
END;
EXEC UpdateVehicle
    @VehicleID = 1, 
    @CustomerID = 2, 
    @VehicleNumber = 'ABC123', 
    @Model = 'Sedan', 
    @Veh_Year = 2022, 
    @VehicleType = 'Car', 
    @VehicleCompany = 'Toyota', 
    @VehicleName = 'Corolla'
--3.
CREATE PROCEDURE InsertMechanic
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO Mechanics (FirstName, LastName, PhoneNumber, Email)
    VALUES (@FirstName, @LastName, @PhoneNumber, @Email)
END;
EXEC InsertMechanic 'sager','patel','1234567890','sagerpatel123@gmail.com'
--4.
CREATE PROCEDURE DeleteServiceHistory
    @ServiceHistoryID INT
AS
BEGIN
    DELETE FROM Services_History
    WHERE ServiceHistoryID = @ServiceHistoryID
END;
EXEC DeleteServiceHistory 
    @ServiceHistoryID = 1

------CREATE THE FUNCTION-----
--1.
CREATE FUNCTION GetCustomerFullName (@CustomerID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FullName VARCHAR(100);
    
    SELECT @FullName = FirstName + ' ' + LastName
    FROM Customers
    WHERE CustomerID = @CustomerID;
    
    RETURN @FullName;
END;
SELECT dbo.GetCustomerFullName(1) AS GetCustomerFullName;
--2.
CREATE FUNCTION CalculateServiceItemTotalCost 
    (@ServiceHistoryID INT, @ItemID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10, 2);
    DECLARE @UnitCost DECIMAL(10, 2);
    DECLARE @Quantity INT;
    SELECT @UnitCost = UnitPrice 
    FROM Inventory 
    WHERE ItemID = @ItemID;
    SELECT @Quantity = Quantity 
    FROM ServiceItems 
    WHERE ServiceHistoryID = @ServiceHistoryID AND ItemID = @ItemID;
    SET @TotalCost = @UnitCost * @Quantity;
    
    RETURN @TotalCost;
END;
SELECT dbo.CalculateServiceItemTotalCost(1,1)as CalculateServiceItemTotalCost;
--3.
CREATE FUNCTION CalculateInventoryValue()
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(18,2)
    
    SELECT @TotalValue = SUM(Quantity * UnitPrice) FROM Inventory
    
    RETURN @TotalValue
END;
SELECT dbo.CalculateInventoryValue()as CalculateInventory;
--4.
CREATE FUNCTION CalculateTotalPayments
    (@ServiceHistoryID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalPaid DECIMAL(10, 2);
    SELECT @TotalPaid = SUM(AmountPaid)
    FROM Payments
    WHERE ServiceHistoryID = @ServiceHistoryID;
    IF @TotalPaid IS NULL
        SET @TotalPaid = 0;
    RETURN @TotalPaid;
END;
SELECT dbo.CalculateTotalPayments(1) AS TotalPaid;
