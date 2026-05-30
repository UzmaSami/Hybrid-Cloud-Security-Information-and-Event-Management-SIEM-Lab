# 🛡️ Hybrid Cloud Security Information and Event Management (SIEM) Lab

## 📝 Objective
The goal of this project was to engineer and deploy a fully functional Hybrid SIEM environment capable of ingesting, normalizing, and correlating security telemetry from both an On-Premises Active Directory domain and a Microsoft Azure Cloud environment. 

This lab demonstrates practical skills in cloud infrastructure provisioning, API integrations, endpoint log forwarding, custom Splunk Processing Language (SPL) development, and proactive threat detection.

## 🛠️ Technologies & Tools Used
- **SIEM Engine:** Splunk Enterprise, Splunk Universal Forwarder
- **Cloud Infrastructure:** Microsoft Azure (Entra ID, Event Hubs, App Registrations, Service Principals)
- **On-Premises Infrastructure:** Windows Server (Active Directory Domain Controller)
- **Scripting & Automation:** PowerShell, Simple XML, Splunk Processing Language (SPL)
## 📊 Key Threat Detections Engineered
- This SIEM is configured to monitor, parse, and alert on the following threat vectors in real-time:

- Azure Cloud Identity Compromise: Captures Error Code 50126 (Invalid username/password) directly from Entra ID via Event Hubs.

- On-Premises Brute Force Attacks: Parses Windows Security Event 4625 (Failed Logon) to extract target usernames and attacker IP addresses.

- Active Account Lockouts: Tracks Windows Security Event 4740 across the domain to detect when an attacker successfully locks out a user account.

- Cloud Sign-In Tracking: Normalizes JSON cloud logs to map successful and failed authentication attempts geographically.
  ## Step-by-Step Implementation
### Phase 1: Cloud Log Routing (Azure)
- Created an Azure Event Hub namespace to act as a scalable data pipeline.

- Configured Entra ID Diagnostic Settings to stream SignInLogs to the Event Hub.

- Registered an Enterprise Application to generate API credentials (Tenant ID, Client ID, Secret).

### Phase 2: SIEM Cloud Integration
- Installed the Splunk Add-on for Microsoft Cloud Services.

- Configured the Add-on with the Azure App Registration credentials to establish a secure, continuous pull of cloud telemetry using the AMQP protocol.

### Phase 3: On-Premises Endpoint Forwarding
- Deployed a Splunk Universal Forwarder onto an isolated Windows Server Domain Controller.

- Configured inputs.conf via PowerShell to continuously capture and forward local Windows Security Event logs over TCP port 9997.

### Phase 4: Data Normalization & Dashboard Engineering
- Developed custom SPL queries to unify disparate log formats (Azure JSON arrays and Windows XML logs) into a single pane of glass.

- Engineered a custom Simple XML Dashboard to visualize real-time brute force attempts, active lockouts, and Azure cloud authentication failures.

### Phase 5: Attack Simulation & Validation
- Executed custom PowerShell scripts against the Domain Controller to generate synthetic brute force attacks and intentionally trigger Event 4740 (Account Lockouts).

- Simulated malicious cloud logins to validate the Azure Entra ID to Splunk pipeline routing.
