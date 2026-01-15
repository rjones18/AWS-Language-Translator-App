module "translator_apprunner" {
  source = "git::https://github.com/rjones18/AWS-APPRUNNER-TERRAFORM-MODULE.git?ref=v1.0.1"

  name = "translator-app-${var.environment}"

  image_identifier = var.ecr_image_uri
  container_port   = 8080

  cpu    = "1024" # 1 vCPU
  memory = "2048" # 2 GB RAM

  auto_deployments_enabled = true

  health_check_path = "/"

  # Optional plain env vars
  env = {
    FLASK_ENV = var.environment
    LOG_LEVEL = "info"
  }

  # Optional: App Runner-injected secrets
  # (If you want App Runner to inject instead of your Python code calling SM)
  # secret_env = {
  #   MALIK_SECRETS_NAME = var.secrets_manager_arn
  # }

  # Runtime IAM permissions for your container
  # secretsmanager_arns = [
  #   var.secrets_manager_arn
  # ]

  tags = {
    Project     = "translator-app"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# --------------------------------------------
# Allow App Runner runtime role to call AWS Translate
# --------------------------------------------
resource "aws_iam_policy" "apprunner_translate" {
  name        = "translator-${var.environment}-apprunner-translate"
  description = "Allow App Runner instance role to call AWS Translate and Amazon Polly"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TranslateAndPolly"
        Effect = "Allow"
        Action = [
          "translate:TranslateText",
          "polly:SynthesizeSpeech",
          "polly:DescribeVoices"
        ]
        Resource = "*"
      }
    ]
  })
}


locals {
  apprunner_instance_role_name = regex("role/(.+)$", module.translator_apprunner.instance_role_arn)[0]
}

resource "aws_iam_role_policy_attachment" "apprunner_translate_attach" {
  role       = local.apprunner_instance_role_name
  policy_arn = aws_iam_policy.apprunner_translate.arn
}

