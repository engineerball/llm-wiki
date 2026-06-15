---
title: "Red Hat OpenShift AI"
type: concept
tags: [concept, ml, platform, kubernetes, ai, red-hat]
date: 2026-05-13
---

# Red Hat OpenShift AI

A Kubernetes-native AI/ML platform by [[red-hat|Red Hat]]. Integrates [[kubeflow-pipelines|Kubeflow Pipelines (KFP)]] for ML workflow orchestration and supports orchestrators like [[argo-workflows|Argo Workflows]] and [[tekton|Tekton]].

## Key Capabilities

- **ML Pipeline Orchestration**: KFP integration lets engineers define ML training pipelines as Python functions with `@kfp.dsl.component` decorators, each specifying their own library dependencies without manual container image management
- **Automated Containerization**: OpenShift containerizes and deploys each pipeline component in a dedicated pod
- **Data Sharing via S3**: KFP's `kfp-launcher` init container + S3-compatible storage (MinIO) bridges pod isolation, letting engineers treat cloud object storage as local filesystem while preserving data lineage
- **Parallel Execution**: Tasks without explicit dependencies execute in parallel for better cluster resource utilization
- **Workbenches**: Pre-loaded images supporting frameworks like PyTorch for experimentation
- **Feature Store Integration**: Works with [[feast|Feast]] for feature management and fast recommendation lookup

## ML Training Pipeline Pattern

```
Load data (from Feast) → Train Model → Generate Candidates (to Feast)
```

Each stage is a KFP component wired together with `after()` for execution ordering. The pipeline is compiled to YAML and submitted to the pipeline server, which uses OpenShift to spawn pods per task.

## Pod Architecture per Pipeline

| Pod Type | Function | Count |
|---|---|---|
| `kfp-run-job` | Compiles/submits pipeline | 1 |
| `*-system-dag-driver` | Coordinates task ordering | 1 |
| `*-system-container-driver` | Creates pod specs, monitors, retries | N per task |
| `*-system-container-impl` | Executes developer code | N per task |

## Trade-offs

- **Small datasets**: KFP's input/output artifact pattern works well (data copied via S3 transparently)
- **Large datasets**: May exceed pod ephemeral storage limits, causing eviction; alternatives include sharing S3 locations instead of full copies, or using external storage pools

## Related Pages

- [[red-hat-two-tower-model-openshift-2026|Red Hat's two-tower recommender]] — concrete implementation example
- [[kubeflow-pipelines|KFP]] — pipeline framework
- [[feast|Feast]] — feature store
- [[argo-workflows|Argo Workflows]] — orchestrator alternative
- [[cold-start-problem]] — handled via category preferences + encoder generalization
