# 🛡️ Hybrid Cloud Security Information and Event Management (SIEM) Lab

## Building a Unified Hybrid Cloud SIEM: Bridging the On-Premises and Cloud Divide
By Uzma Sami (AZ-104, AZ-500)

The modern attack surface doesn’t care where your servers live, but traditional security tools do. This project is my engineering approach to solving the hybrid visibility gap.

If you have ever worked in a Security Operations Center (SOC) managing a hybrid infrastructure, you know the pain of fragmented visibility. Your on-premises firewalls are logging to one system, your cloud-native workloads are logging to another, and your identity provider is somewhere in between.

When a threat actor compromises an on-premises endpoint and uses it to pivot into your Azure environment, that lateral movement happens in the dark spaces between your security tools.

I built the Hybrid Cloud SIEM Lab to solve exactly this problem. This repository isn't just a collection of deployment scripts; it is a blueprint for centralizing telemetry, writing high-fidelity detections, and automating responses across physical and cloud boundaries.

The Architecture: Designing for Total Visibility
To build a reliable hybrid SIEM, I had to abandon the idea of treating on-premises and cloud as separate entities. The goal was a unified data plane. Here is how I architected the solution:

1. Breaking Down Data Silos (The Ingestion Layer)
A SIEM is only as intelligent as the data it consumes. I engineered the ingestion pipeline to aggressively pull logs from both sides of the perimeter into a centralized Log Analytics Workspace.

Cloud-Native Connectors: Seamlessly bound Azure Activity logs, Microsoft Entra ID diagnostic settings, and PaaS metrics directly to the SIEM without deploying a single agent.

On-Premises Forwarding: To capture the physical network, I deployed Azure Arc and configured Syslog/CEF forwarders to securely pipe Linux daemon logs and Windows Security Events across the internet into our unified workspace.

2. Signal Over Noise (Detection Engineering)
If you just forward everything to a SIEM, you don't get security; you get alert fatigue. As a security engineer, my job is to filter the noise.

I wrote custom Kusto Query Language (KQL) analytics rules mapped explicitly to the MITRE ATT&CK framework.

Instead of relying on out-of-the-box alerts, I engineered correlation queries designed to catch cross-environment movement—for example, detecting a brute-force attack on an on-premises Linux box followed immediately by an anomalous Entra ID login from the same external IP.

3. Machine-Speed Defense (SOAR Integration)
In a live incident, human response time is too slow. By the time an analyst triages an alert, the data is already exfiltrated.

I integrated Security Orchestration, Automation, and Response (SOAR) playbooks.

When a high-fidelity alert fires (like anomalous privilege escalation), the SIEM automatically triggers a Logic App workflow that can isolate the compromised on-premises VM or revoke the user's Entra ID session—containing the blast radius before an analyst even opens the ticket.

🛠️ How to Replicate This Build
If you are a fellow security engineer looking to test these detection rules or simulate hybrid attacks, I have automated the foundational setup of this lab.

What You Will Need
An active Microsoft Azure Subscription.

At least one on-premises (or local hypervisor) Virtual Machine to act as the legacy environment.

Azure PowerShell module (Az) installed locally.

Deployment Pipeline
1. Clone the Infrastructure
Pull down the repository to your local management machine:

Bash
git clone https://github.com/UzmaSami/Hybrid-Cloud-Security-Information-and-Event-Management-SIEM-Lab.git
cd Hybrid-Cloud-Security-Information-and-Event-Management-SIEM-Lab
2. Provision the Cloud Resources
Execute the main build script to provision the Log Analytics Workspace, enable Microsoft Sentinel, and establish the required data connector configurations.

PowerShell
.\Deploy-HybridSIEM.ps1
3. Arc-Enable Your On-Premises Lab
Run the included bootstrapping script on your local/on-premises VMs to project them into Azure via Azure Arc, binding them to the centralized workspace.

PowerShell
.\Configure-ArcAgents.ps1
4. Deploy Analytic Rules & Playbooks
Inject the custom KQL detections and SOAR automation logic into the SIEM instance.

PowerShell
.\Deploy-DetectionsAndSOAR.ps1
The Takeaway
Security engineering in a hybrid world requires treating your entire infrastructure as a single, contiguous organism. By routing all telemetry through a centralized, cloud-native SIEM, tuning alerts to MITRE ATT&CK, and automating the immediate response, we can finally turn the lights on in the dark corners of the hybrid cloud.
