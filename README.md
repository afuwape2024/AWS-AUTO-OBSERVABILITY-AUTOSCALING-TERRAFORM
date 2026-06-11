# AWS-AUTO-OBSERVABILITY-AUTOSCALING-TERRAFORM
# AWS Observability & Auto Scaling Platform

## Overview

This project demonstrates the implementation of a cloud-native observability platform on AWS using Terraform, Prometheus, Grafana, EC2 Auto Scaling Groups, Launch Templates, IAM Roles, and Node Exporter.

The solution automatically provisions infrastructure, deploys monitoring agents, and dynamically discovers EC2 instances using Prometheus EC2 Service Discovery. Newly launched Auto Scaling instances are automatically monitored without requiring manual Prometheus configuration updates.

## Architecture

```text
Internet
    |
Grafana (Port 3000)
    |
Prometheus (Port 9090)
    |
EC2 Service Discovery (IAM Role)
    |
    +----> EC2 Instance 1 (Node Exporter :9100) Auto-scale
```
<img width="1122" height="232" alt="image" src="https://github.com/user-attachments/assets/80d35039-466c-4ed9-bdf2-9ebdb67ba055" />


## Key Features

* Infrastructure provisioning using Terraform
* AWS Launch Templates and Auto Scaling Groups
* Prometheus metrics collection and monitoring
* Grafana dashboards and visualization
* Node Exporter deployment through EC2 User Data
* IAM-based EC2 Service Discovery
* Dynamic target registration using EC2 tags
* Secure Security Group configuration
* Automated scaling and monitoring integration
* Cloud-native observability architecture

## Technologies Used

* AWS EC2
* AWS Auto Scaling Groups
* AWS IAM
* Terraform
* Prometheus
* Grafana
* Node Exporter
* Linux (Ubuntu)
* Bash Scripting

## Terraform Components

### Networking

* VPC
* Public Subnets
* Internet Gateway
* Route Tables
* Security Groups

### Compute

* EC2 Instances
* Launch Templates
* Auto Scaling Groups

### Monitoring

* Prometheus Server
* Grafana Server
* Node Exporter
  <img width="1142" height="394" alt="image" src="https://github.com/user-attachments/assets/07aa34c9-638d-4d2e-b308-3d57bf7c66f2" />


### Identity & Access Management

* IAM Role
* IAM Policy
* IAM Instance Profile

## Automatic EC2 Discovery

Prometheus leverages AWS EC2 Service Discovery to automatically discover instances tagged with:

```text
Monitor=true
```

As new instances are launched through the Auto Scaling Group, Prometheus automatically begins scraping metrics without requiring any manual updates to `prometheus.yml`.
<img width="387" height="482" alt="image" src="https://github.com/user-attachments/assets/59c6db03-b247-4f5b-a241-f3194cc8b7da" />


## Monitoring Metrics

The platform provides visibility into:

* CPU Utilization
* Memory Usage
* Disk Utilization
* Network Throughput
* System Load
* Filesystem Capacity
* Instance Availability
* Auto Scaling Infrastructure Health

## Grafana Dashboards

The following dashboard is configured:

* Node Exporter Full (Dashboard ID: 1860)

Visualizations include:

* CPU Usage
* Memory Utilization
* Disk Performance
* Network Traffic
* System Uptime
* Resource Consumption Trends

## Security

* SSH access restricted through Security Groups
* Prometheus exposed on port 9090
* Grafana exposed on port 3000
* Node Exporter restricted to Prometheus access
* IAM least-privilege permissions for EC2 discovery

## Outcome

Successfully implemented a fully automated AWS observability platform where newly provisioned Auto Scaling instances are automatically discovered, monitored, and visualized through Prometheus and Grafana with no manual intervention.
