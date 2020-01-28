provider "aws" {
		shared_credentials_file = ".aws/Cred/accessKeys.csv"
        region = "ap-southeast-1"
}

resource "aws_key_pair" "hung" {
  key_name = "hung"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA1Jy1w8BSeJoKIPpWmMIjSStZdmSyreJbp72MXu7ltNiGke4qJGMYfPMM5vNQvNBJuA6Ra/C2wjF7IbsDMwVbxynaaglj1ECSbYF/b8xgXqpChhSERjtl/VTEJxFgp/HkvhRuXYxfFT2W9OTJATqd8BdxtJ4l+zWpVaArSJ2Ex4o+yLzWLGjOaEyabl/33sxKQUAk67iSTfEVeYRs6S1EMLMeV5p19GGQN7Jlmv3s3rbup26bk42n5SKt4rVppe17ZP1LlzKLrl/+WRhrsDMNjIngJ7HLv+S+q8E52iVN+E5cMxSnFjIaC2kI9Tig/v9+bhmqnwyxcwWKVcJJKl8uqQ=="
}
