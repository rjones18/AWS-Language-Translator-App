# 🔥 Translator Torch

**Translator Torch** is a cloud-native language translation and text-to-speech application deployed on **AWS App Runner**.  
The application translates **English → Spanish, French, or Japanese** using **Amazon Translate**, then speaks the translated text back to the user using **Amazon Polly**.

This project demonstrates a modern, fully managed AWS architecture using **Terraform, App Runner, and CI/CD security scanning**.

---

## 🚀 Features

- 🌍 Translate English into **Spanish, French, or Japanese**
- 🗣️ Convert translated text into speech using **Amazon Polly**
- ☁️ Serverless container runtime using **AWS App Runner**
- 🔐 Secure IAM-based permissions for AWS service access
- 🛠️ Infrastructure as Code (IaC) using **Terraform**
- 🔎 **Snyk** scanning for Infrastructure-as-Code security
- 🔄 Automated CI/CD with **GitHub Actions**

---

## 🏗️ Architecture

![Translator Torch Architecture](https://github.com/rjones18/Images/blob/main/TranslatorTorch.png)

### Architecture Flow

1. User submits English text and selects a target language
2. Request is sent to the Flask application running on AWS App Runner
3. App Runner service:
   - Calls **Amazon Translate** to translate the text
   - Calls **Amazon Polly** to synthesize speech
4. Audio response is returned to the user

---

## 🧱 Infrastructure

The App Runner infrastructure is deployed using a reusable Terraform module.

### Core AWS Services
- **AWS App Runner** – Serverless container hosting
- **Amazon Translate** – Language translation
- **Amazon Polly** – Text-to-speech
- **Amazon ECR** – Container image registry
- **IAM** – Fine-grained runtime permissions
- **Route 53 (optional)** – Custom domain support

### Terraform Module
Infrastructure is deployed using this custom module:

👉 https://github.com/rjones18/AWS-APPRUNNER-TERRAFORM-MODULE

Key features of the module:
- App Runner service creation
- Runtime IAM role configuration
- Secrets and environment variable support
- Health checks and auto-deployments
- Custom domain compatibility

---

## 🔐 Security & CI/CD

### GitHub Actions Pipeline
- Builds and pushes container images to **Amazon ECR**
- Deploys infrastructure using **Terraform**
- Triggers App Runner deployments automatically

### Snyk Security Scanning
Just like the **Malik AI ECS project**, this pipeline includes **Snyk** to scan:
- Terraform IaC for security issues
- Misconfigurations and policy risks before deployment

---

## 🎥 Demo

> 📽️ **Demo Video Coming Soon**

The demo will show:
- Selecting a target language
- Translating English text
- Playing synthesized speech audio
- Live App Runner deployment in action

(You can embed a video or link here once uploaded.)

---

## 📦 Repository Structure

```text
.
├── app/                    # Flask application code
├── terraform/              # App Runner infrastructure
├── .github/workflows/      # GitHub Actions CI/CD
├── Dockerfile
├── requirements.txt
└── README.md
