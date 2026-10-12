
# STIGs Implementation and Security Hardening

## Project Overview

This repository documents the implementation of **Security Technical Implementation Guides (STIGs)** to improve Windows operating system security, remediate configuration vulnerabilities, and strengthen compliance with established security baselines.

The project focuses on applying security configurations using **PowerShell**, validating registry and system settings, and conducting compliance assessments using **Tenable Nessus**.

## Objectives

- Implement DISA STIG security configurations on Windows operating systems.
- Automate security hardening tasks using PowerShell scripts.
- Identify and remediate security misconfigurations.
- Validate STIG compliance through Tenable Nessus scans.
- Document security improvements and remediation procedures.

## Tools and Technologies

- **Microsoft Azure** – Virtual machine deployment and management.
- **Windows 11** – Target operating system for STIG implementation.
- **PowerShell ISE** – Development and execution of security hardening scripts.
- **Tenable Nessus** – Vulnerability scanning and STIG compliance assessment.

## STIG Implementation

Each PowerShell script in the `STIG` folder addresses a specific security configuration requirement.

Scripts are designed to:

1. Identify the required security configuration.
2. Create or modify the necessary registry settings.
3. Apply the specified STIG security controls.
4. Verify the configured values.
5. Support compliance validation through follow-up scans.

## Validation and Compliance

STIG implementations are evaluated by verifying the configured settings and conducting follow-up compliance scans using Tenable Nessus.

The goal is to reduce security misconfigurations, improve system hardening, and demonstrate practical vulnerability remediation techniques.

---

**Project Status:** Ongoing — Additional STIG implementations and PowerShell remediation scripts will be added as the project progresses.
