CREATE DATABASE VEHICLE_SERVICE3
-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    CTU_Address VARCHAR(255)
);
SELECT * FROM Customers
INSERT INTO CUSTOMERS (FirstName, LastName, Email, PhoneNumber, CTU_Address) VALUES('JOHN','SHAH','johnshah123@gmail.com',1234567890,'150ft rooad ,rajkot')
-- Create Vehicles Table
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
SELECT * FROM Vehicles
delete Vehicles where vehicleNumber='GJ03LP1234'
INSERT INTO Vehicles (CustomerID,VehicleNumber, Model, Veh_Year, VehicleType, VehicleCompany, VehicleName)VALUES(1,'GJ03LP1234','ABC',2025,'CAR','TOYOTA','FORTUNER')
-- Create Mechanics Table
CREATE TABLE Mechanics (
    MechanicID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    HireDate DATETIME DEFAULT GETDATE()
);
INSERT INTO Mechanics (FirstName, LastName, PhoneNumber, Email)
VALUES 
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com')


-- Create Services History Table
CREATE TABLE Services_History (
    ServiceID INT IDENTITY(1,1),
	ServiceHistoryID INT,
    VehicleID INT,
    ServiceName VARCHAR(100),
    Price DECIMAL(10, 2),
    DurationMinutes INT, -- Duration of the service in minutes
	PRIMARY KEY (ServiceHistoryID, ServiceID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);
INSERT INTO Services_History (ServiceHistoryID,ServiceName, Price, DurationMinutes)
VALUES 
    (1,'Oil Change', 50.00, 30)  -- Assuming VehicleID = 1 exists in Vehicles table

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    ServiceHistoryID INT,
    PaymentDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10, 2),
    PaymentMethod VARCHAR(50), -- e.g., 'Cash', 'Credit Card'
    --FOREIGN KEY (ServiceID) REFERENCES Services_History(ServiceID)
	FOREIGN KEY (ServiceHistoryID) REFERENCES Services_History(ServiceHistoryID)
);
--delete Payments where PaymentMethod='Debit Card'
INSERT INTO Payments (ServiceHistoryID,AmountPaid, PaymentMethod)
VALUES 
    (1,50.00, 'Cash')  -- Assuming ServiceHistoryID = 1 exists in Services_History table

-- Create Inventory Table
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    DateAdded DATETIME DEFAULT GETDATE()
);
select * from Inventory
INSERT INTO Inventory (ItemName, Quantity, UnitPrice)
VALUES 
    ('Oil Filter', 100, 10.00)


-- Create Service Items Table
CREATE TABLE ServiceItems (
    ServiceHistoryID INT,
    ItemID INT,
    Quantity INT,
    TotalCost DECIMAL(10, 2),
	ServiceID int,
    PRIMARY KEY (ItemID),
    FOREIGN KEY (ServiceHistoryID) REFERENCES Services_History(ServiceHistoryID),
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID)
);
select *from ServiceItems
-- Assuming that ItemID values (1, 2, 3, etc.) exist in the Inventory table, and
-- ServiceHistoryID values (1, 2, 3, etc.) exist in the Services_History table.

INSERT INTO ServiceItems (ServiceHistoryID, ItemID, Quantity, TotalCost,ServiceID)
VALUES 
    (1, 1, 1, 10.00,1)  -- ServiceHistoryID = 1, ItemID = 1


SELECT * FROM Customers
SELECT * FROM Vehicles
SELECT * FROM Mechanics
SELECT * FROM Services_History
SELECT * FROM Payments
SELECT * FROM Inventory
SELECT * FROM ServiceItems

delete Customers where PhoneNumber=1234567890