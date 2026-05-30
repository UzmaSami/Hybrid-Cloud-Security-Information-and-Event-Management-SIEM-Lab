# 🛡️ Hybrid Cloud Security Information and Event Management (SIEM) Lab

## 📝 Objective
The goal of this project was to engineer and deploy a fully functional Hybrid SIEM environment capable of ingesting, normalizing, and correlating security telemetry from both an On-Premises Active Directory domain and a Microsoft Azure Cloud environment. 

This lab demonstrates practical skills in cloud infrastructure provisioning, API integrations, endpoint log forwarding, custom Splunk Processing Language (SPL) development, and proactive threat detection.

## 🛠️ Technologies & Tools Used
- **SIEM Engine:** Splunk Enterprise, Splunk Universal Forwarder
- **Cloud Infrastructure:** Microsoft Azure (Entra ID, Event Hubs, App Registrations, Service Principals)
- **On-Premises Infrastructure:** Windows Server (Active Directory Domain Controller)
- **Scripting & Automation:** PowerShell, Simple XML, Splunk Processing Language (SPL)

## 🏗️ Architecture Diagram
graph TD
    subgraph Cloud ["Microsoft Azure Cloud"]
        A[Entra ID] -->|Diagnostic Settings| B[Azure Event Hub]
        B -->|AMQP Port 5671| C{Azure App Registration}
    end

    subgraph OnPrem ["On-Premises Network"]
        D[Windows Server Domain Controller] -->|Event 4625 and 4740| E[Splunk Universal Forwarder]
    end

    subgraph SOC ["Security Operations Center"]
        C -->|REST API Ingestion| F[Splunk Enterprise SIEM]
        E -->|TCP Port 9997| F
        F -->|Data Normalization| G((Hybrid SOC Dashboard))
    end
    subgraph "On-Premises Network"
        D[Windows Server 2022 <br/> Domain Controller] -->|Event Logs: 4625, 4740| E[Splunk Universal Forwarder]
    end

    subgraph "Security Operations Center (SOC)"
        C -->|REST API Ingestion| F[Splunk Enterprise <br/> Indexer & Search Head]
        E -->|TCP Port 9997| F
        F -->|SPL & XML Parsing| G((Hybrid SOC <br/> Dashboard))
    endb
