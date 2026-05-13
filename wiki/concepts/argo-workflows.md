---
title: "Argo Workflows"
type: concept
tags: [concept, kubernetes, orchestration, workflow]
date: 2026-05-13
---

# Argo Workflows

A container-native workflow engine for orchestrating parallel jobs on [[kubernetes|Kubernetes]]. Used as an execution backend for [[kubeflow-pipelines|Kubeflow Pipelines (KFP)]] in platforms like [[openshift-ai|Red Hat OpenShift AI]].

## Role in ML Pipelines

When a KFP pipeline is submitted, Argo Workflows handles:
- Containerizing each pipeline component
- Creating and managing one pod per pipeline task
- Coordinating execution order based on task dependencies
- Running independent tasks in parallel
- Implementing retry logic for failed tasks

## Related Pages

- [[kubeflow-pipelines|KFP — Kubeflow Pipelines]]
- [[tekton|Tekton]] — alternative orchestrator
- [[openshift-ai|Red Hat OpenShift AI]]
