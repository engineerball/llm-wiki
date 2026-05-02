---
name: "quartz-publish"
description: "Publishes an existing markdown wiki or Obsidian vault to GitHub Pages with Quartz. Use when a repo already has content and needs Quartz setup, verification, deployment, or deployment fixes."
---

# Quartz Publish

Use this skill to get an existing markdown wiki or Obsidian vault live on GitHub Pages with Quartz.

## Overview

The agent should do the repo work end to end:

- find the content directory
- install Quartz if it is missing, or work with the existing Quartz setup
- configure Quartz for the repo
- verify the site locally
- set up or fix GitHub Pages deployment
- commit, push, and verify the live site

Ask the human only for unavoidable external actions such as authentication, permission approval, or a GitHub setting the agent cannot change directly.

## Workflow

1. If Quartz is being added to an existing repo for the first time, do the work on a branch unless the user explicitly wants otherwise.
2. Inspect the repo and identify the content directory, any existing Quartz files, helper scripts, and deployment workflow.
3. If Quartz is missing, add it in a way that fits the repo. If Quartz already exists, read the existing config before changing it.
4. Connect Quartz to the repo's actual content directory. Prefer building directly from that directory. Only copy or symlink content if the repo actually needs that.
5. Match Quartz link resolution to the repo's existing markdown or Obsidian link style.
6. Set the site title and `baseUrl` for the target GitHub Pages URL.
7. Add or update helper scripts, `.gitignore`, and any small glue needed to make the setup repeatable.
8. Create or update the GitHub Pages workflow. Include the working branch in the workflow triggers so deployment can be tested before merging to main.
9. Ensure GitHub Pages is configured to deploy from `GitHub Actions`. If the agent cannot change that setting directly, ask the human for that one UI action. The `github-pages` environment may have deployment branch policies that only allow `main`. If the deploy job fails with "Branch is not allowed to deploy due to environment protection rules," check the environment's branch policies via the GitHub API and add the working branch if needed.
10. Run a local Quartz build and local preview. Fix path, asset, link, and config issues until the site works locally.
11. **Human review -- local preview.** Start the local dev server (`npx quartz build -d <content-dir> --serve`) and ask the human to check the site in their browser before proceeding. Do not skip this step or substitute automated checks for it. Wait for the human to confirm the site looks good.
12. Commit and push only after the human approves the local preview.
13. **Human review -- live preview on branch.** After pushing the branch, wait for the GitHub Actions deployment to complete and ask the human to check the live Pages URL. Do not open a PR to main or propose merging until the human confirms the live site works.
14. Once the human approves the live site, offer to create a PR to main. After merge, remove the working branch from the workflow triggers so only main deploys going forward.

## Verification

Verify the build with:

- `npx quartz build -d <content-dir>`
- `npx quartz build -d <content-dir> --serve`

Check that:

- the homepage renders
- note links resolve correctly
- images and other assets load
- search output is generated
- graph view works if enabled
- the `baseUrl` matches the final Pages URL
- the live Pages URL loads successfully

## Guardrails

- Do not assume Quartz lives in a specific directory.
- Do not assume the content directory is named `wiki/` or `content/`.
- Do not leave `baseUrl` blank.
- Do not copy content into Quartz unless there is a real repo-specific reason.
- If assets are symlinked, verify both local build behavior and CI behavior.
- Preserve useful repo-specific Quartz customization instead of resetting to defaults.
- Do not add first-time Quartz integration work directly on `main` unless the user explicitly asks for that.
- Do not stop at local setup. The goal is a live GitHub Pages site.

## References

- Quartz docs: https://quartz.jzhao.xyz/