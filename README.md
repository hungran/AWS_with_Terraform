# AWS_with_Terraform

Vũ Mạnh Hùng
    
- vmhung290791@gmail.com

Nguồn: 
- Thực hành theo hướng dẫn của [blog](https://github.com/100daysofdevops/21_days_of_aws_using_terraform/blob/master/README.md) 21 days of aws using by terraform 
- Tham khảo phần auto-scaling theo metric CPU từ [Link](https://github.com/cloudposse/terraform-aws-ec2-autoscale-group/blob/master/variables.tf)

# Index
- [VPC](#VPC)
- [EC2](#EC2)
- [ELB](#ELB)
- [Auto-Scaling](#Auto-Scaling)
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

3. Tạo `EBS volume`, attach `ebs` đến `instance`

4. Tạo Output `instance_id` lần lượt để attach vào bài lab elastic-loadbalancer
- Tham số cụ thể của module EC2 như sau:
    - [main.tf](./ec2/main.tf)
    - [variables.tf](./ec2/variables.tf)

## ELB - Need fix
1. Tạo Target Group 
2. Attach Target Group vào từng instance 
3. Tao loadbalancer
    - Chọn đến security group đã tạo ở `module vpc`
    - subnet trỏ đến 2 public_subnet đã tạo ở `module vpc`
    - chọn `ip_address_type` là ipv4
    - `load_balancer_tyep` là application
4. tạo `load_balancer_listener` 
    - Trỏ đến load balancer vừa tạo ở trên qua `arn`:
            
            load_balancer_arn = "${aws_lb.hung_lb.arn}"
    - Port & Protocol
    - default_action là `forward` và trỏ đến `target_group_arn`
            
            target_group_arn = "${aws_lb_target_group.hung-target-group.arn}"

5. Tham số 
    - [main.tf](./elb/main.tf)
    - [variables.tf](./elb/variables.tf)
    - [output.tf](./elb/output.tf)

# Auto-Scaling
