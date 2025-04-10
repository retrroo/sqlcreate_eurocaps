CREATE TABLE Soort_partner (
    SoortPartnerID INT PRIMARY KEY,
    Omschrijving VARCHAR(255)
);

CREATE TABLE Partner (
    PartnerID INT PRIMARY KEY,
    Bedrijfsnaam VARCHAR(100),
    Straatnaam VARCHAR(100),
    Huisnummer VARCHAR(10),
    Postcode VARCHAR(10),
    Plaats VARCHAR(50),
    Land VARCHAR(50),
    Email VARCHAR(100),
    TelNr VARCHAR(20),
    SoortPartnerID INT,
    FOREIGN KEY (SoortPartnerID) REFERENCES Soort_partner(SoortPartnerID)
);

CREATE TABLE PartnerContact (
    PartnerContactID INT PRIMARY KEY,
    Voornaam VARCHAR(50),
    Achternaam VARCHAR(50),
    Functie VARCHAR(50),
    Email VARCHAR(100),
    TelNr VARCHAR(20),
    PartnerID INT,
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID)
);

CREATE TABLE SoortProduct (
    SoortProductID INT PRIMARY KEY,
    Omschrijving VARCHAR(100),
    Gewicht DECIMAL(5,2),
    Afmeting VARCHAR(20),
    Materiaal VARCHAR(50)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductHTDatum DATETIME,
    CStatusProduct VARCHAR(10),
    FStatusProduct VARCHAR(10),
    PStatusProduct VARCHAR(10),
    SoortProductID INT,
    FOREIGN KEY (SoortProductID) REFERENCES SoortProduct(SoortProductID)
);

CREATE TABLE Levering (
    LeveringID INT PRIMARY KEY,
    LeveringDatum DATE,
    VerwachteLeverdatum DATE,
    PartnerID INT,
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID)
);

CREATE TABLE LeveringRegel (
    LeveringID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (LeveringID, ProductID),
    FOREIGN KEY (LeveringID) REFERENCES Levering(LeveringID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Grinding (
    GrindingID INT PRIMARY KEY,
    G_DatumTijdStart DATETIME,
    G_DatumTijdEind DATETIME,
    G_Machine VARCHAR(50)
);

CREATE TABLE Grinding_Product (
    GrindingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (GrindingID, ProductID),
    FOREIGN KEY (GrindingID) REFERENCES Grinding(GrindingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Filling (
    FillingID INT PRIMARY KEY,
    F_DatumTijdStart DATETIME,
    F_DatumTijdEind DATETIME,
    F_Machine VARCHAR(50)
);

CREATE TABLE Filling_Product (
    FillingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (FillingID, ProductID),
    FOREIGN KEY (FillingID) REFERENCES Filling(FillingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Packaging (
    PackagingID INT PRIMARY KEY,
    P_DatumTijdStart DATETIME,
    P_DatumTijdEind DATETIME,
    P_Machine VARCHAR(50),
    AantalStuksInDoos INT
);

CREATE TABLE Packaging_Product (
    PackagingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (PackagingID, ProductID),
    FOREIGN KEY (PackagingID) REFERENCES Packaging(PackagingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Retour (
    RetourID INT PRIMARY KEY,
    RetourDatum DATE,
    RedenRetour VARCHAR(255),
    StatusRetour VARCHAR(50),
    PartnerID INT,
    Contactpersoon VARCHAR(100),
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID)
);

CREATE TABLE Retour_Product (
    RetourID INT,
    ProductID INT,
    AantalRetour INT,
    RedenSpecifiek VARCHAR(255),
    PRIMARY KEY (RetourID, ProductID),
    FOREIGN KEY (RetourID) REFERENCES Retour(RetourID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Kwaliteitscontrole (
    KwaliteitID INT PRIMARY KEY,
    ProductID INT,
    ControleDatum DATE,
    StatusRetour VARCHAR(20), -- bijv. "OK", "NOK"
    RedenAfkeur VARCHAR(255),
    AantalAfgekeurd INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
