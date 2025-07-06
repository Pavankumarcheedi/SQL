CREATE DATABASE HairSalonDB;

USE HairSalonDB;


USE HairSalonDB;





-- Drop all if exist
DROP TABLE IF EXISTS ClientCancellations;
DROP TABLE IF EXISTS FutureBookings;
DROP TABLE IF EXISTS NoShowReport;
DROP TABLE IF EXISTS ProductListingRetail;
DROP TABLE IF EXISTS ReceiptTransactions;
DROP TABLE IF EXISTS ServiceListing;
DROP TABLE IF EXISTS HairSalonNoShowWrangled;

CREATE TABLE ClientCancellations (
    CancelDate VARCHAR(255),
    Code VARCHAR(255),
    Service1 VARCHAR(255),
    Staff VARCHAR(255),
    BookingDate VARCHAR(255),
    CanceledBy VARCHAR(255),
    Days1 VARCHAR(255)
);

CREATE TABLE FutureBookings (
    Code VARCHAR(255),
    Staff VARCHAR(255),
    Service1 VARCHAR(255),
    Dates VARCHAR(255),
    Timee VARCHAR(255),
    TimeInt VARCHAR(255)
);

CREATE TABLE NoShowReport (
    Dates VARCHAR(255),
    Code VARCHAR(255),
    Service1 VARCHAR(255),
    Staff VARCHAR(255)
);

CREATE TABLE ProductListingRetail (
    IsActive VARCHAR(255),
    Code VARCHAR(255),
    Description1 VARCHAR(255),
    Supplier VARCHAR(255),
    Brand VARCHAR(255),
    Category VARCHAR(255),
    Price VARCHAR(255),
    OnHand VARCHAR(255),
    Minimum VARCHAR(255),
    Maximum VARCHAR(255),
    Cost VARCHAR(255),
    COG VARCHAR(255),
    YTD VARCHAR(255),
    Package VARCHAR(255)
);

CREATE TABLE ReceiptTransactions (
    Receipt VARCHAR(255),
    Dates VARCHAR(255),
    Description1 VARCHAR(255),
    Client VARCHAR(255),
    Staff VARCHAR(255),
    Quantity VARCHAR(255),
    Amount VARCHAR(255),
    GST VARCHAR(255),
    PST VARCHAR(255)
);

CREATE TABLE ServiceListing (
    IsActive VARCHAR(255),
    Code VARCHAR(255),
    Descr VARCHAR(255),
    Cate VARCHAR(255),
    Price VARCHAR(255),
    Cost VARCHAR(255)
);


CREATE TABLE HairSalonNoShowWrangled (
    sno VARCHAR(255),
    book_tod VARCHAR(255),
    book_dow VARCHAR(255),
    book_category VARCHAR(255),
    book_staff VARCHAR(255),
    last_category VARCHAR(255),
    last_staff VARCHAR(255),
    last_day_services VARCHAR(255),
    last_receipt_tot VARCHAR(255),
    last_dow VARCHAR(255),
    last_tod VARCHAR(255),
    last_noshow VARCHAR(255),
    last_prod_flag VARCHAR(255),
    last_cumrev VARCHAR(255),
    last_cumbook VARCHAR(255),
    last_cumstyle VARCHAR(255),
    last_cumcolor VARCHAR(255),
    last_cumprod VARCHAR(255),
    last_cumcancel VARCHAR(255),
    last_cumnoshow VARCHAR(255),
    noshow VARCHAR(255),
    recency VARCHAR(255)
);



TRUNCATE TABLE ClientCancellations;
TRUNCATE TABLE FutureBookings;
TRUNCATE TABLE NoShowReport;
TRUNCATE TABLE ProductListingRetail;
TRUNCATE TABLE ReceiptTransactions;
TRUNCATE TABLE ServiceListing;
TRUNCATE TABLE HairSalonNoShowWrangled;



select * from ClientCancellations


select * from FutureBookings
select * from HairSalonNoShowWrangled
select * from NoShowReport
select * from ProductListingRetail
select * from ReceiptTransactions
select * from ServiceListing




