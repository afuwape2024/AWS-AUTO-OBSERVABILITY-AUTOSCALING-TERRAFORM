# AWS Observability & Auto Scaling Platform

## Project Overview

In this project, I built a fully automated monitoring and observability solution on AWS using Terraform, Prometheus, Grafana, and EC2 Auto Scaling Groups.

The goal was to create a platform where newly launched EC2 instances are automatically discovered, monitored, and visualized without requiring any manual configuration changes. By combining Infrastructure as Code (Terraform) with Prometheus EC2 Service Discovery, the monitoring environment scales alongside the infrastructure.

## What I Built

* Provisioned AWS infrastructure using Terraform
* Created Launch Templates and Auto Scaling Groups for dynamic EC2 deployment
* Configured Prometheus to collect infrastructure metrics
* Installed Node Exporter automatically through EC2 User Data scripts
* Implemented EC2 Service Discovery using IAM roles and AWS APIs
* Built Grafana dashboards for real-time infrastructure monitoring
* Configured Security Groups and IAM policies following AWS security best practices
* Enabled automatic monitoring of newly launched instances through EC2 tags

## Architecture

```text
Grafana
   v
Prometheus
   v
AWS EC2 Service Discovery
   +--> EC2 Instance (Node Exporter) Auto scale
```
<img width="1122" height="232" alt="image" src="https://github.com/user-attachments/assets/80d35039-466c-4ed9-bdf2-9ebdb67ba055" />

## How It Works

Prometheus uses AWS EC2 Service Discovery to identify instances tagged with:

Monitor=true

When an Auto Scaling Group launches a new EC2 instance:

1. Node Exporter is installed automatically during boot.
2. The instance receives the monitoring tag.
3. Prometheus discovers the instance through AWS APIs.
4. Metrics are automatically scraped on port 9100.
5. Grafana dashboards update with the new server metrics.

No manual updates to Prometheus configuration are required.

## Technologies Used

* AWS EC2
* Auto Scaling Groups
* Launch Templates
* IAM Roles & Policies
* Terraform
* Prometheus
* Grafana
* Node Exporter
* Linux (Ubuntu)
* Bash Scripting
* PromQL

## Monitoring Capabilities
  <img width="1142" height="394" alt="image" src="https://github.com/user-attachments/assets/07aa34c9-638d-4d2e-b308-3d57bf7c66f2" />
The platform provides visibility into:

* CPU utilization
* Memory usage
* Disk utilization
* Network traffic
* System uptime
* Load averages
* Auto Scaling infrastructure health

## Key Lessons Learned

This project helped strengthen my understanding of:

* Infrastructure as Code (IaC)
* AWS networking and security
* IAM role-based access
* Prometheus service discovery
* Grafana dashboard management
* Auto Scaling operations
* Observability and monitoring best practices
<img width="387" height="482" alt="image" src="https://github.com/user-attachments/assets/59c6db03-b247-4f5b-a241-f3194cc8b7da" />

## Results

Successfully deployed a scalable AWS monitoring platform where infrastructure can grow automatically while remaining fully observable. New EC2 instances are discovered and monitored without any manual intervention, providing a production-style observability workflow similar to what is used in modern cloud environments.
