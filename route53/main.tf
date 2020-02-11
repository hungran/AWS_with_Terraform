provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}

data "aws_route53_zone" "domain-hung" {
    name       = "vumanhhung.be"
    
}

resource "aws_route53_record" "www" {
    zone_id = "${data.aws_route53_zone.domain-hung.zone_id}"
    type    = "A"
    name    = "www"
    alias   {
        name     = "dualstack.${var.elb_dns_name}" 
        zone_id  =  "${var.elb_zone_id}"
        evaluate_target_health = true
    }
}
