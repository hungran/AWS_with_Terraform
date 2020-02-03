Vũ Mạnh Hùng
vmhung290791@gmail.com

# AWS_with_Terraform
Thực hành theo hướng dẫn của [blog](https://github.com/100daysofdevops/21_days_of_aws_using_terraform/blob/master/README.md) 21 days of aws using by terraform 

# Index
- [VPC](#VPC)
- [EC2](#EC2)

## VPC
- Security Group
- Route Table

- Internet Gateways
- Subnets
- Custom Route Table

Các bước thực hành  Day 2:
1. Tạo query / list all AZ có trong region
2. Định nghĩa [variables.tf](/vpc/variables.tf) để làm tham số, mục đích template cho các lần deploy sau
3. Định nghĩa **VPC**, query đến cidr trong `variables.tf`
4. Định nghĩa **Internet Gateway** (igw) trỏ đến vpc vừa tạo
5. Định nghĩa **Public Route**, có default route (0.0.0.0) trỏ đến igw
6. Định nghĩa **Privae Route**, default route mặc định gắn với vpc
7. Định nghĩa **public subnet**, query đến template varibales.tf
8. Định nghĩa **private subnet**, query đến template varibales.tf
9. Associate lần lượt public route và private route đến public subnet và private subnet
10. Tạo **Security group**, tạo rule mở port 80, 22

## EC2
1. Tạo module VPC - Mục đính sử dụng làm template, điều chỉnh tham số khi có nhu cầu, tránh hardcode, gọi tham số giữa các module
    - **Chú ý: Dùng `output.tf` để gọi giá trị giữa các module**
    - **Để trống các biến `variables.tf` nếu cần định nghĩa hoặc gọi giá trị từ module khác tại root `main.tf`**

2. Tạo module EC2, tạo `main.tf`, khai báo `variable.tf` **chú ý để trống các giá trị cần link với module khác** ví dụ: `subnet`, `security_group`
- Tạo `public_key` bằng **putty gen** hoặc **ssh-gent** --> upload 
- Tạo `bootstrap.tpl`

- Tham số cụ thể của module EC2 như sau:
    - [main.tf](./ec2/main.tf)
    - [variables.tf](./ec2/variables.tf)