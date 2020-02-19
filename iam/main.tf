provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}



resource "aws_iam_user" "hung_users" {
  name = "${element(var.username,count.index)}"
  count = "${length(var.username)}"
}

data "aws_iam_policy_document" "iampolicy_for_users" {
    statement {
        actions = [
            "ec2:*"
        ]
    resources = [
        "*"
    ]
    } 
}
resource "aws_iam_policy" "iampolicy_for_users" {
    name = "ec2-full-permission"
    policy = "${data.aws_iam_policy_document.iampolicy_for_users.json}"
}
//Attaching the IAM policy to the recently created users
resource "aws_iam_user_policy_attachment" "iampolicy_for_usersattachment" {
    count = "${length(var.username)}"
    user = "${element(aws_iam_user.hung_users.*.name, count.index)}"
    policy_arn  = "${aws_iam_policy.iampolicy_for_users.arn}" 
}

// define policy file json for resource
data "template_file" "iam_role_policy" {
  template = "${file("./iam_role_policy.json.tpl")}"
}  
// role policy --> role with policy from data template_file
resource "aws_iam_role_policy" "hung-iam-role-policy" {
  name = "hung-iam-role-policy"
  role = "${aws_iam_role.hung-iam-role.id}"
  
  policy = "${(data.template_file.iam_role_policy.rendered)}"

}

//Method 2: use resource iam_role --> assume_role_policy
resource "aws_iam_role" "hung-iam-role" {
  name = "hung-iam-role"
    assume_role_policy = <<EOF
        {
        "Version": "2012-10-17",
        "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
        }
        ]
        }
        EOF
    tags = {
        tag-key = "hung-iam-role"
    }
}

resource "aws_iam_instance_profile" "hung-iam-instance-profile" {
    name = "hung-iam-instance-profile"
    role = "${aws_iam_role.hung-iam-role.name}"
}
