create database hackathon;
use hackathon;


create table Customers(
	customer_id varchar(10) primary key,
    full_name varchar(100) not null,
    phone varchar(15) not null unique,
    address varchar(200) not null
);

create table InsuranceAgents(
     agent_id varchar(10) primary key,
     full_name varchar(100) not null,
     region varchar(50) not null,
     years_of_experience int check(years_of_experience >= 0),
     commision_rate decimal(5,2) check(commision_rate >= 0)
);

create table Policies(
     policy_id int primary key auto_increment,
     agent_id varchar(10),
     customer_id varchar(10),
     foreign key (customer_id) references Customers(customer_id),
     foreign key (agent_id) references InsuranceAgents(agent_id),
     start_date timestamp not null,
     end_date timestamp not null,
     policy_status enum('Active', 'Expired',  'Cancelled')
);

create table ClaimPayments(
      payment_id int primary key auto_increment,
      policy_id int,
      foreign key (policy_id) references Policies(policy_id),
	  payment_method varchar(50) not null,
      payment_date timestamp default current_timestamp,
      amount decimal(15,2) check(amount >=0)
);

insert into Customers values 
('C001', 'Nguyen Van An', '0912345678', 'Hanoi, Vietnam'),
('C002', 'Tran Thi Binh', '0923456789', 'Hanoi, Vietnam'),
('C003', 'Le Minh Chau', '0934567890', 'Hanoi, Vietnam'),
('C004', 'Pham Hoang Duc', '0945678901', 'Hanoi, Vietnam'),
('C005', 'Vu Thi Hoa ', '0956789012', 'Hanoi, Vietnam');

insert into InsuranceAgents values
('A001', 'Nguyen Van Minh','Mien Bac',10,5.50),
('A002', 'Tran Thi Lan','Mien Nam',15,7.00),
('A003', 'Le Hoang Nam','Mien Trung',8,4.50),
('A004', 'Pham Quang Huy','Mien Tay',20,8.00),
('A005', 'Vu Thi Mai','Mien Bac',5,3.50);

insert into Policies (customer_id, agent_id, start_date, end_date, policy_status) values
('C001','A001','2024-01-01 08:00:00','2025-01-01 08:00:00','Active'),
('C002','A002','2024-02-01 09:30:00','2025-02-01 09:30:00','Active'),
('C003','A003','2023-03-02 10:00:00','2024-03-02 10:00:00','Expired'),
('C004','A004','2024-05-02 14:00:00','2025-05-02 14:00:00','Active'),
('C005','A005','2024-06-03 15:30:00','2025-06-03 15:30:00','Active');
insert into ClaimPayments (policy_id, payment_method, payment_date, amount) values
(1,'Bank Transfer','2024-05-01 08:45:00',5000000),
(2,'Bank Transfer','2024-06-01 10:00:00',7500000),
(4,'Cash','2024-08-02 15:00:00',2000000),
(1,'Bank Transfer','2024-09-04 11:00:00',3000000),
(3,'Credit Card','2023-10-05 14:00:00',1500000);

update Customers
set address =  'District 1,Ho Chi Minh City' 
where customer_id = 'C002';

update InsuranceAgents
set years_of_experience = years_of_experience + 2,
    commission_rate = commission_rate + 1.5
WHERE agent_id = 'A001';

delete FROM Policies
where status = 'Cancelled'
and start_date < '2024-06-15';

select agent_id,full_name,region from InsuranceAgents
where years_of_experience > 8;

select customer_id, full_name, phone from Customers
where full_name like 'Nguyen%';

select policy_id, start_date, status
from Policies
order by start_date desc;

select agent_id, full_name
from InsuranceAgents
limit 3 offset 2;
