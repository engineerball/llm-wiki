---
title: "KFP — Kubeflow Pipelines"
type: concept
tags: [concept, ml, pipelining, kubernetes]
date: 2026-05-13
---

# KFP — Kubeflow Pipelines

A platform for building, deploying, and managing end-to-end [[ml|machine learning]] workflows on [[kubernetes|Kubernetes]]. Each pipeline component is a Python function decorated with ` @kfp.dsl.component`, specifying its own library dependencies without needing manual Docker image maintenance.

## Key Architecture

### Component Definition

```python
@dsl.component(base_image=BASE_IMAGE, 
               packages_to_install=["minio", "psycopg2-binary"])
def train_model(
    item_df_input: Input[Dataset],
    user_df_input: Input[Dataset],
    interaction_df_input: Input[Dataset],
    item_output_model: Output[Model],
    user_output_model: Output[Model],
):
```

### Pipeline Orchestration

Components are wired together using `.after()` for explicit ordering, or left unchained for parallel execution:

```python
@dsl.pipeline(name="batch_recommendation")
def batch_recommendation():
    load_task = load_data_from_feast()
    train_task = train_model(...).after(load_task)
```

The compiled YAML is submitted to a pipeline server, which integrates with [[argo-workflows|Argo Workflows]] or [[tekton|Tekton]] to containerize and deploy each component.

### Pod Architecture per Pipeline

| Pod | Function |
|---|---|
| `kfp-run-job` | Compiles and submits pipeline (1 per run) |
| `*-system-dag-driver` | Coordinates task execution order |
| `*-system-container-driver` | Creates pod specs, monitors, retries, manages outputs (N per task) |
| `*-system-container-impl` | Executes developer's task-specific code (N per task) |

### Data Sharing

- **Small datasets**: Components write to local ephemeral filesystem; `kfp-launcher` init container copies via [[s3|S3-compatible storage]] (MinIO) transparently
- **Large datasets**: May hit pod eviction limits; alternatives include sharing S3 locations or using external storage like [[feast|Feast]]

## Benefits

- Simplified dependency management per component
- Automatic failure recovery and retry logic
- Parallel execution abstraction for independent tasks
- Data lineage preserved after ephemeral pods terminate

## Related Pages

- [[openshift-ai]] — Red Hat OpenShift AI integrates KFP
- [[feast|Feast]] — feature store used in KFP pipelines
- [[argo-workflows|Argo Workflows]] — alternative orchestrator
- [[tekton|Tekton]] — alternative orchestrator
- [[redhat-two-tower-model-openshift-2026|Red Hat's product recommender]] — concrete KFP implementation
- [[kubernetes|Kubernetes]] — underlying platform
