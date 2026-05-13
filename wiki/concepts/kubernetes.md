---
title: "Kubernetes"
type: concept
tags: [concept, infrastructure, orchestration, containers]
date: 2026-05-13
---

# Kubernetes

Open-source container orchestration platform. Foundation for ML platforms like [[openshift-ai|Red Hat OpenShift AI]] and pipeline engines like [[kubeflow-pipelines|KFP]] and [[argo-workflows|Argo Workflows]].

## Key Concepts for ML

- **Pod isolation**: Pods cannot access each other's local ephemeral storage — [[kubeflow-pipelines|KFP]] bridges this with init containers and [[s3|S3-compatible storage]]
- **Eviction manager**: Can terminate pods that exceed storage limits on a node
- **Container-native workflows**: Orchestration engines run each pipeline step as a dedicated container/pod

## Related Pages

- [[openshift-ai|Red Hat OpenShift AI]] — Kubernetes-native AI platform
- [[kubeflow-pipelines|KFP — Kubeflow Pipelines]]
