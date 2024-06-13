public class Employee{

    public string Name { get; set; }
    public string Department { get; set; }
    public int Salary { get; set; }
    public int Age { get; set; }
    public string Address { get; set; }
    public string PhoneNumber { get; set; }    
}

// Create table Employee in SQL Server
CREATE TABLE Employee
(
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Salary INT,
    Age INT,
    Address NVARCHAR(50),
    PhoneNumber NVARCHAR(50)
)